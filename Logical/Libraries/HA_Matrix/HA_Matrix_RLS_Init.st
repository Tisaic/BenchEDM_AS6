(* Initialize RLS *)
FUNCTION HA_Matrix_RLS_Init
	HA_Matrix_RLS_Init	 			:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pTheta+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pTheta+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pP+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pP+Internal.sizeArray+4,4);
	IF pTheta = 0 OR pP = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.col1 <> 1 OR Internal.row2 <> Internal.col2 OR Internal.row1 <> Internal.row2 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row2*Internal.col2 > MAX_HA_MATRIX_ARRAY_IDX+1 OR InitVariance <= 0.0 THEN
		HA_Matrix_RLS_Init	 		:= FALSE;
	ELSE
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			Internal.temp1 			:= 0.0;
			brsmemcpy(pTheta+(Internal.i1*Internal.col1)*8,ADR(Internal.temp1),8);
		END_FOR;
		FOR Internal.i1 := 0 TO Internal.row2-1 DO
		    FOR Internal.i2 := 0 TO Internal.col2-1 DO
				Internal.temp1 		:= 0.0;
				IF Internal.i1 = Internal.i2 THEN
					Internal.temp1 	:= InitVariance;
				END_IF;
				brsmemcpy(pP+(Internal.i1*Internal.col2+Internal.i2)*8,ADR(Internal.temp1),8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION