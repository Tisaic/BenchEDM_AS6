
ACTION Seq_FirstStart_MR:

	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"MR","inst":"0","type":"C","ident":"MBMOPEN","enable":"TRUE","par":{"Device":"<ST>SL2.IF1.ST1.IF1.ST5.IF1","Mode":"<ST>/PHY=RS485 /PA=E /DB=8 /SB=1 /BD=38400","DataObject":"<ST>MbRTU","IsAscii":"<BO>FALSE","Timeout":"<LR>0.25"}}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"MR","inst":"0","type":"W","ident":"MBMOPEN","time":"5.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"MR","inst":"0","type":"C","ident":"MBMOPEN","enable":"FALSE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"MR","inst":"0","type":"C","ident":"MBMASTER","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"MR","inst":"0","type":"W","ident":"MBMASTER","time":"5.0"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"MR","inst":"0","type":"M","ident":"ERROR","enable":"TRUE","sev":"4","time":"0.0"}'));

	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"type":"D","time":"0.5"}'));

	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"type":"D","time":"0.1"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_0_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));

	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"C","ident":"ERRORRESET","enable":"TRUE"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"type":"D","time":"0.1"}'));
	TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"driver":"AB","inst":"RP_1_0","type":"C","ident":"ERRORRESET","enable":"FALSE"}'));
END_ACTION
