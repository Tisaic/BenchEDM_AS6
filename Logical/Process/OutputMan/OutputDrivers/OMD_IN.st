
ACTION OMD_IN:

//	FOR i := 0 TO MAX_DRIVER_IN_IDX DO
//		IF NOT gDriver.IN[i].FirstScanComplete THEN
//			gDriver.IN[i].FirstScanComplete 													:= TRUE;
//
//			gDriver.IN[i].DefaultPar.DI_Estop_Par.FilterOnTime									:= 50.0;							//LR
//			gDriver.IN[i].DefaultPar.DI_Estop_Par.FilterOffTime									:= 50.0;							//LR
//			gDriver.IN[i].DefaultPar.DI_Estop_Par.InvertedIOMapping								:= FALSE;							//BO
//			gDriver.IN[i].DefaultPar.DI_Estop_Forcing.On										:= FALSE;							//BO
//			gDriver.IN[i].DefaultPar.DI_Estop_Forcing.Off										:= FALSE;							//BO
//			gDriver.IN[i].DefaultPar.DI_Estop_Sim.Active										:= gSim.Full OR gSim.IO;			//BO
//			gDriver.IN[i].DefaultPar.DI_Estop_Sim.Logical										:= FALSE;							//BO
//
//			brsmemcpy(ADR(gDriver.IN[i].Par),ADR(gDriver.IN[i].DefaultPar),SIZEOF(gDriver.IN[i].Par));
//		END_IF;
//
//		brsmemset(ADR(gDriver.IN[i].Sev),0,SIZEOF(gDriver.IN[i].Sev));
//		brsmemset(ADR(gDriver.IN[i].Status),0,SIZEOF(gDriver.IN[i].Status));
//		FOR j := 0 TO MAX_DRIVER_IN_MON_IDX DO
//			IF gDriver.IN[i].Par.Mon[j].Enable THEN
//				IF gDriver.IN[i].Mon[j] THEN
//					gDriver.IN[i].CTON_Mon[j](IN := TRUE, PT := LREAL_TO_TIME(gDriver.IN[i].Par.Mon[j].Time*1000.0));
//					IF gDriver.IN[i].CTON_Mon[j].Q THEN
//						gDriver.IN[i].Sev[j] := gDriver.IN[i].Par.Mon[j].Sev;
//						IF gDriver.IN[i].Status.Severity < gDriver.IN[i].Sev[j] THEN
//							gDriver.IN[i].Status.Severity := gDriver.IN[i].Sev[j];
//						END_IF;
//					END_IF;
//				ELSE
//					gDriver.IN[i].CTON_Mon[j](IN := FALSE);
//					gDriver.IN[i].Sev[j] := 0;
//				END_IF;
//			ELSE
//				gDriver.IN[i].CTON_Mon[j](IN := FALSE);
//				gDriver.IN[i].Sev[j] := 0;
//			END_IF;
//		END_FOR;
//		IF gDriver.IN[i].Cmd[C_IN_RESET] THEN
//			gDriver.IN[i].Cmd[C_IN_RESET] := FALSE;
//			brsmemset(ADR(gDriver.IN[i].Cmd),0,SIZEOF(gDriver.IN[i].Cmd));
//			brsmemset(ADR(gDriver.IN[i].Sev),0,SIZEOF(gDriver.IN[i].Sev));
//			brsmemset(ADR(gDriver.IN[i].Status),0,SIZEOF(gDriver.IN[i].Status));
//			brsmemcpy(ADR(gDriver.IN[i].Par),ADR(gDriver.IN[i].DefaultPar),SIZEOF(gDriver.IN[i].Par));
//		END_IF;
//		IF gDriver.IN[i].Cmd[C_IN_CLEARCMD] THEN
//			gDriver.IN[i].Cmd[C_IN_CLEARCMD] := FALSE;
//			brsmemset(ADR(gDriver.IN[i].Cmd),0,SIZEOF(gDriver.IN[i].Cmd));
//		END_IF;
//		IF gDriver.IN[i].Cmd[C_IN_CLEARMON] THEN
//			gDriver.IN[i].Cmd[C_IN_CLEARMON] := FALSE;
//			brsmemset(ADR(gDriver.IN[i].Status.Severity),0,SIZEOF(gDriver.IN[i].Status.Severity));
//			brsmemset(ADR(gDriver.IN[i].Sev),0,SIZEOF(gDriver.IN[i].Sev));
//			brsmemset(ADR(gDriver.IN[i].Par.Mon),0,SIZEOF(gDriver.IN[i].Par.Mon));
//		END_IF;
//		IF gDriver.IN[i].Cmd[C_IN_DEFAULTMON] THEN
//			gDriver.IN[i].Cmd[C_IN_DEFAULTMON] := FALSE;
//			brsmemcpy(ADR(gDriver.IN[i].Par.Mon),ADR(gDriver.IN[i].DefaultPar.Mon),SIZEOF(gDriver.IN[i].Par.Mon));
//		END_IF;
//		IF gDriver.IN[i].Cmd[C_IN_CLEARPAR] THEN
//			gDriver.IN[i].Cmd[C_IN_CLEARPAR] := FALSE;
//			brsmemset(ADR(gDriver.IN[i].Par),0,SIZEOF(gDriver.IN[i].Par));
//		END_IF;
//		IF gDriver.IN[i].Cmd[C_IN_DEFAULTPAR] THEN
//			gDriver.IN[i].Cmd[C_IN_DEFAULTPAR] := FALSE;
//			brsmemcpy(ADR(gDriver.IN[i].Par),ADR(gDriver.IN[i].DefaultPar),SIZEOF(gDriver.IN[i].Par));
//		END_IF;
//		IF gDriver.IN[i].Cmd[C_IN_FORCEENABLE] THEN
//			gDriver.IN[i].Cmd[C_IN_FORCEENABLE] := FALSE;
//			gDriver.IN[i].Par.ForceEnable := TRUE;
//		END_IF;
//		IF gDriver.IN[i].Cmd[C_IN_FORCEDISABLE] THEN
//			gDriver.IN[i].Cmd[C_IN_FORCEDISABLE] := FALSE;
//			gDriver.IN[i].Par.ForceEnable := FALSE;
//		END_IF;
//
//		IF NOT gDriver.IN[i].Par.ForceEnable OR (gDriver.IN[i].Par.DI_Estop_Forcing.On AND gDriver.IN[i].Par.DI_Estop_Forcing.Off) THEN
//			gDriver.IN[i].Par.DI_Estop_Forcing.On := FALSE;
//			gDriver.IN[i].Par.DI_Estop_Forcing.Off := FALSE;
//		END_IF;
//		gDriver.IN[i].DI_Estop(Forcing := gDriver.IN[i].Par.DI_Estop_Forcing, Par := gDriver.IN[i].Par.DI_Estop_Par, Sim := gDriver.IN[i].Par.DI_Estop_Sim);
//							
//		gDriver.IN[i].Wait[W_IN_DI_ESTOP]				:= BOOL_TO_DINT(NOT gDriver.IN[i].DI_Estop.Signal.Filtered);
//
//		gDriver.IN[i].Mon[M_IN_ERROR]					:= gDriver.IN[i].MpAxisBasic_0.Error;
//	END_FOR;
//
////	McSwitchEnum :		
////	(		
////		mcSWITCH_OFF := 0,		 						(*State/Behavior selection switched off*)
////		mcSWITCH_ON := 1			 					(*State/Behavior selection switched on*)
////	);		

END_ACTION
