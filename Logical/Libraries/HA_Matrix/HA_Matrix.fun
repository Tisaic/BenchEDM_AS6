FUNCTION HA_Matrix_Tran : BOOL
	VAR_INPUT
		pIn : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_SwapR : BOOL
	VAR_INPUT
		Swap1 : DINT;
		Swap2 : DINT;
		pIn : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_SwapC : BOOL
	VAR_INPUT
		Swap1 : DINT;
		Swap2 : DINT;
		pIn : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Sub : BOOL
	VAR_INPUT
		pIn1 : UDINT;
		pIn2 : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Rref : BOOL
	VAR_INPUT
		pIn : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Mult : BOOL
	VAR_INPUT
		pIn1 : UDINT;
		pIn2 : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Inc : BOOL
	VAR_INPUT
		pIn : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_I : BOOL
	VAR_INPUT
		pIn : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Fill : BOOL
	VAR_INPUT
		FillValue : LREAL;
		pIn : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Det : LREAL
	VAR_INPUT
		pIn : UDINT;
		pTemp : UDINT;
		pResult : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Add : BOOL
	VAR_INPUT
		pIn1 : UDINT;
		pIn2 : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Cholesky : BOOL
	VAR_INPUT
		pIn : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_CholSolve : BOOL
	VAR_INPUT
		pL : UDINT;
		pB : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_XtX : BOOL
	VAR_INPUT
		pX : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_XtY : BOOL
	VAR_INPUT
		pX : UDINT;
		pY : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_AddRidge : BOOL
	VAR_INPUT
		pInOut : UDINT;
		Lambda : LREAL;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_RLS : BOOL
	VAR_INPUT
		pTheta : UDINT;
		pP : UDINT;
		pX : UDINT;
		Y : LREAL;
		Lambda : LREAL;
		pTemp : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_RLS_Init : BOOL
	VAR_INPUT
		pTheta : UDINT;
		pP : UDINT;
		InitVariance : LREAL;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Predict : BOOL
	VAR_INPUT
		pX : UDINT;
		pBeta : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_BuildLags : BOOL
	VAR_INPUT
		pY_history : UDINT;
		pU_history : UDINT;
		LagOrder : DINT;
		NumOutputs : DINT;
		NumInputs : DINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_RollingUpdate : BOOL
	VAR_INPUT
		pBuffer : UDINT;
		NewValue : LREAL;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_RMSE : LREAL
	VAR_INPUT
		pY_true : UDINT;
		pY_pred : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Residuals : BOOL
	VAR_INPUT
		pY_true : UDINT;
		pY_pred : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_R2Score : LREAL
	VAR_INPUT
		pY_true : UDINT;
		pY_pred : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Standardize : BOOL
	VAR_INPUT
		pX : UDINT;
		pMean : UDINT;
		pStd : UDINT;
		Mode : DINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_PolyExpand : BOOL
	VAR_INPUT
		pX : UDINT;
		Order : DINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Diff : BOOL
	VAR_INPUT
		pX : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_AddBias : BOOL
	VAR_INPUT
		pX : UDINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_PredictMultiStep : BOOL
	VAR_INPUT
		pState : UDINT;
		pBeta : UDINT;
		pHistory : UDINT;
		Steps : DINT;
		LagOrder : DINT;
		PolyOrder : DINT;
		UseDerivative : BOOL;
		UseBias : BOOL;
		pOut : UDINT;
		pLagTemp : UDINT;
		pPolyTemp : UDINT;
		pFeatTemp : UDINT;
		pPredTemp : UDINT;
		pWorkState : UDINT;
		pWorkHist : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
		Success : BOOL;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_Ridge_Fit : BOOL
	VAR_INPUT
		pX : UDINT;
		pY : UDINT;
		Lambda : LREAL;
		UseBias : BOOL;
		WarmupSteps : DINT;
		pBeta : UDINT;
		pXtX : UDINT;
		pXtY : UDINT;
		pL : UDINT;
		pXwork : UDINT;
		pYwork : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
		Success : BOOL;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_BuildLagsStride : BOOL
	VAR_INPUT
		pY_history : UDINT;
		pU_history : UDINT;
		LagOrder : DINT;
		NumOutputs : DINT;
		NumInputs : DINT;
		Stride : DINT;
		pOut : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_InitStateBuffer : BOOL
	VAR_INPUT
		pX : UDINT;
		LagOrder : DINT;
		pState : UDINT;
		pHistory : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_NGRC_BuildTrainingData : BOOL
	VAR_INPUT
		pX : UDINT;
		LagOrder : DINT;
		PolyOrder : DINT;
		Stride : DINT;
		UseBias : BOOL;
		WarmupSteps : DINT;
		pOut : UDINT;
		pLagWork : UDINT;
		pPolyWork : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
		Success : BOOL;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_NGRC_Fit : BOOL
	VAR_INPUT
		pX : UDINT;
		pY : UDINT;
		LagOrder : DINT;
		PolyOrder : DINT;
		Stride : DINT;
		Lambda : LREAL;
		UseBias : BOOL;
		UseDerivative : BOOL;
		WarmupSteps : DINT;
		pBeta : UDINT;
		pXtX : UDINT;
		pXtY : UDINT;
		pL : UDINT;
		pLagWork : UDINT;
		pPolyWork : UDINT;
		pFeatWork : UDINT;
		pYwork : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
		Success : BOOL;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_NGRC_InitState : BOOL
	VAR_INPUT
		pX : UDINT;
		LagOrder : DINT;
		Stride : DINT;
		pState : UDINT;
		pHistory : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_NGRC_Predict : BOOL
	VAR_INPUT
		pHistory : UDINT;
		pBeta : UDINT;
		LagOrder : DINT;
		PolyOrder : DINT;
		UseBias : BOOL;
		pOut : UDINT;
		pLagWork : UDINT;
		pPolyWork : UDINT;
		pFeatWork : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
		Success : BOOL;
	END_VAR
END_FUNCTION

FUNCTION HA_Matrix_NGRC_PredictMultiStep : BOOL
	VAR_INPUT
		pState : UDINT;
		pBeta : UDINT;
		pHistory : UDINT;
		Steps : DINT;
		LagOrder : DINT;
		PolyOrder : DINT;
		Stride : DINT;
		UseBias : BOOL;
		UseDerivative : BOOL;
		pOut : UDINT;
		pLagWork : UDINT;
		pPolyWork : UDINT;
		pFeatWork : UDINT;
		pPredWork : UDINT;
		pWorkState : UDINT;
		pWorkHist : UDINT;
	END_VAR
	VAR
		Internal : HA_Matrix_Internal_typ;
		Success : BOOL;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK FB_NGRC
	VAR_INPUT
		Enable : BOOL;
		Train : BOOL;
		Predict : BOOL;
		PredictSteps : DINT;
		Reset : BOOL;
	END_VAR
	VAR_OUTPUT
		Status : NGRC_Status_enum;
		Error : NGRC_Error_enum;
		Ready : BOOL;
		Busy : BOOL;
		Done : BOOL;
		Stats : NGRC_Stats_typ;
	END_VAR
	VAR_IN_OUT
		Config : NGRC_Config_typ;
		TrainingData : HA_Matrix_Array_typ;
		PredictionOutput : HA_Matrix_Array_typ;
	END_VAR
	VAR
		Internal : NGRC_Internal_typ;
		TrainTrigger : BOOL;
		PredictTrigger : BOOL;
		ResetTrigger : BOOL;
		Success : BOOL;
		StartTime : UDINT;
		NumDims : DINT;
		NumSamples : DINT;
		IsTrained : BOOL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_NGRC_Online
	VAR_INPUT
		Enable : BOOL;
		NewSample : BOOL;
		PredictNext : BOOL;
		Reset : BOOL;
	END_VAR
	VAR_OUTPUT
		Status : NGRC_Status_enum;
		Error : NGRC_Error_enum;
		Ready : BOOL;
		PredictionValid : BOOL;
	END_VAR
	VAR_IN_OUT
		Config : NGRC_Config_typ;
		CurrentValue : HA_Matrix_Array_typ;
		Prediction : HA_Matrix_Array_typ;
		TrainedModel : FB_NGRC;
	END_VAR
	VAR
		History : HA_Matrix_Array_typ;
		State : HA_Matrix_Array_typ;
		PredWork : HA_Matrix_Array_typ;
		NewSampleTrigger : BOOL;
		PredictTrigger : BOOL;
		Success : BOOL;
		Initialized : BOOL;
		NumDims : DINT;
		i : DINT;
		temp : LREAL;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_NGRC_Simple
	VAR_INPUT
		Execute : BOOL;
		LagOrder : DINT;
		PolyOrder : DINT;
		Stride : DINT;
		Lambda : LREAL;
		PredictSteps : DINT;
	END_VAR
	VAR_OUTPUT
		Done : BOOL;
		Busy : BOOL;
		Error : BOOL;
		ErrorID : NGRC_Error_enum;
	END_VAR
	VAR_IN_OUT
		TrainingData : HA_Matrix_Array_typ;
		Predictions : HA_Matrix_Array_typ;
	END_VAR
	VAR
		Model : FB_NGRC;
		InternalConfig : NGRC_Config_typ;
		InternalTrainData : HA_Matrix_Array_typ;
		InternalPredictions : HA_Matrix_Array_typ;
		ExecuteTrigger : BOOL;
		State : DINT;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_NGRC_Continuous
	VAR_INPUT
		Enable : BOOL;
		Reset : BOOL;
		NewSample : LREAL;
	END_VAR
	VAR_OUTPUT
		PredictedNext : LREAL;
		Predicted5Step : ARRAY[0..4] OF LREAL;
		Status : NGRC_Continuous_Status_typ;
		Metrics : NGRC_Continuous_Metrics_typ;
	END_VAR
	VAR_IN_OUT
		Config : NGRC_Continuous_Config_typ;
	END_VAR
	VAR
		Model_Active : FB_NGRC;
		Model_Training : FB_NGRC;
		Predictor_Online : FB_NGRC_Online;
		DataBuffer : ARRAY[0..499] OF LREAL;
		BufferIndex : DINT := 0;
		BufferFull : BOOL := FALSE;
		TrainingData : HA_Matrix_Array_typ;
		CurrentSample : HA_Matrix_Array_typ;
		PredictionBuffer : HA_Matrix_Array_typ;
		PredictionOutput_Active : HA_Matrix_Array_typ;
		PredictionOutput_Training : HA_Matrix_Array_typ;
		TrainingState : DINT := 0;
		StateFlags : StateFlags_typ;
		ModelSwapReady : BOOL := FALSE;
		SamplesSinceRetrain : DINT := 0;
		RetrainTrigger : BOOL := FALSE;
		PredictionState : DINT := 0;
		MultiStepState : DINT := 0;
		ErrorSum_1Step : LREAL := 0.0;
		ErrorCount_1Step : DINT := 0;
		MaxError_1Step : LREAL := 0.0;
		LastPrediction : LREAL := 0.0;
		ErrorSum_5Step : LREAL := 0.0;
		ErrorCount_5Step : DINT := 0;
		ErrorWindow : ARRAY[0..19] OF LREAL;
		ErrorWindowIndex : DINT := 0;
		PredictionHistory : ARRAY[0..4] OF LREAL;
		PredictionAge : ARRAY[0..4] OF DINT;
		i : DINT;
		j : DINT;
		temp : LREAL;
		CycleCount : DINT := 0;
	END_VAR
END_FUNCTION_BLOCK

FUNCTION_BLOCK FB_NGRC_Continuous_MultiVar
VAR_INPUT
	Enable : BOOL;
	Reset : BOOL;
	NewSample : ARRAY[0..9] OF LREAL;
END_VAR
VAR_OUTPUT
	PredictedNext : ARRAY[0..9] OF LREAL;
	Predicted5Step : ARRAY[0..9, 0..4] OF LREAL;
	Status : NGRC_MultiVar_Status_typ;
	Metrics : NGRC_MultiVar_Metrics_typ;
END_VAR
VAR_IN_OUT
	Config : NGRC_MultiVar_Config_typ;
END_VAR
VAR
	Model_Active : FB_NGRC;
	Model_Training : FB_NGRC;
	Predictor_Online : FB_NGRC_Online;
	DataBuffer : ARRAY[0..4999] OF LREAL;
	BufferIndex : DINT := 0;
	BufferFull : BOOL := FALSE;
	TrainingData : HA_Matrix_Array_typ;
	CurrentSample : HA_Matrix_Array_typ;
	PredictionBuffer : HA_Matrix_Array_typ;
	PredictionOutput_Active : HA_Matrix_Array_typ;
	PredictionOutput_Training : HA_Matrix_Array_typ;
	StateFlags : StateFlags_typ;
	TrainingState : DINT := 0;
	ModelSwapReady : BOOL := FALSE;
	SamplesSinceRetrain : DINT := 0;
	RetrainTrigger : BOOL := FALSE;
	PredictionState : DINT := 0;
	MultiStepState : DINT := 0;
	ErrorSum_1Step : ARRAY[0..9] OF LREAL;
	ErrorCount_1Step : ARRAY[0..9] OF DINT;
	MaxError_1Step : ARRAY[0..9] OF LREAL;
	LastPrediction : ARRAY[0..9] OF LREAL;
	ErrorSum_5Step : ARRAY[0..9] OF LREAL;
	ErrorCount_5Step : ARRAY[0..9] OF DINT;
	ErrorWindow : ARRAY[0..19] OF LREAL;
	ErrorWindowIndex : DINT := 0;
	TotalErrorSum : LREAL := 0.0;
	TotalErrorCount : DINT := 0;
	PredictionHistory : ARRAY[0..9, 0..4] OF LREAL;
	PredictionAge : ARRAY[0..9, 0..4] OF DINT;
	i : DINT;
	j : DINT;
	k : DINT;
	temp : LREAL;
	tempSum : LREAL;
	CycleCount : DINT := 0;
	NumVars : DINT;
	BufferOffset : DINT;
END_VAR
END_FUNCTION_BLOCK