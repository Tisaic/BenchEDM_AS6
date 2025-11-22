FUNCTION TC_NGRC_RLS : BOOL
	VAR_INPUT
		pTheta : UDINT;
		pP : UDINT;
		pX : UDINT;
		Y : LREAL;
		Lambda : LREAL;
		pTemp : UDINT;
		pError : UDINT := 0;  (* Optional error structure *)
	END_VAR
	VAR
		Internal : TC_NGRC_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION TC_NGRC_RLS_Init : BOOL
	VAR_INPUT
		pTheta : UDINT;
		pP : UDINT;
		InitVariance : LREAL;
		pError : UDINT := 0;
	END_VAR
	VAR
		Internal : TC_NGRC_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION TC_NGRC_Predict : BOOL
	VAR_INPUT
		pX : UDINT;
		pBeta : UDINT;
		pOut : UDINT;
		pError : UDINT := 0;
	END_VAR
	VAR
		Internal : TC_NGRC_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION TC_NGRC_BuildLagsStride : BOOL
	VAR_INPUT
		pY_history : UDINT;
		pU_history : UDINT;
		LagOrder : DINT;
		NumOutputs : DINT;
		NumInputs : DINT;
		Stride : DINT;
		pOut : UDINT;
		pError : UDINT := 0;
	END_VAR
	VAR
		Internal : TC_NGRC_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION TC_NGRC_PolyExpand : BOOL
	VAR_INPUT
		pX : UDINT;
		Order : DINT;
		pOut : UDINT;
		pError : UDINT := 0;
	END_VAR
	VAR
		Internal : TC_NGRC_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION TC_NGRC_AddBias : BOOL
	VAR_INPUT
		pX : UDINT;
		pOut : UDINT;
		pError : UDINT := 0;
	END_VAR
	VAR
		Internal : TC_NGRC_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION TC_NGRC_RollingUpdate : BOOL
	VAR_INPUT
		pBuffer : UDINT;
		NewValue : LREAL;
		pError : UDINT := 0;
	END_VAR
	VAR
		Internal : TC_NGRC_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION TC_NGRC_RMSE : LREAL
	VAR_INPUT
		pY_true : UDINT;
		pY_pred : UDINT;
		pError : UDINT := 0;
	END_VAR
	VAR
		Internal : TC_NGRC_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION TC_NGRC_CalcMem : BOOL
	VAR_INPUT
		NumVariables : DINT;
		LagOrder : DINT;
		PolyOrder : DINT;
		UseBias : BOOL;
		Stride : DINT := 1;
		EnableWorkspaceReuse : BOOL := TRUE;
		pOutput : UDINT;
	END_VAR
	VAR
		Internal : TC_NGRC_CalcMem_Internal_typ;
	END_VAR
END_FUNCTION

FUNCTION_BLOCK TC_NGRC_Continuous
	VAR_INPUT
		In : TC_NGRC_Continuous_In_typ;
	END_VAR
	VAR_OUTPUT
		Out : TC_NGRC_Continuous_Out_typ;
	END_VAR
	VAR
		Internal : TC_NGRC_Continuous_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK