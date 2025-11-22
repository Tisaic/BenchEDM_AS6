
ACTION Seq_INIT_Q3:

	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VQ3_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VQ3_0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VQ3_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VQ3_0","type":"M","ident":"ERROR","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VQ3_0","type":"W","ident":"READYTOPOWERON","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VQ3_0","type":"C","ident":"POWER","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VQ3_0","type":"W","ident":"POWERON","time":"5.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VQ3_0","type":"M","ident":"NOTPOWERON","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VQ3_0","type":"C","ident":"HOME","enable":"TRUE","par":{"AB.Homing.Position":"<LR>50.0"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VQ3_0","type":"W","ident":"ISHOMED","time":"5.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VQ3_0","type":"C","ident":"HOME","enable":"FALSE"}'));
																  
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RQ3_0_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RQ3_0_0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RQ3_0_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RQ3_0_0","type":"M","ident":"ERROR","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RQ3_0_0","type":"W","ident":"READYTOPOWERON","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RQ3_0_0","type":"C","ident":"POWER","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RQ3_0_0","type":"W","ident":"POWERON","time":"5.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RQ3_0_0","type":"M","ident":"NOTPOWERON","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RQ3_0_0","type":"C","ident":"HOME","enable":"TRUE","par":{"AB.Homing.Position":"<LR>50.0"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RQ3_0_0","type":"W","ident":"ISHOMED","time":"5.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RQ3_0_0","type":"C","ident":"HOME","enable":"FALSE"}'));
																  
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RQ3_0_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RQ3_0_0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RQ3_0_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RQ3_0_0","type":"M","ident":"ERROR","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RQ3_0_0","type":"W","ident":"AXISREADY","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RQ3_0_0","type":"C","ident":"MOVECYCLICPOSITION","enable":"TRUE","par":{"CyclicPositionSource":"<SD>0"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RQ3_0_0","type":"W","ident":"MOVECYCLICPOSITIONACTIVE","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RQ3_0_0","type":"M","ident":"NOTMOVECYCLICPOSITIONACTIVE","enable":"TRUE","sev":"4","time":"0.0"}'));

END_ACTION
