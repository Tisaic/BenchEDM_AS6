(* Calculate Differences *)
FUNCTION HA_Matrix_Diff
	HA_Matrix_Diff	 				:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(UDINT)*2;
	brsmemcpy(ADR(Internal.row1),pX+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pX+Internal.sizeArray+4,4);
	Internal.row2					:= Internal.row1 - 1;
	Internal.col2					:= Internal.col1;
	IF pX = 0 OR pOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row1 < 2 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row2*Internal.col2 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_Diff	 			:= FALSE;
	ELSE
		brsmemset(pOut,0,Internal.sizeTotal);
		brsmemcpy(pOut+Internal.sizeArray,ADR(Internal.row2),4);
		brsmemcpy(pOut+Internal.sizeArray+4,ADR(Internal.col2),4);
		FOR Internal.i1 := 0 TO Internal.row2-1 DO
		    FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp1),pX+((Internal.i1+1)*Internal.col1+Internal.i2)*8,8);
				brsmemcpy(ADR(Internal.temp2),pX+(Internal.i1*Internal.col1+Internal.i2)*8,8);
		        Internal.result 	:= Internal.temp1 - Internal.temp2;
				brsmemcpy(pOut+(Internal.i1*Internal.col2+Internal.i2)*8,ADR(Internal.result),8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION