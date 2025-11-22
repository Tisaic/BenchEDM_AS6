(* Rolling Buffer Update *)
FUNCTION HA_Matrix_RollingUpdate
	HA_Matrix_RollingUpdate	 		:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pBuffer+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pBuffer+Internal.sizeArray+4,4);
	IF pBuffer = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_RollingUpdate	 	:= FALSE;
	ELSE
		FOR Internal.i1 := Internal.row1*Internal.col1-1 TO 1 BY -1 DO
			brsmemcpy(ADR(Internal.temp1),pBuffer+(Internal.i1-1)*8,8);
			brsmemcpy(pBuffer+Internal.i1*8,ADR(Internal.temp1),8);
		END_FOR;
		brsmemcpy(pBuffer,ADR(NewValue),8);
	END_IF;
END_FUNCTION