
{REDUND_ERROR} FUNCTION_BLOCK TC_Eval (*Evalditional Handler*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		ES_ID : STRING[32];
		Logical : ARRAY[0..MAX_EVAL_LOGICAL_IDX] OF BOOL;
		Operator : TC_EVAL_OPERATOR_ENUM;
		Call : DINT;
		ES_Call : STRING[32];
		Par : TC_Eval_Par_typ;
		Forcing : TC_Eval_Forcing_typ;
		Sim : TC_Eval_Sim_typ;
		EdgeReset : BOOL;
	END_VAR
	VAR_OUTPUT
		Signal : TC_Eval_Signal_typ;
	END_VAR
	VAR
		Internal : TC_Eval_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK
