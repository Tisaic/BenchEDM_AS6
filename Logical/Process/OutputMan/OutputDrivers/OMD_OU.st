
ACTION OMD_OU:

//	FOR i := 0 TO MAX_DRIVER_OU_IDX DO
//		IF NOT gDriver.OU[i].FirstScanComplete THEN
//			gDriver.OU[i].FirstScanComplete 													:= TRUE;
//			gDriver.OU[i].DefaultPar.OU.Acceleration											:= 50.0;							//RR
//			
//			brsmemcpy(ADR(gDriver.OU[i].Par),ADR(gDriver.OU[i].DefaultPar),SIZEOF(gDriver.OU[i].Par));
//		END_IF;
//
//		brsmemset(ADR(gDriver.OU[i].Sev),0,SIZEOF(gDriver.OU[i].Sev));
//		brsmemset(ADR(gDriver.OU[i].Status),0,SIZEOF(gDriver.OU[i].Status));
//		FOR j := 0 TO MAX_DRIVER_OU_MON_IDX DO
//			IF gDriver.OU[i].Par.Mon[j].Enable THEN
//				IF gDriver.OU[i].Mon[j] THEN
//					gDriver.OU[i].CTON_Mon[j](IN := TRUE, PT := LREAL_TO_TIME(gDriver.OU[i].Par.Mon[j].Time*1000.0));
//					IF gDriver.OU[i].CTON_Mon[j].Q THEN
//						gDriver.OU[i].Sev[j] := gDriver.OU[i].Par.Mon[j].Sev;
//						IF gDriver.OU[i].Status.Severity < gDriver.OU[i].Sev[j] THEN
//							gDriver.OU[i].Status.Severity := gDriver.OU[i].Sev[j];
//						END_IF;
//					END_IF;
//				ELSE
//					gDriver.OU[i].CTON_Mon[j](IN := FALSE);
//					gDriver.OU[i].Sev[j] := 0;
//				END_IF;
//			ELSE
//				gDriver.OU[i].CTON_Mon[j](IN := FALSE);
//				gDriver.OU[i].Sev[j] := 0;
//			END_IF;
//		END_FOR;
//		IF gDriver.OU[i].Cmd[C_OU_RESET] THEN
//			gDriver.OU[i].Cmd[C_OU_RESET] := FALSE;
//			brsmemset(ADR(gDriver.OU[i].Cmd),0,SIZEOF(gDriver.OU[i].Cmd));
//			brsmemset(ADR(gDriver.OU[i].Sev),0,SIZEOF(gDriver.OU[i].Sev));
//			brsmemset(ADR(gDriver.OU[i].Status),0,SIZEOF(gDriver.OU[i].Status));
//			brsmemcpy(ADR(gDriver.OU[i].Par),ADR(gDriver.OU[i].DefaultPar),SIZEOF(gDriver.OU[i].Par));
//		END_IF;
//		IF gDriver.OU[i].Cmd[C_OU_CLEARCMD] THEN
//			gDriver.OU[i].Cmd[C_OU_CLEARCMD] := FALSE;
//			brsmemset(ADR(gDriver.OU[i].Cmd),0,SIZEOF(gDriver.OU[i].Cmd));
//		END_IF;
//		IF gDriver.OU[i].Cmd[C_OU_CLEARMON] THEN
//			gDriver.OU[i].Cmd[C_OU_CLEARMON] := FALSE;
//			brsmemset(ADR(gDriver.OU[i].Status.Severity),0,SIZEOF(gDriver.OU[i].Status.Severity));
//			brsmemset(ADR(gDriver.OU[i].Sev),0,SIZEOF(gDriver.OU[i].Sev));
//			brsmemset(ADR(gDriver.OU[i].Par.Mon),0,SIZEOF(gDriver.OU[i].Par.Mon));
//		END_IF;
//		IF gDriver.OU[i].Cmd[C_OU_DEFAULTMON] THEN
//			gDriver.OU[i].Cmd[C_OU_DEFAULTMON] := FALSE;
//			brsmemcpy(ADR(gDriver.OU[i].Par.Mon),ADR(gDriver.OU[i].DefaultPar.Mon),SIZEOF(gDriver.OU[i].Par.Mon));
//		END_IF;
//		IF gDriver.OU[i].Cmd[C_OU_CLEARPAR] THEN
//			gDriver.OU[i].Cmd[C_OU_CLEARPAR] := FALSE;
//			brsmemset(ADR(gDriver.OU[i].Par),0,SIZEOF(gDriver.OU[i].Par));
//		END_IF;
//		IF gDriver.OU[i].Cmd[C_OU_DEFAULTPAR] THEN
//			gDriver.OU[i].Cmd[C_OU_DEFAULTPAR] := FALSE;
//			brsmemcpy(ADR(gDriver.OU[i].Par),ADR(gDriver.OU[i].DefaultPar),SIZEOF(gDriver.OU[i].Par));
//		END_IF;
//		gDriver.OU[i].			:= gDriver.OU[i].Cmd[C_OU_ERRORRESET] OR gMain.ErrorReset;
//							
//		gDriver.OU[i].Wait[W_OU_NOERROR]				:= BOOL_TO_DOUT(NOT gDriver.OU[i].);
//
//		gDriver.OU[i].Mon[M_OU_ERROR]					:= gDriver.OU[i].MpAxisBasic_0.Error;
//	END_FOR;
//
////	McSwitchEnum :		
////	(		
////		mcSWITCH_OFF := 0,		 						(*State/Behavior selection switched off*)
////		mcSWITCH_ON := 1			 					(*State/Behavior selection switched on*)
////	);		

END_ACTION
