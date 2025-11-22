FUNCTION_BLOCK FB_NGRC_Online

IF NOT Enable THEN
	Status := NGRC_IDLE;
	Error := NGRC_ERR_NONE;
	Ready := FALSE;
	PredictionValid := FALSE;
	Initialized := FALSE;
	RETURN;
END_IF;

IF Reset THEN
	Status := NGRC_IDLE;
	Error := NGRC_ERR_NONE;
	PredictionValid := FALSE;
	Initialized := FALSE;
	RETURN;
END_IF;

IF NOT TrainedModel.Ready OR NOT TrainedModel.IsTrained THEN
	Status := NGRC_ERROR;
	Error := NGRC_ERR_NOT_TRAINED;
	Ready := FALSE;
	RETURN;
END_IF;

IF NOT Initialized THEN
	NumDims := CurrentValue.Col;
	IF CurrentValue.Row <> 1 OR NumDims = 0 THEN
		Status := NGRC_ERROR;
		Error := NGRC_ERR_INVALID_CONFIG;
		RETURN;
	END_IF;
	brsmemcpy(ADR(State),ADR(TrainedModel.Internal.State),SIZEOF(HA_Matrix_Array_typ));
	brsmemcpy(ADR(History),ADR(TrainedModel.Internal.History),SIZEOF(HA_Matrix_Array_typ));
	Initialized := TRUE;
	Status := NGRC_IDLE;
	Ready := TRUE;
END_IF;

IF NewSample AND NOT NewSampleTrigger THEN
	NewSampleTrigger := TRUE;
	FOR i := 0 TO NumDims-1 DO
		temp := CurrentValue.M[i];
		brsmemcpy(ADR(State.M[i]),ADR(temp),8);
	END_FOR;
	FOR i := History.Row*History.Col-1 TO NumDims BY -1 DO
	    temp := History.M[i-NumDims];
		brsmemcpy(ADR(History.M[i]),ADR(temp),8);
	END_FOR;
	FOR i := 0 TO NumDims-1 DO
		temp := State.M[i];
		brsmemcpy(ADR(History.M[i]),ADR(temp),8);
	END_FOR;
	PredictionValid := FALSE;
END_IF;
IF NOT NewSample THEN
	NewSampleTrigger := FALSE;
END_IF;

IF PredictNext AND NOT PredictTrigger THEN
	PredictTrigger := TRUE;
	Status := NGRC_PREDICTING;
	Success := HA_Matrix_NGRC_Predict(
		ADR(History),
		ADR(TrainedModel.Internal.Beta),
		Config.LagOrder,
		Config.PolyOrder,
		Config.UseBias,
		ADR(PredWork),
		ADR(TrainedModel.Internal.LagWork),
		ADR(TrainedModel.Internal.PolyWork),
		ADR(TrainedModel.Internal.FeatWork)
	);
	IF NOT Success THEN
		Status := NGRC_ERROR;
		Error := NGRC_ERR_PREDICTION_FAILED;
		PredictionValid := FALSE;
	ELSE
		IF Config.UseDerivative THEN
			FOR i := 0 TO NumDims-1 DO
				PredWork.M[i] := State.M[i] + PredWork.M[i];
			END_FOR;
		END_IF;
		brsmemcpy(ADR(Prediction),ADR(PredWork),SIZEOF(HA_Matrix_Array_typ));
		Status := NGRC_IDLE;
		PredictionValid := TRUE;
	END_IF;
END_IF;
IF NOT PredictNext THEN
	PredictTrigger := FALSE;
END_IF;

Ready := (Status = NGRC_IDLE) AND Initialized;

END_FUNCTION_BLOCK