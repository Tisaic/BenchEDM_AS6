
TYPE
	Services_typ : 	STRUCT 
		DeviceName : STRING[255];
		Alarms : S_Alarms_typ;
		Recipes : S_Recipes_typ;
		DirMan : S_DirMan_typ;
		Time : S_Time_typ;
	END_STRUCT;
	S_Out_Status_typ : 	STRUCT 
		CurrentState : STRING[80];
		InReset : BOOL;
		Initializing : BOOL;
		WaitingForCommand : BOOL;
		Processing : BOOL;
		InError : BOOL;
		Error : BOOL;
	END_STRUCT;
	S_Out_Ignore_typ : 	STRUCT 
		Cmd : STRING[255];
		Reason : STRING[255];
	END_STRUCT;
	S_Out_ErrorInfo_typ : 	STRUCT 
		Severity : USINT;
		Text : STRING[255];
		State : STRING[80];
		Code : UINT;
	END_STRUCT;
	S_Alarms_typ : 	STRUCT 
		In : S_Alarms_In_typ;
		Internal : S_Alarms_Internal_typ;
		Out : S_Alarms_Out_typ;
	END_STRUCT;
	S_Alarms_In_typ : 	STRUCT 
		ResetAlarms : BOOL;
		ClearHistory : BOOL;
		ExportHistory : BOOL;
		AlarmList : ARRAY[0..TC_ALARMX_BUFFER_IDX]OF TC_AlarmX_Core_Buffer_typ;
	END_STRUCT;
	S_Alarms_Internal_typ : 	STRUCT 
		MpAlarmXListUI_0 : MpAlarmXListUI;
		MpAlarmXHistory_0 : MpAlarmXHistory;
		MpAlarmXCore_0 : MpAlarmXCore;
		CTON_StartDelay : CTON;
		CTON_ResetDelay : CTON;
		StateResetAlarms : INT;
		StateExportHistory : INT;
		MpAlarmXHistoryUI_0 : MpAlarmXHistoryUI;
		TC_AlarmXCore_0 : TC_AlarmXCore;
	END_STRUCT;
	S_Alarms_Out_typ : 	STRUCT 
		AlarmActive : BOOL;
		BufferInfo : TC_AlarmX_BufferInfo_typ;
	END_STRUCT;
	S_Recipes_typ : 	STRUCT 
		In : S_Recipes_In_typ;
		Internal : S_Recipes_Internal_typ;
		Out : S_Recipes_Out_typ;
	END_STRUCT;
	S_Recipes_In_typ : 	STRUCT 
		ForceDefaults : BOOL;
		ForceSave : BOOL;
		ForceLoad : BOOL;
		RecipeDefinitions : ARRAY[0..MAX_TC_RECIPE_IDX]OF Recipe_Definition_typ;
	END_STRUCT;
	S_Recipes_Internal_typ : 	STRUCT 
		TC_Recipe_Helper_0 : ARRAY[0..MAX_TC_RECIPE_IDX]OF TC_Recipe_Helper;
		tempAlarm : TC_AlarmX_Core_Buffer_typ;
	END_STRUCT;
	S_Recipes_Out_typ : 	STRUCT 
		ParametersReady : BOOL;
	END_STRUCT;
	S_DirMan_typ : 	STRUCT 
		In : S_DirMan_In_typ;
		Out : S_DirMan_Out_typ;
		Internal : S_DirMan_Internal_typ;
	END_STRUCT;
	S_DirMan_In_typ : 	STRUCT 
		DirDef : ARRAY[0..MAX_DIR_DEF_IDX]OF TC_DirDef_typ;
		TransferList : ARRAY[0..MAX_TRANSFER_LIST_IDX]OF TC_Dir_Transfer_List_typ;
		Refresh : BOOL;
		RefreshDelay : LREAL;
	END_STRUCT;
	S_DirMan_Internal_typ : 	STRUCT 
		State : DIR_MAN_STATE_ENUM;
		TC_DirReadAll_USB : TC_DirReadAll;
		TC_DirReadAll_0 : TC_DirReadAll;
		TC_DirSanitize_0 : TC_DirSanitize;
		TC_DirMake_0 : TC_DirMake;
		TC_Dir_USB_Connect_0 : TC_Dir_USB_Connect;
		TC_Dir_Transfer_0 : TC_Dir_Transfer;
		CTON_Delay : CTON;
	END_STRUCT;
	S_DirMan_Out_typ : 	STRUCT 
		FileList : ARRAY[0..MAX_DIR_MAN_FILE_LIST_IDX]OF TC_FileList_typ;
		FileListUSB : ARRAY[0..MAX_DIR_MAN_FILE_LIST_IDX]OF TC_FileList_typ;
		DirectoriesCreated : BOOL;
	END_STRUCT;
	S_Time_typ : 	STRUCT 
		In : S_Time_In_typ;
		Internal : S_Time_Internal_typ;
		Out : S_Time_Out_typ;
	END_STRUCT;
	S_Time_In_typ : 	STRUCT 
		Cmd : S_Time_In_Cmd_typ;
		Par : S_Time_In_Par_typ;
	END_STRUCT;
	S_Time_In_Cmd_typ : 	STRUCT 
		setTime : BOOL;
	END_STRUCT;
	S_Time_In_Par_typ : 	STRUCT 
		newTime : DATE_AND_TIME;
	END_STRUCT;
	S_Time_Internal_typ : 	STRUCT 
		state : TIME_STATE_ENUM;
		lastState : TIME_STATE_ENUM;
		CTON_Delay : CTON;
		CTON_Timeout : CTON;
		BlankCmdCmp : S_Time_In_Cmd_typ;
		DTSetTime_0 : DTSetTime;
		DTGetTime_0 : DTGetTime;
		tempAlarm : TC_AlarmX_Core_Buffer_typ;
		LastErrorInfo : S_Out_ErrorInfo_typ;
	END_STRUCT;
	S_Time_Out_typ : 	STRUCT 
		Status : S_Time_Out_Status_typ;
		ErrorInfo : S_Out_ErrorInfo_typ;
		IgnoreInfo : S_Out_Ignore_typ;
	END_STRUCT;
	S_Time_Out_Status_typ : 	STRUCT 
		CurrentState : STRING[80];
		InReset : BOOL;
		Initializing : BOOL;
		WaitingForCommand : BOOL;
		Processing : BOOL;
		InError : BOOL;
		Error : BOOL;
		TimeValid : BOOL;
		CurrentTime : DATE_AND_TIME;
	END_STRUCT;
END_TYPE
