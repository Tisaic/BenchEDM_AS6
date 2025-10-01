
ACTION Seq_INIT_V:

	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VV_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VV_0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VV_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VV_0","type":"W","ident":"READYTOPOWERON","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VV_0","type":"C","ident":"POWER","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VV_0","type":"W","ident":"POWERON","time":"5.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VV_0","type":"C","ident":"HOME","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VV_0","type":"W","ident":"ISHOMED","time":"5.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VV_0","type":"C","ident":"HOME","enable":"FALSE"}'));
																  
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RV0_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RV0_0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RV0_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RV0_0","type":"W","ident":"READYTOPOWERON","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RV0_0","type":"C","ident":"POWER","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RV0_0","type":"W","ident":"POWERON","time":"5.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RV0_0","type":"C","ident":"HOME","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RV0_0","type":"W","ident":"ISHOMED","time":"5.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"RV0_0","type":"C","ident":"HOME","enable":"FALSE"}'));
																  
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RV0_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RV0_0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RV0_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RV0_0","type":"W","ident":"AXISREADY","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RV0_0","type":"C","ident":"MOVECYCLICPOSITION","enable":"TRUE","par":{"CyclicPositionSource":"<SD>0"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"RV0_0","type":"W","ident":"MOVECYCLICPOSITIONACTIVE","time":"10.0"}'));

END_ACTION
