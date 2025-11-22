
ACTION Seq_MASTER_START:

	gDriver.ResetAll := TRUE;
	TC_Seq_Add(ADR(JSONStrings),ADR('{"type":"D","time":"0.01"}'));
//    Seq_INIT_Q1;
//    Seq_INIT_Q2;
//    Seq_INIT_Q3;
//    Seq_INIT_Q4;
//    Seq_INIT_Q5;
//    Seq_INIT_Q6;
//    Seq_INIT_CNC;
//    Seq_ENABLE_TR;

	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"MR","inst":"0","type":"C","ident":"MBMOPEN","enable":"TRUE","par":{"Device":"<ST>SL2.IF1.ST1.IF1.ST5.IF1","Mode":"<ST>/PHY=RS485 /PA=E /DB=8 /SB=1 /BD=38400","DataObject":"<ST>MbRTU","IsAscii":"<BO>FALSE","Timeout":"<LR>0.25"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"MR","inst":"0","type":"W","ident":"MBMOPEN","time":"50000.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"MR","inst":"0","type":"C","ident":"MBMOPEN","enable":"FALSE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"MR","inst":"0","type":"C","ident":"MBMASTER","enable":"TRUE"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"MR","inst":"0","type":"W","ident":"MBMASTER","time":"50000.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"MR","inst":"0","type":"M","ident":"ERROR","enable":"TRUE","sev":"4","time":"0.0"}'));

//	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"C","ident":"MOVEPROGRAM","enable":"TRUE","par":{"CN.ProgramName":"<ST>GCODE/p.cnc"}}'));
//	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"W","ident":"MOVEACTIVE","time":"5.0"}'));
//	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"W","ident":"MOVEDONE","time":"1000000.0"}'));
//	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"C","ident":"MOVEPROGRAM","enable":"FALSE"}'));
//	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VX_0","type":"C","ident":"MOVEABSOLUTE","enable":"TRUE","par":{"AB.Position":"<LR>20.0","AB.Velocity":"<RR>10.0","AB.Acceleration":"<RR>50.0","AB.Deceleration":"<RR>50.0"}}'));
//	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VX_0","type":"W","ident":"MOVEDONE","time":"30.0"}'));
//	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VX_0","type":"C","ident":"MOVEABSOLUTE","enable":"FALSE"}'));


END_ACTION
