(* NGRC Single-Step Prediction *)
FUNCTION HA_Matrix_NGRC_Predict
	HA_Matrix_NGRC_Predict			:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(UDINT)*2;
	brsmemcpy(ADR(Internal.row1),pHistory+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pHistory+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pBeta+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pBeta+Internal.sizeArray+4,4);
	Internal.row3					:= Internal.col1;
	Internal.col3					:= 1;
	IF pHistory = 0 OR pBeta = 0 OR pOut = 0 OR pLagWork = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR LagOrder < 1 OR PolyOrder < 1 OR PolyOrder > 3 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row2*Internal.col2 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_NGRC_Predict		:= FALSE;
	ELSE
		brsmemset(pLagWork,0,Internal.sizeTotal);
		brsmemcpy(pLagWork+Internal.sizeArray,ADR(Internal.row3),4);
		brsmemcpy(pLagWork+Internal.sizeArray+4,ADR(Internal.col3),4);
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			brsmemcpy(ADR(Internal.temp1),pHistory+Internal.i1*8,8);
			brsmemcpy(pLagWork+Internal.i1*8,ADR(Internal.temp1),8);
		END_FOR;
		IF PolyOrder > 1 AND pPolyWork <> 0 THEN
			Success := HA_Matrix_PolyExpand(pLagWork,PolyOrder,pPolyWork);
			IF NOT Success THEN
				HA_Matrix_NGRC_Predict := FALSE;
				RETURN;
			END_IF;
			IF UseBias THEN
				Success := HA_Matrix_AddBias(pPolyWork,pFeatWork);
				IF NOT Success THEN
					HA_Matrix_NGRC_Predict := FALSE;
					RETURN;
				END_IF;
				Success := HA_Matrix_Predict(pFeatWork,pBeta,pOut);
			ELSE
				Success := HA_Matrix_Predict(pPolyWork,pBeta,pOut);
			END_IF;
		ELSE
			IF UseBias THEN
				Success := HA_Matrix_AddBias(pLagWork,pFeatWork);
				IF NOT Success THEN
					HA_Matrix_NGRC_Predict := FALSE;
					RETURN;
				END_IF;
				Success := HA_Matrix_Predict(pFeatWork,pBeta,pOut);
			ELSE
				Success := HA_Matrix_Predict(pLagWork,pBeta,pOut);
			END_IF;
		END_IF;
		IF NOT Success THEN
			HA_Matrix_NGRC_Predict	:= FALSE;
			RETURN;
		END_IF;
	END_IF;
END_FUNCTION