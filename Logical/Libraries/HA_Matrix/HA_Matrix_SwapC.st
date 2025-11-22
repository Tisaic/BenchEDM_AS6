(* Swap Column *)
FUNCTION HA_Matrix_SwapC
	HA_Matrix_SwapC	 				:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pIn+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pIn+Internal.sizeArray+4,4);
	IF pIn = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Swap1 = Swap2 OR Internal.col1-1 < Swap1 OR Internal.col1-1 < Swap2 THEN
		HA_Matrix_SwapC	 			:= FALSE;
	ELSE
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			brsmemcpy(ADR(Internal.temp1),pIn+(Internal.i1*Internal.col1+Swap1)*8,8);
			brsmemcpy(ADR(Internal.temp2),pIn+(Internal.i1*Internal.col1+Swap2)*8,8);
			brsmemcpy(pIn+(Internal.i1*Internal.col1+Swap1)*8,ADR(Internal.temp2),8);
			brsmemcpy(pIn+(Internal.i1*Internal.col1+Swap2)*8,ADR(Internal.temp1),8);
		END_FOR;
	END_IF;
END_FUNCTION