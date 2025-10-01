
{REDUND_ERROR} FUNCTION_BLOCK TC_Seq_Handler (*Sequence Handler*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Enable : BOOL;
		Reset : BOOL;
		ErrorReset : BOOL;
		ClearBuffer : BOOL;
		ForceNext : BOOL;
		Pause : BOOL;
		pJsonArray : UDINT;
	END_VAR
	VAR_OUTPUT
		Out : TC_Seq_Handler_Out_typ;
	END_VAR
	VAR
		Internal : TC_Seq_Handler_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION TC_Seq_EnumStringSearch : DINT (*Returns a negative value if not found*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		EnumNameSTRING : STRING[32]; (*STRING*)
		EnumValueSTRING : STRING[32]; (*STRING*)
	END_VAR
	VAR
		Internal : TC_Seq_ESS_Internal_typ;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION TC_Seq_JsonToElem : DINT (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pJsonString : UDINT;
		pElement : UDINT;
	END_VAR
	VAR
		Internal : TC_Seq_JsonToElem_Internal_typ;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION TC_Seq_Add : DINT (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pJsonArray : UDINT;
		pJson : UDINT;
	END_VAR
	VAR
		Internal : TC_Seq_Generic_Internal_typ;
	END_VAR
END_FUNCTION

{REDUND_ERROR} FUNCTION TC_Seq_AddFront : DINT (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		pJsonArray : UDINT;
		pJson : UDINT;
	END_VAR
	VAR
		Internal : TC_Seq_Generic_Internal_typ;
	END_VAR
END_FUNCTION
