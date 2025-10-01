
(* Helper Function for Setting and Acknowledging Alarms with User Logger support. *)
FUNCTION TC_AlarmX_Helper
	TC_AlarmX_Helper 					:= -1;
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	Internal.ArEventLogGetIdent_0(Execute := FALSE);
	Internal.ArEventLogGetIdent_0(Execute := TRUE, Name := '$$arlogusr');
	Internal.AddText 					:= AlarmName;
	Internal.Active						:= NOT MpAlarmXCheckState(MpLink,AlarmName,mpALARMX_STATE_NONE);
	
	CASE AlarmAction OF
		TC_ALARMX_ACTION_NONE:
			TC_AlarmX_Helper 			:= 0;	
		TC_ALARMX_ACTION_SET:
			TC_AlarmX_Helper 			:= 0;
			IF NOT Internal.Active OR AllowMultiple THEN
				MpAlarmXSet(MpLink,AlarmName);
				brsmemset(ADR(Internal.AddText),0,SIZEOF(Internal.AddText));
				Internal.AddText 	:= AlarmName;
				TC_brsstrcat(ADR(Internal.AddText),ADR(' - Set'),SIZEOF(Internal.AddText));
				IF LogEventAddText <> '' THEN
					TC_brsstrcat(ADR(Internal.AddText),ADR(' - Info: '),SIZEOF(Internal.AddText));	
					TC_brsstrcat(ADR(Internal.AddText),ADR(LogEventAddText),SIZEOF(Internal.AddText));	
				END_IF;
				Internal.ArEventLogWrite_0(Execute := FALSE);
				Internal.ArEventLogWrite_0(Execute := TRUE, Ident := Internal.ArEventLogGetIdent_0.Ident, EventID := -536870912, OriginRecordID := 0, ObjectID := 'TC_AlarmX_Helper', AddDataSize := brsstrlen(ADR(Internal.AddText)), AddDataFormat := 1, AddData := ADR(Internal.AddText), TimeStamp := 0);
			END_IF;
		TC_ALARMX_ACTION_SET_NO_LOG:
			TC_AlarmX_Helper 			:= 0;
			IF NOT Internal.Active OR AllowMultiple THEN
				MpAlarmXSet(MpLink,AlarmName);
				brsmemset(ADR(Internal.AddText),0,SIZEOF(Internal.AddText));
			END_IF;
		TC_ALARMX_ACTION_ACK:
			TC_AlarmX_Helper 			:= 0;
			IF Internal.Active THEN
				MpAlarmXAcknowledge(MpLink,AlarmName);
				brsmemset(ADR(Internal.AddText),0,SIZEOF(Internal.AddText));
				Internal.AddText 	:= AlarmName;
				TC_brsstrcat(ADR(Internal.AddText),ADR(' - Ack'),SIZEOF(Internal.AddText));
				IF LogEventAddText <> '' THEN
					TC_brsstrcat(ADR(Internal.AddText),ADR(' - Info: '),SIZEOF(Internal.AddText));	
					TC_brsstrcat(ADR(Internal.AddText),ADR(LogEventAddText),SIZEOF(Internal.AddText));	
				END_IF;
				Internal.ArEventLogWrite_0(Execute := FALSE);
				Internal.ArEventLogWrite_0(Execute := TRUE, Ident := Internal.ArEventLogGetIdent_0.Ident, EventID := -536870912, OriginRecordID := 0, ObjectID := 'TC_AlarmX_Helper', AddDataSize := brsstrlen(ADR(Internal.AddText)), AddDataFormat := 1, AddData := ADR(Internal.AddText), TimeStamp := 0);
			END_IF;
		TC_ALARMX_ACTION_ACK_NO_LOG:
			TC_AlarmX_Helper 			:= 0;
			IF Internal.Active THEN
				MpAlarmXAcknowledge(MpLink,AlarmName);
			END_IF;
		TC_ALARMX_ACTION_LOG_ONLY:
			TC_AlarmX_Helper 			:= 0;
			brsmemset(ADR(Internal.AddText),0,SIZEOF(Internal.AddText));
			IF LogEventAddText <> '' THEN
				TC_brsstrcat(ADR(Internal.AddText),ADR('Info: '),SIZEOF(Internal.AddText));	
				TC_brsstrcat(ADR(Internal.AddText),ADR(LogEventAddText),SIZEOF(Internal.AddText));	
				Internal.ArEventLogWrite_0(Execute := FALSE);
				Internal.ArEventLogWrite_0(Execute := TRUE, Ident := Internal.ArEventLogGetIdent_0.Ident, EventID := -536870912, OriginRecordID := 0, ObjectID := 'TC_AlarmX_Helper', AddDataSize := brsstrlen(ADR(Internal.AddText)), AddDataFormat := 1, AddData := ADR(Internal.AddText), TimeStamp := 0);
			END_IF;
	END_CASE;
	
END_FUNCTION
