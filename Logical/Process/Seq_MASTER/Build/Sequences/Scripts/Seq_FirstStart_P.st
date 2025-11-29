
ACTION Seq_FirstStart_P:

	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"type":"D","time":"0.1"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"type":"D","time":"0.1"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"M","ident":"ERROR","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"W","ident":"READYTOPOWERON","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"C","ident":"POWER","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"W","ident":"POWERON","time":"5.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"M","ident":"NOTPOWERON","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"C","ident":"HOME","enable":"TRUE","par":{"AB.Homing.Mode":"<SD>140"}}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"W","ident":"ISHOMED","time":"5.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"C","ident":"HOME","enable":"FALSE"}'));

	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"type":"D","time":"0.1"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"type":"D","time":"0.1"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"M","ident":"ERROR","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"W","ident":"READYTOPOWERON","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"C","ident":"POWER","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"W","ident":"POWERON","time":"5.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"M","ident":"NOTPOWERON","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"C","ident":"HOME","enable":"TRUE","par":{"AB.Homing.Mode":"<SD>140"}}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"W","ident":"ISHOMED","time":"5.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"C","ident":"HOME","enable":"FALSE"}'));

END_ACTION
