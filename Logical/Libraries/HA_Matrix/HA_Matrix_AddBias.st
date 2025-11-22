(* Add Bias Column *)
FUNCTION HA_Matrix_AddBias
	HA_Matrix_AddBias	 			:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(UDINT)*2;
	brsmemcpy(ADR(Internal.row1),pX+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pX+Internal.sizeArray+4,4);
	Internal.row2					:= Internal.row1;
	Internal.col2					:= Internal.col1 + 1;
	IF pX = 0 OR pOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row2*Internal.col2 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_AddBias	 		:= FALSE;
	ELSE
		brsmemset(pOut,0,Internal.sizeTotal);
		brsmemcpy(pOut+Internal.sizeArray,ADR(Internal.row2),4);
		brsmemcpy(pOut+Internal.sizeArray+4,ADR(Internal.col2),4);
		Internal.temp1 				:= 1.0;
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			brsmemcpy(pOut+(Internal.i1*Internal.col2)*8,ADR(Internal.temp1),8);
		    FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp2),pX+(Internal.i1*Internal.col1+Internal.i2)*8,8);
				brsmemcpy(pOut+(Internal.i1*Internal.col2+Internal.i2+1)*8,ADR(Internal.temp2),8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION