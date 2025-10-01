
(* Pops the top index out of the array into out variable *)
FUNCTION TC_Array_Pop

	TC_Array_Pop := 0;
	brsmemset(ADR(emptyData), 0, SIZEOF(emptyData));
	
	//Validate input parameters
	IF pBuffer = 0 THEN
		TC_Array_Pop.0  := TRUE;
		TC_Array_Pop.15 := TRUE;
	END_IF
	
	IF sizeBuffer = 0 THEN
		TC_Array_Pop.1  := TRUE;
		TC_Array_Pop.15 := TRUE;
	END_IF
	
	IF pElement = 0 THEN
		TC_Array_Pop.2  := TRUE;
		TC_Array_Pop.15 := TRUE;
	END_IF
	
	IF SizeElement = 0 THEN
		TC_Array_Pop.3  := TRUE;
		TC_Array_Pop.15 := TRUE;
	END_IF
	
	IF sizeBuffer MOD SizeElement <> 0 THEN
		TC_Array_Pop.4  := TRUE;
		TC_Array_Pop.15 := TRUE;
	END_IF
	
	IF SizeElement > TC_ARRAY_MAXELEMENTSIZE THEN
		TC_Array_Pop.5  := TRUE;
		TC_Array_Pop.15 := TRUE;
	END_IF
	
	//Everything passed we can go a head and look for an index to pop
	IF TC_Array_Pop = 0 THEN
		FOR i:=0 TO (sizeBuffer / SizeElement) - 1 DO
			IF brsmemcmp(pBuffer + SizeElement*i, ADR(emptyData), SizeElement) <> 0 THEN
				//We found the first index
				brsmemcpy(pElement, pBuffer + SizeElement*i, SizeElement);
				nextSpot := brsmemmove(pBuffer, pBuffer + SizeElement*(i+1), sizeBuffer - SizeElement * (i+1));
				brsmemset(nextSpot, 0, SizeElement*(i+1));
				TC_Array_Pop := 1;
				EXIT;
			END_IF
		END_FOR
	END_IF

END_FUNCTION
