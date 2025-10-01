
TYPE
	Sim_Time_typ : 	STRUCT 
		RTInfo_0 : RTInfo;
		TimeInc : LREAL;
		Time : LREAL;
	END_STRUCT;
	Sim_typ : 	STRUCT 
		Full : BOOL;
		IO : BOOL;
		Time : Sim_Time_typ;
	END_STRUCT;
END_TYPE
