
{REDUND_ERROR} FUNCTION TC_AlarmX_Helper : DINT (*Helper Function for Setting and Acknowledging Alarms with User Logger support.*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		MpLink : MpComIdentType;
		AlarmName : STRING[255];
		AlarmAction : TC_ALARMX_ACTION_ENUM;
		LogEventAddText : STRING[255];
		AllowMultiple : BOOL;
	END_VAR
	VAR
		Internal : TC_AlarmX_Helper_Internal_typ;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION_BLOCK TC_AlarmXCore (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		enable : BOOL;
		MpLink : MpComIdentType;
		pBuffer : UDINT;
		pOutputData : REFERENCE TO TC_AlarmX_AlarmExtraData_typ;
		delayTime : TIME;
	END_VAR
	VAR
		internal : TC_AlarmX_Core_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK
