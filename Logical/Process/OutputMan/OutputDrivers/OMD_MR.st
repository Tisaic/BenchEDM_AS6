
ACTION OMD_MR:

	FOR i := 0 TO MAX_DRIVER_MR_IDX DO
		IF NOT gDriver.MR[i].FirstScanComplete THEN
			gDriver.MR[i].FirstScanComplete 			:= TRUE;
			gDriver.MR[i].DefaultPar.Device				:= 'SL2.IF1.ST1.IF1.ST5.IF1';					//ST
			gDriver.MR[i].DefaultPar.Mode				:= '/PHY=RS485 /PA=E /DB=8 /SB=1 /BD=38400';	//ST
			gDriver.MR[i].DefaultPar.DataObject			:= 'MbRTU';										//ST
			gDriver.MR[i].DefaultPar.IsAscii			:= FALSE;										//BO
			gDriver.MR[i].DefaultPar.Timeout			:= 1.0;											//LR
			gDriver.MR[i].DefaultPar.CmdNode			:= 1;											//UD
			gDriver.MR[i].DefaultPar.CmdFunctionCall	:= 1;											//UD
			gDriver.MR[i].DefaultPar.CmdOffset			:= 1;											//UD
			gDriver.MR[i].DefaultPar.CmdData			:= 0;											//UD
			brsmemcpy(ADR(gDriver.MR[i].Par),ADR(gDriver.MR[i].DefaultPar),SIZEOF(gDriver.MR[i].Par));
		ELSIF NOT gDriver.MR[i].ParametersLoaded AND gMain.Services.Recipes.Out.ParametersReady THEN
			gDriver.MR[i].ParametersLoaded := TRUE;
			brsmemcpy(ADR(gDriver.MR[i].Par),ADR(gPar.Driver.MR[i]),SIZEOF(gDriver.MR[i].Par));
		END_IF;

		brsmemset(ADR(gDriver.MR[i].Sev),0,SIZEOF(gDriver.MR[i].Sev));
		brsmemset(ADR(gDriver.MR[i].Status),0,SIZEOF(gDriver.MR[i].Status));
		FOR j := 0 TO MAX_DRIVER_MR_MON_IDX DO
			IF gDriver.MR[i].Par.Mon[j].Enable THEN
				IF gDriver.MR[i].Mon[j] THEN
					gDriver.MR[i].CTON_Mon[j](IN := TRUE, PT := LREAL_TO_TIME(gDriver.MR[i].Par.Mon[j].Time*1000.0));
					IF gDriver.MR[i].CTON_Mon[j].Q THEN
						gDriver.MR[i].Sev[j] := gDriver.MR[i].Par.Mon[j].Sev;
						IF gDriver.MR[i].Status.Severity < gDriver.MR[i].Sev[j] THEN
							gDriver.MR[i].Status.Severity := gDriver.MR[i].Sev[j];
						END_IF;
					END_IF;
				ELSE
					gDriver.MR[i].CTON_Mon[j](IN := FALSE);
					gDriver.MR[i].Sev[j] := 0;
				END_IF;
			ELSE
				gDriver.MR[i].CTON_Mon[j](IN := FALSE);
				gDriver.MR[i].Sev[j] := 0;
			END_IF;
		END_FOR;
		IF gDriver.MR[i].Cmd[C_MR_RESET] OR gDriver.ResetAll THEN
			gDriver.MR[i].Cmd[C_MR_RESET] := FALSE;
			brsmemset(ADR(gDriver.MR[i].Mon),0,SIZEOF(gDriver.MR[i].Mon));
			brsmemset(ADR(gDriver.MR[i].Cmd),0,SIZEOF(gDriver.MR[i].Cmd));
			brsmemset(ADR(gDriver.MR[i].Sev),0,SIZEOF(gDriver.MR[i].Sev));
			brsmemset(ADR(gDriver.MR[i].Status),0,SIZEOF(gDriver.MR[i].Status));
		END_IF;
		IF gDriver.MR[i].Cmd[C_MR_CLEARCMD] THEN
			gDriver.MR[i].Cmd[C_MR_CLEARCMD] := FALSE;
			brsmemset(ADR(gDriver.MR[i].Cmd),0,SIZEOF(gDriver.MR[i].Cmd));
		END_IF;
		IF gDriver.MR[i].Cmd[C_MR_CLEARMON] THEN
			gDriver.MR[i].Cmd[C_MR_CLEARMON] := FALSE;
			brsmemset(ADR(gDriver.MR[i].Status.Severity),0,SIZEOF(gDriver.MR[i].Status.Severity));
			brsmemset(ADR(gDriver.MR[i].Sev),0,SIZEOF(gDriver.MR[i].Sev));
			brsmemset(ADR(gDriver.MR[i].Par.Mon),0,SIZEOF(gDriver.MR[i].Par.Mon));
		END_IF;
		IF gDriver.MR[i].Cmd[C_MR_DEFAULTMON] THEN
			gDriver.MR[i].Cmd[C_MR_DEFAULTMON] := FALSE;
			brsmemcpy(ADR(gDriver.MR[i].Par.Mon),ADR(gDriver.MR[i].DefaultPar.Mon),SIZEOF(gDriver.MR[i].Par.Mon));
		END_IF;
		IF gDriver.MR[i].Cmd[C_MR_CLEARPAR] THEN
			gDriver.MR[i].Cmd[C_MR_CLEARPAR] := FALSE;
			brsmemset(ADR(gDriver.MR[i].Par),0,SIZEOF(gDriver.MR[i].Par));
		END_IF;
		IF gDriver.MR[i].Cmd[C_MR_DEFAULTPAR] THEN
			gDriver.MR[i].Cmd[C_MR_DEFAULTPAR] := FALSE;
			brsmemcpy(ADR(gDriver.MR[i].Par),ADR(gDriver.MR[i].DefaultPar),SIZEOF(gDriver.MR[i].Par));
		END_IF;
		IF gDriver.MR[i].Cmd[C_MR_SAVEPAR] THEN
			gDriver.MR[i].Cmd[C_MR_SAVEPAR] := FALSE;
			brsmemcpy(ADR(gPar.Driver.MR[i]),ADR(gDriver.MR[i].Par),SIZEOF(gDriver.MR[i].Par));
		END_IF;
		IF gDriver.MR[i].Cmd[C_MR_LOADPAR] THEN
			gDriver.MR[i].Cmd[C_MR_LOADPAR] := FALSE;
			brsmemcpy(ADR(gDriver.MR[i].Par),ADR(gPar.Driver.MR[i]),SIZEOF(gDriver.MR[i].Par));
		END_IF;

		gDriver.MR[i].MBMOpen_0.enable					:= gDriver.MR[i].Cmd[C_MR_MBMOPEN] AND NOT (gDriver.MR[i].Cmd[C_MR_ERRORRESET] OR gMain.ErrorReset);
		gDriver.MR[i].MBMaster_0.enable					:= gDriver.MR[i].Cmd[C_MR_MBMASTER] AND NOT (gDriver.MR[i].Cmd[C_MR_ERRORRESET] OR gMain.ErrorReset);
		gDriver.MR[i].MBMCmd_0.enable					:= gDriver.MR[i].Cmd[C_MR_MBMCMD] AND NOT (gDriver.MR[i].Cmd[C_MR_ERRORRESET] OR gMain.ErrorReset);
		gDriver.MR[i].MBMClose_0.enable					:= gDriver.MR[i].Cmd[C_MR_MBMCLOSE] AND NOT (gDriver.MR[i].Cmd[C_MR_ERRORRESET] OR gMain.ErrorReset);	

		gDriver.MR[i].MBMOpen_0(pDevice := ADR(gDriver.MR[i].Par.Device), pMode := ADR(gDriver.MR[i].Par.Mode), pConfig := ADR(gDriver.MR[i].Par.DataObject), timeout := LREAL_TO_UINT(gDriver.MR[i].Par.Timeout*1000.0), ascii := BOOL_TO_USINT(gDriver.MR[i].Par.IsAscii));
		IF gDriver.MR[i].MBMOpen_0.ident <> 0 AND gDriver.MR[i].MBMOpen_0.enable THEN
			gDriver.MR[i].Ident := gDriver.MR[i].MBMOpen_0.ident;
		END_IF;
		gDriver.MR[i].MBMCmd_0(ident := gDriver.MR[i].Ident, mfc := UDINT_TO_USINT(gDriver.MR[i].Par.CmdFunctionCall), node := UDINT_TO_USINT(gDriver.MR[i].Par.CmdNode), data := ADR(gDriver.MR[i].Par.CmdData), offset := UDINT_TO_UINT(gDriver.MR[i].Par.CmdOffset), len := 1);
		gDriver.MR[i].MBMaster_0(ident := gDriver.MR[i].Ident);
		gDriver.MR[i].MBMClose_0(ident := gDriver.MR[i].Ident);
		IF gDriver.MR[i].MBMClose_0.enable AND gDriver.MR[i].MBMClose_0.status = 0 THEN
			gDriver.MR[i].Ident := 0;
		END_IF;

		gDriver.MR[i].Status.Active						:= gDriver.MR[i].MBMaster_0.enable AND (gDriver.MR[i].MBMaster_0.status = 65535 OR gDriver.MR[i].MBMaster_0.status = 0);
							
		gDriver.MR[i].Wait[W_MR_NOERROR]				:= BOOL_TO_DINT((gDriver.MR[i].MBMOpen_0.status = 0 OR gDriver.MR[i].MBMOpen_0.status = 65535 OR gDriver.MR[i].MBMOpen_0.status = 65534) AND (gDriver.MR[i].MBMaster_0.status = 0 OR gDriver.MR[i].MBMaster_0.status = 65535 OR gDriver.MR[i].MBMaster_0.status = 65534) AND (gDriver.MR[i].MBMCmd_0.status = 0 OR gDriver.MR[i].MBMCmd_0.status = 65535 OR gDriver.MR[i].MBMCmd_0.status = 65534) AND (gDriver.MR[i].MBMClose_0.status = 0 OR gDriver.MR[i].MBMClose_0.status = 65535 OR gDriver.MR[i].MBMClose_0.status = 65534));
		gDriver.MR[i].Wait[W_MR_MBMOPEN]				:= BOOL_TO_DINT(gDriver.MR[i].MBMOpen_0.status = 0);
		gDriver.MR[i].Wait[W_MR_MBMASTER]				:= BOOL_TO_DINT(gDriver.MR[i].MBMaster_0.status = 0 OR gDriver.MR[i].MBMaster_0.status = 65535);
		gDriver.MR[i].Wait[W_MR_MBMCMD]					:= BOOL_TO_DINT(gDriver.MR[i].MBMCmd_0.status = 0);
		gDriver.MR[i].Wait[W_MR_MBMCLOSE]				:= BOOL_TO_DINT(gDriver.MR[i].MBMClose_0.status = 0);

		IF gDriver.MR[i].MBMaster_0.enable THEN
			IF gDriver.MR[i].Wait[W_MR_NOERROR] = 0 THEN
				gDriver.MR[i].Mon[M_MR_ERROR]			:= TRUE;
			ELSIF gDriver.MR[i].MBMaster_0.execute THEN
				gDriver.MR[i].Mon[M_MR_ERROR]			:= FALSE;
			END_IF;
		ELSE
			gDriver.MR[i].Mon[M_MR_ERROR]				:= gDriver.MR[i].Wait[W_MR_NOERROR] = 0;
		END_IF;
	END_FOR;

END_ACTION
