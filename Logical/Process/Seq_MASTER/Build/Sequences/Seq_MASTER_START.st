
ACTION Seq_MASTER_START:
	
	//TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VX_0","type":"M","ident":"ERRORRESET","enable":"TRUE","sev":"4","cmp":"1","dbon":"0.0","dboff":"0.0"}'));

	TC_Seq_Add(ADR(JSONStrings),ADR('{"type":"D","time":"5.0"}'));
    Seq_INIT_X;
    Seq_INIT_Y;
    Seq_INIT_Z;
    Seq_INIT_T;
    Seq_INIT_V;											  
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VX_0","type":"C","ident":"MOVEABSOLUTE","enable":"TRUE","par":{"AB.Position":"<LR>20.0","AB.Velocity":"<RR>10.0","AB.Acceleration":"<RR>50.0","AB.Deceleration":"<RR>50.0"}}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VX_0","type":"W","ident":"MOVEDONE","time":"30.0"}'));
	TC_Seq_Add(ADR(JSONStrings),ADR('{"driver":"AB","inst":"VX_0","type":"C","ident":"MOVEABSOLUTE","enable":"FALSE"}'));


//	FOR i := 0 TO MAX_DRIVER_AB_IDX DO
//		brsmemset(ADR(TempSTRING),0,SIZEOF(TempSTRING));
//		brsmemset(ADR(TempInst),0,SIZEOF(TempInst));
//		brsmemset(ADR(TempDriver),0,SIZEOF(TempDriver));
//		brsmemset(ADR(TempFind),0,SIZEOF(TempFind));
//		brsmemset(ADR(TempJson),0,SIZEOF(TempJson));
//		brsmemset(ADR(TempJsonStart),0,SIZEOF(TempJsonStart));
//		brsmemset(ADR(TempJsonEnd),0,SIZEOF(TempJsonEnd));
//		TC_brsstrcat(ADR(TempFind),ADR('DRIVER_INST_'),SIZEOF(TempFind));
//		TC_brsstrcat(ADR(TempDriver),ADR('AB'),SIZEOF(TempDriver));
//		TC_brsstrcat(ADR(TempFind),ADR(TempDriver),SIZEOF(TempFind));
//		TC_brsstrcat(ADR(TempFind),ADR('_'),SIZEOF(TempFind));
//		TempDINT := TC_Find_R(ADR(gES.DRIVER_INST_AB_ENUM[i]),ADR(TempFind));
//		IF TempDINT >= 0 THEN
//			TC_brsstrcat(ADR(TempInst),ADR(gES.DRIVER_INST_AB_ENUM[i])+DINT_TO_UDINT(TempDINT),SIZEOF(TempInst));
//		END_IF;
//		TC_brsstrcat(ADR(TempJsonStart),ADR('{"driver":"'),SIZEOF(TempJsonStart));
//		TC_brsstrcat(ADR(TempJsonStart),ADR(TempDriver),SIZEOF(TempJsonStart));
//		TC_brsstrcat(ADR(TempJsonStart),ADR('","inst":"'),SIZEOF(TempJsonStart));
//		TC_brsstrcat(ADR(TempJsonStart),ADR(TempInst),SIZEOF(TempJsonStart));
//		TC_brsstrcat(ADR(TempJsonStart),ADR('",'),SIZEOF(TempJsonStart));
//
//		TempJsonEnd := '"type":"C","ident":"ERRORRESET","enable":"TRUE"}';
//		brsmemset(ADR(TempJson),0,SIZEOF(TempJson));
//		TC_brsstrcat(ADR(TempJson),ADR(TempJsonStart),SIZEOF(TempJson));
//		TC_brsstrcat(ADR(TempJson),ADR(TempJsonEnd),SIZEOF(TempJson));
//		TC_Seq_Add(ADR(JSONStrings),ADR(TempJson));
//
//		TempJsonEnd := '"type":"W","ident":"NOERROR","time":"10.0"}';
//		brsmemset(ADR(TempJson),0,SIZEOF(TempJson));
//		TC_brsstrcat(ADR(TempJson),ADR(TempJsonStart),SIZEOF(TempJson));
//		TC_brsstrcat(ADR(TempJson),ADR(TempJsonEnd),SIZEOF(TempJson));
//		TC_Seq_Add(ADR(JSONStrings),ADR(TempJson));
//
//		TempJsonEnd := '"type":"C","ident":"ERRORRESET","enable":"FALSE"}';
//		brsmemset(ADR(TempJson),0,SIZEOF(TempJson));
//		TC_brsstrcat(ADR(TempJson),ADR(TempJsonStart),SIZEOF(TempJson));
//		TC_brsstrcat(ADR(TempJson),ADR(TempJsonEnd),SIZEOF(TempJson));
//		TC_Seq_Add(ADR(JSONStrings),ADR(TempJson));
//
//		TempJsonEnd := '"type":"C","ident":"ERRORRESET","enable":"TRUE"}';
//		brsmemset(ADR(TempJson),0,SIZEOF(TempJson));
//		TC_brsstrcat(ADR(TempJson),ADR(TempJsonStart),SIZEOF(TempJson));
//		TC_brsstrcat(ADR(TempJson),ADR(TempJsonEnd),SIZEOF(TempJson));
//		TC_Seq_Add(ADR(JSONStrings),ADR(TempJson));
//
//		TempJsonEnd := '"type":"C","ident":"ERRORRESET","enable":"TRUE"}';
//		brsmemset(ADR(TempJson),0,SIZEOF(TempJson));
//		TC_brsstrcat(ADR(TempJson),ADR(TempJsonStart),SIZEOF(TempJson));
//		TC_brsstrcat(ADR(TempJson),ADR(TempJsonEnd),SIZEOF(TempJson));
//		TC_Seq_Add(ADR(JSONStrings),ADR(TempJson));
//	END_FOR;
//
//		TempJsonEnd := '"type":"C","ident":"ERRORRESET","enable":"TRUE"}';
//		TempJsonEnd := '"type":"W","ident":"NOERROR","time":"10.0"}';
//		TempJsonEnd := '"type":"C","ident":"ERRORRESET","enable":"FALSE"}';
//		TempJsonEnd := '"type":"W","ident":"READYTOPOWERON","time":"10.0"}';
//		TempJsonEnd := '"type":"C","ident":"POWER","enable":"TRUE"}';
//		TempJsonEnd := '"type":"W","ident":"POWERON","time":"5.0"}';
//		TempJsonEnd := '"type":"C","ident":"HOME","enable":"TRUE"}';
//		TempJsonEnd := '"type":"W","ident":"ISHOMED","time":"5.0"}';
//		TempJsonEnd := '"type":"C","ident":"HOME","enable":"FALSE"}';

END_ACTION
