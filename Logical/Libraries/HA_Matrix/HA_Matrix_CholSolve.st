(* Cholesky Solve *)
FUNCTION HA_Matrix_CholSolve
	HA_Matrix_CholSolve	 			:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pL+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pL+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pB+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pB+Internal.sizeArray+4,4);
	IF pL = 0 OR pB = 0 OR pOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row1 <> Internal.col1 OR Internal.row1 <> Internal.row2 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row2*Internal.col2 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_CholSolve	 		:= FALSE;
	ELSE
		brsmemset(pOut,0,Internal.sizeTotal);
		brsmemcpy(pOut+Internal.sizeArray,ADR(Internal.row2),4);
		brsmemcpy(pOut+Internal.sizeArray+4,ADR(Internal.col2),4);
		FOR Internal.i3 := 0 TO Internal.col2-1 DO
		    FOR Internal.i1 := 0 TO Internal.row1-1 DO
				brsmemcpy(ADR(Internal.result),pB+(Internal.i1*Internal.col2+Internal.i3)*8,8);
		        FOR Internal.i2 := 0 TO Internal.i1-1 DO
					brsmemcpy(ADR(Internal.temp1),pL+(Internal.i1*Internal.col1+Internal.i2)*8,8);
					brsmemcpy(ADR(Internal.temp2),pOut+(Internal.i2*Internal.col2+Internal.i3)*8,8);
		            Internal.result := Internal.result - Internal.temp1*Internal.temp2;
		        END_FOR;
				brsmemcpy(ADR(Internal.temp1),pL+(Internal.i1*Internal.col1+Internal.i1)*8,8);
		        Internal.result 	:= Internal.result/Internal.temp1;
				brsmemcpy(pOut+(Internal.i1*Internal.col2+Internal.i3)*8,ADR(Internal.result),8);
		    END_FOR;
		    FOR Internal.i1 := Internal.row1-1 TO 0 BY -1 DO
				brsmemcpy(ADR(Internal.result),pOut+(Internal.i1*Internal.col2+Internal.i3)*8,8);
		        FOR Internal.i2 := Internal.i1+1 TO Internal.row1-1 DO
					brsmemcpy(ADR(Internal.temp1),pL+(Internal.i2*Internal.col1+Internal.i1)*8,8);
					brsmemcpy(ADR(Internal.temp2),pOut+(Internal.i2*Internal.col2+Internal.i3)*8,8);
		            Internal.result := Internal.result - Internal.temp1*Internal.temp2;
		        END_FOR;
				brsmemcpy(ADR(Internal.temp1),pL+(Internal.i1*Internal.col1+Internal.i1)*8,8);
		        Internal.result 	:= Internal.result/Internal.temp1;
				brsmemcpy(pOut+(Internal.i1*Internal.col2+Internal.i3)*8,ADR(Internal.result),8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION