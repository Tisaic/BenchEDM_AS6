(* Multi-Step Prediction with Integration *)
FUNCTION HA_Matrix_PredictMultiStep
	HA_Matrix_PredictMultiStep	 	:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(UDINT)*2;
	brsmemcpy(ADR(Internal.row1),pState+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pState+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pBeta+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pBeta+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row3),pHistory+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col3),pHistory+Internal.sizeArray+4,4);
	Internal.row4					:= Steps;
	Internal.col4					:= Internal.col1;
	IF pState = 0 OR pBeta = 0 OR pHistory = 0 OR pOut = 0 OR pLagTemp = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row3 = 0 OR Internal.col3 = 0 OR Steps <= 0 OR LagOrder < 0 OR PolyOrder < 1 OR PolyOrder > 3 OR Internal.row1 <> 1 OR Internal.col3 <> 1 OR Internal.col2 <> Internal.col1 OR Internal.row4*Internal.col4 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_PredictMultiStep	:= FALSE;
	ELSE
		brsmemset(pOut,0,Internal.sizeTotal);
		brsmemcpy(pOut+Internal.sizeArray,ADR(Internal.row4),4);
		brsmemcpy(pOut+Internal.sizeArray+4,ADR(Internal.col4),4);
		FOR Internal.i1 := 0 TO Internal.col1-1 DO
			brsmemcpy(ADR(Internal.temp1),pState+Internal.i1*8,8);
			brsmemcpy(pWorkState+Internal.i1*8,ADR(Internal.temp1),8);
		END_FOR;
		FOR Internal.i1 := 0 TO Internal.row3-1 DO
			brsmemcpy(ADR(Internal.temp1),pHistory+Internal.i1*8,8);
			brsmemcpy(pWorkHist+Internal.i1*8,ADR(Internal.temp1),8);
		END_FOR;
		FOR Internal.i1 := 0 TO Steps-1 DO
			Success := HA_Matrix_BuildLags(pWorkHist,0,LagOrder,Internal.col1,0,pLagTemp);
			IF NOT Success THEN
				HA_Matrix_PredictMultiStep := FALSE;
				RETURN;
			END_IF;
			IF PolyOrder > 1 AND pPolyTemp <> 0 THEN
				Success := HA_Matrix_PolyExpand(pLagTemp,PolyOrder,pPolyTemp);
				IF NOT Success THEN
					HA_Matrix_PredictMultiStep := FALSE;
					RETURN;
				END_IF;
				IF UseBias THEN
					Success := HA_Matrix_AddBias(pPolyTemp,pFeatTemp);
					IF NOT Success THEN
						HA_Matrix_PredictMultiStep := FALSE;
						RETURN;
					END_IF;
					Success := HA_Matrix_Predict(pFeatTemp,pBeta,pPredTemp);
				ELSE
					Success := HA_Matrix_Predict(pPolyTemp,pBeta,pPredTemp);
				END_IF;
			ELSE
				IF UseBias THEN
					Success := HA_Matrix_AddBias(pLagTemp,pFeatTemp);
					IF NOT Success THEN
						HA_Matrix_PredictMultiStep := FALSE;
						RETURN;
					END_IF;
					Success := HA_Matrix_Predict(pFeatTemp,pBeta,pPredTemp);
				ELSE
					Success := HA_Matrix_Predict(pLagTemp,pBeta,pPredTemp);
				END_IF;
			END_IF;
			IF NOT Success THEN
				HA_Matrix_PredictMultiStep := FALSE;
				RETURN;
			END_IF;
			FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp1),pPredTemp+Internal.i2*8,8);
				IF UseDerivative THEN
					brsmemcpy(ADR(Internal.temp2),pWorkState+Internal.i2*8,8);
					Internal.temp1 := Internal.temp2 + Internal.temp1;
					brsmemcpy(pWorkState+Internal.i2*8,ADR(Internal.temp1),8);
				ELSE
					brsmemcpy(pWorkState+Internal.i2*8,ADR(Internal.temp1),8);
				END_IF;
				brsmemcpy(pOut+(Internal.i1*Internal.col4+Internal.i2)*8,ADR(Internal.temp1),8);
			END_FOR;
			FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp1),pWorkState+Internal.i2*8,8);
				Success := HA_Matrix_RollingUpdate(pWorkHist,Internal.temp1);
				IF NOT Success THEN
					HA_Matrix_PredictMultiStep := FALSE;
					RETURN;
				END_IF;
			END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION