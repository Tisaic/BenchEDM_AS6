(* Determinant *)
FUNCTION HA_Matrix_Det

    HA_Matrix_Det := FALSE;
    brsmemset(ADR(Internal),0,SIZEOF(Internal));
    Internal.sizeArray := SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
    Internal.sizeTotal := Internal.sizeArray + SIZEOF(DINT)*2;
    brsmemcpy(ADR(Internal.row1),pIn+Internal.sizeArray,4);
    brsmemcpy(ADR(Internal.col1),pIn+Internal.sizeArray+4,4);
    IF pIn = 0 OR pTemp = 0 OR pResult = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row1 <> Internal.col1 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
        Internal.result := 0.0;
        brsmemcpy(pResult,ADR(Internal.result),8);
        HA_Matrix_Det := FALSE;
    ELSE
        IF Internal.row1 = 1 THEN
            brsmemcpy(ADR(Internal.result),pIn,8);
            brsmemcpy(pResult,ADR(Internal.result),8);
            HA_Matrix_Det := TRUE;
        ELSIF Internal.row1 = 2 THEN
            brsmemcpy(ADR(Internal.temp1),pIn+0*8,8);
            brsmemcpy(ADR(Internal.temp2),pIn+1*8,8);
            brsmemcpy(ADR(Internal.temp3),pIn+2*8,8);
            brsmemcpy(ADR(Internal.temp4),pIn+3*8,8);
            Internal.result := Internal.temp1*Internal.temp4 - Internal.temp2*Internal.temp3;
            brsmemcpy(pResult,ADR(Internal.result),8);
            HA_Matrix_Det := TRUE;
        ELSE
            Internal.result := 1.0;  (* Use result to track sign *)
            brsmemcpy(pTemp,pIn,Internal.sizeArray);
            brsmemcpy(pTemp+Internal.sizeArray,pIn+Internal.sizeArray,8);
            FOR Internal.i1 := 0 TO Internal.row1-2 DO
                brsmemcpy(ADR(Internal.temp1),pTemp+(Internal.i1*Internal.col1+Internal.i1)*8,8);
                IF ABS(Internal.temp1) < 1.0e-10 THEN
                    FOR Internal.i2 := Internal.i1+1 TO Internal.row1-1 DO
                        brsmemcpy(ADR(Internal.temp1),pTemp+(Internal.i2*Internal.col1+Internal.i1)*8,8);
                        IF ABS(Internal.temp1) > 1.0e-10 THEN
                            FOR Internal.i3 := 0 TO Internal.col1-1 DO
                                brsmemcpy(ADR(Internal.temp2),pTemp+(Internal.i1*Internal.col1+Internal.i3)*8,8);
                                brsmemcpy(ADR(Internal.temp3),pTemp+(Internal.i2*Internal.col1+Internal.i3)*8,8);
                                brsmemcpy(pTemp+(Internal.i1*Internal.col1+Internal.i3)*8,ADR(Internal.temp3),8);
                                brsmemcpy(pTemp+(Internal.i2*Internal.col1+Internal.i3)*8,ADR(Internal.temp2),8);
                            END_FOR;
                            Internal.result := -Internal.result;  (* Negate sign *)
                            EXIT;
                        END_IF;
                    END_FOR;
                END_IF;
                brsmemcpy(ADR(Internal.temp1),pTemp+(Internal.i1*Internal.col1+Internal.i1)*8,8);
                IF ABS(Internal.temp1) < 1.0e-10 THEN
                    Internal.result := 0.0;
                    brsmemcpy(pResult,ADR(Internal.result),8);
                    HA_Matrix_Det := TRUE;  (* Successfully determined matrix is singular *)
                    RETURN;
                END_IF;
                FOR Internal.i2 := Internal.i1+1 TO Internal.row1-1 DO
                    brsmemcpy(ADR(Internal.temp2),pTemp+(Internal.i2*Internal.col1+Internal.i1)*8,8);
                    Internal.temp3 := Internal.temp2/Internal.temp1;
                    FOR Internal.i3 := Internal.i1 TO Internal.col1-1 DO
                        brsmemcpy(ADR(Internal.temp2),pTemp+(Internal.i2*Internal.col1+Internal.i3)*8,8);
                        brsmemcpy(ADR(Internal.temp4),pTemp+(Internal.i1*Internal.col1+Internal.i3)*8,8);
                        Internal.temp2 := Internal.temp2 - Internal.temp3*Internal.temp4;
                        brsmemcpy(pTemp+(Internal.i2*Internal.col1+Internal.i3)*8,ADR(Internal.temp2),8);
                    END_FOR;
                END_FOR;
            END_FOR;
            (* result already contains the sign, now multiply by diagonal elements *)
            FOR Internal.i1 := 0 TO Internal.row1-1 DO
                brsmemcpy(ADR(Internal.temp1),pTemp+(Internal.i1*Internal.col1+Internal.i1)*8,8);
                Internal.result := Internal.result*Internal.temp1;
            END_FOR;
            brsmemcpy(pResult,ADR(Internal.result),8);
            HA_Matrix_Det := TRUE;
        END_IF;
    END_IF;
END_FUNCTION