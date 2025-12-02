
ACTION Seq_MASTER_START:

	gDriver.ResetAll := TRUE;
	brsmemcpy(ADR(JSONStrings),ADR(gScripts.FirstStart),SIZEOF(JSONStrings));

	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"C","ident":"MOVEPROGRAM","enable":"TRUE","par":{"CN.ProgramName":"<ST>GCODE/p.cnc"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"W","ident":"MOVEACTIVE","time":"5.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"W","ident":"MOVEDONE","time":"1000000.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"C","ident":"MOVEPROGRAM","enable":"FALSE"}'));

	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"DO","inst":"0","type":"C","ident":"ENABLE","enable":"FALSE"}'));
END_ACTION
