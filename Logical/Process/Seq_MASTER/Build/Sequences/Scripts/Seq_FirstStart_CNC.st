
ACTION Seq_FirstStart_CNC:

	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CN","inst":"0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CN","inst":"0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CN","inst":"0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CN","inst":"0","type":"M","ident":"ERROR","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CN","inst":"0","type":"W","ident":"READYTOPOWERON","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CN","inst":"0","type":"C","ident":"POWER","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CN","inst":"0","type":"W","ident":"POWERON","time":"5.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CN","inst":"0","type":"M","ident":"NOTPOWERON","enable":"TRUE","sev":"4","time":"0.0"}'));

END_ACTION
