FUNCTION_BLOCK FB_NGRC_Continuous_MultiVar

(* ===== MAIN LOGIC ===== *)

IF NOT Enable THEN
	StateFlags.Initialized := FALSE;
	StateFlags.ActiveModelValid := FALSE;
	StateFlags.PredictionActive := FALSE;
	TrainingState := 0;
	PredictionState := 0;
	MultiStepState := 0;
	BufferIndex := 0;
	BufferFull := FALSE;
	Metrics.SampleCount := 0;
	Status.Ready := FALSE;
	Status.PredictionValid := FALSE;
	Status.IsTraining := FALSE;
	Status.ConfigValid := FALSE;
	RETURN;
END_IF;

IF Reset THEN
	StateFlags.Initialized := FALSE;
	StateFlags.ActiveModelValid := FALSE;
	StateFlags.PredictionActive := FALSE;
	TrainingState := 0;
	PredictionState := 0;
	MultiStepState := 0;
	BufferIndex := 0;
	BufferFull := FALSE;
	Metrics.SampleCount := 0;
	Metrics.TotalRetrains := 0;
	Metrics.ModelSwaps := 0;
	TotalErrorSum := 0.0;
	TotalErrorCount := 0;
	
	(* Reset per-variable metrics *)
	FOR i := 0 TO 9 DO
		ErrorSum_1Step[i] := 0.0;
		ErrorCount_1Step[i] := 0;
		MaxError_1Step[i] := 0.0;
		ErrorSum_5Step[i] := 0.0;
		ErrorCount_5Step[i] := 0;
		Metrics.OneStepRMSE[i] := 0.0;
		Metrics.OneStepMaxError[i] := 0.0;
		Metrics.FiveStepRMSE[i] := 0.0;
	END_FOR;
	
	Status.Ready := FALSE;
	Status.PredictionValid := FALSE;
	Status.IsTraining := FALSE;
	Status.ConfigValid := FALSE;
	RETURN;
END_IF;

(* Validate configuration *)
NumVars := Config.NumVariables;
IF NumVars < 1 OR NumVars > Config.MaxVariables THEN
	Status.ConfigValid := FALSE;
	Status.Ready := FALSE;
	RETURN;
END_IF;
Status.ConfigValid := TRUE;

IF NOT StateFlags.Initialized THEN
	(* Initialize data structures *)
	TrainingData.Row := 0;
	TrainingData.Col := NumVars;
	
	CurrentSample.Row := 1;
	CurrentSample.Col := NumVars;
	
	PredictionBuffer.Row := 1;
	PredictionBuffer.Col := NumVars;
	
	(* Clear error window *)
	FOR i := 0 TO 19 DO
		ErrorWindow[i] := 0.0;
	END_FOR;
	
	(* Initialize prediction age tracking *)
	FOR i := 0 TO 9 DO
		FOR j := 0 TO 4 DO
			PredictionAge[i, j] := -1;
		END_FOR;
	END_FOR;
	
	StateFlags.Initialized := TRUE;
END_IF;

CycleCount := CycleCount + 1;

(* ===== DATA COLLECTION (Multivariable) ===== *)
(* Store sample in circular buffer: [sample_index * NumVars + var_index] *)
BufferOffset := BufferIndex * NumVars;
FOR i := 0 TO NumVars-1 DO
	DataBuffer[BufferOffset + i] := NewSample[i];
END_FOR;

BufferIndex := BufferIndex + 1;
IF BufferIndex >= Config.BufferSize THEN
	BufferIndex := 0;
	BufferFull := TRUE;
END_IF;
Metrics.SampleCount := Metrics.SampleCount + 1;


(* ===== BACKGROUND TRAINING ===== *)
IF TrainingState = 0 THEN
	(* Determine if training should start *)
	IF NOT StateFlags.ActiveModelValid THEN
		(* Initial training *)
		IF Metrics.SampleCount >= Config.TrainingSamples THEN
			TrainingState := 1;
			Status.IsTraining := TRUE;
			Status.LastRetrainReason := 'Initial training';
		END_IF;
	ELSE
		(* Retraining *)
		SamplesSinceRetrain := SamplesSinceRetrain + 1;
		
		CASE Config.RetrainMode OF
			1: (* Interval *)
				IF SamplesSinceRetrain >= Config.RetrainInterval THEN
					RetrainTrigger := TRUE;
					Status.LastRetrainReason := 'Interval';
				END_IF;
			2: (* Error-based *)
				IF Metrics.MovingAvgError > Config.RetrainErrorThreshold THEN
					RetrainTrigger := TRUE;
					Status.LastRetrainReason := 'Error threshold';
				END_IF;
			3: (* Continuous *)
				IF SamplesSinceRetrain >= 10 THEN
					RetrainTrigger := TRUE;
					Status.LastRetrainReason := 'Continuous';
				END_IF;
		END_CASE;
		
		IF RetrainTrigger THEN
			TrainingState := 1;
			Status.IsTraining := TRUE;
			RetrainTrigger := FALSE;
			SamplesSinceRetrain := 0;
			Metrics.TotalRetrains := Metrics.TotalRetrains + 1;
		END_IF;
	END_IF;
END_IF;

(* Execute training state machine *)
CASE TrainingState OF
	0: (* Idle *)
		Status.TrainingProgress := 0;
		Metrics.TrainingCycles := 0;
		
	1: (* Prepare and Reset *)
		(* Prepare training data - convert circular buffer to matrix *)
		IF BufferFull THEN
			(* Use last TrainingSamples from buffer *)
			FOR i := 0 TO Config.TrainingSamples-1 DO
				j := BufferIndex - Config.TrainingSamples + i;
				IF j < 0 THEN j := j + Config.BufferSize; END_IF;
				
				(* Copy all variables for this sample *)
				FOR k := 0 TO NumVars-1 DO
					TrainingData.M[i * NumVars + k] := DataBuffer[j * NumVars + k];
				END_FOR;
			END_FOR;
		ELSE
			(* Use what we have *)
			FOR i := 0 TO Config.TrainingSamples-1 DO
				FOR k := 0 TO NumVars-1 DO
					TrainingData.M[i * NumVars + k] := DataBuffer[i * NumVars + k];
				END_FOR;
			END_FOR;
		END_IF;
		
		TrainingData.Row := Config.TrainingSamples;
		TrainingData.Col := NumVars;
		
		(* Reset training model *)
		Model_Training(
			Enable := TRUE,
			Reset := TRUE,
			Train := FALSE,
			Predict := FALSE,
			PredictSteps := Config.PredictSteps,
			Config := Config.ModelConfig,
			TrainingData := TrainingData,
			PredictionOutput := PredictionOutput_Training
		);
		
		IF Model_Training.Ready THEN
			Model_Training.Reset := FALSE;
			TrainingState := 2;
			Status.TrainingProgress := 10;
		END_IF;
		Metrics.TrainingCycles := Metrics.TrainingCycles + 1;
		
	2: (* Training *)
		Model_Training(
			Enable := TRUE,
			Reset := FALSE,
			Train := TRUE,
			Predict := FALSE,
			PredictSteps := Config.PredictSteps,
			Config := Config.ModelConfig,
			TrainingData := TrainingData,
			PredictionOutput := PredictionOutput_Training
		);
		
		Status.TrainingProgress := 50;
		Metrics.TrainingCycles := Metrics.TrainingCycles + 1;
		
		IF Model_Training.Done THEN
			Model_Training.Train := FALSE;
			
			IF Model_Training.Status = NGRC_TRAINED THEN
				(* Success *)
				ModelSwapReady := TRUE;
				TrainingState := 0;
				Status.IsTraining := FALSE;
				Status.TrainingProgress := 100;
			ELSE
				(* Failed *)
				TrainingState := 0;
				Status.IsTraining := FALSE;
				Status.TrainingProgress := 0;
			END_IF;
		END_IF;
END_CASE;


(* ===== MODEL SWAP ===== *)
IF ModelSwapReady THEN
	(* Copy trained model to active *)
	brsmemcpy(ADR(Model_Active.Internal), ADR(Model_Training.Internal), SIZEOF(NGRC_Internal_typ));
	
	StateFlags.ActiveModelValid := TRUE;
	ModelSwapReady := FALSE;
	Metrics.ModelSwaps := Metrics.ModelSwaps + 1;
	
	(* Reinit predictor *)
	PredictionState := 0;
	StateFlags.PredictionActive := FALSE;
	
	(* Trigger multi-step *)
	MultiStepState := 1;
END_IF;


(* ===== CONTINUOUS 1-STEP PREDICTION (Multivariable) ===== *)
CASE PredictionState OF
	0: (* Need to initialize *)
		IF StateFlags.ActiveModelValid THEN
			PredictionState := 1;
		END_IF;
		
	1: (* Initialize online predictor *)
		(* Copy current sample to matrix *)
		FOR i := 0 TO NumVars-1 DO
			CurrentSample.M[i] := NewSample[i];
		END_FOR;
		
		Predictor_Online(
			Enable := TRUE,
			Reset := TRUE,
			NewSample := FALSE,
			PredictNext := FALSE,
			Config := Config.ModelConfig,
			CurrentValue := CurrentSample,
			Prediction := PredictionBuffer,
			TrainedModel := Model_Active
		);
		
		IF Predictor_Online.Ready THEN
			Predictor_Online.Reset := FALSE;
			StateFlags.PredictionActive := TRUE;
			PredictionState := 2;
			Status.Ready := TRUE;
		END_IF;
		
	2: (* Active prediction *)
		(* Update current sample *)
		FOR i := 0 TO NumVars-1 DO
			CurrentSample.M[i] := NewSample[i];
		END_FOR;
		
		Predictor_Online(
			Enable := TRUE,
			Reset := FALSE,
			NewSample := TRUE,
			PredictNext := TRUE,
			Config := Config.ModelConfig,
			CurrentValue := CurrentSample,
			Prediction := PredictionBuffer,
			TrainedModel := Model_Active
		);
		
		IF Predictor_Online.PredictionValid THEN
			Status.PredictionValid := TRUE;
			
			(* Extract predictions for all variables *)
			tempSum := 0.0;
			FOR i := 0 TO NumVars-1 DO
				PredictedNext[i] := PredictionBuffer.M[i];
				
				(* Calculate per-variable error *)
				IF ErrorCount_1Step[i] > 0 THEN
					temp := NewSample[i] - LastPrediction[i];
					ErrorSum_1Step[i] := ErrorSum_1Step[i] + temp * temp;
					Metrics.OneStepRMSE[i] := SQRT(ErrorSum_1Step[i] / ErrorCount_1Step[i]);
					
					IF ABS(temp) > MaxError_1Step[i] THEN
						MaxError_1Step[i] := ABS(temp);
					END_IF;
					Metrics.OneStepMaxError[i] := MaxError_1Step[i];
					
					tempSum := tempSum + ABS(temp);
				END_IF;
				
				ErrorCount_1Step[i] := ErrorCount_1Step[i] + 1;
				LastPrediction[i] := PredictedNext[i];
			END_FOR;
			
			(* Overall metrics *)
			IF TotalErrorCount > 0 THEN
				(* Moving average of total error *)
				ErrorWindow[ErrorWindowIndex] := tempSum / NumVars;
				ErrorWindowIndex := ErrorWindowIndex + 1;
				IF ErrorWindowIndex >= 20 THEN
					ErrorWindowIndex := 0;
				END_IF;
				
				Metrics.MovingAvgError := 0.0;
				FOR i := 0 TO 19 DO
					Metrics.MovingAvgError := Metrics.MovingAvgError + ErrorWindow[i];
				END_FOR;
				Metrics.MovingAvgError := Metrics.MovingAvgError / 20.0;
				
				(* Overall RMSE *)
				tempSum := 0.0;
				FOR i := 0 TO NumVars-1 DO
					tempSum := tempSum + Metrics.OneStepRMSE[i];
				END_FOR;
				Metrics.OverallRMSE := tempSum / NumVars;
			END_IF;
			
			TotalErrorCount := TotalErrorCount + 1;
			
			(* Trigger multi-step periodically *)
			IF CycleCount MOD Config.MultiStepUpdateInterval = 0 THEN
				MultiStepState := 1;
			END_IF;
		END_IF;
END_CASE;


(* ===== MULTI-STEP PREDICTION (Multivariable) ===== *)
CASE MultiStepState OF
	0: (* Idle *)
		;
		
	1: (* Reset *)
		IF StateFlags.ActiveModelValid THEN
			Model_Active(
				Enable := TRUE,
				Reset := FALSE,
				Train := FALSE,
				Predict := FALSE,
				PredictSteps := Config.PredictSteps,
				Config := Config.ModelConfig,
				TrainingData := TrainingData,
				PredictionOutput := PredictionOutput_Active
			);
			MultiStepState := 2;
		END_IF;
		
	2: (* Predict *)
		Model_Active(
			Enable := TRUE,
			Reset := FALSE,
			Train := FALSE,
			Predict := TRUE,
			PredictSteps := Config.PredictSteps,
			Config := Config.ModelConfig,
			TrainingData := TrainingData,
			PredictionOutput := PredictionOutput_Active
		);
		
		IF Model_Active.Done THEN
			Model_Active.Predict := FALSE;
			
			IF Model_Active.Status = NGRC_TRAINED THEN
				(* Extract multi-step predictions *)
				(* Format: [step0_var0, step0_var1, ..., step1_var0, step1_var1, ...] *)
				FOR i := 0 TO Config.PredictSteps-1 DO  (* Horizon *)
					FOR j := 0 TO NumVars-1 DO  (* Variable *)
						Predicted5Step[j, i] := PredictionOutput_Active.M[i * NumVars + j];
						PredictionHistory[j, i] := PredictionOutput_Active.M[i * NumVars + j];
						PredictionAge[j, i] := 0;
					END_FOR;
				END_FOR;
			END_IF;
			
			MultiStepState := 0;
		END_IF;
END_CASE;


(* ===== VALIDATE MULTI-STEP PREDICTIONS (Multivariable) ===== *)
FOR i := 0 TO NumVars-1 DO  (* Each variable *)
	FOR j := 0 TO 4 DO  (* Each horizon *)
		IF PredictionAge[i, j] >= 0 THEN
			PredictionAge[i, j] := PredictionAge[i, j] + 1;
			
			IF PredictionAge[i, j] = (j + 1) THEN
				(* Prediction horizon reached *)
				temp := NewSample[i] - PredictionHistory[i, j];
				Metrics.StepErrors[i, j] := temp;
				
				(* Update per-variable multi-step RMSE *)
				ErrorSum_5Step[i] := ErrorSum_5Step[i] + temp * temp;
				ErrorCount_5Step[i] := ErrorCount_5Step[i] + 1;
				Metrics.FiveStepRMSE[i] := SQRT(ErrorSum_5Step[i] / ErrorCount_5Step[i]);
				
				PredictionAge[i, j] := -1;
			END_IF;
		END_IF;
	END_FOR;
END_FOR;

END_FUNCTION_BLOCK