(* Recursive Least Squares Update *)
FUNCTION HA_Matrix_RLS
	HA_Matrix_RLS	 				:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(DINT)*2;
	brsmemcpy(ADR(Internal.row1),pTheta+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pTheta+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row2),pP+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col2),pP+Internal.sizeArray+4,4);
	brsmemcpy(ADR(Internal.row3),pX+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col3),pX+Internal.sizeArray+4,4);
	IF pTheta = 0 OR pP = 0 OR pX = 0 OR Internal.row1 = 0 OR Internal.col1 = 0 OR Internal.row2 = 0 OR Internal.col2 = 0 OR Internal.row3 = 0 OR Internal.col3 = 0 OR Internal.col1 <> 1 OR Internal.row2 <> Internal.col2 OR Internal.row1 <> Internal.row2 OR Internal.row3 <> Internal.row1 OR Internal.col3 <> 1 OR Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Internal.row2*Internal.col2 > MAX_HA_MATRIX_ARRAY_IDX+1 OR Lambda <= 0.0 OR Lambda > 1.0 THEN
		HA_Matrix_RLS	 			:= FALSE;
	ELSE
		Internal.temp1 				:= 0.0;
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			Internal.temp2 			:= 0.0;
		    FOR Internal.i2 := 0 TO Internal.row2-1 DO
				brsmemcpy(ADR(Internal.temp3),pP+(Internal.i1*Internal.col2+Internal.i2)*8,8);
				brsmemcpy(ADR(Internal.temp4),pX+(Internal.i2*Internal.col3)*8,8);
		        Internal.temp2 		:= Internal.temp2 + Internal.temp3*Internal.temp4;
		    END_FOR;
			brsmemcpy(pTemp+(Internal.i1*1)*8,ADR(Internal.temp2),8);
			brsmemcpy(ADR(Internal.temp3),pX+(Internal.i1*Internal.col3)*8,8);
			Internal.temp1 			:= Internal.temp1 + Internal.temp3*Internal.temp2;
		END_FOR;
		Internal.temp1 				:= Lambda + Internal.temp1;
		IF ABS(Internal.temp1) < 1.0e-10 THEN
		    HA_Matrix_RLS	 		:= FALSE;
		    RETURN;
		END_IF;
		Internal.result 			:= 0.0;
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			brsmemcpy(ADR(Internal.temp2),pX+(Internal.i1*Internal.col3)*8,8);
			brsmemcpy(ADR(Internal.temp3),pTheta+(Internal.i1*Internal.col1)*8,8);
		    Internal.result 		:= Internal.result + Internal.temp2*Internal.temp3;
		END_FOR;
		Internal.result 			:= Y - Internal.result;
		FOR Internal.i1 := 0 TO Internal.row1-1 DO
			brsmemcpy(ADR(Internal.temp2),pTemp+(Internal.i1*1)*8,8);
		    Internal.temp3 			:= Internal.temp2/Internal.temp1;
			brsmemcpy(ADR(Internal.temp4),pTheta+(Internal.i1*Internal.col1)*8,8);
			Internal.temp4 			:= Internal.temp4 + Internal.temp3*Internal.result;
			brsmemcpy(pTheta+(Internal.i1*Internal.col1)*8,ADR(Internal.temp4),8);
		END_FOR;
		FOR Internal.i1 := 0 TO Internal.row2-1 DO
		    FOR Internal.i2 := 0 TO Internal.col2-1 DO
				Internal.temp2 		:= 0.0;
		        FOR Internal.i3 := 0 TO Internal.row2-1 DO
					brsmemcpy(ADR(Internal.temp3),pTemp+(Internal.i1*1)*8,8);
					brsmemcpy(ADR(Internal.temp4),pX+(Internal.i3*Internal.col3)*8,8);
					brsmemcpy(ADR(Internal.temp5),pP+(Internal.i3*Internal.col2+Internal.i2)*8,8);
		            Internal.temp2 	:= Internal.temp2 + Internal.temp3*Internal.temp4*Internal.temp5;
		        END_FOR;
				brsmemcpy(ADR(Internal.temp3),pP+(Internal.i1*Internal.col2+Internal.i2)*8,8);
		        Internal.result 	:= (Internal.temp3 - Internal.temp2/Internal.temp1)/Lambda;
				brsmemcpy(pP+(Internal.i1*Internal.col2+Internal.i2)*8,ADR(Internal.result),8);
		    END_FOR;
		END_FOR;
	END_IF;
END_FUNCTION