FUNCTION_BLOCK FB_NGRC_Continuous

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
	ErrorSum_1Step := 0.0;
	ErrorCount_1Step := 0;
	ErrorSum_5Step := 0.0;
	ErrorCount_5Step := 0;
	MaxError_1Step := 0.0;
	Status.Ready := FALSE;
	Status.PredictionValid := FALSE;
	Status.IsTraining := FALSE;
	RETURN;
END_IF;

IF NOT StateFlags.Initialized THEN
	TrainingData.Row := 0;
	TrainingData.Col := 1;
	CurrentSample.Row := 1;
	CurrentSample.Col := 1;
	PredictionBuffer.Row := 1;  (* ADD THIS *)
	PredictionBuffer.Col := 1;  (* ADD THIS *)
	
	FOR i := 0 TO 19 DO
		ErrorWindow[i] := 0.0;
	END_FOR;
	
	FOR i := 0 TO 4 DO
		PredictionAge[i] := -1;
	END_FOR;
	
	StateFlags.Initialized := TRUE;
END_IF;

CycleCount := CycleCount + 1;

(* ===== DATA COLLECTION ===== *)
DataBuffer[BufferIndex] := NewSample;
BufferIndex := BufferIndex + 1;
IF BufferIndex >= Config.BufferSize THEN
	BufferIndex := 0;
	BufferFull := TRUE;
END_IF;
Metrics.SampleCount := Metrics.SampleCount + 1;

(* ===== BACKGROUND TRAINING ===== *)
IF TrainingState = 0 THEN
	IF NOT StateFlags.ActiveModelValid THEN
		IF Metrics.SampleCount >= Config.TrainingSamples THEN
			TrainingState := 1;
			Status.IsTraining := TRUE;
			Status.LastRetrainReason := 'Initial training';
		END_IF;
	ELSE
		SamplesSinceRetrain := SamplesSinceRetrain + 1;
		
		CASE Config.RetrainMode OF
			1:
				IF SamplesSinceRetrain >= Config.RetrainInterval THEN
					RetrainTrigger := TRUE;
					Status.LastRetrainReason := 'Interval';
				END_IF;
			2:
				IF Metrics.MovingAvgError > Config.RetrainErrorThreshold THEN
					RetrainTrigger := TRUE;
					Status.LastRetrainReason := 'Error threshold';
				END_IF;
			3:
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

CASE TrainingState OF
	0:
		Status.TrainingProgress := 0;
		Metrics.TrainingCycles := 0;
		
	1:
		IF BufferFull THEN
			FOR i := 0 TO Config.TrainingSamples-1 DO
				j := BufferIndex - Config.TrainingSamples + i;
				IF j < 0 THEN j := j + Config.BufferSize; END_IF;
				TrainingData.M[i] := DataBuffer[j];
			END_FOR;
		ELSE
			FOR i := 0 TO Config.TrainingSamples-1 DO
				TrainingData.M[i] := DataBuffer[i];
			END_FOR;
		END_IF;
		TrainingData.Row := Config.TrainingSamples;
		TrainingData.Col := 1;
		
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
		
	2:
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
				ModelSwapReady := TRUE;
				TrainingState := 0;
				Status.IsTraining := FALSE;
				Status.TrainingProgress := 100;
			ELSE
				TrainingState := 0;
				Status.IsTraining := FALSE;
				Status.TrainingProgress := 0;
			END_IF;
		END_IF;
END_CASE;

(* ===== MODEL SWAP ===== *)
IF ModelSwapReady THEN
	brsmemcpy(ADR(Model_Active.Internal), ADR(Model_Training.Internal), SIZEOF(NGRC_Internal_typ));
	
	StateFlags.ActiveModelValid := TRUE;
	ModelSwapReady := FALSE;
	Metrics.ModelSwaps := Metrics.ModelSwaps + 1;
	
	PredictionState := 0;
	StateFlags.PredictionActive := FALSE;
	MultiStepState := 1;
END_IF;

(* ===== CONTINUOUS 1-STEP PREDICTION ===== *)
CASE PredictionState OF
	0:
		IF StateFlags.ActiveModelValid THEN
			PredictionState := 1;
		END_IF;
		
	1:
		CurrentSample.M[0] := NewSample;
		
		Predictor_Online(
			Enable := TRUE,
			Reset := TRUE,
			NewSample := FALSE,
			PredictNext := FALSE,
			Config := Config.ModelConfig,
			CurrentValue := CurrentSample,
			Prediction := PredictionBuffer,  (* CHANGED - Pass buffer *)
			TrainedModel := Model_Active
		);
		
		IF Predictor_Online.Ready THEN
			Predictor_Online.Reset := FALSE;
			StateFlags.PredictionActive := TRUE;
			PredictionState := 2;
			Status.Ready := TRUE;
		END_IF;
		
	2:
		CurrentSample.M[0] := NewSample;
		
		Predictor_Online(
			Enable := TRUE,
			Reset := FALSE,
			NewSample := TRUE,
			PredictNext := TRUE,
			Config := Config.ModelConfig,
			CurrentValue := CurrentSample,
			Prediction := PredictionBuffer,  (* CHANGED - Pass buffer *)
			TrainedModel := Model_Active
		);
		
		IF Predictor_Online.PredictionValid THEN
			Status.PredictionValid := TRUE;
			PredictedNext := PredictionBuffer.M[0];  (* CHANGED - Read from buffer *)
			
			IF ErrorCount_1Step > 0 THEN
				temp := NewSample - LastPrediction;
				ErrorSum_1Step := ErrorSum_1Step + temp * temp;
				Metrics.OneStepRMSE := SQRT(ErrorSum_1Step / ErrorCount_1Step);
				
				IF ABS(temp) > MaxError_1Step THEN
					MaxError_1Step := ABS(temp);
				END_IF;
				Metrics.OneStepMaxError := MaxError_1Step;
				
				ErrorWindow[ErrorWindowIndex] := ABS(temp);
				ErrorWindowIndex := ErrorWindowIndex + 1;
				IF ErrorWindowIndex >= 20 THEN
					ErrorWindowIndex := 0;
				END_IF;
				
				Metrics.MovingAvgError := 0.0;
				FOR i := 0 TO 19 DO
					Metrics.MovingAvgError := Metrics.MovingAvgError + ErrorWindow[i];
				END_FOR;
				Metrics.MovingAvgError := Metrics.MovingAvgError / 20.0;
			END_IF;
			
			ErrorCount_1Step := ErrorCount_1Step + 1;
			LastPrediction := PredictedNext;
			
			IF CycleCount MOD Config.MultiStepUpdateInterval = 0 THEN
				MultiStepState := 1;
			END_IF;
		END_IF;
END_CASE;

(* ===== MULTI-STEP PREDICTION ===== *)
CASE MultiStepState OF
	0:
		;
		
	1:
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
		
	2:
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
				FOR i := 0 TO 4 DO
					Predicted5Step[i] := PredictionOutput_Active.M[i];
					PredictionHistory[i] := PredictionOutput_Active.M[i];
					PredictionAge[i] := 0;
				END_FOR;
			END_IF;
			
			MultiStepState := 0;
		END_IF;
END_CASE;

(* ===== VALIDATE MULTI-STEP PREDICTIONS ===== *)
FOR i := 0 TO 4 DO
	IF PredictionAge[i] >= 0 THEN
		PredictionAge[i] := PredictionAge[i] + 1;
		
		IF PredictionAge[i] = (i + 1) THEN
			temp := NewSample - PredictionHistory[i];
			Metrics.StepErrors[i] := temp;
			
			ErrorSum_5Step := ErrorSum_5Step + temp * temp;
			ErrorCount_5Step := ErrorCount_5Step + 1;
			Metrics.FiveStepRMSE := SQRT(ErrorSum_5Step / ErrorCount_5Step);
			
			PredictionAge[i] := -1;
		END_IF;
	END_IF;
END_FOR;

END_FUNCTION_BLOCK