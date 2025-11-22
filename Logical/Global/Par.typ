
TYPE
	Par_typ : 	STRUCT 
		IO : Par_IO_typ;
		System : Par_System_typ; (*Desc 1*) (*Desc 2*) (*Desc 3*)
		Process : Par_Process_typ;
		Services : Par_Services_typ;
		Driver : Par_Driver_typ;
	END_STRUCT;
	Par_Services_typ : 	STRUCT 
		Cert : Par_Services_Cert_typ;
		Email : Par_Services_Email_typ;
	END_STRUCT;
	Par_Services_Cert_typ : 	STRUCT 
		CountryCode : STRING[9];
		StateProvince : STRING[513];
		Locality : STRING[513];
		Organization : STRING[255];
		OrganizationUnit : STRING[255];
		ContactEmail : STRING[513];
		CommonName : STRING[255];
		IP : STRING[513];
	END_STRUCT;
	Par_Services_Email_typ : 	STRUCT 
		Port : UINT;
		Timeout : UDINT;
		Host : STRING[255];
		User : STRING[255];
		Password : STRING[255];
		Sender : STRING[255];
		Receiver : STRING[255];
	END_STRUCT;
	Par_Process_typ : 	STRUCT 
		Master : Par_Master_typ;
		Monitor : Par_Monitor_typ;
	END_STRUCT;
	Par_System_typ : 	STRUCT 
		Debugger : Par_System_Debugger_typ;
		UnitCode : STRING[20];
		LanguageCode : STRING[20];
		Serial : STRING[80];
	END_STRUCT;
	Par_Monitor_typ : 	STRUCT 
		Mon : ARRAY[0..MAX_MON_IDX]OF TC_Mon_Par_typ := [(FilterOnTime:=10.0,FilterOffTime:=5.0),49(0)];
	END_STRUCT;
	Par_Master_typ : 	STRUCT 
		Eval : ARRAY[0..MAX_MASTER_EVAL_IDX]OF TC_Eval_Par_typ;
	END_STRUCT;
	Par_System_Debugger_typ : 	STRUCT 
		HoldProcessInInit : BOOL;
	END_STRUCT;
	Par_IO_Stepper_typ : 	STRUCT 
		TC_IO_DI_HomeSwitch : TC_IO_Digital_Par_typ;
	END_STRUCT;
	Par_IO_BX18_typ : 	STRUCT 
		TC_IO_DI_ReqSettingsInvalid : TC_IO_Digital_Par_typ;
		TC_IO_DI_ReqStateInvalid : TC_IO_Digital_Par_typ;
		TC_IO_DI_EDMOutputActive : TC_IO_Digital_Par_typ;
		TC_IO_DI_EdgefindModeEnabled : TC_IO_Digital_Par_typ;
		TC_IO_DI_EdgeFound : TC_IO_Digital_Par_typ;
		TC_IO_DI_ISOPulseMode : TC_IO_Digital_Par_typ;
		TC_IO_DI_ElectrodePositiveMode : TC_IO_Digital_Par_typ;
		TC_IO_DI_PowerFault : TC_IO_Digital_Par_typ;
		TC_IO_DI_LowVoltageFault : TC_IO_Digital_Par_typ;
		TC_IO_DI_HighVoltageFault : TC_IO_Digital_Par_typ;
		TC_IO_DI_EstopActive : TC_IO_Digital_Par_typ;
		TC_IO_DI_OnTimeChanged : TC_IO_Digital_Par_typ;
		TC_IO_DI_OffTimeChanged : TC_IO_Digital_Par_typ;
		TC_IO_DI_CurrentChanged : TC_IO_Digital_Par_typ;
		TC_IO_AI_Feedback : TC_IO_Analog_Par_typ;
		TC_IO_AI_Power : TC_IO_Analog_Par_typ;
		TC_IO_DO_Enable : TC_IO_Digital_Par_typ;
		TC_IO_DO_ISOFreqMode : TC_IO_Digital_Par_typ;
		TC_IO_DO_EdgeFindMode : TC_IO_Digital_Par_typ;
		TC_IO_DO_ElectrodePositiveMode : TC_IO_Digital_Par_typ;
		TC_IO_DO_ChangeRequest : TC_IO_Digital_Par_typ;
		TC_IO_AO_OnTime : TC_IO_Analog_Par_typ;
		TC_IO_AO_OffTime : TC_IO_Analog_Par_typ;
		TC_IO_AO_Current : TC_IO_Analog_Par_typ;
	END_STRUCT;
	Par_IO_Safety_typ : 	STRUCT 
		TC_IO_DI_HMI_STOP : TC_IO_Digital_Par_typ;
		TC_IO_DI_ESTOP : TC_IO_Digital_Par_typ;
	END_STRUCT;
	Par_IO_typ : 	STRUCT 
		Simulate : BOOL;
		Safety : Par_IO_Safety_typ;
		BX18 : Par_IO_BX18_typ;
		Stepper : Par_IO_Stepper_typ;
	END_STRUCT;
	Par_Driver_typ : 	STRUCT 
		AB : ARRAY[0..MAX_DRIVER_AB_IDX]OF Driver_AB_Par_typ;
		CS : ARRAY[0..MAX_DRIVER_CS_IDX]OF Driver_CS_Par_typ;
		CN : ARRAY[0..MAX_DRIVER_CN_IDX]OF Driver_CN_Par_typ;
		TR : ARRAY[0..MAX_DRIVER_TR_IDX]OF Driver_TR_Par_typ;
		MR : ARRAY[0..MAX_DRIVER_MR_IDX]OF Driver_MR_Par_typ;
	END_STRUCT;
END_TYPE
