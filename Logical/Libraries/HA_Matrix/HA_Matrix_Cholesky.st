(* Cholesky Decomposition *)
FUNCTION HA_Matrix_Cholesky
	HA_Matrix_Cholesky	 			:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pIn+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pIn+Internal.sizeArray+4,4);
	IF pIn = 0 OR pOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row1 <> Internal.col1 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_Cholesky	 		:= FALSE;
	ELSE
		brsmemset(pOut,0,Internal.sizeTotal);
		brsmemcpy(pOut+Internal.sizeArray,ADR(Internal.row1),4);
		brsmemcpy(pOut+Internal.sizeArray+4,ADR(Internal.col1),4);
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
		    FOR Internal.i2 := 0 TO Internal.i1 DO
				Internal.result 	:= 0.0;
		        IF Internal.i1 = Internal.i2 THEN
		            FOR Internal.i3 := 0 TO Internal.i2-1 DO
						brsmemcpy(ADR(Internal.temp1),pOut+(Internal.i1*Internal.col1+Internal.i3)*8,8);
		                Internal.result := Internal.result + Internal.temp1*Internal.temp1;
		            END_FOR;
					brsmemcpy(ADR(Internal.temp1),pIn+(Internal.i1*Internal.col1+Internal.i1)*8,8);
		            Internal.result := Internal.temp1 - Internal.result;
		            IF Internal.result < 1.0e-10 THEN
		                HA_Matrix_Cholesky := FALSE;
		                RETURN;
		            END_IF;
		            Internal.result := SQRT(Internal.result);
					brsmemcpy(pOut+(Internal.i1*Internal.col1+Internal.i1)*8,ADR(Internal.result),8);
		        ELSE
		            FOR Internal.i3 := 0 TO Internal.i2-1 DO
						brsmemcpy(ADR(Internal.temp1),pOut+(Internal.i1*Internal.col1+Internal.i3)*8,8);
						brsmemcpy(ADR(Internal.temp2),pOut+(Internal.i2*Internal.col1+Internal.i3)*8,8);
		                Internal.result := Internal.result + Internal.temp1*Internal.temp2;
		            END_FOR;
					brsmemcpy(ADR(Internal.temp1),pIn+(Internal.i1*Internal.col1+Internal.i2)*8,8);
					brsmemcpy(ADR(Internal.temp2),pOut+(Internal.i2*Internal.col1+Internal.i2)*8,8);
		            Internal.result := (Internal.temp1 - Internal.result)/Internal.temp2;
					brsmemcpy(pOut+(Internal.i1*Internal.col1+Internal.i2)*8,ADR(Internal.result),8);
		        END_IF;
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION