(* Build Lag Matrix *)
FUNCTION HA_Matrix_BuildLags
	HA_Matrix_BuildLags	 			:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pY_history+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pY_history+Internal.sizeArray+4,4);
	IF pU_history <> 0 THEN
		brsmemcpy(ADR(Internal.row2),pU_history+Internal.sizeArray,4);
		brsmemcpy(ADR(Internal.col2),pU_history+Internal.sizeArray+4,4);
	ELSE
		Internal.row2 				:= 0;
		Internal.col2 				:= 0;
	END_IF;
	Internal.row3					:= NumOutputs*LagOrder + NumInputs*LagOrder;
	Internal.col3					:= 1;
	IF pY_history = 0 OR pOut = 0 OR LagOrder = 0 OR NumOutputs = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row1 < NumOutputs*LagOrder OR Internal.col1 <> 1 OR Internal.row3*Internal.col3 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_BuildLags	 		:= FALSE;
	ELSE
		IF pU_history <> 0 THEN
			IF NumInputs = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row2 < NumInputs*LagOrder OR Internal.col2 <> 1 THEN
				HA_Matrix_BuildLags	 := FALSE;
				RETURN;
			END_IF;
		END_IF;
		brsmemset(pOut,0,Internal.sizeTotal);
		brsmemcpy(pOut+Internal.sizeArray,ADR(Internal.row3),4);
		brsmemcpy(pOut+Internal.sizeArray+4,ADR(Internal.col3),4);
		Internal.i4 				:= 0;
		FOR Internal.i1 := 0 TO LagOrder-1 DO
		    FOR Internal.i2 := 0 TO NumOutputs-1 DO
				brsmemcpy(ADR(Internal.temp1),pY_history+(Internal.i1*NumOutputs+Internal.i2)*8,8);
				brsmemcpy(pOut+Internal.i4*8,ADR(Internal.temp1),8);
				Internal.i4 			:= Internal.i4 + 1;
		    END_FOR;
		END_FOR;
		IF pU_history <> 0 AND NumInputs > 0 THEN
			FOR Internal.i1 := 0 TO LagOrder-1 DO
			    FOR Internal.i2 := 0 TO NumInputs-1 DO
					brsmemcpy(ADR(Internal.temp1),pU_history+(Internal.i1*NumInputs+Internal.i2)*8,8);
					brsmemcpy(pOut+Internal.i4*8,ADR(Internal.temp1),8);
					Internal.i4 		:= Internal.i4 + 1;
			    END_FOR;
			END_FOR;
		END_IF;
	END_IF;
END_FUNCTION