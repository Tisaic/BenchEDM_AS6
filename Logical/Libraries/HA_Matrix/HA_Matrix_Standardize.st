(* Standardize Features *)
FUNCTION HA_Matrix_Standardize
	HA_Matrix_Standardize	 		:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pX+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pX+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pMean+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pMean+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row3),pStd+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col3),pStd+Internal.sizeArray+4,4);
	IF pX = 0 OR pMean = 0 OR pStd = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row3 = 0 OR Internal.col3 = 0 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row2 <> Internal.col1 OR Internal.col2 <> 1 OR Internal.row3 <> Internal.col1 OR Internal.col3 <> 1 THEN
		HA_Matrix_Standardize	 	:= FALSE;
	ELSE
		IF Mode = 0 THEN
			FOR Internal.i2 := 0 TO Internal.col1-1 DO
				Internal.temp1 		:= 0.0;
				FOR Internal.i1 := 0 TO Internal.row1-1 DO
					brsmemcpy(ADR(Internal.temp2),pX+(Internal.i1*Internal.col1+Internal.i2)*8,8);
					Internal.temp1 	:= Internal.temp1 + Internal.temp2;
				END_FOR;
				Internal.temp1 		:= Internal.temp1/DINT_TO_LREAL(Internal.row1);
				brsmemcpy(pMean+Internal.i2*8,ADR(Internal.temp1),8);
			END_FOR;
			FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp1),pMean+Internal.i2*8,8);
				Internal.temp2 		:= 0.0;
				FOR Internal.i1 := 0 TO Internal.row1-1 DO
					brsmemcpy(ADR(Internal.temp3),pX+(Internal.i1*Internal.col1+Internal.i2)*8,8);
					Internal.temp4 	:= Internal.temp3 - Internal.temp1;
					Internal.temp2 	:= Internal.temp2 + Internal.temp4*Internal.temp4;
				END_FOR;
				Internal.temp2 		:= Internal.temp2/DINT_TO_LREAL(Internal.row1);
				Internal.temp2 		:= SQRT(Internal.temp2);
				IF Internal.temp2 < 1.0e-10 THEN
					Internal.temp2 	:= 1.0;
				END_IF;
				brsmemcpy(pStd+Internal.i2*8,ADR(Internal.temp2),8);
			END_FOR;
		END_IF;
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
		    FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp1),pX+(Internal.i1*Internal.col1+Internal.i2)*8,8);
				brsmemcpy(ADR(Internal.temp2),pMean+Internal.i2*8,8);
				brsmemcpy(ADR(Internal.temp3),pStd+Internal.i2*8,8);
		        Internal.result 	:= (Internal.temp1 - Internal.temp2)/Internal.temp3;
				brsmemcpy(pX+(Internal.i1*Internal.col1+Internal.i2)*8,ADR(Internal.result),8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION