FUNCTION_BLOCK FB_NGRC_Simple

IF Execute AND NOT ExecuteTrigger THEN
	ExecuteTrigger := TRUE;
	State := 0;
	Done := FALSE;
	Busy := TRUE;
	Error := FALSE;
	ErrorID := NGRC_ERR_NONE;
	brsmemcpy(ADR(InternalTrainData),ADR(TrainingData),SIZEOF(HA_Matrix_Array_typ));
END_IF;

IF NOT Execute THEN
	ExecuteTrigger := FALSE;
	IF Done THEN
		State := 0;
		Busy := FALSE;
	END_IF;
END_IF;

InternalConfig.LagOrder := LagOrder;
InternalConfig.PolyOrder := PolyOrder;
InternalConfig.Stride := Stride;
InternalConfig.Lambda := Lambda;
InternalConfig.UseBias := TRUE;
InternalConfig.UseDerivative := TRUE;
InternalConfig.WarmupSteps := 0;

Model.Enable := Execute;
Model.PredictSteps := PredictSteps;

CASE State OF
	0:
		IF Execute THEN
			Model.Reset := TRUE;
			Model(Config := InternalConfig, TrainingData := InternalTrainData, PredictionOutput := InternalPredictions);
			State := 1;
		END_IF;
		
	1:
		Model.Reset := FALSE;
		Model(Config := InternalConfig, TrainingData := InternalTrainData, PredictionOutput := InternalPredictions);
		IF Model.Ready THEN
			State := 2;
		END_IF;
		
	2:
		Model.Train := TRUE;
		Model(Config := InternalConfig, TrainingData := InternalTrainData, PredictionOutput := InternalPredictions);
		IF Model.Done THEN
			Model.Train := FALSE;
			IF Model.Status = NGRC_TRAINED THEN
				State := 3;
			ELSE
				Error := TRUE;
				ErrorID := Model.Error;
				Done := TRUE;
				State := 0;
			END_IF;
		END_IF;
		
	3:
		Model.Predict := TRUE;
		Model(Config := InternalConfig, TrainingData := InternalTrainData, PredictionOutput := InternalPredictions);
		IF Model.Done THEN
			Model.Predict := FALSE;
			IF Model.Status = NGRC_TRAINED THEN
				brsmemcpy(ADR(Predictions),ADR(InternalPredictions),SIZEOF(HA_Matrix_Array_typ));
				Done := TRUE;
				State := 0;
			ELSE
				Error := TRUE;
				ErrorID := Model.Error;
				Done := TRUE;
				State := 0;
			END_IF;
		END_IF;
		
END_CASE;

END_FUNCTION_BLOCK