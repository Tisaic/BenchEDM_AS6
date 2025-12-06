
ACTION OMD_CN:

	gDriver.CN[DRIVER_INST_CN_0].MpLinkADR 																:= ADR(gCNC);
	gDriver.CN[DRIVER_INST_CN_0].OverrideSetpoint[0]													:= 100.0;
	gDriver.CN[DRIVER_INST_CN_0].OverrideSetpoint[1]													:= gDriver.BX[DRIVER_INST_BX_0].Status.OverrideFactor;
	gDriver.CN[DRIVER_INST_CN_0].RapidOverrideSetpoint[0]												:= 100.0;
	gDriver.CN[DRIVER_INST_CN_0].FeedrateOverrideSetpoint[0]											:= 100.0;
	
	FOR i := 0 TO MAX_DRIVER_CN_IDX DO
		IF NOT gDriver.CN[i].FirstScanComplete THEN
			gDriver.CN[i].FirstScanComplete 															:= TRUE;	

			gDriver.CN[i].DefaultPar.CN.Block															:= '';								//ST 
			gDriver.CN[i].DefaultPar.CN.Jog.CoordSystem													:= 0;								//UD
			gDriver.CN[i].DefaultPar.CN.Jog.PathLimits.Acceleration										:= 50.0;							//RR 
			gDriver.CN[i].DefaultPar.CN.Jog.PathLimits.Deceleration										:= 50.0;							//RR 
			gDriver.CN[i].DefaultPar.CN.Jog.PathLimits.Jerk												:= 0.0;								//RR 
			gDriver.CN[i].DefaultPar.CN.Jog.PathLimits.Velocity											:= 10.0;							//RR 
			gDriver.CN[i].DefaultPar.CN.MoveProgramOptions.InitProgram									:= '';								//ST 
			gDriver.CN[i].DefaultPar.CN.MoveProgramOptions.RepositioningParameter.AxisVelocityFactor	:= 10.0;							//RR 
			gDriver.CN[i].DefaultPar.CN.MoveProgramOptions.RepositioningParameter.String				:= '';								//ST
			gDriver.CN[i].DefaultPar.CN.MoveProgramOptions.RepositioningParameter.Type					:= mcPRGRP_SINGLE_AXIS;				//McPrgAxesReposTypeEnum 
			gDriver.CN[i].DefaultPar.CN.MoveProgramOptions.SaveRestartData								:= mcSWITCH_OFF;					//McSwitchEnum 
			gDriver.CN[i].DefaultPar.CN.MoveProgramOptions.StartMode									:= mcPRGSM_NON_MODAL;				//McPrgStartModeEnum 
			gDriver.CN[i].DefaultPar.CN.MoveProgramOptions.StartPointParameter							:= 0.0;								//LR 
			gDriver.CN[i].DefaultPar.CN.MoveProgramOptions.StartPointType								:= mcPRGSP_STANDARD;				//McPrgStartPointEnum
			gDriver.CN[i].DefaultPar.CN.ProgramName														:= '';								//ST 
			gDriver.CN[i].DefaultPar.FeedrateOverrideSource												:= 0;								//SD
			gDriver.CN[i].DefaultPar.OverrideSource														:= 0;								//SD
			gDriver.CN[i].DefaultPar.RapidOverrideSource												:= 0;								//SD				
			brsmemcpy(ADR(gDriver.CN[i].Par),ADR(gDriver.CN[i].DefaultPar),SIZEOF(gDriver.CN[i].Par));
		ELSIF NOT gDriver.CN[i].ParametersLoaded AND gMain.Services.Recipes.Out.ParametersReady THEN
			gDriver.CN[i].ParametersLoaded := TRUE;
			brsmemcpy(ADR(gDriver.CN[i].Par),ADR(gPar.Driver.CN[i]),SIZEOF(gDriver.CN[i].Par));
		END_IF;

		brsmemset(ADR(gDriver.CN[i].Sev),0,SIZEOF(gDriver.CN[i].Sev));
		brsmemset(ADR(gDriver.CN[i].Status),0,SIZEOF(gDriver.CN[i].Status));
		FOR j := 0 TO MAX_DRIVER_CN_MON_IDX DO
			IF gDriver.CN[i].Par.Mon[j].Enable THEN
				IF gDriver.CN[i].Mon[j] THEN
					gDriver.CN[i].CTON_Mon[j](IN := TRUE, PT := LREAL_TO_TIME(gDriver.CN[i].Par.Mon[j].Time*1000.0));
					IF gDriver.CN[i].CTON_Mon[j].Q THEN
						gDriver.CN[i].Sev[j] := gDriver.CN[i].Par.Mon[j].Sev;
						IF gDriver.CN[i].Status.Severity < gDriver.CN[i].Sev[j] THEN
							gDriver.CN[i].Status.Severity := gDriver.CN[i].Sev[j];
						END_IF;
					END_IF;
				ELSE
					gDriver.CN[i].CTON_Mon[j](IN := FALSE);
					gDriver.CN[i].Sev[j] := 0;
				END_IF;
			ELSE
				gDriver.CN[i].CTON_Mon[j](IN := FALSE);
				gDriver.CN[i].Sev[j] := 0;
			END_IF;
		END_FOR;
		IF gDriver.CN[i].Cmd[C_CN_RESET] OR gDriver.ResetAll THEN
			gDriver.CN[i].Cmd[C_CN_RESET] := FALSE;
			brsmemset(ADR(gDriver.CN[i].Mon),0,SIZEOF(gDriver.CN[i].Mon));
			brsmemset(ADR(gDriver.CN[i].Cmd),0,SIZEOF(gDriver.CN[i].Cmd));
			brsmemset(ADR(gDriver.CN[i].Sev),0,SIZEOF(gDriver.CN[i].Sev));
			brsmemset(ADR(gDriver.CN[i].Status),0,SIZEOF(gDriver.CN[i].Status));
		END_IF;
		IF gDriver.CN[i].Cmd[C_CN_CLEARCMD] THEN
			gDriver.CN[i].Cmd[C_CN_CLEARCMD] := FALSE;
			brsmemset(ADR(gDriver.CN[i].Cmd),0,SIZEOF(gDriver.CN[i].Cmd));
		END_IF;
		IF gDriver.CN[i].Cmd[C_CN_CLEARMON] THEN
			gDriver.CN[i].Cmd[C_CN_CLEARMON] := FALSE;
			brsmemset(ADR(gDriver.CN[i].Status.Severity),0,SIZEOF(gDriver.CN[i].Status.Severity));
			brsmemset(ADR(gDriver.CN[i].Sev),0,SIZEOF(gDriver.CN[i].Sev));
			brsmemset(ADR(gDriver.CN[i].Par.Mon),0,SIZEOF(gDriver.CN[i].Par.Mon));
		END_IF;
		IF gDriver.CN[i].Cmd[C_CN_DEFAULTMON] THEN
			gDriver.CN[i].Cmd[C_CN_DEFAULTMON] := FALSE;
			brsmemcpy(ADR(gDriver.CN[i].Par.Mon),ADR(gDriver.CN[i].DefaultPar.Mon),SIZEOF(gDriver.CN[i].Par.Mon));
		END_IF;
		IF gDriver.CN[i].Cmd[C_CN_CLEARPAR] THEN
			gDriver.CN[i].Cmd[C_CN_CLEARPAR] := FALSE;
			brsmemset(ADR(gDriver.CN[i].Par),0,SIZEOF(gDriver.CN[i].Par));
		END_IF;
		IF gDriver.CN[i].Cmd[C_CN_DEFAULTPAR] THEN
			gDriver.CN[i].Cmd[C_CN_DEFAULTPAR] := FALSE;
			brsmemcpy(ADR(gDriver.CN[i].Par),ADR(gDriver.CN[i].DefaultPar),SIZEOF(gDriver.CN[i].Par));
		END_IF;
		IF gDriver.CN[i].Cmd[C_CN_SAVEPAR] THEN
			gDriver.CN[i].Cmd[C_CN_SAVEPAR] := FALSE;
			brsmemcpy(ADR(gPar.Driver.CN[i]),ADR(gDriver.CN[i].Par),SIZEOF(gDriver.CN[i].Par));
		END_IF;
		IF gDriver.CN[i].Cmd[C_CN_LOADPAR] THEN
			gDriver.CN[i].Cmd[C_CN_LOADPAR] := FALSE;
			brsmemcpy(ADR(gDriver.CN[i].Par),ADR(gPar.Driver.CN[i]),SIZEOF(gDriver.CN[i].Par));
		END_IF;

		gDriver.CN[i].MpCncFlex_0.ErrorReset							:= gDriver.CN[i].Cmd[C_CN_ERRORRESET] OR gMain.ErrorReset;
		gDriver.CN[i].MpCncFlex_0.Continue								:= gDriver.CN[i].Cmd[C_CN_CONTINUE];
		gDriver.CN[i].MpCncFlex_0.Home									:= gDriver.CN[i].Cmd[C_CN_HOME];
		gDriver.CN[i].MpCncFlex_0.Interrupt								:= gDriver.CN[i].Cmd[C_CN_INTERRUPT];
		gDriver.CN[i].MpCncFlex_0.Jog									:= gDriver.CN[i].Cmd[C_CN_JOG];
		gDriver.CN[i].MpCncFlex_0.MoveBlock								:= gDriver.CN[i].Cmd[C_CN_MOVEBLOCK];
		gDriver.CN[i].MpCncFlex_0.MoveProgram							:= gDriver.CN[i].Cmd[C_CN_MOVEPROGRAM];
		gDriver.CN[i].MpCncFlex_0.Power									:= gDriver.CN[i].Cmd[C_CN_POWER];
		gDriver.CN[i].MpCncFlex_0.SingleStep							:= gDriver.CN[i].Cmd[C_CN_SINGLESTEP];
		gDriver.CN[i].MpCncFlex_0.Stop									:= gDriver.CN[i].Cmd[C_CN_STOP];
		gDriver.CN[i].MpCncFlex_0.Update								:= gDriver.CN[i].Cmd[C_CN_UPDATE];

		gDriver.CN[i].MpCncFlex_0.Override								:= 0.0;
		IF gDriver.CN[i].Par.OverrideSource <= MAX_DRIVER_CN_SOURCE_IDX THEN
			gDriver.CN[i].MpCncFlex_0.Override							:= gDriver.CN[i].OverrideSetpoint[gDriver.CN[i].Par.OverrideSource];
		END_IF;
		gDriver.CN[i].MpCncFlex_0.RapidOverride							:= 0.0;
		IF gDriver.CN[i].Par.RapidOverrideSource <= MAX_DRIVER_CN_SOURCE_IDX THEN
			gDriver.CN[i].MpCncFlex_0.RapidOverride						:= gDriver.CN[i].RapidOverrideSetpoint[gDriver.CN[i].Par.RapidOverrideSource];
		END_IF;
		gDriver.CN[i].MpCncFlex_0.FeedrateOverride						:= 0.0;
		IF gDriver.CN[i].Par.FeedrateOverrideSource <= MAX_DRIVER_CN_SOURCE_IDX THEN
			gDriver.CN[i].MpCncFlex_0.FeedrateOverride					:= gDriver.CN[i].FeedrateOverrideSetpoint[gDriver.CN[i].Par.FeedrateOverrideSource];
		END_IF;

		gDriver.CN[i].MpCncFlex_0(MpLink := gDriver.CN[i].MpLinkADR, Enable := TRUE, Parameters := ADR(gDriver.CN[i].Par.CN));
		gDriver.CN[i].MC_GroupReadActualPosition_15_0(AxesGroup := gDriver.CN[i].MpLinkADR, Enable := TRUE, CoordSystem := mcJACS);
		
		gDriver.CN[i].Status.Position_mcJACS := gDriver.CN[i].MC_GroupReadActualPosition_15_0.Position;

		gDriver.CN[i].Wait[W_CN_NOERROR]								:= BOOL_TO_DINT(NOT gDriver.CN[i].MpCncFlex_0.Error);
		gDriver.CN[i].Wait[W_CN_COMMANDABORTED]							:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.CommandAborted);
		gDriver.CN[i].Wait[W_CN_COMMANDBUSY]							:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.CommandBusy);
		gDriver.CN[i].Wait[W_CN_UPDATEDONE]								:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.UpdateDone);
		gDriver.CN[i].Wait[W_CN_INMOTION]								:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.InMotion);
		gDriver.CN[i].Wait[W_CN_ISHOMED]								:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.IsHomed);
		gDriver.CN[i].Wait[W_CN_MOVEACTIVE]								:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.MoveActive);
		gDriver.CN[i].Wait[W_CN_MOVEDONE]								:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.MoveDone);
		gDriver.CN[i].Wait[W_CN_MOVEINTERRUPTED]						:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.MoveInterrupted);
		gDriver.CN[i].Wait[W_CN_POWERON]								:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.PowerOn);
		gDriver.CN[i].Wait[W_CN_SINGLESTEPACTIVE]						:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.SingleStepActive);
		gDriver.CN[i].Wait[W_CN_STOPPED]								:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.Stopped);
		gDriver.CN[i].Wait[W_CN_COMMUNICATIONREADY]						:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.Info.CommunicationReady);
		gDriver.CN[i].Wait[W_CN_READYTOPOWERON]							:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.Info.ReadyToPowerOn);
		gDriver.CN[i].Wait[W_CN_WAITFORCONTINUE]						:= BOOL_TO_DINT(gDriver.CN[i].MpCncFlex_0.Info.WaitForContinue);

		gDriver.CN[i].Mon[M_CN_ERROR]									:= gDriver.CN[i].MpCncFlex_0.Error;
		gDriver.CN[i].Mon[M_CN_NOTPOWERON]								:= NOT gDriver.CN[i].MpCncFlex_0.PowerOn;
		gDriver.CN[i].Mon[M_CN_NOTMOVEACTIVE]							:= NOT gDriver.CN[i].MpCncFlex_0.MoveActive;
	END_FOR;

//	McPrgAxesReposTypeEnum :
//	(
//		mcPRGRP_SINGLE_AXIS, (*The axes are positioned by single-axis movements*)
//		mcPRGRP_PROGRAM, (*The axes are positioned by a program*)
//		mcPRGRP_SINGLE_AXIS_AUTOMATIC (*The axes are positioned automatically*)
//	);
//	McSwitchEnum :
//	(
//		mcSWITCH_OFF,					(*State/Behavior selection switched off*)
//		mcSWITCH_ON			 			(*State/Behavior selection switched on*)
//	);
//	McPrgStartModeEnum :
//	(
//		mcPRGSM_NON_MODAL, (*Non-modal start mode*)
//		mcPRGSM_MODAL, (*Modal start mode*)
//		mcPRGSM_RESTART, (*Starts the program using the saved restart data*)
//		mcPRGSM_SIMULATION, (*High-precision simulation*)
//		mcPRGSM_SIMULATION_GEOMETRY (*Geometric simulation*)
//	);
//	McPrgStartPointEnum :
//	(
//		mcPRGSP_STANDARD, (*Start at beginning*)
//		mcPRGSP_BLOCK_NUMBER, (*Start at specified block number*)
//		mcPRGSP_ABORT_LINE, (*Start at the line number at which the program aborted*)
//		mcPRGSP_ABORT_POINT, (*Start at the point where the program aborted*)
//		mcPRGSP_LINE_NUMBER := 5, (*Start at the specified line number*)
//		mcPRGSP_PATH_DISTANCE_LINE (*Start at line in which the specified path is reached*)
//	);

END_ACTION
