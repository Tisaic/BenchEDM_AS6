
ACTION Seq_MASTER_START:
	
	TC_Seq_Add(ADR(JSONStrings),ADR('{"type":"D","time":"0.01"}'));
    Seq_INIT_X;
    Seq_INIT_Y;
    Seq_INIT_Z;
    Seq_INIT_T;
    Seq_INIT_V;
    Seq_INIT_CNC;
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"C","ident":"MOVEPROGRAM","enable":"TRUE","par":{"CN.ProgramName":"<ST>GCODE/p.cnc"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"W","ident":"MOVEACTIVE","time":"5.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"W","ident":"MOVEDONE","time":"1000000.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"CN","inst":"0","type":"C","ident":"MOVEPROGRAM","enable":"FALSE"}'));
//	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VX_0","type":"C","ident":"MOVEABSOLUTE","enable":"TRUE","par":{"AB.Position":"<LR>20.0","AB.Velocity":"<RR>10.0","AB.Acceleration":"<RR>50.0","AB.Deceleration":"<RR>50.0"}}'));
//	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VX_0","type":"W","ident":"MOVEDONE","time":"30.0"}'));
//	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VX_0","type":"C","ident":"MOVEABSOLUTE","enable":"FALSE"}'));


END_ACTION
