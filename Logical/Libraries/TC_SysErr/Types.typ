
TYPE
	Internal_TC_SysErr_Log : 	STRUCT 
		State : INT;
		TC_SysErr_Lookup_0 : TC_SysErr_Lookup;
		ArEventLogGetIdent_0 : ArEventLogGetIdent;
		ArEventLogWrite_0 : ArEventLogWrite;
		AddData : STRING[255];
	END_STRUCT;
	Internal_TC_SysErr_Lookup : 	STRUCT 
		ArTextSysGetText_0 : ArTextSysGetText;
		TextID : STRING[255];
		ErrorNumString : STRING[80];
		State : INT;
	END_STRUCT;
END_TYPE
