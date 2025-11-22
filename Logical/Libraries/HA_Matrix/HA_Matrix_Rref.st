(* Reduced Row Echelon Form *)
FUNCTION HA_Matrix_Rref
	HA_Matrix_Rref		 			:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pIn+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pIn+Internal.sizeArray+4,4);
	IF pIn = 0 OR pOut = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_Rref	 			:= FALSE;
		brsmemset(pOut,0,Internal.sizeTotal);
		Internal.result				:= 0.0;
		IF pOut <> 0 THEN
			brsmemcpy(pOut,ADR(Internal.row1),4);
		END_IF;
	ELSE 
	    brsmemcpy(pOut,pIn,Internal.sizeTotal);
        FOR Internal.i1 := 0 TO Internal.row1-1 DO
			brsmemcpy(ADR(Internal.temp1),pOut+(Internal.i1*Internal.col1+Internal.i1)*8,8);
			IF ABS(Internal.temp1) < 1.0e-10 THEN
        		FOR Internal.i2 := Internal.i1+1 TO Internal.row1-1 DO
					brsmemcpy(ADR(Internal.temp1),pOut+(Internal.i2*Internal.col1+Internal.i1)*8,8);
					IF ABS(Internal.temp1) > 1.0e-10 THEN
						FOR Internal.i3 := 0 TO Internal.col1-1 DO
							brsmemcpy(ADR(Internal.temp2),pOut+(Internal.i1*Internal.col1+Internal.i3)*8,8);
							brsmemcpy(ADR(Internal.temp3),pOut+(Internal.i2*Internal.col1+Internal.i3)*8,8);
							brsmemcpy(pOut+(Internal.i1*Internal.col1+Internal.i3)*8,ADR(Internal.temp3),8);
							brsmemcpy(pOut+(Internal.i2*Internal.col1+Internal.i3)*8,ADR(Internal.temp2),8);
						END_FOR;
						EXIT;
					END_IF;
				END_FOR;
			END_IF;
			brsmemcpy(ADR(Internal.temp1),pOut+(Internal.i1*Internal.col1+Internal.i1)*8,8);
			IF ABS(Internal.temp1) > 1.0e-10 THEN
	            FOR Internal.i2 := 0 TO Internal.col1-1 DO
					brsmemcpy(ADR(Internal.temp2),pOut+(Internal.i1*Internal.col1+Internal.i2)*8,8);
	                Internal.temp3 := Internal.temp2 / Internal.temp1;
					brsmemcpy(pOut+(Internal.i1*Internal.col1+Internal.i2)*8,ADR(Internal.temp3),8);
	            END_FOR;
	            FOR Internal.i2 := 0 TO Internal.row1-1 DO
	                IF Internal.i2 <> Internal.i1 THEN
						brsmemcpy(ADR(Internal.temp1),pOut+(Internal.i2*Internal.col1+Internal.i1)*8,8);
	                    FOR Internal.i3 := 0 TO Internal.col1-1 DO
							brsmemcpy(ADR(Internal.temp2),pOut+(Internal.i2*Internal.col1+Internal.i3)*8,8);
							brsmemcpy(ADR(Internal.temp3),pOut+(Internal.i1*Internal.col1+Internal.i3)*8,8);
							Internal.temp4 := Internal.temp2 - Internal.temp1 * Internal.temp3;
							IF ABS(Internal.temp4) < 1.0e-10 THEN
								Internal.temp4 := 0.0;
							END_IF;
							brsmemcpy(pOut+(Internal.i2*Internal.col1+Internal.i3)*8,ADR(Internal.temp4),8);
	                    END_FOR;
	                END_IF;
	            END_FOR;
			END_IF;
        END_FOR;
		Internal.i3 := 0;
        FOR Internal.i1 := 0 TO Internal.row1-1 DO
			Internal.i4 := 0;
	    	FOR Internal.i2 := 0 TO Internal.col1-1 DO
				brsmemcpy(ADR(Internal.temp1),pOut+(Internal.i1*Internal.col1+Internal.i2)*8,8);
				IF ABS(Internal.temp1) > 1.0e-10 THEN
					Internal.i4 := 1;
				END_IF;
			END_FOR;
			IF Internal.i4 = 0 THEN
				Internal.i3 := Internal.i3 + 1;
			END_IF;
        END_FOR;
		IF pOut <> 0 THEN
			brsmemcpy(pOut,ADR(Internal.i3),4);
		END_IF;
	END_IF;
END_FUNCTION