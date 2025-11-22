(* Initialize State Buffer *)
FUNCTION HA_Matrix_InitStateBuffer
	HA_Matrix_InitStateBuffer	 	:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(UDINT)*2;
	brsmemcpy(ADR(Internal.row1),pX+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pX+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pState+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pState+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row3),pHistory+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col3),pHistory+Internal.sizeArray+4,4);
	IF pX = 0 OR pState = 0 OR pHistory = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row3 = 0 OR Internal.col3 = 0 OR LagOrder < 1 OR Internal.row1 < LagOrder OR Internal.col3 <> 1 OR Internal.row2 <> 1 OR Internal.col2 <> Internal.col1 OR Internal.row3 <> LagOrder*Internal.col1 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_InitStateBuffer	:= FALSE;
	ELSE
		FOR Internal.i2 := 0 TO Internal.col1-1 DO
			brsmemcpy(ADR(Internal.temp1),pX+((Internal.row1-1)*Internal.col1+Internal.i2)*8,8);
			brsmemcpy(pState+Internal.i2*8,ADR(Internal.temp1),8);
		END_FOR;
		FOR Internal.i1 := 0 TO LagOrder-1 DO
		    FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp1),pX+((Internal.row1-1-Internal.i1)*Internal.col1+Internal.i2)*8,8);
				brsmemcpy(pHistory+(Internal.i1*Internal.col1+Internal.i2)*8,ADR(Internal.temp1),8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION