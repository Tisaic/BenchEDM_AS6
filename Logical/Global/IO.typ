
TYPE
	IO_typ : 	STRUCT 
		ForceEnable : BOOL;
		AllConfiguredModulesOk : BOOL;
		Safety : IO_Safety_typ;
	END_STRUCT;
	IO_Safety_typ : 	STRUCT 
		TC_IO_DI_HMI_STOP : TC_IO_DI;
		TC_IO_DI_ESTOP : TC_IO_DI;
	END_STRUCT;
END_TYPE
