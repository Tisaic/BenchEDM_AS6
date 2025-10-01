
TYPE
	Recipe_Definition_typ : 	STRUCT 
		MpLink : MpComIdentType;
		VarName : STRING[100];
		pVar : UDINT;
		SizeVar : UDINT;
		pCmpVar : UDINT;
		pDefaultVar : UDINT;
		DeviceName : STRING[50];
		FileName : STRING[255];
	END_STRUCT;
	TC_Recipe_Helper_Internal_typ : 	STRUCT 
		MpRecipeRegPar_0 : MpRecipeRegPar;
		MpRecipeXml_0 : MpRecipeXml;
		LastState : TC_RECIPE_HELPER_STATE_ENUM;
		State : TC_RECIPE_HELPER_STATE_ENUM;
		ErrorReset : BOOL;
		CTON_Timeout : CTON;
	END_STRUCT;
	TC_RECIPE_HELPER_STATE_ENUM : 
		(
		TC_RH_ST_RESET,
		TC_RH_ST_VALIDATE_INPUTS,
		TC_RH_ST_REG_PAR_W,
		TC_RH_ST_READY,
		TC_RH_ST_SAVE_W,
		TC_RH_ST_LOAD_W,
		TC_RH_ST_AUTO_LOAD_W,
		TC_RH_ST_AUTO_RESET_D,
		TC_RH_ST_AUTO_RESET_C,
		TC_RH_ST_AUTO_RESET_W,
		TC_RH_ST_AUTO_SAVE_W,
		TC_RH_ST_ERROR
		);
END_TYPE
