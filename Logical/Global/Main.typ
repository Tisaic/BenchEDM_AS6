
TYPE
	Main_typ : 	STRUCT 
		ErrorReset : BOOL;
		Process : Process_typ;
		Services : Services_typ;
	END_STRUCT;
	Scripts_typ : 	STRUCT 
		FirstStart : ARRAY[0..MAX_TC_SEQ_BUFFER_IDX]OF STRING[MAX_TC_SEQ_JSON_STRING_LEN];
	END_STRUCT;
END_TYPE
