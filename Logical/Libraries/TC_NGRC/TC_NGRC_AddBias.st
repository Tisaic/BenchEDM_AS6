(* Add Bias Term *)
FUNCTION TC_NGRC_AddBias
	TC_NGRC_AddBias := TRUE;
	brsmemset(ADR(Internal), 0, SIZEOF(Internal));
	IF pError <> 0 THEN
		brsmemset(pError, 0, SIZEOF(TC_NGRC_Error_typ));
	END_IF;
	(* Read metadata from fixed offsets *)
	brsmemcpy(ADR(Internal.row1), pX+0, 4);
	brsmemcpy(ADR(Internal.col1), pX+4, 4);
	
	(* Output dimensions: add one column for bias *)
	Internal.row2 := Internal.row1;
	Internal.col2 := Internal.col1 + 1;
	
	(* Validate inputs *)
	IF pX = 0 OR pOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 THEN
		TC_NGRC_AddBias := FALSE;
	ELSE
		(* Write output metadata to fixed offsets *)
		brsmemcpy(pOut+0, ADR(Internal.row2), 4);
		brsmemcpy(pOut+4, ADR(Internal.col2), 4);
		
		(* Copy input features and add bias term *)
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			(* Set bias term (first element) to 1.0 *)
			Internal.temp1 := 1.0;
			brsmemcpy(pOut+8+(Internal.i1*Internal.col2)*8, ADR(Internal.temp1), 8);
			
			(* Copy original features *)
			FOR Internal.i2 := 0 TO Internal.col1-1 DO
				(* Read X[i1, i2] from offset 8 *)
				brsmemcpy(ADR(Internal.temp1), pX+8+(Internal.i1*Internal.col1+Internal.i2)*8, 8);
				(* Write to Out[i1, i2+1] at offset 8 *)
				brsmemcpy(pOut+8+(Internal.i1*Internal.col2+(Internal.i2+1))*8, ADR(Internal.temp1), 8);
			END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION