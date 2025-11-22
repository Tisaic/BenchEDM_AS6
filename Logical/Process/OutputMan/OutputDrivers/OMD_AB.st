
ACTION OMD_AB:

	gDriver.AB[DRIVER_INST_AB_VX_0].MpLinkADR 													:= ADR(gAxisVX_0);
	gDriver.AB[DRIVER_INST_AB_VY_0].MpLinkADR 													:= ADR(gAxisVY_0);
	gDriver.AB[DRIVER_INST_AB_VZ_0].MpLinkADR 													:= ADR(gAxisVZ_0);
	gDriver.AB[DRIVER_INST_AB_VT_0].MpLinkADR 													:= ADR(gAxisVT_0);
	gDriver.AB[DRIVER_INST_AB_VV_0].MpLinkADR 													:= ADR(gAxisVV_0);
	gDriver.AB[DRIVER_INST_AB_RX_0_0].MpLinkADR 												:= ADR(gAxisRX_0_0);
	gDriver.AB[DRIVER_INST_AB_RY_0_0].MpLinkADR 												:= ADR(gAxisRY_0_0);
	gDriver.AB[DRIVER_INST_AB_RZ_0_0].MpLinkADR 												:= ADR(gAxisRZ_0_0);
	gDriver.AB[DRIVER_INST_AB_RT_0_0].MpLinkADR 												:= ADR(gAxisRT_0_0);
	gDriver.AB[DRIVER_INST_AB_RV_0_0].MpLinkADR 												:= ADR(gAxisRV_0_0);

	FOR i := 0 TO MAX_DRIVER_AB_IDX DO
		IF NOT gDriver.AB[i].FirstScanComplete THEN
			gDriver.AB[i].FirstScanComplete 													:= TRUE;
			gDriver.AB[i].DefaultPar.AB.Acceleration											:= 50.0;							//RR
			gDriver.AB[i].DefaultPar.AB.AutoTune.FeedForward.Acceleration						:= 50.0;							//RR
			gDriver.AB[i].DefaultPar.AB.AutoTune.FeedForward.Direction							:= mcDIR_BOTH;						//McDirectionEnum
			gDriver.AB[i].DefaultPar.AB.AutoTune.FeedForward.MaxVelocityPercent					:= 50.0;							//RR
			gDriver.AB[i].DefaultPar.AB.AutoTune.FeedForward.Mode								:= mcACPAX_TUNE_FF_MODE_STANDARD; 	//McAcpAxAutoTuneFeedFwdModeEnum
			gDriver.AB[i].DefaultPar.AB.AutoTune.LoopFilterMode									:= mcAXIS_TUNE_LOOP_FILTER_F1;		//MpAxisAutoTuneLoopFilterModeEnum
			gDriver.AB[i].DefaultPar.AB.AutoTune.MaxCurrentPercent								:= 80.0;							//RR
			gDriver.AB[i].DefaultPar.AB.AutoTune.MaxDistance									:= 0.0;								//LR
			gDriver.AB[i].DefaultPar.AB.AutoTune.MaxPositionError								:= 1.0;								//LR
			gDriver.AB[i].DefaultPar.AB.AutoTune.Mode											:= mcAXIS_TUNE_AUTOMATIC;			//MpAxisAutoTuneModeEnum
			gDriver.AB[i].DefaultPar.AB.AutoTune.Options.MaxProportionalGain					:= 0.0;								//RR
			gDriver.AB[i].DefaultPar.AB.AutoTune.Options.SpeedTuneFilterTmeMode					:= mcACPAX_FILTER_TIME_USE;			//McAcpAxFilterTimeModeEnum
			gDriver.AB[i].DefaultPar.AB.AutoTune.Options.SpeedTuneLoopFilter1Mode				:= mcACPAX_LOOP_FILTER_IGNORE;		//McAcpAxLoopFilterModeEnum
			gDriver.AB[i].DefaultPar.AB.AutoTune.Orientation									:= mcACPAX_ORIENTATION_HORIZONTAL;	//McAcpAxAutoTuneOrientationEnum
			gDriver.AB[i].DefaultPar.AB.AutoTune.SaveControllerSettings							:= FALSE;							//BO
			gDriver.AB[i].DefaultPar.AB.Deceleration											:= 50.0;							//RR
			gDriver.AB[i].DefaultPar.AB.Direction												:= mcDIR_SHORTEST_WAY;				//McDirectionEnum
			gDriver.AB[i].DefaultPar.AB.Distance												:= 0.0;								//LR
			gDriver.AB[i].DefaultPar.AB.Homing.Mode												:= mcHOMING_DIRECT;					//McHomingModeEnum
			gDriver.AB[i].DefaultPar.AB.Homing.Position											:= 0.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Homing.Options.Acceleration								:= 50.0;							//RR
			gDriver.AB[i].DefaultPar.AB.Homing.Options.AdditionalTorqueLimit.NegativeDirection	:= 0.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Homing.Options.AdditionalTorqueLimit.PositiveDirection	:= 0.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Homing.Options.BlockDetectionPositionError				:= 0.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Homing.Options.DisableRestorePositionOnEnable			:= mcSWITCH_OFF;					//McSwitchEnum
			gDriver.AB[i].DefaultPar.AB.Homing.Options.DriveSpecificHoming						:= mcSWITCH_OFF;					//McSwitchEnum
			gDriver.AB[i].DefaultPar.AB.Homing.Options.DriveSpecificHomingMode					:= 0;								//SS
			gDriver.AB[i].DefaultPar.AB.Homing.Options.HomingDirection							:= mcDIR_POSITIVE;					//McDirectionEnum
			gDriver.AB[i].DefaultPar.AB.Homing.Options.HomingVelocity							:= 5.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Homing.Options.KeepDirection							:= mcSWITCH_OFF;					//McSwitchEnum
			gDriver.AB[i].DefaultPar.AB.Homing.Options.PositionErrorStopLimit					:= 0.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Homing.Options.ReferencePulse							:= mcSWITCH_OFF;					//McSwitchEnum
			gDriver.AB[i].DefaultPar.AB.Homing.Options.ReferencePulseBlockingDistance			:= 0.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Homing.Options.RestorePositionVariableAddress			:= 0;								//UD
			gDriver.AB[i].DefaultPar.AB.Homing.Options.SensorOffset								:= 0.0;								//LR
			gDriver.AB[i].DefaultPar.AB.Homing.Options.SensorOffsetDirection					:= mcDIR_POSITIVE;					//McDirectionEnum
			gDriver.AB[i].DefaultPar.AB.Homing.Options.StartDirection							:= mcDIR_POSITIVE;					//McDirectionEnum
			gDriver.AB[i].DefaultPar.AB.Homing.Options.StartVelocity							:= 1.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Homing.Options.SwitchEdge								:= mcDIR_POSITIVE;					//McDirectionEnum
			gDriver.AB[i].DefaultPar.AB.Homing.Options.TorqueLimit								:= 0.1;								//RR
			gDriver.AB[i].DefaultPar.AB.Jerk													:= 0.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Jog.Acceleration										:= 50.0;							//RR
			gDriver.AB[i].DefaultPar.AB.Jog.Deceleration										:= 50.0;							//RR
			gDriver.AB[i].DefaultPar.AB.Jog.Jerk												:= 0.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Jog.LimitPosition.FirstPosition							:= 0.0;								//LR
			gDriver.AB[i].DefaultPar.AB.Jog.LimitPosition.LastPosition							:= 0.0;								//LR
			gDriver.AB[i].DefaultPar.AB.Jog.Velocity											:= 5.0;								//RR
			gDriver.AB[i].DefaultPar.AB.LimitLoad.Direction										:= mcDIR_CURRENT;					//McDirectionEnum
			gDriver.AB[i].DefaultPar.AB.LimitLoad.Load											:= 2.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Position												:= 0.0;								//LR
			gDriver.AB[i].DefaultPar.AB.Stop.Deceleration										:= 50.0;							//RR
			gDriver.AB[i].DefaultPar.AB.Stop.Jerk												:= 0.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Stop.StopAtPosition.Activate							:= FALSE;							//BO
			gDriver.AB[i].DefaultPar.AB.Stop.StopAtPosition.Deceleration						:= 0.0;								//RR
			gDriver.AB[i].DefaultPar.AB.Stop.StopAtPosition.Position							:= 0.0;								//LR
			gDriver.AB[i].DefaultPar.AB.Velocity												:= 5.0;								//RR	
			brsmemcpy(ADR(gDriver.AB[i].Par),ADR(gDriver.AB[i].DefaultPar),SIZEOF(gDriver.AB[i].Par));
		ELSIF NOT gDriver.AB[i].ParametersLoaded AND gMain.Services.Recipes.Out.ParametersReady THEN
			gDriver.AB[i].ParametersLoaded := TRUE;
			brsmemcpy(ADR(gDriver.AB[i].Par),ADR(gPar.Driver.AB[i]),SIZEOF(gDriver.AB[i].Par));
		END_IF;

		brsmemset(ADR(gDriver.AB[i].Sev),0,SIZEOF(gDriver.AB[i].Sev));
		brsmemset(ADR(gDriver.AB[i].Status),0,SIZEOF(gDriver.AB[i].Status));
		FOR j := 0 TO MAX_DRIVER_AB_MON_IDX DO
			IF gDriver.AB[i].Par.Mon[j].Enable THEN
				IF gDriver.AB[i].Mon[j] THEN
					gDriver.AB[i].CTON_Mon[j](IN := TRUE, PT := LREAL_TO_TIME(gDriver.AB[i].Par.Mon[j].Time*1000.0));
					IF gDriver.AB[i].CTON_Mon[j].Q THEN
						gDriver.AB[i].Sev[j] := gDriver.AB[i].Par.Mon[j].Sev;
						IF gDriver.AB[i].Status.Severity < gDriver.AB[i].Sev[j] THEN
							gDriver.AB[i].Status.Severity := gDriver.AB[i].Sev[j];
						END_IF;
					END_IF;
				ELSE
					gDriver.AB[i].CTON_Mon[j](IN := FALSE);
					gDriver.AB[i].Sev[j] := 0;
				END_IF;
			ELSE
				gDriver.AB[i].CTON_Mon[j](IN := FALSE);
				gDriver.AB[i].Sev[j] := 0;
			END_IF;
		END_FOR;
		IF gDriver.AB[i].Cmd[C_AB_RESET] OR gDriver.ResetAll THEN
			gDriver.AB[i].Cmd[C_AB_RESET] := FALSE;
			brsmemset(ADR(gDriver.AB[i].Mon),0,SIZEOF(gDriver.AB[i].Mon));
			brsmemset(ADR(gDriver.AB[i].Cmd),0,SIZEOF(gDriver.AB[i].Cmd));
			brsmemset(ADR(gDriver.AB[i].Sev),0,SIZEOF(gDriver.AB[i].Sev));
			brsmemset(ADR(gDriver.AB[i].Status),0,SIZEOF(gDriver.AB[i].Status));
		END_IF;
		IF gDriver.AB[i].Cmd[C_AB_CLEARCMD] THEN
			gDriver.AB[i].Cmd[C_AB_CLEARCMD] := FALSE;
			brsmemset(ADR(gDriver.AB[i].Cmd),0,SIZEOF(gDriver.AB[i].Cmd));
		END_IF;
		IF gDriver.AB[i].Cmd[C_AB_CLEARMON] THEN
			gDriver.AB[i].Cmd[C_AB_CLEARMON] := FALSE;
			brsmemset(ADR(gDriver.AB[i].Status.Severity),0,SIZEOF(gDriver.AB[i].Status.Severity));
			brsmemset(ADR(gDriver.AB[i].Sev),0,SIZEOF(gDriver.AB[i].Sev));
			brsmemset(ADR(gDriver.AB[i].Par.Mon),0,SIZEOF(gDriver.AB[i].Par.Mon));
		END_IF;
		IF gDriver.AB[i].Cmd[C_AB_DEFAULTMON] THEN
			gDriver.AB[i].Cmd[C_AB_DEFAULTMON] := FALSE;
			brsmemcpy(ADR(gDriver.AB[i].Par.Mon),ADR(gDriver.AB[i].DefaultPar.Mon),SIZEOF(gDriver.AB[i].Par.Mon));
		END_IF;
		IF gDriver.AB[i].Cmd[C_AB_CLEARPAR] THEN
			gDriver.AB[i].Cmd[C_AB_CLEARPAR] := FALSE;
			brsmemset(ADR(gDriver.AB[i].Par),0,SIZEOF(gDriver.AB[i].Par));
		END_IF;
		IF gDriver.AB[i].Cmd[C_AB_DEFAULTPAR] THEN
			gDriver.AB[i].Cmd[C_AB_DEFAULTPAR] := FALSE;
			brsmemcpy(ADR(gDriver.AB[i].Par),ADR(gDriver.AB[i].DefaultPar),SIZEOF(gDriver.AB[i].Par));
		END_IF;
		IF gDriver.AB[i].Cmd[C_AB_SAVEPAR] THEN
			gDriver.AB[i].Cmd[C_AB_SAVEPAR] := FALSE;
			brsmemcpy(ADR(gPar.Driver.AB[i]),ADR(gDriver.AB[i].Par),SIZEOF(gDriver.AB[i].Par));
		END_IF;
		IF gDriver.AB[i].Cmd[C_AB_LOADPAR] THEN
			gDriver.AB[i].Cmd[C_AB_LOADPAR] := FALSE;
			brsmemcpy(ADR(gDriver.AB[i].Par),ADR(gPar.Driver.AB[i]),SIZEOF(gDriver.AB[i].Par));
		END_IF;

		gDriver.AB[i].MpAxisBasic_0.ErrorReset			:= gDriver.AB[i].Cmd[C_AB_ERRORRESET] OR gMain.ErrorReset;
		gDriver.AB[i].MpAxisBasic_0.Home				:= gDriver.AB[i].Cmd[C_AB_HOME];
		gDriver.AB[i].MpAxisBasic_0.Power				:= gDriver.AB[i].Cmd[C_AB_POWER];
		gDriver.AB[i].MpAxisBasic_0.Update				:= gDriver.AB[i].Cmd[C_AB_UPDATE];
		gDriver.AB[i].MpAxisBasic_0.AutoTune			:= gDriver.AB[i].Cmd[C_AB_AUTOTUNE];
		gDriver.AB[i].MpAxisBasic_0.JogPositive			:= gDriver.AB[i].Cmd[C_AB_JOGPOSITIVE];
		gDriver.AB[i].MpAxisBasic_0.JogNegative			:= gDriver.AB[i].Cmd[C_AB_JOGNEGATIVE];
		gDriver.AB[i].MpAxisBasic_0.LimitLoad			:= gDriver.AB[i].Cmd[C_AB_LIMITLOAD];
		gDriver.AB[i].MpAxisBasic_0.Stop				:= gDriver.AB[i].Cmd[C_AB_STOP];
		gDriver.AB[i].MpAxisBasic_0.MoveAbsolute		:= gDriver.AB[i].Cmd[C_AB_MOVEABSOLUTE];
		gDriver.AB[i].MpAxisBasic_0.MoveAdditive		:= gDriver.AB[i].Cmd[C_AB_MOVEADDITIVE];
		gDriver.AB[i].MpAxisBasic_0.MoveVelocity		:= gDriver.AB[i].Cmd[C_AB_MOVEVELOCITY];
		gDriver.AB[i].MpAxisBasic_0.ReleaseBrake		:= gDriver.AB[i].Cmd[C_AB_RELEASEBRAKE];	
		gDriver.AB[i].MpAxisBasic_0.Simulate			:= gDriver.AB[i].Cmd[C_AB_SIMULATE];	

		gDriver.AB[i].MpAxisBasic_0(MpLink := gDriver.AB[i].MpLinkADR, Enable := TRUE, Parameters := ADR(gDriver.AB[i].Par.AB));

		gDriver.AB[i].Status.Position					:= gDriver.AB[i].MpAxisBasic_0.Position;
		gDriver.AB[i].Status.Velocity					:= gDriver.AB[i].MpAxisBasic_0.Velocity;
							
		gDriver.AB[i].Wait[W_AB_NOERROR]				:= BOOL_TO_DINT(NOT gDriver.AB[i].MpAxisBasic_0.Error);
		gDriver.AB[i].Wait[W_AB_COMMUNICATIONREADY]		:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.Info.CommunicationReady);
		gDriver.AB[i].Wait[W_AB_READYTOPOWERON]			:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.Info.ReadyToPowerOn);
		gDriver.AB[i].Wait[W_AB_POWERON]				:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.PowerOn);
		gDriver.AB[i].Wait[W_AB_ISHOMED]				:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.IsHomed AND NOT gDriver.AB[i].MpAxisBasic_0.CommandBusy);
		gDriver.AB[i].Wait[W_AB_LIMITLOADACTIVE]		:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.LimitLoadReady);
		gDriver.AB[i].Wait[W_AB_MOVEDONE]				:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.MoveDone);
		gDriver.AB[i].Wait[W_AB_UPDATEDONE]				:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.UpdateDone);
		gDriver.AB[i].Wait[W_AB_AUTOTUNEDONE]			:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.AutoTuneDone);
		gDriver.AB[i].Wait[W_AB_BRAKERELEASED]			:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.BrakeReleased);
		gDriver.AB[i].Wait[W_AB_COMMANDABORTED]			:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.CommandAborted);
		gDriver.AB[i].Wait[W_AB_COMMANDBUSY]			:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.CommandBusy);
		gDriver.AB[i].Wait[W_AB_INPOSITION]				:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.InPosition);
		gDriver.AB[i].Wait[W_AB_INVELOCITY]				:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.InVelocity);
		gDriver.AB[i].Wait[W_AB_MOVEACTIVE]				:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.MoveActive);
		gDriver.AB[i].Wait[W_AB_STOPPED]				:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.Stopped);
		gDriver.AB[i].Wait[W_AB_JOGGING]				:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.Info.Jogging);
		gDriver.AB[i].Wait[W_AB_JOGLIMITREACHED]		:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.Info.JogLimitReached);
		gDriver.AB[i].Wait[W_AB_SIMULATION]				:= BOOL_TO_DINT(gDriver.AB[i].MpAxisBasic_0.Info.Simulation);

		gDriver.AB[i].Mon[M_AB_ERROR]					:= gDriver.AB[i].MpAxisBasic_0.Error;
		gDriver.AB[i].Mon[M_AB_NOTPOWERON]				:= NOT gDriver.AB[i].MpAxisBasic_0.PowerOn;
	END_FOR;

//	McDirectionEnum :
//	(
//		mcDIR_POSITIVE := 0,							(*Movement only in the positive direction *)
//		mcDIR_NEGATIVE := 1,							(*Movement only in the negative direction*)
//		mcDIR_CURRENT := 2,								(*Movement in the direction of the active movement*)
//		mcDIR_SHORTEST_WAY := 3,						(*Movement with the shortest distance to the target, either in positive or negative direction. The movement will be in the positive direction if the distance is the same in both directions*)
//		mcDIR_EXCEED_PERIOD := 8,						(*The end position can be located outside of the axis period. The axis period can be exited in the negative direction if the end position is also negative*)
//		mcDIR_UNDEFINED := 9,							(*Movement in undefined direction*)
//		mcDIR_BOTH := 10								(*Movement in both directions*)
//	);		
//	McSwitchEnum :		
//	(		
//		mcSWITCH_OFF := 0,		 						(*State/Behavior selection switched off*)
//		mcSWITCH_ON := 1			 					(*State/Behavior selection switched on*)
//	);		
//	McHomingModeEnum :		
//	(		
//		mcHOMING_DIRECT := 0,							(*Direct homing. "Position" is used directly as the new axis position*)
//		mcHOMING_SWITCH_GATE := 1,						(*Homing with reference gate*)
//		mcHOMING_ABSOLUTE_SWITCH := 2,					(*Performs homing with absolute reference switch*)
//		mcHOMING_LIMIT_SWITCH := 4,	    				(*Homing with hardware limit switch*)
//		mcHOMING_ABSOLUTE := 5,							(*Homing by setting the "Position" homing offset for an absolute encoder*)
//		mcHOMING_DCM := 7,								(*Homing using interval-encoded reference marks*)
//		mcHOMING_BLOCK_TORQUE := 9,						(*Performs homing to mechanical limit, torque as criteria*)
//		mcHOMING_BLOCK_LAG_ERROR := 10,					(*Performs homing to mechanical limit, lag error as criteria*)
//		mcHOMING_ABSOLUTE_CORRECTION := 133,  			(*Homing by setting the "Position" homing offset for an absolute encoder with counter range correction. This mode must be used if the overflow of the absolute encoder is within the axis range of movement*)
//		mcHOMING_DCM_CORRECTION := 135,	 				(*Homing using distance-coded reference marks with counting range correction*)
//		mcHOMING_DEFAULT := 140,		 				(*All parameters, including "Position", are taken from the initial configuration for the axis*)
//		mcHOMING_INIT := 141,							(*All parameters, including "Position", are taken from an earlier initialization made using function block MC_BR_InitHome*)
//		mcHOMING_RESTORE_POSITION := 142				(*Restores position from a remanent variable*)
//	);		
//	MpAxisAutoTuneModeEnum : 		
//	(		
//		mcAXIS_TUNE_AUTOMATIC := 0, 					(* Performs a complete auto-tuning sequence of all controllers*)
//		mcAXIS_TUNE_SPEED := 1, 						(* Speed controller tuning*)
//		mcAXIS_TUNE_POSITION := 2, 						(* Position controller tuning*)
//		mcAXIS_TUNE_TEST := 3, 							(* Tests system stability*)
//		mcAXIS_TUNE_LOOP_FILTER := 4, 					(* Loop filter tuning*)
//		mcAXIS_TUNE_FEED_FORWARD := 5 					(*Feed forward tuning*)
//	);			
//	MpAxisAutoTuneLoopFilterModeEnum : 		
//	(		
//		mcAXIS_TUNE_LOOP_FILTER_F1 := 0, 				(*Tuning of loop filter 1 as a notch filter*)
//		mcAXIS_TUNE_LOOP_FILTER_F1_F2 := 1, 			(*Tuning of filter 1 and 2 as a notch filter*)
//		mcAXIS_TUNE_LOOP_FILTER_F1_F2_F3 := 2 			(*Tuning of filter 1, 2 and 3 as a notch filter*)
//	);	
//	McAcpAxAutoTuneOrientationEnum:	
//	(	
//		mcACPAX_ORIENTATION_HORIZONTAL := 0, 		 	(*Horizontal orientation*)
//		mcACPAX_ORIENTATION_VERTICAL := 1    		 	(*Vertical orientation*)
//	);		
//	McAcpAxFilterTimeModeEnum:		
//	(		
//		mcACPAX_FILTER_TIME_USE := 0,  					(*The determination of filter time constants is disabled; however, filter time constants are taken into account for autotuning*)
//		mcACPAX_FILTER_TIME_TUNE_MODE1 := 1, 		 	(*The controlled variable is the unfiltered actual speed n*)
//		mcACPAX_FILTER_TIME_TUNE_MODE2 := 2  		 	(*The controlled variable is the filtered actual speed n*)
//	);		
//	McAcpAxLoopFilterModeEnum:		
//	(		
//		mcACPAX_LOOP_FILTER_IGNORE := 0,  				(*Loop filters are neither taken into account nor calculated.*)
//		mcACPAX_LOOP_FILTER_USE := 1,  					(*The parameters for all loop filters are taken into account for autotuning*)
//		mcACPAX_LOOP_FILTER_TUNE_NOTCH := 2  			(*The parameters for the loop filter are calculated*)
//	);		
//	McAcpAxAutoTuneFeedFwdModeEnum:		
//	(		
//		mcACPAX_TUNE_FF_MODE_STANDARD := 0, 			(*Standard (active) tuning mode*)
//		mcACPAX_TUNE_FF_MODE_PASSIVE := 1 				(*Passive tuning mode*)
//	);		
//	McAcpAxAutoTuneFeedFwdCmdEnum:		
//	(		
//		mcACPAX_TUNE_FF_CMD_START := 0, 				(*Start (standard or passive) tuning process*)
//		mcACPAX_TUNE_FF_CMD_FINISH := 1, 				(*Finish (passive) tuning process*)
//		mcACPAX_TUNE_FF_CMD_ABORT := 2 					(*Abort (stop) (passive) tuning process*)
//	);

END_ACTION
