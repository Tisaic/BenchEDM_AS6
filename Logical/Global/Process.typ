
TYPE
	Process_typ : 	STRUCT 
		Monitor : P_Monitor_typ;
		Master : P_Master_typ;
	END_STRUCT;
	P_Monitor_typ : 	STRUCT 
		Out : P_Monitor_Out_typ;
		In : P_Monitor_In_typ;
		Internal : P_Monitor_Internal_typ;
	END_STRUCT;
	P_Monitor_Out_typ : 	STRUCT 
		SevActiveAny : BOOL;
		SevActive : ARRAY[0..MAX_SEVERITY_IDX]OF BOOL;
		ProcessErrorSev : ARRAY[0..MAX_PROCESS_IDX]OF DINT;
	END_STRUCT;
	P_Monitor_In_typ : 	STRUCT 
		New_Member : USINT;
	END_STRUCT;
	P_Monitor_Internal_typ : 	STRUCT 
		tempAlarm : TC_AlarmX_Core_Buffer_typ;
		TC_Mon_0 : ARRAY[0..MAX_MON_IDX]OF TC_Mon;
		TempSTRING : STRING[80];
	END_STRUCT;
	P_Master_typ : 	STRUCT 
		In : P_Master_In_typ;
		Internal : P_Master_Internal_typ;
		Out : P_Master_Out_typ;
	END_STRUCT;
	P_Master_In_typ : 	STRUCT 
		Par : P_Master_In_Par_typ;
		Cmd : P_Master_In_Cmd_typ;
	END_STRUCT;
	P_Master_In_Par_typ : 	STRUCT 
		SingleStepMode : BOOL;
	END_STRUCT;
	P_Master_In_Cmd_typ : 	STRUCT 
		Reset : BOOL;
		Start : BOOL;
		UncontrolledStop : BOOL;
		ControlledStop : BOOL;
		NormalStop : BOOL;
		Pause : BOOL;
		Unpause : BOOL;
		SingleStep : BOOL;
	END_STRUCT;
	P_Master_Internal_typ : 	STRUCT 
		CALL : MASTER_CALL_ENUM;
		WAIT : ARRAY[0..MAX_TC_SEQ_WAIT_IDX]OF MASTER_W_ENUM;
		ENABLE : ARRAY[0..MAX_TC_SEQ_CMD_IDX]OF BOOL;
		CMD : MASTER_C_ENUM;
		ELEMENT : TC_Seq_Handler_Buffer_typ;
		BUFFER : ARRAY[0..MAX_TC_SEQ_BUFFER_IDX]OF TC_Seq_Handler_Buffer_typ;
		TC_Eval_0 : ARRAY[0..MAX_MASTER_EVAL_IDX]OF TC_Eval;
		TC_Seq_Handler_0 : TC_Seq_Handler;
	END_STRUCT;
	P_Master_Out_IgnoreInfo_typ : 	STRUCT 
		Cmd : STRING[255];
		Reason : STRING[255];
	END_STRUCT;
	P_Master_Out_ErrorInfo_typ : 	STRUCT 
		Severity : DINT;
		Text : STRING[255];
	END_STRUCT;
	P_Master_Out_Status_typ : 	STRUCT 
		CurrentState : STRING[80];
		Stopping : BOOL;
		Paused : BOOL;
		InReset : BOOL;
		Initializing : BOOL;
		WaitingForCommand : BOOL;
		SingleStepWaiting : BOOL;
		Processing : BOOL;
		InError : BOOL;
		Error : BOOL;
	END_STRUCT;
	P_Master_Out_typ : 	STRUCT 
		IgnoreInfo : P_Master_Out_IgnoreInfo_typ;
		ErrorInfo : P_Master_Out_ErrorInfo_typ;
		Status : P_Master_Out_Status_typ;
	END_STRUCT;
END_TYPE
