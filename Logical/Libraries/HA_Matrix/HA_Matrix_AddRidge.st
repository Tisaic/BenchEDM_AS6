(* Add Ridge Penalty *)
FUNCTION HA_Matrix_AddRidge
	HA_Matrix_AddRidge	 			:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pInOut+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pInOut+Internal.sizeArray+4,4);
	IF pInOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row1 <> Internal.col1 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Lambda < 0.0 THEN
		HA_Matrix_AddRidge	 		:= FALSE;
	ELSE
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			brsmemcpy(ADR(Internal.temp1),pInOut+(Internal.i1*Internal.col1+Internal.i1)*8,8);
		    Internal.temp1 			:= Internal.temp1 + Lambda;
			brsmemcpy(pInOut+(Internal.i1*Internal.col1+Internal.i1)*8,ADR(Internal.temp1),8);
		END_FOR;
	END_IF;
END_FUNCTION