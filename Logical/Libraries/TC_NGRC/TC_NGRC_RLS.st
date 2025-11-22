(* Recursive Least Squares Update *)
FUNCTION TC_NGRC_RLS
	TC_NGRC_RLS := TRUE;
	brsmemset(ADR(Internal), 0, SIZEOF(Internal));
	
	(* Clear error if provided *)
	IF pError <> 0 THEN
		brsmemset(pError, 0, SIZEOF(TC_NGRC_Error_typ));
	END_IF;
	
	(* Validate pointers *)
	IF pTheta = 0 OR pP = 0 OR pX = 0 OR pTemp = 0 THEN
		TC_NGRC_RLS := FALSE;
		IF pError <> 0 THEN
			Internal.i1 := TC_NGRC_ERR_NULL_POINTER;
			brsmemcpy(pError+0, ADR(Internal.i1), 4);
			brsmemcpy(pError+4, ADR('TC_NGRC_RLS'), 13);
			brsmemcpy(pError+44, ADR('Null pointer input'), 19);
		END_IF;
		RETURN;
	END_IF;
	
	(* Read metadata from fixed offsets *)
	brsmemcpy(ADR(Internal.row1), pTheta+0, 4);
	brsmemcpy(ADR(Internal.col1), pTheta+4, 4);
	brsmemcpy(ADR(Internal.row2), pP+0, 4);
	brsmemcpy(ADR(Internal.col2), pP+4, 4);
	brsmemcpy(ADR(Internal.row3), pX+0, 4);
	brsmemcpy(ADR(Internal.col3), pX+4, 4);
	
	(* Validate dimensions *)
	IF Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row3 = 0 OR Internal.col3 = 0 THEN
		TC_NGRC_RLS := FALSE;
		IF pError <> 0 THEN
			Internal.i1 := TC_NGRC_ERR_INVALID_DIMENSIONS;
			brsmemcpy(pError+0, ADR(Internal.i1), 4);
			brsmemcpy(pError+4, ADR('TC_NGRC_RLS'), 13);
			brsmemcpy(pError+44, ADR('Zero dimensions'), 15);
		END_IF;
		RETURN;
	END_IF;
	
	(* Validate dimension compatibility *)
	IF Internal.col1 <> 1 OR Internal.row2 <> Internal.col2 OR Internal.row1 <> Internal.row2 OR Internal.row3 <> Internal.row1 OR Internal.col3 <> 1 THEN
		TC_NGRC_RLS := FALSE;
		IF pError <> 0 THEN
			Internal.i1 := TC_NGRC_ERR_DIMENSION_MISMATCH;
			brsmemcpy(pError+0, ADR(Internal.i1), 4);
			brsmemcpy(pError+4, ADR('TC_NGRC_RLS'), 13);
			brsmemcpy(pError+44, ADR('Dimension mismatch'), 18);
		END_IF;
		RETURN;
	END_IF;
	
	(* Validate Lambda *)
	IF Lambda <= 0.0 OR Lambda > 1.0 THEN
		TC_NGRC_RLS := FALSE;
		IF pError <> 0 THEN
			Internal.i1 := TC_NGRC_ERR_INVALID_LAMBDA;
			brsmemcpy(pError+0, ADR(Internal.i1), 4);
			brsmemcpy(pError+4, ADR('TC_NGRC_RLS'), 13);
			brsmemcpy(pError+44, ADR('Lambda must be (0,1]'), 20);
		END_IF;
		RETURN;
	END_IF;
	
	(* Compute: Temp = P * X *)
	Internal.temp1 := 0.0;
	FOR Internal.i1 := 0 TO Internal.row1-1 DO
		Internal.temp2 := 0.0;
	    FOR Internal.i2 := 0 TO Internal.row2-1 DO
			brsmemcpy(ADR(Internal.temp3), pP+8+(Internal.i1*Internal.col2+Internal.i2)*8, 8);
			brsmemcpy(ADR(Internal.temp4), pX+8+(Internal.i2*Internal.col3)*8, 8);
	        Internal.temp2 := Internal.temp2 + Internal.temp3*Internal.temp4;
	    END_FOR;
		brsmemcpy(pTemp+8+(Internal.i1*1)*8, ADR(Internal.temp2), 8);
		brsmemcpy(ADR(Internal.temp3), pX+8+(Internal.i1*Internal.col3)*8, 8);
		Internal.temp1 := Internal.temp1 + Internal.temp3*Internal.temp2;
	END_FOR;
	
	(* Compute denominator *)
	Internal.temp1 := Lambda + Internal.temp1;
	IF ABS(Internal.temp1) < 1.0e-10 THEN
	    TC_NGRC_RLS := FALSE;
		IF pError <> 0 THEN
			Internal.i1 := TC_NGRC_ERR_SINGULAR_MATRIX;
			brsmemcpy(pError+0, ADR(Internal.i1), 4);
			brsmemcpy(pError+4, ADR('TC_NGRC_RLS'), 13);
			brsmemcpy(pError+44, ADR('Singular matrix detected'), 24);
		END_IF;
	    RETURN;
	END_IF;
	
	(* Compute prediction error *)
	Internal.result := 0.0;
	FOR Internal.i1 := 0 TO Internal.row1-1 DO
		brsmemcpy(ADR(Internal.temp2), pX+8+(Internal.i1*Internal.col3)*8, 8);
		brsmemcpy(ADR(Internal.temp3), pTheta+8+(Internal.i1*Internal.col1)*8, 8);
	    Internal.result := Internal.result + Internal.temp2*Internal.temp3;
	END_FOR;
	Internal.result := Y - Internal.result;
	
	(* Update Theta *)
	FOR Internal.i1 := 0 TO Internal.row1-1 DO
		brsmemcpy(ADR(Internal.temp2), pTemp+8+(Internal.i1*1)*8, 8);
	    Internal.temp3 := Internal.temp2/Internal.temp1;
		brsmemcpy(ADR(Internal.temp4), pTheta+8+(Internal.i1*Internal.col1)*8, 8);
		Internal.temp4 := Internal.temp4 + Internal.temp3*Internal.result;
		brsmemcpy(pTheta+8+(Internal.i1*Internal.col1)*8, ADR(Internal.temp4), 8);
	END_FOR;
	
	(* Update P *)
	FOR Internal.i1 := 0 TO Internal.row2-1 DO
	    FOR Internal.i2 := 0 TO Internal.col2-1 DO
			Internal.temp2 := 0.0;
	        FOR Internal.i3 := 0 TO Internal.row2-1 DO
				brsmemcpy(ADR(Internal.temp3), pTemp+8+(Internal.i1*1)*8, 8);
				brsmemcpy(ADR(Internal.temp4), pX+8+(Internal.i3*Internal.col3)*8, 8);
				brsmemcpy(ADR(Internal.temp5), pP+8+(Internal.i3*Internal.col2+Internal.i2)*8, 8);
	            Internal.temp2 := Internal.temp2 + Internal.temp3*Internal.temp4*Internal.temp5;
	        END_FOR;
			brsmemcpy(ADR(Internal.temp3), pP+8+(Internal.i1*Internal.col2+Internal.i2)*8, 8);
	        Internal.result := (Internal.temp3 - Internal.temp2/Internal.temp1)/Lambda;
			brsmemcpy(pP+8+(Internal.i1*Internal.col2+Internal.i2)*8, ADR(Internal.result), 8);
	    END_FOR;
	END_FOR;
	
	(* Success *)
	IF pError <> 0 THEN
		Internal.i1 := TC_NGRC_ERR_SUCCESS;
		brsmemcpy(pError+0, ADR(Internal.i1), 4);
	END_IF;
	
END_FUNCTION