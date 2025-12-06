
ACTION Seq_FirstStart_X:

	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"M","ident":"ERROR","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"W","ident":"READYTOPOWERON","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"C","ident":"POWER","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"W","ident":"POWERON","time":"5.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"M","ident":"NOTPOWERON","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"C","ident":"HOME","enable":"TRUE","par":{"AB.Homing.Mode":"<SD>140"}}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"W","ident":"ISHOMED","time":"60.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"C","ident":"HOME","enable":"FALSE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"C","ident":"MOVEABSOLUTE","enable":"TRUE","par":{"AB.Position":"<LR>0.0","AB.Velocity":"<RR>20.0","AB.Acceleration":"<RR>1000.0","AB.Deceleration":"<RR>1000.0"}}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"W","ident":"MOVEDONE","time":"30.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RX_0_0","type":"C","ident":"MOVEABSOLUTE","enable":"FALSE"}'));

	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"VX_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"VX_0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"VX_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"VX_0","type":"M","ident":"ERROR","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"VX_0","type":"W","ident":"READYTOPOWERON","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"VX_0","type":"C","ident":"POWER","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"VX_0","type":"W","ident":"POWERON","time":"5.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"VX_0","type":"M","ident":"NOTPOWERON","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"VX_0","type":"C","ident":"HOME","enable":"TRUE","par":{"AB.Homing.Mode":"<SD>0","AB.Homing.Position":"<LR>0.0"}}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"VX_0","type":"W","ident":"ISHOMED","time":"5.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"VX_0","type":"C","ident":"HOME","enable":"FALSE"}'));

	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CS","inst":"RX_0_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CS","inst":"RX_0_0","type":"W","ident":"NOERROR","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CS","inst":"RX_0_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CS","inst":"RX_0_0","type":"M","ident":"ERROR","enable":"TRUE","sev":"4","time":"0.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CS","inst":"RX_0_0","type":"W","ident":"AXISREADY","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CS","inst":"RX_0_0","type":"C","ident":"MOVECYCLICPOSITION","enable":"TRUE","par":{"CyclicPositionSource":"<SD>0"}}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CS","inst":"RX_0_0","type":"W","ident":"MOVECYCLICPOSITIONACTIVE","time":"10.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"CS","inst":"RX_0_0","type":"M","ident":"NOTMOVECYCLICPOSITIONACTIVE","enable":"TRUE","sev":"4","time":"0.0"}'));

END_ACTION
