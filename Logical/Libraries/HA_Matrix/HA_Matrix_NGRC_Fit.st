(* Fit NGRC Model *)
FUNCTION HA_Matrix_NGRC_Fit
	HA_Matrix_NGRC_Fit				:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(UDINT)*2;
	brsmemcpy(ADR(Internal.row1),pX+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pX+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pY+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pY+Internal.sizeArray+4,4);
	Internal.row3					:= Internal.row1 - (LagOrder-1)*Stride - WarmupSteps;
	IF UseDerivative THEN
		Internal.row4 				:= Internal.row3 - 1;
		Internal.col4 				:= Internal.col2;
	ELSE
		Internal.row4 				:= Internal.row3;
		Internal.col4 				:= Internal.col2;
	END_IF;
	IF pX = 0 OR pY = 0 OR pBeta = 0 OR pXtX = 0 OR pXtY = 0 OR pL = 0 OR pLagWork = 0 OR pFeatWork = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR LagOrder < 1 OR PolyOrder < 1 OR PolyOrder > 3 OR Stride < 1 OR WarmupSteps < 0 OR Lambda < 0.0 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row2*Internal.col2 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row1 <= (LagOrder-1)*Stride + WarmupSteps THEN
		HA_Matrix_NGRC_Fit			:= FALSE;
	ELSE
		Success := HA_Matrix_NGRC_BuildTrainingData(pX,LagOrder,PolyOrder,Stride,UseBias,WarmupSteps,pFeatWork,pLagWork,pPolyWork);
		IF NOT Success THEN
			HA_Matrix_NGRC_Fit		:= FALSE;
			RETURN;
		END_IF;
		IF UseDerivative THEN
			(* Adjust feature matrix dimensions to match derivative targets *)
			brsmemcpy(pFeatWork+Internal.sizeArray,ADR(Internal.row4),4);
			
			(* Build derivative targets *)
			brsmemset(pYwork,0,Internal.sizeTotal);
			brsmemcpy(pYwork+Internal.sizeArray,ADR(Internal.row4),4);
			brsmemcpy(pYwork+Internal.sizeArray+4,ADR(Internal.col4),4);
			FOR Internal.i1 := WarmupSteps + (LagOrder-1)*Stride TO Internal.row1-2 DO
				Internal.i4 		:= Internal.i1 - WarmupSteps - (LagOrder-1)*Stride;
				FOR Internal.i2 := 0 TO Internal.col1-1 DO
					brsmemcpy(ADR(Internal.temp1),pX+((Internal.i1+1)*Internal.col1+Internal.i2)*8,8);
					brsmemcpy(ADR(Internal.temp2),pX+(Internal.i1*Internal.col1+Internal.i2)*8,8);
					Internal.temp3 	:= Internal.temp1 - Internal.temp2;
					brsmemcpy(pYwork+(Internal.i4*Internal.col4+Internal.i2)*8,ADR(Internal.temp3),8);
				END_FOR;
			END_FOR;
			Success := HA_Matrix_XtX(pFeatWork,pXtX);
			IF NOT Success THEN
				HA_Matrix_NGRC_Fit	:= FALSE;
				RETURN;
			END_IF;
			Success := HA_Matrix_AddRidge(pXtX,Lambda);
			IF NOT Success THEN
				HA_Matrix_NGRC_Fit	:= FALSE;
				RETURN;
			END_IF;
			Success := HA_Matrix_Cholesky(pXtX,pL);
			IF NOT Success THEN
				HA_Matrix_NGRC_Fit	:= FALSE;
				RETURN;
			END_IF;
			Success := HA_Matrix_XtY(pFeatWork,pYwork,pXtY);
			IF NOT Success THEN
				HA_Matrix_NGRC_Fit	:= FALSE;
				RETURN;
			END_IF;
			Success := HA_Matrix_CholSolve(pL,pXtY,pBeta);
			IF NOT Success THEN
				HA_Matrix_NGRC_Fit	:= FALSE;
				RETURN;
			END_IF;
		ELSE
			brsmemset(pYwork,0,Internal.sizeTotal);
			brsmemcpy(pYwork+Internal.sizeArray,ADR(Internal.row4),4);
			brsmemcpy(pYwork+Internal.sizeArray+4,ADR(Internal.col4),4);
			FOR Internal.i1 := WarmupSteps + (LagOrder-1)*Stride TO Internal.row1-1 DO
				Internal.i4 		:= Internal.i1 - WarmupSteps - (LagOrder-1)*Stride;
				FOR Internal.i2 := 0 TO Internal.col2-1 DO
					brsmemcpy(ADR(Internal.temp1),pY+(Internal.i1*Internal.col2+Internal.i2)*8,8);
					brsmemcpy(pYwork+(Internal.i4*Internal.col4+Internal.i2)*8,ADR(Internal.temp1),8);
				END_FOR;
			END_FOR;
			Success := HA_Matrix_XtX(pFeatWork,pXtX);
			IF NOT Success THEN
				HA_Matrix_NGRC_Fit	:= FALSE;
				RETURN;
			END_IF;
			Success := HA_Matrix_AddRidge(pXtX,Lambda);
			IF NOT Success THEN
				HA_Matrix_NGRC_Fit	:= FALSE;
				RETURN;
			END_IF;
			Success := HA_Matrix_Cholesky(pXtX,pL);
			IF NOT Success THEN
				HA_Matrix_NGRC_Fit	:= FALSE;
				RETURN;
			END_IF;
			Success := HA_Matrix_XtY(pFeatWork,pYwork,pXtY);
			IF NOT Success THEN
				HA_Matrix_NGRC_Fit	:= FALSE;
				RETURN;
			END_IF;
			Success := HA_Matrix_CholSolve(pL,pXtY,pBeta);
			IF NOT Success THEN
				HA_Matrix_NGRC_Fit	:= FALSE;
				RETURN;
			END_IF;
		END_IF;
	END_IF;
END_FUNCTION