
(* Finds the index of the enum string *)
FUNCTION TC_Seq_EnumStringSearch
	TC_Seq_EnumStringSearch := -1;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	IF EnumNameSTRING <> '' AND EnumValueSTRING <> '' THEN
		TC_brsstrcat(ADR(Internal.PvRoot),ADR('gES.'),SIZEOF(Internal.PvRoot));
		TC_brsstrcat(ADR(Internal.PvRoot),ADR(EnumNameSTRING),SIZEOF(Internal.PvRoot));
		Internal.Status := PV_ninfo(ADR(Internal.PvRoot),ADR(Internal.Datatype),ADR(Internal.DataLen),ADR(Internal.Dimension));
		IF Internal.Status = 0 AND Internal.Dimension > 0 THEN
			FOR Internal.i := 0 TO UINT_TO_DINT(Internal.Dimension-1) DO
				Internal.IdxString := DINT_TO_STRING(Internal.i);
				brsmemset(ADR(Internal.PvName),0,SIZEOF(Internal.PvName));
				TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.PvRoot),SIZEOF(Internal.PvName));
				TC_brsstrcat(ADR(Internal.PvName),ADR('['),SIZEOF(Internal.PvName));
				TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.IdxString),SIZEOF(Internal.PvName));
				TC_brsstrcat(ADR(Internal.PvName),ADR(']'),SIZEOF(Internal.PvName));
				Internal.Status := PV_xgetadr(ADR(Internal.PvName),ADR(Internal.PvAddress),ADR(Internal.PvLen));
				IF Internal.Status = 0 AND SIZEOF(Internal.PvValue) = Internal.PvLen THEN
					brsmemcpy(ADR(Internal.PvValue),Internal.PvAddress,SIZEOF(Internal.PvValue)-1);
					IF EnumValueSTRING = Internal.PvValue THEN
						TC_Seq_EnumStringSearch := Internal.i;
						EXIT;
					END_IF;
				ELSE
					EXIT;
				END_IF;
			END_FOR;
		END_IF;
	END_IF;	
END_FUNCTION
