(* Rolling Update Buffer *)
FUNCTION TC_NGRC_RollingUpdate
	TC_NGRC_RollingUpdate := TRUE;
	brsmemset(ADR(Internal), 0, SIZEOF(Internal));
	
	(* Clear error if provided *)
	IF pError <> 0 THEN
		brsmemset(pError, 0, SIZEOF(TC_NGRC_Error_typ));
	END_IF;
	
	(* Validate pointer *)
	IF pBuffer = 0 THEN
		TC_NGRC_RollingUpdate := FALSE;
		IF pError <> 0 THEN
			Internal.i1 := TC_NGRC_ERR_NULL_POINTER;
			brsmemcpy(pError+0, ADR(Internal.i1), 4);
			brsmemcpy(pError+4, ADR('TC_NGRC_RollingUpdate'), 22);
			brsmemcpy(pError+44, ADR('Null pointer input'), 19);
		END_IF;
		RETURN;
	END_IF;
	
	(* Read metadata from fixed offsets *)
	brsmemcpy(ADR(Internal.row1), pBuffer+0, 4);
	brsmemcpy(ADR(Internal.col1), pBuffer+4, 4);
	
	(* Validate dimensions *)
	IF Internal.row1 = 0 OR Internal.col1 <> 1 THEN
		TC_NGRC_RollingUpdate := FALSE;
		IF pError <> 0 THEN
			Internal.i1 := TC_NGRC_ERR_INVALID_DIMENSIONS;
			brsmemcpy(pError+0, ADR(Internal.i1), 4);
			brsmemcpy(pError+4, ADR('TC_NGRC_RollingUpdate'), 22);
			brsmemcpy(pError+44, ADR('Buffer must be n×1'), 18);
		END_IF;
		RETURN;
	END_IF;
	
	(* Shift existing values *)
	FOR Internal.i1 := Internal.row1-1 TO 1 BY -1 DO
		brsmemcpy(ADR(Internal.temp1), pBuffer+8+(Internal.i1-1)*8, 8);
		brsmemcpy(pBuffer+8+Internal.i1*8, ADR(Internal.temp1), 8);
	END_FOR;
	
	(* Insert new value *)
	brsmemcpy(pBuffer+8, ADR(NewValue), 8);
	
	(* Success *)
	IF pError <> 0 THEN
		Internal.i1 := TC_NGRC_ERR_SUCCESS;
		brsmemcpy(pError+0, ADR(Internal.i1), 4);
	END_IF;
	
END_FUNCTION