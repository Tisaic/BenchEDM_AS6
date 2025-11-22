
ACTION Seq_ENABLE_TR:

	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ1_0","type":"C","ident":"MOVECYCLICPOSITION","enable":"TRUE","par":{"CyclicPositionSource":"<SD>0"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ1_0","type":"W","ident":"MOVECYCLICPOSITIONACTIVE","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ1_0","type":"M","ident":"NOTMOVECYCLICPOSITIONACTIVE","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ2_0","type":"C","ident":"MOVECYCLICPOSITION","enable":"TRUE","par":{"CyclicPositionSource":"<SD>0"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ2_0","type":"W","ident":"MOVECYCLICPOSITIONACTIVE","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ2_0","type":"M","ident":"NOTMOVECYCLICPOSITIONACTIVE","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ3_0","type":"C","ident":"MOVECYCLICPOSITION","enable":"TRUE","par":{"CyclicPositionSource":"<SD>0"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ3_0","type":"W","ident":"MOVECYCLICPOSITIONACTIVE","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ3_0","type":"M","ident":"NOTMOVECYCLICPOSITIONACTIVE","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ4_0","type":"C","ident":"MOVECYCLICPOSITION","enable":"TRUE","par":{"CyclicPositionSource":"<SD>0"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ4_0","type":"W","ident":"MOVECYCLICPOSITIONACTIVE","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ4_0","type":"M","ident":"NOTMOVECYCLICPOSITIONACTIVE","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ5_0","type":"C","ident":"MOVECYCLICPOSITION","enable":"TRUE","par":{"CyclicPositionSource":"<SD>0"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ5_0","type":"W","ident":"MOVECYCLICPOSITIONACTIVE","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ5_0","type":"M","ident":"NOTMOVECYCLICPOSITIONACTIVE","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ6_0","type":"C","ident":"MOVECYCLICPOSITION","enable":"TRUE","par":{"CyclicPositionSource":"<SD>0"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ6_0","type":"W","ident":"MOVECYCLICPOSITIONACTIVE","time":"10.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CS","inst":"VQ6_0","type":"M","ident":"NOTMOVECYCLICPOSITIONACTIVE","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"TR","inst":"0","type":"C","ident":"ENABLE","enable":"TRUE"}'));

END_ACTION
