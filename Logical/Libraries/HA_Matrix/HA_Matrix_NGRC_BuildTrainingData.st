(* Build NGRC Training Dataset *)
FUNCTION HA_Matrix_NGRC_BuildTrainingData
	HA_Matrix_NGRC_BuildTrainingData := TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(UDINT)*2;
	brsmemcpy(ADR(Internal.row1),pX+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pX+Internal.sizeArray+4,4);
	Internal.row2					:= Internal.row1 - (LagOrder-1)*Stride - WarmupSteps;
	Internal.col2					:= Internal.col1 * LagOrder;
	IF PolyOrder = 2 THEN
		Internal.col3 				:= Internal.col2 + (Internal.col2*(Internal.col2+1))/2;
	ELSIF PolyOrder = 3 THEN
		Internal.col3 				:= Internal.col2 + (Internal.col2*(Internal.col2+1))/2 + (Internal.col2*(Internal.col2+1)*(Internal.col2+2))/6;
	ELSE
		Internal.col3 				:= Internal.col2;
	END_IF;
	Internal.row3					:= Internal.row2;
	IF UseBias THEN
		Internal.col4 				:= Internal.col3 + 1;
	ELSE
		Internal.col4 				:= Internal.col3;
	END_IF;
	Internal.row4					:= Internal.row2;
	IF pX = 0 OR pOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR LagOrder < 1 OR PolyOrder < 1 OR PolyOrder > 3 OR Stride < 1 OR WarmupSteps < 0 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row1 <= (LagOrder-1)*Stride + WarmupSteps OR Internal.row4*Internal.col4 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_NGRC_BuildTrainingData := FALSE;
	ELSE
		brsmemset(pOut,0,Internal.sizeTotal);
		brsmemcpy(pOut+Internal.sizeArray,ADR(Internal.row4),4);
		brsmemcpy(pOut+Internal.sizeArray+4,ADR(Internal.col4),4);
		brsmemset(pLagWork,0,Internal.sizeTotal);
		brsmemcpy(pLagWork+Internal.sizeArray,ADR(Internal.row2),4);
		brsmemcpy(pLagWork+Internal.sizeArray+4,ADR(Internal.col2),4);
		Internal.i4 					:= 0;
		FOR Internal.i1 := WarmupSteps + (LagOrder-1)*Stride TO Internal.row1-1 DO
			FOR Internal.i2 := 0 TO LagOrder-1 DO
				Internal.row3 		:= Internal.i1 - Internal.i2*Stride;
				FOR Internal.i3 := 0 TO Internal.col1-1 DO
					brsmemcpy(ADR(Internal.temp1),pX+(Internal.row3*Internal.col1+Internal.i3)*8,8);
					brsmemcpy(pLagWork+(Internal.i4*Internal.col2+(Internal.i2*Internal.col1+Internal.i3))*8,ADR(Internal.temp1),8);
				END_FOR;
			END_FOR;
			Internal.i4 				:= Internal.i4 + 1;
		END_FOR;
		IF PolyOrder > 1 AND pPolyWork <> 0 THEN
			Success := HA_Matrix_PolyExpand(pLagWork,PolyOrder,pPolyWork);
			IF NOT Success THEN
				HA_Matrix_NGRC_BuildTrainingData := FALSE;
				RETURN;
			END_IF;
			IF UseBias THEN
				Success := HA_Matrix_AddBias(pPolyWork,pOut);
				IF NOT Success THEN
					HA_Matrix_NGRC_BuildTrainingData := FALSE;
					RETURN;
				END_IF;
			ELSE
				brsmemcpy(pOut,pPolyWork,Internal.sizeTotal);
			END_IF;
		ELSE
			IF UseBias THEN
				Success := HA_Matrix_AddBias(pLagWork,pOut);
				IF NOT Success THEN
					HA_Matrix_NGRC_BuildTrainingData := FALSE;
					RETURN;
				END_IF;
			ELSE
				brsmemcpy(pOut,pLagWork,Internal.sizeTotal);
			END_IF;
		END_IF;
	END_IF;
END_FUNCTION