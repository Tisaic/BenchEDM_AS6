(* Initialize NGRC State Buffer *)
FUNCTION HA_Matrix_NGRC_InitState
	HA_Matrix_NGRC_InitState		:= TRUE;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.sizeArray				:= SIZEOF(LREAL)*(MAX_HA_MATRIX_ARRAY_IDX+1);
	Internal.sizeTotal				:= Internal.sizeArray + SIZEOF(UDINT)*2;
	
	(* Read INPUT dimensions *)
	brsmemcpy(ADR(Internal.row1),pX+Internal.sizeArray,4);
	brsmemcpy(ADR(Internal.col1),pX+Internal.sizeArray+4,4);
	
	(* Validate INPUTS only - removed output dimension validation *)
	IF pX = 0 OR pState = 0 OR pHistory = 0 OR 
	   Internal.row1 = 0 OR Internal.col1 = 0 OR 
	   LagOrder < 1 OR Stride < 1 OR 
	   Internal.row1 < (LagOrder-1)*Stride + 1 OR 
	   Internal.row1*Internal.col1 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_NGRC_InitState	:= FALSE;
		RETURN;
	END_IF;
	
	(* CALCULATE output dimensions *)
	Internal.row2					:= 1;                    (* State: 1 row *)
	Internal.col2					:= Internal.col1;        (* State: same cols as input *)
	Internal.row3					:= LagOrder*Internal.col1; (* History: LagOrder*cols rows *)
	Internal.col3					:= 1;                    (* History: 1 column *)
	
	(* Verify output will fit in array *)
	IF Internal.row2*Internal.col2 > MAX_HA_MATRIX_ARRAY_IDX+1 OR 
	   Internal.row3*Internal.col3 > MAX_HA_MATRIX_ARRAY_IDX+1 THEN
		HA_Matrix_NGRC_InitState	:= FALSE;
		RETURN;
	END_IF;
	
	(* INITIALIZE State array *)
	brsmemset(pState,0,Internal.sizeTotal);
	brsmemcpy(pState+Internal.sizeArray,ADR(Internal.row2),4);
	brsmemcpy(pState+Internal.sizeArray+4,ADR(Internal.col2),4);
	
	(* INITIALIZE History array *)
	brsmemset(pHistory,0,Internal.sizeTotal);
	brsmemcpy(pHistory+Internal.sizeArray,ADR(Internal.row3),4);
	brsmemcpy(pHistory+Internal.sizeArray+4,ADR(Internal.col3),4);
	
	(* POPULATE State with last sample from X *)
	FOR Internal.i2 := 0 TO Internal.col1-1 DO
		brsmemcpy(ADR(Internal.temp1),pX+((Internal.row1-1)*Internal.col1+Internal.i2)*8,8);
		brsmemcpy(pState+Internal.i2*8,ADR(Internal.temp1),8);
	END_FOR;
	
	(* POPULATE History with last LagOrder samples at stride intervals *)
	FOR Internal.i1 := 0 TO LagOrder-1 DO
	    FOR Internal.i2 := 0 TO Internal.col1-1 DO
			Internal.row4 		:= Internal.row1-1-Internal.i1*Stride;
			brsmemcpy(ADR(Internal.temp1),pX+(Internal.row4*Internal.col1+Internal.i2)*8,8);
			brsmemcpy(pHistory+(Internal.i1*Internal.col1+Internal.i2)*8,ADR(Internal.temp1),8);
	    END_FOR;
	END_FOR;
END_FUNCTION