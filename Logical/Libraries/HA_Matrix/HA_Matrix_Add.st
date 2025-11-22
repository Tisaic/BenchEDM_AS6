(* Addition *)
FUNCTION HA_Matrix_Add
	HA_Matrix_Add	 				:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pIn1+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pIn1+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pIn2+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pIn2+Internal.sizeArray+4,4);
	IF pIn1 = 0 OR pIn2 = 0 OR pOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row2*Internal.col2 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row1 <> Internal.row2 OR Internal.col1 <> Internal.col2 THEN
		HA_Matrix_Add	 			:= FALSE;
	ELSE
		brsmemset(pOut,0,Internal.sizeTotal);
		brsmemcpy(pOut+Internal.sizeArray,ADR(Internal.row1),4);
		brsmemcpy(pOut+Internal.sizeArray+4,ADR(Internal.col1),4);
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
		    FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp1),pIn1+(Internal.i1*Internal.col1+Internal.i2)*8,8);
				brsmemcpy(ADR(Internal.temp2),pIn2+(Internal.i1*Internal.col1+Internal.i2)*8,8);
		        Internal.result 	:= Internal.temp1 + Internal.temp2;
				brsmemcpy(pOut+(Internal.i1*Internal.col1+Internal.i2)*8,ADR(Internal.result),8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION