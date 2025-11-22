
(* Identity *)
FUNCTION HA_Matrix_I
	HA_Matrix_I	 					:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pIn+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pIn+Internal.sizeArray+4,4);
	IF pIn = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row1 <> Internal.col1 THEN
		HA_Matrix_I	 				:= FALSE;
	ELSE
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
		    FOR Internal.i2 := 0 TO Internal.col1-1 DO
				Internal.temp1 		:= 0.0;
				IF Internal.i1 = Internal.i2 THEN
					Internal.temp1 	:= 1.0;
				END_IF;
				brsmemcpy(pIn+(Internal.i1*Internal.row1+Internal.i2)*8,ADR(Internal.temp1),8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION
