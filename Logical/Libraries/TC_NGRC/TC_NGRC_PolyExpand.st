(* Polynomial Feature Expansion *)
FUNCTION TC_NGRC_PolyExpand
	TC_NGRC_PolyExpand := TRUE;
	brsmemset(ADR(Internal), 0, SIZEOF(Internal));
	
	(* Clear error if provided *)
	IF pError <> 0 THEN
		brsmemset(pError, 0, SIZEOF(TC_NGRC_Error_typ));
	END_IF;
	
	(* Validate pointers *)
	IF pX = 0 OR pOut = 0 THEN
		TC_NGRC_PolyExpand := FALSE;
		IF pError <> 0 THEN
			Internal.i1 := TC_NGRC_ERR_NULL_POINTER;
			brsmemcpy(pError+0, ADR(Internal.i1), 4);
			brsmemcpy(pError+4, ADR('TC_NGRC_PolyExpand'), 19);
			brsmemcpy(pError+44, ADR('Null pointer input'), 19);
		END_IF;
		RETURN;
	END_IF;
	
	(* Read metadata from fixed offsets *)
	brsmemcpy(ADR(Internal.row1), pX+0, 4);
	brsmemcpy(ADR(Internal.col1), pX+4, 4);
	
	(* Validate dimensions *)
	IF Internal.row1 = 0 OR Internal.col1 = 0 THEN
		TC_NGRC_PolyExpand := FALSE;
		IF pError <> 0 THEN
			Internal.i1 := TC_NGRC_ERR_INVALID_DIMENSIONS;
			brsmemcpy(pError+0, ADR(Internal.i1), 4);
			brsmemcpy(pError+4, ADR('TC_NGRC_PolyExpand'), 19);
			brsmemcpy(pError+44, ADR('Zero dimensions'), 15);
		END_IF;
		RETURN;
	END_IF;
	
	(* Validate order *)
	IF Order < 1 OR Order > 3 THEN
		TC_NGRC_PolyExpand := FALSE;
		IF pError <> 0 THEN
			Internal.i1 := TC_NGRC_ERR_INVALID_ORDER;
			brsmemcpy(pError+0, ADR(Internal.i1), 4);
			brsmemcpy(pError+4, ADR('TC_NGRC_PolyExpand'), 19);
			brsmemcpy(pError+44, ADR('Order must be 1-3'), 17);
		END_IF;
		RETURN;
	END_IF;
	
	(* Calculate output dimensions based on polynomial order *)
	IF Order = 2 THEN
		Internal.col2 := Internal.col1 + (Internal.col1*(Internal.col1+1))/2;
	ELSIF Order = 3 THEN
		Internal.col2 := Internal.col1 + (Internal.col1*(Internal.col1+1))/2 + (Internal.col1*(Internal.col1+1)*(Internal.col1+2))/6;
	ELSE
		Internal.col2 := Internal.col1;
	END_IF;
	Internal.row2 := Internal.row1;
	
	(* Write output metadata to fixed offsets *)
	brsmemcpy(pOut+0, ADR(Internal.row2), 4);
	brsmemcpy(pOut+4, ADR(Internal.col2), 4);
	
	(* Copy linear terms *)
	FOR Internal.i1 := 0 TO Internal.row1-1 DO
		FOR Internal.i2 := 0 TO Internal.col1-1 DO
			brsmemcpy(ADR(Internal.temp1), pX+8+(Internal.i1*Internal.col1+Internal.i2)*8, 8);
			brsmemcpy(pOut+8+(Internal.i1*Internal.col2+Internal.i2)*8, ADR(Internal.temp1), 8);
		END_FOR;
	END_FOR;
	
	IF Order >= 2 THEN
		(* Add quadratic terms *)
		Internal.i4 := Internal.col1;
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			FOR Internal.i2 := 0 TO Internal.col1-1 DO
				FOR Internal.i3 := Internal.i2 TO Internal.col1-1 DO
					brsmemcpy(ADR(Internal.temp1), pX+8+(Internal.i1*Internal.col1+Internal.i2)*8, 8);
					brsmemcpy(ADR(Internal.temp2), pX+8+(Internal.i1*Internal.col1+Internal.i3)*8, 8);
					Internal.result := Internal.temp1 * Internal.temp2;
					brsmemcpy(pOut+8+(Internal.i1*Internal.col2+Internal.i4)*8, ADR(Internal.result), 8);
					Internal.i4 := Internal.i4 + 1;
				END_FOR;
			END_FOR;
			Internal.i4 := Internal.col1;
		END_FOR;
	END_IF;
	
	IF Order = 3 THEN
		(* Add cubic terms - FIXED: Use separate integer variables *)
		Internal.i4 := Internal.col1 + (Internal.col1*(Internal.col1+1))/2;
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			FOR Internal.i2 := 0 TO Internal.col1-1 DO
				FOR Internal.i3 := Internal.i2 TO Internal.col1-1 DO
					(* Use separate loop variable for innermost loop *)
					Internal.row3 := Internal.i3;  (* Store start *)
					FOR Internal.col3 := Internal.row3 TO Internal.col1-1 DO
						brsmemcpy(ADR(Internal.temp1), pX+8+(Internal.i1*Internal.col1+Internal.i2)*8, 8);
						brsmemcpy(ADR(Internal.temp2), pX+8+(Internal.i1*Internal.col1+Internal.i3)*8, 8);
						brsmemcpy(ADR(Internal.temp3), pX+8+(Internal.i1*Internal.col1+Internal.col3)*8, 8);
						Internal.result := Internal.temp1 * Internal.temp2 * Internal.temp3;
						brsmemcpy(pOut+8+(Internal.i1*Internal.col2+Internal.i4)*8, ADR(Internal.result), 8);
						Internal.i4 := Internal.i4 + 1;
					END_FOR;
				END_FOR;
			END_FOR;
			Internal.i4 := Internal.col1 + (Internal.col1*(Internal.col1+1))/2;
		END_FOR;
	END_IF;
	
	(* Success *)
	IF pError <> 0 THEN
		Internal.i1 := TC_NGRC_ERR_SUCCESS;
		brsmemcpy(pError+0, ADR(Internal.i1), 4);
	END_IF;
	
END_FUNCTION