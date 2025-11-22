(* Root Mean Square Error *)
FUNCTION TC_NGRC_RMSE
	TC_NGRC_RMSE := 0.0;
	brsmemset(ADR(Internal), 0, SIZEOF(Internal));
	IF pError <> 0 THEN
		brsmemset(pError, 0, SIZEOF(TC_NGRC_Error_typ));
	END_IF;
	(* Read metadata from fixed offsets *)
	brsmemcpy(ADR(Internal.row1), pY_true+0, 4);
	brsmemcpy(ADR(Internal.col1), pY_true+4, 4);
	brsmemcpy(ADR(Internal.row2), pY_pred+0, 4);
	brsmemcpy(ADR(Internal.col2), pY_pred+4, 4);
	
	(* Validate inputs *)
	IF pY_true = 0 OR pY_pred = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row1 <> Internal.row2 OR Internal.col1 <> Internal.col2 THEN
		TC_NGRC_RMSE := -1.0;  (* Error indicator *)
	ELSE
		(* Calculate sum of squared errors *)
		Internal.result := 0.0;
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			FOR Internal.i2 := 0 TO Internal.col1-1 DO
				(* Read Y_true[i1, i2] from offset 8 *)
				brsmemcpy(ADR(Internal.temp1), pY_true+8+(Internal.i1*Internal.col1+Internal.i2)*8, 8);
				(* Read Y_pred[i1, i2] from offset 8 *)
				brsmemcpy(ADR(Internal.temp2), pY_pred+8+(Internal.i1*Internal.col1+Internal.i2)*8, 8);
				Internal.temp3 := Internal.temp1 - Internal.temp2;
				Internal.result := Internal.result + Internal.temp3*Internal.temp3;
			END_FOR;
		END_FOR;
		
		(* Calculate RMSE *)
		Internal.temp3 := Internal.row1 * Internal.col1;
		IF Internal.temp3 > 0.0 THEN
			Internal.result := Internal.result / Internal.temp3;
			TC_NGRC_RMSE := SQRT(Internal.result);
		ELSE
			TC_NGRC_RMSE := -1.0;
		END_IF;
	END_IF;
END_FUNCTION