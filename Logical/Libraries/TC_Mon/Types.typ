
TYPE
	TC_Mon_Internal_typ : 	STRUCT 
		CTON_DB_Off : CTON;
		CTON_DB_On : CTON;
		StatusResult : BOOL;
		i : DINT;
	END_STRUCT;
	TC_Mon_ProcessMask_typ : 	STRUCT 
		Sev : DINT;
		ES_ID : STRING[32];
	END_STRUCT;
	TC_Mon_Sim_typ : 	STRUCT 
		Active : BOOL;
		Logical : BOOL;
	END_STRUCT;
	TC_Mon_Signal_typ : 	STRUCT 
		Logical : BOOL;
		Result : BOOL;
		EdgePosResult : BOOL;
		EdgeNegResult : BOOL;
	END_STRUCT;
	TC_Mon_Par_typ : 	STRUCT 
		FilterOnTime : LREAL;
		FilterOffTime : LREAL;
	END_STRUCT;
	TC_Mon_Forcing_typ : 	STRUCT 
		Off : BOOL;
		On : BOOL;
	END_STRUCT;
	TC_MON_OPERATOR_ENUM : 
		(
		TC_MON_OP_AND,
		TC_MON_OP_OR
		);
END_TYPE
