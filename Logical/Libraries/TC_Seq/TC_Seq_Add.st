
(*  *)
FUNCTION TC_Seq_Add
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	TC_Seq_Add := -1;
	IF pJsonArray <> 0 AND pJson <> 0 THEN
		IF brsstrlen(pJson) > 0 THEN
			brsmemmove(pJsonArray+DINT_TO_UDINT(MAX_TC_SEQ_JSON_STRING_LEN+1),pJsonArray,DINT_TO_UDINT((MAX_TC_SEQ_JSON_STRING_LEN+1)*MAX_TC_SEQ_BUFFER_IDX));
			brsmemset(pJsonArray,0,DINT_TO_UDINT(MAX_TC_SEQ_JSON_STRING_LEN+1));
			brsmemcpy(pJsonArray,pJson,DINT_TO_UDINT(MAX_TC_SEQ_JSON_STRING_LEN+1));
			TC_Seq_Add := 0;
		END_IF
	END_IF;
END_FUNCTION
