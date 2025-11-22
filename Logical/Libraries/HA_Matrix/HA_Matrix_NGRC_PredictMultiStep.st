(* NGRC Multi-Step Prediction *)
FUNCTION HA_Matrix_NGRC_PredictMultiStep
	HA_Matrix_NGRC_PredictMultiStep	:= TRUE;
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
	IF pState = 0 OR pBeta = 0 OR pHistory = 0 OR pOut = 0 OR pLagWork = 0 OR pPredWork = 0 OR pWorkState = 0 OR pWorkHist = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row3 = 0 OR Internal.col3 = 0 OR Steps <= 0 OR LagOrder < 1 OR PolyOrder < 1 OR PolyOrder > 3 OR Stride < 1 OR Internal.row1 <> 1 OR Internal.col3 <> 1 OR Internal.col2 <> Internal.col1 OR Internal.row4*Internal.col4 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_NGRC_PredictMultiStep := FALSE;
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
			Success := HA_Matrix_NGRC_Predict(pWorkHist,pBeta,LagOrder,PolyOrder,UseBias,pPredWork,pLagWork,pPolyWork,pFeatWork);
			IF NOT Success THEN
				HA_Matrix_NGRC_PredictMultiStep := FALSE;
				RETURN;
			END_IF;
			FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp1),pPredWork+Internal.i2*8,8);
				IF UseDerivative THEN
					brsmemcpy(ADR(Internal.temp2),pWorkState+Internal.i2*8,8);
					Internal.temp1 := Internal.temp2 + Internal.temp1;
					brsmemcpy(pWorkState+Internal.i2*8,ADR(Internal.temp1),8);
				ELSE
					brsmemcpy(pWorkState+Internal.i2*8,ADR(Internal.temp1),8);
				END_IF;
				brsmemcpy(pOut+(Internal.i1*Internal.col4+Internal.i2)*8,ADR(Internal.temp1),8);
			END_FOR;
			FOR Internal.i2 := Internal.row3-1 TO Internal.col1 BY -1 DO
			    brsmemcpy(ADR(Internal.temp1),pWorkHist+(Internal.i2-Internal.col1)*8,8);
			    brsmemcpy(pWorkHist+Internal.i2*8,ADR(Internal.temp1),8);
			END_FOR;
			FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp1),pWorkState+Internal.i2*8,8);
				brsmemcpy(pWorkHist+Internal.i2*8,ADR(Internal.temp1),8);
			END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION