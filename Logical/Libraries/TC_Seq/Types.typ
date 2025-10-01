
TYPE
	TC_Seq_Par_Element_typ : 	STRUCT 
		Name : STRING[255];
		GenVar : TC_Seq_GenVar_typ;
	END_STRUCT;
	TC_Seq_GenVar_typ : 	STRUCT 
		Select : TC_SEQ_PAR_SELECT_ENUM;
		VarBOOL : BOOL;
		VarSINT : SINT;
		VarUSINT : USINT;
		VarINT : INT;
		VarUINT : UINT;
		VarDINT : DINT;
		VarUDINT : UDINT;
		VarREAL : REAL;
		VarLREAL : LREAL;
		VarTIME : TIME;
		VarDT : DATE_AND_TIME;
		VarSTRING : STRING[MAX_JSON_PARSE_VALUE_LEN];
		VarSTRING_ADR : UDINT;
		VarADR : UDINT;
		VarENUM : DINT;
		VarENUM_STRING : STRING[32];
	END_STRUCT;
	TC_Seq_ESS_Internal_typ : 	STRUCT 
		PvRoot : STRING[255];
		PvName : STRING[255];
		PvValue : STRING[32];
		IdxString : STRING[32];
		PvLen : UDINT;
		PvAddress : UDINT;
		DataLen : UDINT;
		Datatype : UDINT;
		Dimension : UINT;
		Status : UINT;
		i : DINT;
	END_STRUCT;
	TC_Seq_Handler_Buffer_typ : 	STRUCT 
		Type : TC_SEQ_TYPE_ENUM;
		Json : STRING[MAX_TC_SEQ_JSON_STRING_LEN];
		Time : LREAL;
		WaitPvAddress : UDINT;
		UID : DINT;
		Status : DINT;
	END_STRUCT;
	TC_Seq_JsonToElem_Internal_typ : 	STRUCT 
		idx : DINT;
		i : DINT;
		TC_JSON_Parse_0 : TC_JSON_Parse;
		JSONPairs : ARRAY[0..MAX_JSON_PARSE_PAIR_IDX]OF TC_JSON_Parse_Pair_typ;
		Element : TC_Seq_Handler_Buffer_typ;
		EnumNameString_Ident : STRING[32];
		EnumValueString_Ident : STRING[32];
		IdentIdxString : STRING[32];
		IdentIdx : DINT;
		EnumNameString_Inst : STRING[32];
		EnumValueString_Inst : STRING[32];
		InstIdxString : STRING[32];
		InstIdx : DINT;
		DriverRoot : STRING[255];
		PvName : STRING[255];
		PvLen : UDINT;
		DataLen : UDINT;
		ParValue : STRING[MAX_JSON_PARSE_VALUE_LEN];
		ParDataType : STRING[2];
		Datatype : UDINT;
		Dimension : UINT;
		ParPvAddress : ARRAY[0..MAX_TC_SEQ_PAR_IDX]OF UDINT;
		WaitPvAddress : UDINT;
		CmdPvAddress : UDINT;
		PvAddress : UDINT;
		Status : UINT;
		ParElement : ARRAY[0..MAX_JSON_PARSE_PAIR_IDX]OF TC_Seq_Par_Element_typ;
		Driver : STRING[32];
		Ident : STRING[32];
		Inst : STRING[32];
		Enable : BOOL;
		ParDone : BOOL;
		Par : STRING[MAX_TC_SEQ_PAR_STRING_LEN];
	END_STRUCT;
	TC_Seq_Generic_Internal_typ : 	STRUCT 
		i : DINT;
	END_STRUCT;
	TC_Seq_Handler_Internal_typ : 	STRUCT 
		i : DINT;
		ErrorID : DINT;
		CTON_0 : CTON;
		LastState : TC_SEQ_HANDLER_STATE_ENUM;
		State : TC_SEQ_HANDLER_STATE_ENUM;
		CurrentWait : DINT;
		TempJson : STRING[MAX_TC_SEQ_JSON_STRING_LEN];
		CurrentBuffer : TC_Seq_Handler_Buffer_typ;
		RTInfo_0 : RTInfo;
		TimeIncrement : LREAL;
		CurrentDelay : LREAL;
		Status : DINT;
	END_STRUCT;
	TC_Seq_Handler_Out_typ : 	STRUCT 
		Status : TC_Seq_Handler_Out_Status_typ;
		Buffer : TC_Seq_Handler_Out_Buffer_typ;
	END_STRUCT;
	TC_Seq_Handler_Out_Buffer_typ : 	STRUCT 
		Last : ARRAY[0..MAX_TC_SEQ_BUFFER_LAST_IDX]OF TC_Seq_Handler_Buffer_typ;
		Current : TC_Seq_Handler_Buffer_typ;
	END_STRUCT;
	TC_Seq_Handler_Out_Status_typ : 	STRUCT 
		Remaining : LREAL;
		Elapsed : LREAL;
		InReset : BOOL;
		Paused : BOOL;
		Ready : BOOL;
		Processing : BOOL;
		Error : BOOL;
		ErrorID : DINT;
		CurrentState : STRING[32];
		Timeout : BOOL;
		Interrupt : BOOL;
	END_STRUCT;
	TC_Seq_Buffer_Info_typ : 	STRUCT 
		pUID : UDINT;
		pBuffer : UDINT;
	END_STRUCT;
	TC_SEQ_HANDLER_STATE_ENUM : 
		( (*ENUM_STRING*)
		TC_SEQ_HANDLER_RESET,
		TC_SEQ_HANDLER_EVAL,
		TC_SEQ_HANDLER_CMD,
		TC_SEQ_HANDLER_WAIT,
		TC_SEQ_HANDLER_DELAY,
		TC_SEQ_HANDLER_INTERRUPT,
		TC_SEQ_HANDLER_ERROR
		);
	TC_SEQ_WAIT_ENUM : 
		( (*ENUM_STRING*)
		TC_SEQ_WAIT_FALSE,
		TC_SEQ_WAIT_TRUE,
		TC_SEQ_WAIT_INTERRUPT,
		TC_SEQ_WAIT_ERROR
		);
	TC_SEQ_TYPE_ENUM : 
		( (*ENUM_STRING*)
		TC_SEQ_TYPE_NONE,
		TC_SEQ_TYPE_CMD,
		TC_SEQ_TYPE_WAIT,
		TC_SEQ_TYPE_DELAY,
		TC_SEQ_TYPE_BREAK
		);
	TC_SEQ_PAR_SELECT_ENUM : 
		( (*ENUM_STRING*)
		TC_SEQ_PAR_SELECT_NULL,
		TC_SEQ_PAR_SELECT_BOOL,
		TC_SEQ_PAR_SELECT_INT,
		TC_SEQ_PAR_SELECT_USINT,
		TC_SEQ_PAR_SELECT_SINT,
		TC_SEQ_PAR_SELECT_UINT,
		TC_SEQ_PAR_SELECT_DINT,
		TC_SEQ_PAR_SELECT_UDINT,
		TC_SEQ_PAR_SELECT_REAL,
		TC_SEQ_PAR_SELECT_LREAL,
		TC_SEQ_PAR_SELECT_TIME,
		TC_SEQ_PAR_SELECT_DT,
		TC_SEQ_PAR_SELECT_ENUMNAME,
		TC_SEQ_PAR_SELECT_STRING,
		TC_SEQ_PAR_SELECT_STRINGADR,
		TC_SEQ_PAR_SELECT_STRINGLEN,
		TC_SEQ_PAR_SELECT_WSTRINGADR,
		TC_SEQ_PAR_SELECT_WSTRINGLEN,
		TC_SEQ_PAR_SELECT_ADR,
		TC_SEQ_PAR_SELECT_PTR
		);
END_TYPE
