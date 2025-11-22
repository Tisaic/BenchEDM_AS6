(* R-squared Score *)
FUNCTION HA_Matrix_R2Score
	HA_Matrix_R2Score	 			:= 0.0;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pY_true+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pY_true+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pY_pred+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pY_pred+Internal.sizeArray+4,4);
	IF pY_true = 0 OR pY_pred = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row1 <> Internal.row2 OR Internal.col1 <> Internal.col2 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_R2Score	 		:= 0.0;
	ELSE
		Internal.temp1 				:= 0.0;
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
		    FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp2),pY_true+(Internal.i1*Internal.col1+Internal.i2)*8,8);
		        Internal.temp1 		:= Internal.temp1 + Internal.temp2;
		    END_FOR;
		END_FOR;
		Internal.temp1 				:= Internal.temp1/DINT_TO_LREAL(Internal.row1*Internal.col1);
		Internal.temp2 				:= 0.0;
		Internal.temp3 				:= 0.0;
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
		    FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp4),pY_true+(Internal.i1*Internal.col1+Internal.i2)*8,8);
				brsmemcpy(ADR(Internal.temp5),pY_pred+(Internal.i1*Internal.col1+Internal.i2)*8,8);
		        Internal.result 	:= Internal.temp4 - Internal.temp5;
		        Internal.temp2 		:= Internal.temp2 + Internal.result*Internal.result;
		        Internal.result 	:= Internal.temp4 - Internal.temp1;
		        Internal.temp3 		:= Internal.temp3 + Internal.result*Internal.result;
		    END_FOR;
		END_FOR;
		IF ABS(Internal.temp3) < 1.0e-10 THEN
			HA_Matrix_R2Score	 	:= 0.0;
		ELSE
			HA_Matrix_R2Score	 	:= 1.0 - Internal.temp2/Internal.temp3;
		END_IF;
	END_IF;
END_FUNCTION