(* Initialize RLS *)
FUNCTION TC_NGRC_RLS_Init
	TC_NGRC_RLS_Init := TRUE;
	brsmemset(ADR(Internal), 0, SIZEOF(Internal));
	IF pError <> 0 THEN
		brsmemset(pError, 0, SIZEOF(TC_NGRC_Error_typ));
	END_IF;
	(* Read metadata from fixed offsets *)
	brsmemcpy(ADR(Internal.row1), pTheta+0, 4);
	brsmemcpy(ADR(Internal.col1), pTheta+4, 4);
	brsmemcpy(ADR(Internal.row2), pP+0, 4);
	brsmemcpy(ADR(Internal.col2), pP+4, 4);
	
	(* Validate inputs *)
	IF pTheta = 0 OR pP = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.col1 <> 1 OR Internal.row2 <> Internal.col2 OR Internal.row1 <> Internal.row2 OR InitVariance <= 0.0 THEN
		TC_NGRC_RLS_Init := FALSE;
	ELSE
		(* Initialize Theta to zeros *)
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			Internal.temp1 := 0.0;
			(* Write Theta[i1] to offset 8 *)
			brsmemcpy(pTheta+8+(Internal.i1*Internal.col1)*8, ADR(Internal.temp1), 8);
		END_FOR;
		
		(* Initialize P to InitVariance * Identity *)
		FOR Internal.i1 := 0 TO Internal.row2-1 DO
		    FOR Internal.i2 := 0 TO Internal.col2-1 DO
				Internal.temp1 := 0.0;
				IF Internal.i1 = Internal.i2 THEN
					Internal.temp1 := InitVariance;
				END_IF;
				(* Write P[i1, i2] to offset 8 *)
				brsmemcpy(pP+8+(Internal.i1*Internal.col2+Internal.i2)*8, ADR(Internal.temp1), 8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION