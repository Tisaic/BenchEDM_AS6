(* Predict *)
FUNCTION HA_Matrix_Predict
	HA_Matrix_Predict	 			:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pX+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pX+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pBeta+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pBeta+Internal.sizeArray+4,4);
	Internal.row3					:= Internal.row1;
	Internal.col3					:= Internal.col2;
	IF pX = 0 OR pBeta = 0 OR pOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.col1 <> Internal.row2 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row2*Internal.col2 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row3*Internal.col3 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_Predict	 		:= FALSE;
	ELSE
		brsmemset(pOut,0,Internal.sizeTotal);
		brsmemcpy(pOut+Internal.sizeArray,ADR(Internal.row3),4);
		brsmemcpy(pOut+Internal.sizeArray+4,ADR(Internal.col3),4);
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
		    FOR Internal.i2 := 0 TO Internal.col2-1 DO
		        Internal.result 	:= 0.0;
		        FOR Internal.i3 := 0 TO Internal.col1-1 DO
					brsmemcpy(ADR(Internal.temp1),pX+(Internal.i1*Internal.col1+Internal.i3)*8,8);
					brsmemcpy(ADR(Internal.temp2),pBeta+(Internal.i3*Internal.col2+Internal.i2)*8,8);
		            Internal.result := Internal.result + Internal.temp1*Internal.temp2;
		        END_FOR;
				brsmemcpy(pOut+(Internal.i1*Internal.col3+Internal.i2)*8,ADR(Internal.result),8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION