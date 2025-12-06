
ACTION Seq_MASTER_START:

	IF Initialized THEN
		TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"type":"D","time":"5.0"}'));
		TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"BX","inst":"0","type":"C","ident":"ENABLE","enable":"TRUE"}'));
		TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"BX","inst":"0","type":"W","ident":"ACTIVE","time":"5.0"}'));

		TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"C","ident":"MOVEPROGRAM","enable":"TRUE","par":{"CN.ProgramName":"<ST>GCODE/p.cnc","OverrideSource":"<SD>1"}}'));
		TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"W","ident":"MOVEACTIVE","time":"5.0"}'));
		TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"W","ident":"MOVEDONE","time":"1000000.0"}'));
		TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"C","ident":"MOVEPROGRAM","enable":"FALSE","par":{"OverrideSource":"<SD>0"}}'));

		TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"BX","inst":"0","type":"C","ident":"ENABLE","enable":"FALSE"}'));
	ELSE
		gDriver.ResetAll := TRUE;
		brsmemcpy(ADR(JSONStrings),ADR(gScripts.FirstStart),SIZEOF(JSONStrings));
		Initialized := TRUE;
	END_IF;

END_ACTION
