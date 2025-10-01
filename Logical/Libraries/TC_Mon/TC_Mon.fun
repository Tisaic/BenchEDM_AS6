
{REDUND_ERROR} FUNCTION_BLOCK TC_Mon (*Conditional Handler*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		ES_ID : STRING[32];
		Operator : TC_MON_OPERATOR_ENUM;
		Logical : ARRAY[0..MAX_MON_LOGICAL_IDX] OF BOOL;
		Sev : DINT;
		Mask : ARRAY[0..MAX_TC_MON_PROCESS_IDX] OF TC_Mon_ProcessMask_typ;
		Par : TC_Mon_Par_typ;
		Forcing : TC_Mon_Forcing_typ;
		Sim : TC_Mon_Sim_typ;
		EdgeReset : BOOL;
	END_VAR
	VAR_OUTPUT
		Signal : TC_Mon_Signal_typ;
	END_VAR
	VAR
		Internal : TC_Mon_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK
