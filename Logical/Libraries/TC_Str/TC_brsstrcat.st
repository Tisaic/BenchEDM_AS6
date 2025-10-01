
(* Checks the memory area before concatenating to prevent overrun. Returns false and doesnt concat if overrun is detected *)
FUNCTION TC_brsstrcat
	TC_brsstrcat 						:= TRUE;
	IF pSrc = 0 OR pDest = 0 OR DestSize = 0 THEN
		TC_brsstrcat 					:= FALSE;
	ELSE
		TC_brsstrcat					:= TRUE;
		brsmemset(ADR(Internal),0,SIZEOF(Internal));
		Internal.SrcSize := brsstrlen(pSrc);
		Internal.DestSize := brsstrlen(pDest);
		IF (Internal.SrcSize+Internal.DestSize) <= DestSize-1 THEN
			brsstrcat(pDest,pSrc);
		ELSE
			TC_brsstrcat				:= FALSE;
		END_IF;
	END_IF;
END_FUNCTION
