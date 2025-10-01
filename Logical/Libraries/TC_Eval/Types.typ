
TYPE
	TC_Eval_Internal_typ : 	STRUCT 
		CTON_DB_Off : CTON;
		CTON_DB_On : CTON;
		StatusResult : BOOL;
		i : DINT;
	END_STRUCT;
	TC_Eval_Sim_typ : 	STRUCT 
		Active : BOOL;
		Logical : BOOL;
	END_STRUCT;
	TC_Eval_Signal_typ : 	STRUCT 
		Logical : BOOL;
		Result : BOOL;
		EdgePosResult : BOOL;
		EdgeNegResult : BOOL;
	END_STRUCT;
	TC_Eval_Par_typ : 	STRUCT 
		FilterOnTime : LREAL;
		FilterOffTime : LREAL;
	END_STRUCT;
	TC_Eval_Forcing_typ : 	STRUCT 
		Off : BOOL;
		On : BOOL;
	END_STRUCT;
	TC_EVAL_OPERATOR_ENUM : 
		(
		TC_EVAL_OP_AND,
		TC_EVAL_OP_OR
		);
END_TYPE
