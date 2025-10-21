
TYPE
	IO_typ : 	STRUCT 
		ForceEnable : BOOL;
		AllConfiguredModulesOk : BOOL;
		Safety : IO_Safety_typ;
		BX18 : IO_BX18_typ;
	END_STRUCT;
	IO_Safety_typ : 	STRUCT 
		TC_IO_DI_HMI_STOP : TC_IO_DI;
		TC_IO_DI_ESTOP : TC_IO_DI;
	END_STRUCT;
	IO_BX18_typ : 	STRUCT 
		TC_IO_DI_ReqSettingsInvalid : TC_IO_DI;
		TC_IO_DI_ReqStateInvalid : TC_IO_DI;
		TC_IO_DI_EDMOutputActive : TC_IO_DI;
		TC_IO_DI_EdgefindModeEnabled : TC_IO_DI;
		TC_IO_DI_EdgeFound : TC_IO_DI;
		TC_IO_DI_ISOPulseMode : TC_IO_DI;
		TC_IO_DI_ElectrodePositiveMode : TC_IO_DI;
		TC_IO_DI_PowerFault : TC_IO_DI;
		TC_IO_DI_LowVoltageFault : TC_IO_DI;
		TC_IO_DI_HighVoltageFault : TC_IO_DI;
		TC_IO_DI_EstopActive : TC_IO_DI;
		TC_IO_DI_OnTimeChanged : TC_IO_DI;
		TC_IO_DI_OffTimeChanged : TC_IO_DI;
		TC_IO_DI_CurrentChanged : TC_IO_DI;
		TC_IO_AI_Feedback : TC_IO_AI;
		TC_IO_AI_Power : TC_IO_AI;
		TC_IO_DO_Enable : TC_IO_DO;
		TC_IO_DO_ISOFreqMode : TC_IO_DO;
		TC_IO_DO_EdgeFindMode : TC_IO_DO;
		TC_IO_DO_ElectrodePositiveMode : TC_IO_DO;
		TC_IO_DO_ChangeRequest : TC_IO_DO;
		TC_IO_AO_OnTime : TC_IO_AO;
		TC_IO_AO_OffTime : TC_IO_AO;
		TC_IO_AO_Current : TC_IO_AO;
		ModuleOK : BOOL;
		Outputs_control : UINT;
		Outputs_onTime : UINT;
		Outputs_offTime : UINT;
		Outputs_current : UINT;
		Inputs_status : UINT;
		Inputs_EDMservofeedback : UINT;
		Inputs_power : UINT;
	END_STRUCT;
END_TYPE
