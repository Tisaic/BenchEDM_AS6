
(*  *)
FUNCTION TC_Seq_AddFront
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	TC_Seq_AddFront := -1;
	IF pJsonArray <> 0 AND pJson <> 0 THEN
		IF brsstrlen(pJson) > 0 THEN
			FOR Internal.i := MAX_TC_SEQ_BUFFER_IDX TO 0 BY -1 DO
				IF brsstrlen(pJsonArray+DINT_TO_UDINT(Internal.i*(MAX_TC_SEQ_JSON_STRING_LEN+1))) > 0 THEN
					brsmemset(pJsonArray+DINT_TO_UDINT((MAX_TC_SEQ_JSON_STRING_LEN+1)*Internal.i),0,DINT_TO_UDINT(MAX_TC_SEQ_JSON_STRING_LEN+1));
					brsmemcpy(pJsonArray+DINT_TO_UDINT((MAX_TC_SEQ_JSON_STRING_LEN+1)*Internal.i),pJson,DINT_TO_UDINT(MAX_TC_SEQ_JSON_STRING_LEN+1));
					TC_Seq_AddFront := 0;
				END_IF;
			END_FOR;
		END_IF
	END_IF;
END_FUNCTION
