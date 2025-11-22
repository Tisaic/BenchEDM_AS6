(* Transpose *)
FUNCTION HA_Matrix_Tran
	HA_Matrix_Tran		 			:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pIn+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pIn+Internal.sizeArray+4,4);
	Internal.row2					:= Internal.col1;
	Internal.col2					:= Internal.row1;
	IF pIn = 0 OR pOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_Tran	 			:= FALSE;
	ELSE
		brsmemset(pOut,0,Internal.sizeTotal);
		brsmemcpy(pOut+Internal.sizeArray,ADR(Internal.row2),4);
		brsmemcpy(pOut+Internal.sizeArray+4,ADR(Internal.col2),4);
		FOR Internal.i1 := 0 TO (Internal.row1*Internal.col1)-1 DO
			brsmemcpy(pOut+(((Internal.i1 MOD Internal.col1)*Internal.row1)+Internal.i1/Internal.col1)*8,pIn+Internal.i1*8,8);
		END_FOR;
	END_IF;
END_FUNCTION