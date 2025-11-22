(* Predict *)
FUNCTION TC_NGRC_Predict
	TC_NGRC_Predict := TRUE;
	brsmemset(ADR(Internal), 0, SIZEOF(Internal));
	IF pError <> 0 THEN
		brsmemset(pError, 0, SIZEOF(TC_NGRC_Error_typ));
	END_IF;
	(* Read metadata from fixed offsets *)
	brsmemcpy(ADR(Internal.row1), pX+0, 4);
	brsmemcpy(ADR(Internal.col1), pX+4, 4);
	brsmemcpy(ADR(Internal.row2), pBeta+0, 4);
	brsmemcpy(ADR(Internal.col2), pBeta+4, 4);
	
	(* Output dimensions *)
	Internal.row3 := Internal.row1;
	Internal.col3 := Internal.col2;
	
	(* Validate inputs *)
	IF pX = 0 OR pBeta = 0 OR pOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.col1 <> Internal.row2 THEN
		TC_NGRC_Predict := FALSE;
	ELSE
		(* Write output metadata to fixed offsets *)
		brsmemcpy(pOut+0, ADR(Internal.row3), 4);
		brsmemcpy(pOut+4, ADR(Internal.col3), 4);
		
		(* Compute: Out = X * Beta *)
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
		    FOR Internal.i2 := 0 TO Internal.col2-1 DO
		        Internal.result := 0.0;
		        FOR Internal.i3 := 0 TO Internal.col1-1 DO
					(* Read X[i1, i3] from offset 8 *)
					brsmemcpy(ADR(Internal.temp1), pX+8+(Internal.i1*Internal.col1+Internal.i3)*8, 8);
					(* Read Beta[i3, i2] from offset 8 *)
					brsmemcpy(ADR(Internal.temp2), pBeta+8+(Internal.i3*Internal.col2+Internal.i2)*8, 8);
		            Internal.result := Internal.result + Internal.temp1*Internal.temp2;
		        END_FOR;
				(* Write Out[i1, i2] to offset 8 *)
				brsmemcpy(pOut+8+(Internal.i1*Internal.col3+Internal.i2)*8, ADR(Internal.result), 8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION