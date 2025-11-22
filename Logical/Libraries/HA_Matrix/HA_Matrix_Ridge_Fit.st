(* Ridge Regression Fit *)
FUNCTION HA_Matrix_Ridge_Fit
	HA_Matrix_Ridge_Fit	 			:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(UDINT)*2;
	brsmemcpy(ADR(Internal.row1),pX+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pX+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pY+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pY+Internal.sizeArray+4,4);
	IF pX = 0 OR pY = 0 OR pBeta = 0 OR pXtX = 0 OR pXtY = 0 OR pL = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row1 <> Internal.row2 OR WarmupSteps < 0 OR WarmupSteps >= Internal.row1 OR Lambda < 0.0 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row2*Internal.col2 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_Ridge_Fit	 		:= FALSE;
	ELSE
		Internal.row3 				:= Internal.row1 - WarmupSteps;
		Internal.col3 				:= Internal.col1;
		Internal.row4 				:= Internal.row2 - WarmupSteps;
		Internal.col4 				:= Internal.col2;
		IF UseBias THEN
			Internal.col3 			:= Internal.col1 + 1;
		END_IF;
		IF pXwork <> 0 THEN
			brsmemset(pXwork,0,Internal.sizeTotal);
			brsmemcpy(pXwork+Internal.sizeArray,ADR(Internal.row3),4);
			brsmemcpy(pXwork+Internal.sizeArray+4,ADR(Internal.col3),4);
			FOR Internal.i1 := WarmupSteps TO Internal.row1-1 DO
				Internal.i4 		:= Internal.i1 - WarmupSteps;
				IF UseBias THEN
					Internal.temp1 	:= 1.0;
					brsmemcpy(pXwork+(Internal.i4*Internal.col3)*8,ADR(Internal.temp1),8);
					FOR Internal.i2 := 0 TO Internal.col1-1 DO
						brsmemcpy(ADR(Internal.temp1),pX+(Internal.i1*Internal.col1+Internal.i2)*8,8);
						brsmemcpy(pXwork+(Internal.i4*Internal.col3+Internal.i2+1)*8,ADR(Internal.temp1),8);
					END_FOR;
				ELSE
					FOR Internal.i2 := 0 TO Internal.col1-1 DO
						brsmemcpy(ADR(Internal.temp1),pX+(Internal.i1*Internal.col1+Internal.i2)*8,8);
						brsmemcpy(pXwork+(Internal.i4*Internal.col3+Internal.i2)*8,ADR(Internal.temp1),8);
					END_FOR;
				END_IF;
			END_FOR;
			brsmemset(pYwork,0,Internal.sizeTotal);
			brsmemcpy(pYwork+Internal.sizeArray,ADR(Internal.row4),4);
			brsmemcpy(pYwork+Internal.sizeArray+4,ADR(Internal.col4),4);
			FOR Internal.i1 := WarmupSteps TO Internal.row2-1 DO
				Internal.i4 		:= Internal.i1 - WarmupSteps;
				FOR Internal.i2 := 0 TO Internal.col2-1 DO
					brsmemcpy(ADR(Internal.temp1),pY+(Internal.i1*Internal.col2+Internal.i2)*8,8);
					brsmemcpy(pYwork+(Internal.i4*Internal.col4+Internal.i2)*8,ADR(Internal.temp1),8);
				END_FOR;
			END_FOR;
			Success := HA_Matrix_XtX(pXwork,pXtX);
		ELSE
			Success := HA_Matrix_XtX(pX,pXtX);
		END_IF;
		IF NOT Success THEN
			HA_Matrix_Ridge_Fit 	:= FALSE;
			RETURN;
		END_IF;
		Success := HA_Matrix_AddRidge(pXtX,Lambda);
		IF NOT Success THEN
			HA_Matrix_Ridge_Fit 	:= FALSE;
			RETURN;
		END_IF;
		Success := HA_Matrix_Cholesky(pXtX,pL);
		IF NOT Success THEN
			HA_Matrix_Ridge_Fit 	:= FALSE;
			RETURN;
		END_IF;
		IF pXwork <> 0 THEN
			Success := HA_Matrix_XtY(pXwork,pYwork,pXtY);
		ELSE
			Success := HA_Matrix_XtY(pX,pY,pXtY);
		END_IF;
		IF NOT Success THEN
			HA_Matrix_Ridge_Fit 	:= FALSE;
			RETURN;
		END_IF;
		Success := HA_Matrix_CholSolve(pL,pXtY,pBeta);
		IF NOT Success THEN
			HA_Matrix_Ridge_Fit 	:= FALSE;
			RETURN;
		END_IF;
	END_IF;
END_FUNCTION