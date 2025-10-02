FUNCTION TC_Seq_JsonToElem
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	TC_Seq_JsonToElem := 0;
	IF pJsonString = 0 OR pElement = 0 THEN
		TC_Seq_JsonToElem.0 := TRUE;
		RETURN;
	END_IF;
	brsmemset(pElement,0,SIZEOF(Internal.Element));	
	Internal.TC_JSON_Parse_0(Enable := TRUE, pBuffer := pJsonString, pPairs := ADR(Internal.JSONPairs), NoQuotes := TRUE);
	IF Internal.TC_JSON_Parse_0.Error THEN
		TC_Seq_JsonToElem.1 := TRUE;
		RETURN;
	END_IF;
	Internal.TC_JSON_Parse_0(Enable := FALSE);
	FOR Internal.i := 0 TO MAX_JSON_PARSE_PAIR_IDX DO
		IF Internal.JSONPairs[Internal.i].Name = '' AND Internal.JSONPairs[Internal.i].Value = '' THEN
			EXIT;
		ELSE
			IF Internal.JSONPairs[Internal.i].Name = 'par' THEN
				IF Internal.Par = '' THEN
					TC_brsstrcat(ADR(Internal.Par),ADR('{'),SIZEOF(Internal.Par));
				ELSE
					Internal.ParDone := TRUE;
					TC_brsstrcat(ADR(Internal.Par),ADR('}'),SIZEOF(Internal.Par));
				END_IF;
			ELSIF NOT Internal.ParDone AND Internal.Par <> '' THEN
				IF Internal.Par <> '{' THEN
					TC_brsstrcat(ADR(Internal.Par),ADR(','),SIZEOF(Internal.Par));
				END_IF;
				TC_brsstrcat(ADR(Internal.Par),ADR('"'),SIZEOF(Internal.Par));
				TC_brsstrcat(ADR(Internal.Par),ADR(Internal.JSONPairs[Internal.i].Name),SIZEOF(Internal.Par));
				TC_brsstrcat(ADR(Internal.Par),ADR('":"'),SIZEOF(Internal.Par));
				TC_brsstrcat(ADR(Internal.Par),ADR(Internal.JSONPairs[Internal.i].Value),SIZEOF(Internal.Par));
				TC_brsstrcat(ADR(Internal.Par),ADR('"'),SIZEOF(Internal.Par));
			ELSIF Internal.JSONPairs[Internal.i].Name = 'type' THEN
				IF Internal.JSONPairs[Internal.i].Value = 'D' THEN
					Internal.Element.Type 	:= TC_SEQ_TYPE_DELAY;
				ELSIF Internal.JSONPairs[Internal.i].Value = 'W' THEN
					Internal.Element.Type 	:= TC_SEQ_TYPE_WAIT;
				ELSIF Internal.JSONPairs[Internal.i].Value = 'C' THEN
					Internal.Element.Type 	:= TC_SEQ_TYPE_CMD;
				ELSIF Internal.JSONPairs[Internal.i].Value = 'M' THEN
					Internal.Element.Type 	:= TC_SEQ_TYPE_MON;
				ELSE
					TC_Seq_JsonToElem.2 	:= TRUE;
					RETURN;
				END_IF;
			ELSIF Internal.JSONPairs[Internal.i].Name = 'driver' THEN
				Internal.Driver 	:= Internal.JSONPairs[Internal.i].Value;
			ELSIF Internal.JSONPairs[Internal.i].Name = 'ident' THEN
				Internal.Ident 		:= Internal.JSONPairs[Internal.i].Value;
			ELSIF Internal.JSONPairs[Internal.i].Name = 'inst' THEN
				Internal.Inst 		:= Internal.JSONPairs[Internal.i].Value;
			ELSIF Internal.JSONPairs[Internal.i].Name = 'time' THEN
				Internal.Element.Time 		:= STRING_TO_LREAL(Internal.JSONPairs[Internal.i].Value);
			ELSIF Internal.JSONPairs[Internal.i].Name = 'enable' THEN
				Internal.Enable 	:= STRING_TO_BOOL(Internal.JSONPairs[Internal.i].Value);
			ELSIF Internal.JSONPairs[Internal.i].Name = 'sev' THEN
				Internal.Sev 		:= STRING_TO_DINT(Internal.JSONPairs[Internal.i].Value);
			END_IF;
		END_IF;
	END_FOR;

	IF Internal.Element.Type = TC_SEQ_TYPE_DELAY THEN
		brsmemcpy(pElement,ADR(Internal.Element),SIZEOF(Internal.Element));
		RETURN;
	ELSIF Internal.Driver = '' OR Internal.Inst = '' OR Internal.Ident = '' THEN
		TC_Seq_JsonToElem.3 := TRUE;
		brsmemset(pElement,0,SIZEOF(Internal.Element));	
		RETURN;
	END_IF;

	TC_brsstrcat(ADR(Internal.EnumNameString_Inst),ADR('DRIVER_INST_'),SIZEOF(Internal.EnumNameString_Inst));
	TC_brsstrcat(ADR(Internal.EnumNameString_Inst),ADR(Internal.Driver),SIZEOF(Internal.EnumNameString_Inst));
	TC_brsstrcat(ADR(Internal.EnumNameString_Inst),ADR('_ENUM'),SIZEOF(Internal.EnumNameString_Inst));
	TC_brsstrcat(ADR(Internal.EnumValueString_Inst),ADR('DRIVER_INST_'),SIZEOF(Internal.EnumValueString_Inst));
	TC_brsstrcat(ADR(Internal.EnumValueString_Inst),ADR(Internal.Driver),SIZEOF(Internal.EnumValueString_Inst));
	TC_brsstrcat(ADR(Internal.EnumValueString_Inst),ADR('_'),SIZEOF(Internal.EnumValueString_Inst));
	TC_brsstrcat(ADR(Internal.EnumValueString_Inst),ADR(Internal.Inst),SIZEOF(Internal.EnumValueString_Inst));
	Internal.InstIdx := TC_Seq_EnumStringSearch(Internal.EnumNameString_Inst,Internal.EnumValueString_Inst);
	IF Internal.InstIdx < 0 THEN
		TC_Seq_JsonToElem.4 := TRUE;
		brsmemset(pElement,0,SIZEOF(Internal.Element));	
		RETURN;
	END_IF;


	IF Internal.Element.Type = TC_SEQ_TYPE_WAIT THEN
		TC_brsstrcat(ADR(Internal.EnumNameString_Ident),ADR('W_'),SIZEOF(Internal.EnumNameString_Ident));
		TC_brsstrcat(ADR(Internal.EnumNameString_Ident),ADR(Internal.Driver),SIZEOF(Internal.EnumNameString_Ident));
		TC_brsstrcat(ADR(Internal.EnumNameString_Ident),ADR('_ENUM'),SIZEOF(Internal.EnumNameString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR('W_'),SIZEOF(Internal.EnumValueString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR(Internal.Driver),SIZEOF(Internal.EnumValueString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR('_'),SIZEOF(Internal.EnumValueString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR(Internal.Ident),SIZEOF(Internal.EnumValueString_Ident));
		Internal.IdentIdx := TC_Seq_EnumStringSearch(Internal.EnumNameString_Ident,Internal.EnumValueString_Ident);
		IF Internal.IdentIdx < 0 THEN
			TC_Seq_JsonToElem.5 := TRUE;
			brsmemset(pElement,0,SIZEOF(Internal.Element));
			RETURN;
		END_IF;
		brsmemset(ADR(Internal.PvName),0,SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR('gDriver.'),SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.Driver),SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR('['),SIZEOF(Internal.PvName));
		Internal.InstIdxString := DINT_TO_STRING(Internal.InstIdx);
		TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.InstIdxString),SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR('].Wait['),SIZEOF(Internal.PvName));
		Internal.IdentIdxString := DINT_TO_STRING(Internal.IdentIdx);
		TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.IdentIdxString),SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR(']'),SIZEOF(Internal.PvName));
		Internal.Status := PV_xgetadr(ADR(Internal.PvName),ADR(Internal.PvAddress),ADR(Internal.PvLen));
		IF Internal.Status = 0 AND Internal.PvLen = 4 THEN
			Internal.WaitPvAddress := Internal.PvAddress;
			Internal.Element.WaitPvAddress := Internal.PvAddress;
			brsmemcpy(ADR(Internal.Element.Json),pJsonString,SIZEOF(Internal.Element.Json));
			brsmemcpy(pElement,ADR(Internal.Element),SIZEOF(Internal.Element));
		ELSE
			TC_Seq_JsonToElem.6 		:= TRUE;
			brsmemset(pElement,0,SIZEOF(Internal.Element));	
			RETURN;
		END_IF;
	ELSIF Internal.Element.Type = TC_SEQ_TYPE_MON THEN
		TC_brsstrcat(ADR(Internal.EnumNameString_Ident),ADR('M_'),SIZEOF(Internal.EnumNameString_Ident));
		TC_brsstrcat(ADR(Internal.EnumNameString_Ident),ADR(Internal.Driver),SIZEOF(Internal.EnumNameString_Ident));
		TC_brsstrcat(ADR(Internal.EnumNameString_Ident),ADR('_ENUM'),SIZEOF(Internal.EnumNameString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR('M_'),SIZEOF(Internal.EnumValueString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR(Internal.Driver),SIZEOF(Internal.EnumValueString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR('_'),SIZEOF(Internal.EnumValueString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR(Internal.Ident),SIZEOF(Internal.EnumValueString_Ident));
		Internal.IdentIdx := TC_Seq_EnumStringSearch(Internal.EnumNameString_Ident,Internal.EnumValueString_Ident);
		IF Internal.IdentIdx < 0 THEN
			TC_Seq_JsonToElem.7 := TRUE;
			brsmemset(pElement,0,SIZEOF(Internal.Element));
			RETURN;
		END_IF;
		brsmemset(ADR(Internal.PvName),0,SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR('gDriver.'),SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.Driver),SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR('['),SIZEOF(Internal.PvName));
		Internal.InstIdxString := DINT_TO_STRING(Internal.InstIdx);
		TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.InstIdxString),SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR('].Par.Mon['),SIZEOF(Internal.PvName));
		Internal.IdentIdxString := DINT_TO_STRING(Internal.IdentIdx);
		TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.IdentIdxString),SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR(']'),SIZEOF(Internal.PvName));
		brsmemset(ADR(Internal.PvNameSub),0,SIZEOF(Internal.PvNameSub));
		TC_brsstrcat(ADR(Internal.PvNameSub),ADR(Internal.PvName),SIZEOF(Internal.PvNameSub));
		TC_brsstrcat(ADR(Internal.PvNameSub),ADR('.Enable'),SIZEOF(Internal.PvNameSub));
		Internal.Status := PV_xgetadr(ADR(Internal.PvNameSub),ADR(Internal.PvAddress),ADR(Internal.PvLen));
		IF Internal.Status = 0 AND Internal.PvLen = 1 THEN
			brsmemcpy(Internal.PvAddress,ADR(Internal.Enable),SIZEOF(Internal.Enable));
		ELSE
			TC_Seq_JsonToElem.8 		:= TRUE;
			brsmemset(pElement,0,SIZEOF(Internal.Element));	
			RETURN;
		END_IF;
		brsmemset(ADR(Internal.PvNameSub),0,SIZEOF(Internal.PvNameSub));
		TC_brsstrcat(ADR(Internal.PvNameSub),ADR(Internal.PvName),SIZEOF(Internal.PvNameSub));
		TC_brsstrcat(ADR(Internal.PvNameSub),ADR('.Sev'),SIZEOF(Internal.PvNameSub));
		Internal.Status := PV_xgetadr(ADR(Internal.PvNameSub),ADR(Internal.PvAddress),ADR(Internal.PvLen));
		IF Internal.Status = 0 AND Internal.PvLen = 4 THEN
			brsmemcpy(Internal.PvAddress,ADR(Internal.Sev),SIZEOF(Internal.Sev));
		ELSE
			TC_Seq_JsonToElem.9 		:= TRUE;
			brsmemset(pElement,0,SIZEOF(Internal.Element));	
			RETURN;
		END_IF;
		brsmemset(ADR(Internal.PvNameSub),0,SIZEOF(Internal.PvNameSub));
		TC_brsstrcat(ADR(Internal.PvNameSub),ADR(Internal.PvName),SIZEOF(Internal.PvNameSub));
		TC_brsstrcat(ADR(Internal.PvNameSub),ADR('.Time'),SIZEOF(Internal.PvNameSub));
		Internal.Status := PV_xgetadr(ADR(Internal.PvNameSub),ADR(Internal.PvAddress),ADR(Internal.PvLen));
		IF Internal.Status = 0 AND Internal.PvLen = 8 THEN
			brsmemcpy(Internal.PvAddress,ADR(Internal.Element.Time),SIZEOF(Internal.Element.Time));
		ELSE
			TC_Seq_JsonToElem.10 		:= TRUE;
			brsmemset(pElement,0,SIZEOF(Internal.Element));	
			RETURN;
		END_IF;
		brsmemcpy(ADR(Internal.Element.Json),pJsonString,SIZEOF(Internal.Element.Json));
		brsmemcpy(pElement,ADR(Internal.Element),SIZEOF(Internal.Element));
	ELSIF Internal.Element.Type = TC_SEQ_TYPE_CMD THEN
		TC_brsstrcat(ADR(Internal.EnumNameString_Ident),ADR('C_'),SIZEOF(Internal.EnumNameString_Ident));
		TC_brsstrcat(ADR(Internal.EnumNameString_Ident),ADR(Internal.Driver),SIZEOF(Internal.EnumNameString_Ident));
		TC_brsstrcat(ADR(Internal.EnumNameString_Ident),ADR('_ENUM'),SIZEOF(Internal.EnumNameString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR('C_'),SIZEOF(Internal.EnumValueString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR(Internal.Driver),SIZEOF(Internal.EnumValueString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR('_'),SIZEOF(Internal.EnumValueString_Ident));
		TC_brsstrcat(ADR(Internal.EnumValueString_Ident),ADR(Internal.Ident),SIZEOF(Internal.EnumValueString_Ident));
		Internal.IdentIdx := TC_Seq_EnumStringSearch(Internal.EnumNameString_Ident,Internal.EnumValueString_Ident);
		IF Internal.IdentIdx < 0 THEN
			TC_Seq_JsonToElem.11 := TRUE;
			brsmemset(pElement,0,SIZEOF(Internal.Element));	
			RETURN;
		END_IF;
		brsmemset(ADR(Internal.PvName),0,SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.DriverRoot),ADR('gDriver.'),SIZEOF(Internal.DriverRoot));
		TC_brsstrcat(ADR(Internal.DriverRoot),ADR(Internal.Driver),SIZEOF(Internal.DriverRoot));
		TC_brsstrcat(ADR(Internal.DriverRoot),ADR('['),SIZEOF(Internal.DriverRoot));
		Internal.InstIdxString := DINT_TO_STRING(Internal.InstIdx);
		TC_brsstrcat(ADR(Internal.DriverRoot),ADR(Internal.InstIdxString),SIZEOF(Internal.DriverRoot));
		TC_brsstrcat(ADR(Internal.DriverRoot),ADR('].'),SIZEOF(Internal.DriverRoot));
		TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.DriverRoot),SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR('Cmd['),SIZEOF(Internal.PvName));
		Internal.IdentIdxString := DINT_TO_STRING(Internal.IdentIdx);
		TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.IdentIdxString),SIZEOF(Internal.PvName));
		TC_brsstrcat(ADR(Internal.PvName),ADR(']'),SIZEOF(Internal.PvName));
		Internal.Status := PV_xgetadr(ADR(Internal.PvName),ADR(Internal.PvAddress),ADR(Internal.PvLen));
		IF Internal.Status = 0 AND Internal.PvLen = 1 THEN
			Internal.CmdPvAddress := Internal.PvAddress;
		ELSE
			TC_Seq_JsonToElem.12 		:= TRUE;
			brsmemset(pElement,0,SIZEOF(Internal.Element));	
			RETURN;
		END_IF;


		brsmemset(ADR(Internal.JSONPairs),0,SIZEOF(Internal.JSONPairs));	
		Internal.TC_JSON_Parse_0(Enable := TRUE, pBuffer := ADR(Internal.Par), pPairs := ADR(Internal.JSONPairs), NoQuotes := TRUE);
		IF Internal.TC_JSON_Parse_0.Error THEN
			TC_Seq_JsonToElem.13 := TRUE;
			brsmemset(pElement,0,SIZEOF(Internal.Element));	
			RETURN;
		END_IF;
		Internal.TC_JSON_Parse_0(Enable := FALSE);
		Internal.idx := 0;
		FOR Internal.i := 0 TO MAX_JSON_PARSE_PAIR_IDX DO
			IF Internal.JSONPairs[Internal.i].Name = '' AND Internal.JSONPairs[Internal.i].Value = '' THEN
				EXIT;
			ELSIF Internal.JSONPairs[Internal.i].Name <> '' THEN
				brsmemset(ADR(Internal.ParDataType),0,SIZEOF(Internal.ParDataType));
				brsmemcpy(ADR(Internal.ParDataType),ADR(Internal.JSONPairs[Internal.i].Value)+1,2);
				brsmemset(ADR(Internal.ParValue),0,SIZEOF(Internal.ParValue));
				brsmemcpy(ADR(Internal.ParValue),ADR(Internal.JSONPairs[Internal.i].Value)+4,MAX_JSON_PARSE_VALUE_LEN-4);
				brsmemset(ADR(Internal.PvName),0,SIZEOF(Internal.PvName));
				TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.DriverRoot),SIZEOF(Internal.PvName));
				TC_brsstrcat(ADR(Internal.PvName),ADR('Par.'),SIZEOF(Internal.PvName));
				TC_brsstrcat(ADR(Internal.PvName),ADR(Internal.JSONPairs[Internal.i].Name),SIZEOF(Internal.PvName));
				Internal.ParElement[Internal.idx].Name := Internal.PvName;
				Internal.Status := PV_ninfo(ADR(Internal.PvName),ADR(Internal.Datatype),ADR(Internal.DataLen),ADR(Internal.Dimension));
				IF Internal.Status <> 0 THEN
					TC_Seq_JsonToElem.14 := TRUE;
					brsmemset(pElement,0,SIZEOF(Internal.Element));	
					RETURN;
				END_IF;
				IF Internal.Datatype = SYSLIB_IEC_TYPE_BOOL AND Internal.ParDataType = 'BO' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_BOOL;
					Internal.ParElement[Internal.idx].GenVar.VarBOOL 			:= STRING_TO_BOOL(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_SINT AND Internal.ParDataType = 'SS' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_SINT;
					Internal.ParElement[Internal.idx].GenVar.VarSINT 			:= STRING_TO_SINT(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_USINT AND Internal.ParDataType = 'US' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_USINT;
					Internal.ParElement[Internal.idx].GenVar.VarUSINT 		:= STRING_TO_USINT(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_INT AND Internal.ParDataType = 'SI' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_INT;
					Internal.ParElement[Internal.idx].GenVar.VarINT 			:= STRING_TO_INT(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_UINT AND Internal.ParDataType = 'UI' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_UINT;
					Internal.ParElement[Internal.idx].GenVar.VarUINT 			:= STRING_TO_UINT(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_DINT AND Internal.ParDataType = 'SD' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_DINT;
					Internal.ParElement[Internal.idx].GenVar.VarDINT 			:= STRING_TO_DINT(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_UDINT AND Internal.ParDataType = 'UD' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_UDINT;
					Internal.ParElement[Internal.idx].GenVar.VarUDINT 		:= STRING_TO_UDINT(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_REAL AND Internal.ParDataType = 'RR' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_REAL;
					Internal.ParElement[Internal.idx].GenVar.VarREAL 			:= STRING_TO_REAL(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_LREAL AND Internal.ParDataType = 'LR' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_LREAL;
					Internal.ParElement[Internal.idx].GenVar.VarLREAL 		:= STRING_TO_LREAL(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_TIME AND Internal.ParDataType = 'TM' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_TIME;
					Internal.ParElement[Internal.idx].GenVar.VarTIME 			:= STRING_TO_TIME(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_DATE_AND_TIME AND Internal.ParDataType = 'DT' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_DT;
					Internal.ParElement[Internal.idx].GenVar.VarDT 			:= STRING_TO_DT(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_STRING AND Internal.ParDataType = 'ST' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_STRING;
					Internal.ParElement[Internal.idx].GenVar.VarSTRING 		:= Internal.ParValue;
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_UDINT AND Internal.ParDataType = 'SA' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_STRINGADR;
					Internal.ParElement[Internal.idx].GenVar.VarSTRING_ADR 	:= STRING_TO_UDINT(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_UDINT AND Internal.ParDataType = 'AD' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_ADR;
					Internal.ParElement[Internal.idx].GenVar.VarADR 			:= STRING_TO_UDINT(Internal.ParValue);
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_UDINT AND Internal.ParDataType = 'PR' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_PTR;
					Internal.ParElement[Internal.idx].GenVar.VarADR 			:= STRING_TO_UDINT(Internal.ParValue);//TODO: How to assign access a pointer instead of a value...
				ELSIF Internal.Datatype = SYSLIB_IEC_TYPE_DINT AND Internal.ParDataType = 'EN' THEN
					Internal.ParElement[Internal.idx].GenVar.Select 			:= TC_SEQ_PAR_SELECT_ENUMNAME;
					Internal.ParElement[Internal.idx].GenVar.VarENUM 			:= STRING_TO_DINT(Internal.ParValue);//TODO: Use gES? How to get the enum name to value...
					Internal.ParElement[Internal.idx].GenVar.VarENUM_STRING	:= Internal.ParValue;
				ELSE
					TC_Seq_JsonToElem.15 := TRUE;
					brsmemset(pElement,0,SIZEOF(Internal.Element));	
					RETURN;
				END_IF;
				Internal.idx := Internal.idx + 1;
			END_IF;
		END_FOR;

		FOR Internal.i := 0 TO MAX_JSON_PARSE_PAIR_IDX DO
			IF Internal.ParElement[Internal.i].GenVar.Select = TC_SEQ_PAR_SELECT_NULL THEN
				EXIT;
			ELSE
				Internal.Status := PV_xgetadr(ADR(Internal.ParElement[Internal.i].Name),ADR(Internal.PvAddress),ADR(Internal.PvLen));
				IF Internal.Status <> 0 THEN
					TC_Seq_JsonToElem.16 		:= TRUE;
					brsmemset(pElement,0,SIZEOF(Internal.Element));	
					RETURN;
				END_IF;
				CASE Internal.ParElement[Internal.i].GenVar.Select OF
					TC_SEQ_PAR_SELECT_BOOL:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarBOOL),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarBOOL));
					TC_SEQ_PAR_SELECT_INT:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarINT),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarINT));
					TC_SEQ_PAR_SELECT_USINT:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarUSINT),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarUSINT));
					TC_SEQ_PAR_SELECT_SINT:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarSINT),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarSINT));
					TC_SEQ_PAR_SELECT_UINT:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarUINT),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarUINT));
					TC_SEQ_PAR_SELECT_DINT:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarDINT),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarDINT));
					TC_SEQ_PAR_SELECT_UDINT:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarUDINT),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarUDINT));
					TC_SEQ_PAR_SELECT_REAL:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarREAL),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarREAL));
					TC_SEQ_PAR_SELECT_LREAL:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarLREAL),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarLREAL));
					TC_SEQ_PAR_SELECT_TIME:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarTIME),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarTIME));
					TC_SEQ_PAR_SELECT_DT:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarDT),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarDT));
					TC_SEQ_PAR_SELECT_ENUMNAME:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarENUM),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarENUM));
					TC_SEQ_PAR_SELECT_STRING:
						IF Internal.PvLen <= brsstrlen(ADR(Internal.ParElement[Internal.i].GenVar.VarSTRING)) THEN
							TC_Seq_JsonToElem.17 		:= TRUE;
							brsmemset(pElement,0,SIZEOF(Internal.Element));	
							RETURN;
						END_IF;
						brsmemset(Internal.PvAddress,0,Internal.PvLen);
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarSTRING),brsstrlen(ADR(Internal.ParElement[Internal.i].GenVar.VarSTRING)));
					TC_SEQ_PAR_SELECT_STRINGADR:
						IF Internal.PvLen <= brsstrlen(Internal.ParElement[Internal.i].GenVar.VarSTRING_ADR) THEN
							TC_Seq_JsonToElem.18 		:= TRUE;
							brsmemset(pElement,0,SIZEOF(Internal.Element));	
							RETURN;
						END_IF;
						brsmemset(Internal.PvAddress,0,Internal.PvLen);
						brsmemcpy(Internal.PvAddress,Internal.ParElement[Internal.i].GenVar.VarSTRING_ADR,brsstrlen(Internal.ParElement[Internal.i].GenVar.VarSTRING_ADR));
					TC_SEQ_PAR_SELECT_ADR:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarADR),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarADR));
					TC_SEQ_PAR_SELECT_PTR:
						brsmemcpy(Internal.PvAddress,ADR(Internal.ParElement[Internal.i].GenVar.VarADR),SIZEOF(Internal.ParElement[Internal.i].GenVar.VarADR));
				END_CASE;
			END_IF;
		END_FOR;
		brsmemcpy(Internal.CmdPvAddress,ADR(Internal.Enable),1);
		brsmemcpy(ADR(Internal.Element.Json),pJsonString,SIZEOF(Internal.Element.Json));
		brsmemcpy(pElement,ADR(Internal.Element),SIZEOF(Internal.Element));
	END_IF;
END_FUNCTION
