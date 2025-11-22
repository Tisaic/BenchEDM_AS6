
TYPE
	HA_Matrix_Array_typ : 	STRUCT 
		M : ARRAY[0..MAX_HA_MATRIX_ARRAY_IDX]OF LREAL;
		Row : DINT;
		Col : DINT;
	END_STRUCT;
	HA_Matrix_Internal_typ : 	STRUCT 
		sizeArray : UDINT;
		sizeTotal : UDINT;
		row1 : DINT;
		row2 : DINT;
		row3 : DINT;
		row4 : DINT;
		col1 : DINT;
		col2 : DINT;
		col3 : DINT;
		col4 : DINT;
		i1 : DINT;
		i2 : DINT;
		i3 : DINT;
		i4 : DINT;
		temp1 : LREAL;
		temp2 : LREAL;
		temp3 : LREAL;
		temp4 : LREAL;
		temp5 : LREAL;
		result : LREAL;
	END_STRUCT;
	NGRC_Config_typ : 	STRUCT 
		LagOrder : DINT := 2;
		PolyOrder : DINT := 2;
		Stride : DINT := 1;
		Lambda : LREAL := 2.5E-6;
		UseBias : BOOL := TRUE;
		UseDerivative : BOOL := TRUE;
		WarmupSteps : DINT := 0;
	END_STRUCT;
	NGRC_Status_enum : 
		(
		NGRC_IDLE := 0,
		NGRC_TRAINING := 1,
		NGRC_TRAINED := 2,
		NGRC_PREDICTING := 3,
		NGRC_ERROR := 99
		);
	NGRC_Error_enum : 
		(
		NGRC_ERR_NONE := 0,
		NGRC_ERR_NO_DATA := 1,
		NGRC_ERR_INVALID_CONFIG := 2,
		NGRC_ERR_INSUFFICIENT_DATA := 3,
		NGRC_ERR_TRAINING_FAILED := 4,
		NGRC_ERR_PREDICTION_FAILED := 5,
		NGRC_ERR_NOT_TRAINED := 6,
		NGRC_ERR_MEMORY := 7
		);
	NGRC_Internal_typ : 	STRUCT 
		Beta : HA_Matrix_Array_typ;
		XtX : HA_Matrix_Array_typ;
		XtY : HA_Matrix_Array_typ;
		L : HA_Matrix_Array_typ;
		LagWork : HA_Matrix_Array_typ;
		PolyWork : HA_Matrix_Array_typ;
		FeatWork : HA_Matrix_Array_typ;
		Ywork : HA_Matrix_Array_typ;
		PredWork : HA_Matrix_Array_typ;
		State : HA_Matrix_Array_typ;
		History : HA_Matrix_Array_typ;
		WorkState : HA_Matrix_Array_typ;
		WorkHist : HA_Matrix_Array_typ;
		TrainStep : DINT;
	END_STRUCT;
	NGRC_Stats_typ : 	STRUCT 
		TrainRMSE : LREAL;
		TrainR2 : LREAL;
		LastPredTime : UDINT;
		LastTrainTime : UDINT;
		NumFeatures : DINT;
		NumSamples : DINT;
	END_STRUCT;
	NGRC_Continuous_Config_typ : 	STRUCT 
		TrainingSamples : DINT := 200;
		BufferSize : DINT := 500;
		RetrainMode : DINT := 1;
		RetrainInterval : DINT := 50;
		RetrainErrorThreshold : LREAL := 0.1;
		PredictSteps : DINT := 5;
		MultiStepUpdateInterval : DINT := 5;
		ModelConfig : NGRC_Config_typ;
	END_STRUCT;
	NGRC_Continuous_Metrics_typ : 	STRUCT 
		OneStepRMSE : LREAL;
		OneStepMaxError : LREAL;
		FiveStepRMSE : LREAL;
		MovingAvgError : LREAL;
		StepErrors : ARRAY[0..4]OF LREAL;
		SampleCount : DINT;
		TotalRetrains : DINT;
		ModelSwaps : DINT;
		TrainingCycles : DINT;
	END_STRUCT;
	NGRC_Continuous_Status_typ : 	STRUCT 
		Ready : BOOL;
		PredictionValid : BOOL;
		IsTraining : BOOL;
		TrainingProgress : DINT;
		LastRetrainReason : STRING[40];
	END_STRUCT;
	StateFlags_typ : STRUCT
		Initialized : BOOL := FALSE;
		ActiveModelValid : BOOL := FALSE;
		PredictionActive : BOOL := FALSE;
	END_STRUCT;
	NGRC_MultiVar_Config_typ : STRUCT
		NumVariables : DINT := 1;
		MaxVariables : DINT := 10;
		TrainingSamples : DINT := 200;
		BufferSize : DINT := 500;
		RetrainMode : DINT := 1;
		RetrainInterval : DINT := 50;
		RetrainErrorThreshold : REAL := 0.1;
		PredictSteps : DINT := 5;
		MultiStepUpdateInterval : DINT := 5;
		ModelConfig : NGRC_Config_typ;
	END_STRUCT;
	NGRC_MultiVar_Metrics_typ : STRUCT
		OneStepRMSE : ARRAY[0..9] OF LREAL;
		OneStepMaxError : ARRAY[0..9] OF LREAL;
		FiveStepRMSE : ARRAY[0..9] OF LREAL;
		OverallRMSE : LREAL;
		MovingAvgError : LREAL;
		StepErrors : ARRAY[0..9, 0..4] OF LREAL;
		SampleCount : DINT;
		TotalRetrains : DINT;
		ModelSwaps : DINT;
		TrainingCycles : DINT;
	END_STRUCT;
	NGRC_MultiVar_Status_typ : STRUCT
		Ready : BOOL;
		PredictionValid : BOOL;
		IsTraining : BOOL;
		TrainingProgress : DINT;
		LastRetrainReason : STRING[40];
		ConfigValid : BOOL;
	END_STRUCT;
END_TYPE
