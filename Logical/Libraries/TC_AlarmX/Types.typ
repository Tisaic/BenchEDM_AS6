
TYPE
	TC_AlarmX_Helper_Internal_typ : 	STRUCT 
		Active : BOOL;
		AddText : STRING[1000];
		ArEventLogGetIdent_0 : ArEventLogGetIdent;
		ArEventLogWrite_0 : ArEventLogWrite;
	END_STRUCT;
	TC_ALARMX_ACTION_ENUM : 
		(
		TC_ALARMX_ACTION_NONE,
		TC_ALARMX_ACTION_SET,
		TC_ALARMX_ACTION_SET_NO_LOG,
		TC_ALARMX_ACTION_ACK,
		TC_ALARMX_ACTION_ACK_NO_LOG,
		TC_ALARMX_ACTION_LOG_ONLY
		);
	TC_ALARMX_CORE_STATE_ENUM : 
		(
		TC_ALARMX_CORE_RESET,
		TC_ALARMX_CORE_IDLE,
		TC_ALARMX_CORE_SET_C,
		TC_ALARMX_CORE_SET_W
		);
	TC_AlarmX_Core_Internal_typ : 	STRUCT 
		state : TC_ALARMX_CORE_STATE_ENUM;
		currentAlarm : TC_AlarmX_Core_Buffer_typ;
		tDelay : CTON;
		i : INT;
	END_STRUCT;
	TC_AlarmX_Core_Buffer_typ : 	STRUCT 
		name : STRING[MAX_ALARM_NAME_LEN];
		addText : ARRAY[0..TC_ALARMX_MAX_ADD_DATA_IDX]OF STRING[MAX_ALARM_ADD_DATA];
		allowMultiple : BOOL;
	END_STRUCT;
	TC_AlarmX_AlarmExtraData_typ : 	STRUCT 
		AddData : ARRAY[0..TC_ALARMX_MAX_ADD_DATA_IDX]OF STRING[MAX_ALARM_ADD_DATA];
	END_STRUCT;
	TC_AlarmX_CfgMod_Internal_typ : 	STRUCT 
		AlarmName : STRING[MAX_ALARM_NAME_LEN];
		i : USINT;
		CTON_Timeout : CTON;
	END_STRUCT;
	TC_AlarmX_BufferInfo_typ : 	STRUCT 
		Address : UDINT;
		Size : UDINT;
	END_STRUCT;
	TC_Module_Alarm_Info_typ : 	STRUCT 
		ErrorInfo : USINT;
		IgnoreInfo : USINT;
	END_STRUCT;
END_TYPE
