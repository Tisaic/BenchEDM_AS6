FUNCTION_BLOCK FB_NGRC

IF NOT Enable THEN
	Status := NGRC_IDLE;
	Error := NGRC_ERR_NONE;
	Ready := FALSE;
	Busy := FALSE;
	Done := FALSE;
	IsTrained := FALSE;
	RETURN;
END_IF;

IF Reset AND NOT ResetTrigger THEN
	ResetTrigger := TRUE;
	Status := NGRC_IDLE;
	Error := NGRC_ERR_NONE;
	Done := FALSE;
	IsTrained := FALSE;
	Internal.TrainStep := 0;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
END_IF;
IF NOT Reset THEN
	ResetTrigger := FALSE;
END_IF;

Ready := (Status = NGRC_IDLE OR Status = NGRC_TRAINED) AND NOT Busy;
Busy := (Status = NGRC_TRAINING OR Status = NGRC_PREDICTING);

IF Train AND NOT TrainTrigger AND NOT Busy THEN
	TrainTrigger := TRUE;
	Done := FALSE;
	Status := NGRC_TRAINING;
	Error := NGRC_ERR_NONE;
	Internal.TrainStep := 0;
	StartTime := 0;
END_IF;
IF NOT Train THEN
	TrainTrigger := FALSE;
END_IF;

IF Predict AND NOT PredictTrigger AND NOT Busy THEN
	PredictTrigger := TRUE;
	Done := FALSE;
	IF NOT IsTrained THEN
		Status := NGRC_ERROR;
		Error := NGRC_ERR_NOT_TRAINED;
		Done := TRUE;
	ELSE
		Status := NGRC_PREDICTING;
		Error := NGRC_ERR_NONE;
		StartTime := 0;
	END_IF;
END_IF;
IF NOT Predict THEN
	PredictTrigger := FALSE;
END_IF;

CASE Status OF
	NGRC_IDLE:
		;
		
	NGRC_TRAINING:
		IF Internal.TrainStep = 0 THEN
			NumDims := TrainingData.Col;
			NumSamples := TrainingData.Row;
			IF NumDims = 0 OR NumSamples = 0 THEN
				Status := NGRC_ERROR;
				Error := NGRC_ERR_NO_DATA;
				Done := TRUE;
				RETURN;
			END_IF;
			IF Config.LagOrder < 1 OR Config.PolyOrder < 1 OR Config.PolyOrder > 3 OR Config.Stride < 1 OR Config.Lambda < 0.0 THEN
				Status := NGRC_ERROR;
				Error := NGRC_ERR_INVALID_CONFIG;
				Done := TRUE;
				RETURN;
			END_IF;
			IF NumSamples <= (Config.LagOrder-1)*Config.Stride + Config.WarmupSteps + 1 THEN
				Status := NGRC_ERROR;
				Error := NGRC_ERR_INSUFFICIENT_DATA;
				Done := TRUE;
				RETURN;
			END_IF;
			Stats.NumSamples := NumSamples - (Config.LagOrder-1)*Config.Stride - Config.WarmupSteps;
			IF Config.PolyOrder = 2 THEN
				Stats.NumFeatures := NumDims*Config.LagOrder + (NumDims*Config.LagOrder*(NumDims*Config.LagOrder+1))/2;
			ELSIF Config.PolyOrder = 3 THEN
				Stats.NumFeatures := NumDims*Config.LagOrder + (NumDims*Config.LagOrder*(NumDims*Config.LagOrder+1))/2 + (NumDims*Config.LagOrder*(NumDims*Config.LagOrder+1)*(NumDims*Config.LagOrder+2))/6;
			ELSE
				Stats.NumFeatures := NumDims*Config.LagOrder;
			END_IF;
			IF Config.UseBias THEN
				Stats.NumFeatures := Stats.NumFeatures + 1;
			END_IF;
			IF Stats.NumFeatures*Stats.NumFeatures > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
				Status := NGRC_ERROR;
				Error := NGRC_ERR_MEMORY;
				Done := TRUE;
				RETURN;
			END_IF;
			Internal.TrainStep := 1;
			
		ELSIF Internal.TrainStep = 1 THEN
			Success := HA_Matrix_NGRC_Fit(
				ADR(TrainingData),
				ADR(TrainingData),
				Config.LagOrder,
				Config.PolyOrder,
				Config.Stride,
				Config.Lambda,
				Config.UseBias,
				Config.UseDerivative,
				Config.WarmupSteps,
				ADR(Internal.Beta),
				ADR(Internal.XtX),
				ADR(Internal.XtY),
				ADR(Internal.L),
				ADR(Internal.LagWork),
				ADR(Internal.PolyWork),
				ADR(Internal.FeatWork),
				ADR(Internal.Ywork)
			);
			IF NOT Success THEN
				Status := NGRC_ERROR;
				Error := NGRC_ERR_TRAINING_FAILED;
				Done := TRUE;
				RETURN;
			END_IF;
			Internal.TrainStep := 2;
			
		ELSIF Internal.TrainStep = 2 THEN
			Success := HA_Matrix_NGRC_InitState(
				ADR(TrainingData),
				Config.LagOrder,
				Config.Stride,
				ADR(Internal.State),
				ADR(Internal.History)
			);
			IF NOT Success THEN
				Status := NGRC_ERROR;
				Error := NGRC_ERR_TRAINING_FAILED;
				Done := TRUE;
				RETURN;
			END_IF;
			Internal.TrainStep := 3;
			
		ELSIF Internal.TrainStep = 3 THEN
			IsTrained := TRUE;
			Status := NGRC_TRAINED;
			Done := TRUE;
			Internal.TrainStep := 0;
		END_IF;
		
	NGRC_TRAINED:
		;
		
	NGRC_PREDICTING:
		IF PredictSteps <= 0 THEN
			PredictSteps := 1;
		END_IF;
		Success := HA_Matrix_NGRC_PredictMultiStep(
			ADR(Internal.State),
			ADR(Internal.Beta),
			ADR(Internal.History),
			PredictSteps,
			Config.LagOrder,
			Config.PolyOrder,
			Config.Stride,
			Config.UseBias,
			Config.UseDerivative,
			ADR(PredictionOutput),
			ADR(Internal.LagWork),
			ADR(Internal.PolyWork),
			ADR(Internal.FeatWork),
			ADR(Internal.PredWork),
			ADR(Internal.WorkState),
			ADR(Internal.WorkHist)
		);
		IF NOT Success THEN
			Status := NGRC_ERROR;
			Error := NGRC_ERR_PREDICTION_FAILED;
			Done := TRUE;
		ELSE
			Status := NGRC_TRAINED;
			Done := TRUE;
		END_IF;
		
	NGRC_ERROR:
		;
		
END_CASE;

END_FUNCTION_BLOCK