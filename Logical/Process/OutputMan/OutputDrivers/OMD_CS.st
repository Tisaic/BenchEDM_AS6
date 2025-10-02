
ACTION OMD_CS:

	gDriver.CS[DRIVER_INST_CS_RX0_0].MpLinkADR 							:= ADR(gAxisRX0_0);
	gDriver.CS[DRIVER_INST_CS_RX0_0].CyclicPositionSetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VX_0].MpAxisBasic_0.Position;
	gDriver.CS[DRIVER_INST_CS_RX0_0].CyclicVelocitySetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VX_0].MpAxisBasic_0.Velocity;
	gDriver.CS[DRIVER_INST_CS_RX0_0].CyclicTorqueSetpoint[0]			:= 0.0;
	gDriver.CS[DRIVER_INST_CS_RX0_0].CyclicTorqueFeedForwardSetpoint[0]	:= 0.0;

	gDriver.CS[DRIVER_INST_CS_RY0_0].MpLinkADR 							:= ADR(gAxisRY0_0);
	gDriver.CS[DRIVER_INST_CS_RY0_0].CyclicPositionSetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VY_0].MpAxisBasic_0.Position;
	gDriver.CS[DRIVER_INST_CS_RY0_0].CyclicVelocitySetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VY_0].MpAxisBasic_0.Velocity;
	gDriver.CS[DRIVER_INST_CS_RY0_0].CyclicTorqueSetpoint[0]			:= 0.0;
	gDriver.CS[DRIVER_INST_CS_RY0_0].CyclicTorqueFeedForwardSetpoint[0]	:= 0.0;

	gDriver.CS[DRIVER_INST_CS_RZ0_0].MpLinkADR 							:= ADR(gAxisRZ0_0);
	gDriver.CS[DRIVER_INST_CS_RZ0_0].CyclicPositionSetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VZ_0].MpAxisBasic_0.Position;
	gDriver.CS[DRIVER_INST_CS_RZ0_0].CyclicVelocitySetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VZ_0].MpAxisBasic_0.Velocity;
	gDriver.CS[DRIVER_INST_CS_RZ0_0].CyclicTorqueSetpoint[0]			:= 0.0;
	gDriver.CS[DRIVER_INST_CS_RZ0_0].CyclicTorqueFeedForwardSetpoint[0]	:= 0.0;

	gDriver.CS[DRIVER_INST_CS_RT0_0].MpLinkADR 							:= ADR(gAxisRT0_0);
	gDriver.CS[DRIVER_INST_CS_RT0_0].CyclicPositionSetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VT_0].MpAxisBasic_0.Position;
	gDriver.CS[DRIVER_INST_CS_RT0_0].CyclicVelocitySetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VT_0].MpAxisBasic_0.Velocity;
	gDriver.CS[DRIVER_INST_CS_RT0_0].CyclicTorqueSetpoint[0]			:= 0.0;
	gDriver.CS[DRIVER_INST_CS_RT0_0].CyclicTorqueFeedForwardSetpoint[0]	:= 0.0;

	gDriver.CS[DRIVER_INST_CS_RV0_0].MpLinkADR 							:= ADR(gAxisRV0_0);
	gDriver.CS[DRIVER_INST_CS_RV0_0].CyclicPositionSetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VV_0].MpAxisBasic_0.Position;
	gDriver.CS[DRIVER_INST_CS_RV0_0].CyclicVelocitySetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VV_0].MpAxisBasic_0.Velocity;
	gDriver.CS[DRIVER_INST_CS_RV0_0].CyclicTorqueSetpoint[0]			:= 0.0;
	gDriver.CS[DRIVER_INST_CS_RV0_0].CyclicTorqueFeedForwardSetpoint[0]	:= 0.0;
	
	FOR i := 0 TO MAX_DRIVER_CS_IDX DO
		IF NOT gDriver.CS[i].FirstScanComplete THEN
			gDriver.CS[i].FirstScanComplete 													:= TRUE;	
			gDriver.CS[i].DefaultPar.CS.MoveCyclicPosition.Acceleration							:= 0.0;								//RR 
			gDriver.CS[i].DefaultPar.CS.MoveCyclicPosition.AlternativeValueSource				:= mcALT_VALUE_NOT_USED;			//McAltValueSrcEnum
			gDriver.CS[i].DefaultPar.CS.MoveCyclicPosition.Deceleration							:= 0.0;								//RR 
			gDriver.CS[i].DefaultPar.CS.MoveCyclicPosition.DisableJoltLimitation				:= mcSWITCH_OFF;					//McSwitchEnum 
			gDriver.CS[i].DefaultPar.CS.MoveCyclicPosition.InterpolationMode					:= mcIPLM_DEFAULT;					//McIplModeEnum 
			gDriver.CS[i].DefaultPar.CS.MoveCyclicPosition.Jerk									:= 0.0;								//RR 
			gDriver.CS[i].DefaultPar.CS.MoveCyclicPosition.Velocity								:= 0.0;								//RR 
			gDriver.CS[i].DefaultPar.CS.MoveCyclicVelocity.Acceleration							:= 0.0;								//RR 
			gDriver.CS[i].DefaultPar.CS.MoveCyclicVelocity.AlternativeValueSource				:= mcALT_VALUE_NOT_USED;			//McAltValueSrcEnum
			gDriver.CS[i].DefaultPar.CS.MoveCyclicVelocity.Deceleration							:= 0.0;								//RR 
			gDriver.CS[i].DefaultPar.CS.MoveCyclicVelocity.DisableJoltLimitation				:= mcSWITCH_OFF;					//McSwitchEnum 
			gDriver.CS[i].DefaultPar.CS.MoveCyclicVelocity.InterpolationMode					:= mcIPLM_DEFAULT;					//McIplModeEnum 
			gDriver.CS[i].DefaultPar.CS.MoveCyclicVelocity.Jerk									:= 0.0;								//RR 
			gDriver.CS[i].DefaultPar.CS.MoveCyclicVelocity.Mode									:= mcAXIS_MCV_MODE_MOVE_CYC_VEL;	//MpAxisMoveCyclicVelocityModeEnum 
			gDriver.CS[i].DefaultPar.CS.TorqueControl.Acceleration								:= 0.0;								//RR 
			gDriver.CS[i].DefaultPar.CS.TorqueControl.CmdIndependentActivation					:= FALSE;							//BO 
			gDriver.CS[i].DefaultPar.CS.TorqueControl.Jerk										:= 0.0;								//RR  
			gDriver.CS[i].DefaultPar.CS.TorqueControl.MaximumVelocity							:= 0.0;								//RR 
			gDriver.CS[i].DefaultPar.CS.TorqueControl.MinimumVelocity							:= 0.0;								//RR 
			gDriver.CS[i].DefaultPar.CS.TorqueControl.Options.CorrectVelocityLimits				:= FALSE;							//BO
			gDriver.CS[i].DefaultPar.CS.TorqueControl.Options.NoHomingCheck						:= FALSE;							//BO 
			gDriver.CS[i].DefaultPar.CS.TorqueControl.Options.StartAlternativeValueSource		:= mcALT_VALUE_NOT_USED;			//McAltValueSrcEnum
			gDriver.CS[i].DefaultPar.CS.TorqueControl.Options.TimeLimit							:= 0.0;								//RR
			gDriver.CS[i].DefaultPar.CS.TorqueControl.Options.TorqueAlternativeValueSource		:= mcALT_VALUE_NOT_USED;			//McAltValueSrcEnum
			gDriver.CS[i].DefaultPar.CS.TorqueControl.Options.UseTimeLimit						:= FALSE;							//BO
			gDriver.CS[i].DefaultPar.CS.TorqueControl.Options.UseVelocityLimits					:= FALSE;							//BO 
			gDriver.CS[i].DefaultPar.CS.TorqueControl.TorqueRamp								:= 0.0;								//RR
			gDriver.CS[i].DefaultPar.CS.TorqueControl.TorqueResolution							:= 0.0;								//RR
			gDriver.CS[i].DefaultPar.CS.TorqueFeedForward.InterpolationMode						:= mcIPLM_DEFAULT;					//McIplModeEnum 
			gDriver.CS[i].DefaultPar.CS.TorqueFeedForward.Options.DisableMode					:= mcDISABLE_DEFAULT;				//McDisableModeEnum 
			gDriver.CS[i].DefaultPar.CyclicPositionSource										:= 0;								//SD
			gDriver.CS[i].DefaultPar.CyclicTorqueSource											:= 0;								//SD
			gDriver.CS[i].DefaultPar.CyclicTorqueFeedForwardSource								:= 0;								//SD
			gDriver.CS[i].DefaultPar.CyclicVelocitySource										:= 0;								//SD				

			gDriver.CS[i].DefaultPar.Mon[M_CS_ERROR].Enable										:= FALSE;							//BO
			gDriver.CS[i].DefaultPar.Mon[M_CS_ERROR].Sev										:= 4;								//SD
			gDriver.CS[i].DefaultPar.Mon[M_CS_ERROR].Time										:= 0.0;								//LR
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTMOVECYCLICPOSITIONACTIVE].Enable				:= FALSE;							//BO
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTMOVECYCLICPOSITIONACTIVE].Sev					:= 4;								//SD
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTMOVECYCLICPOSITIONACTIVE].Time					:= 0.0;								//LR
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTMOVECYCLICVELOCITYACTIVE].Enable				:= FALSE;							//BO
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTMOVECYCLICVELOCITYACTIVE].Sev					:= 4;								//SD
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTMOVECYCLICVELOCITYACTIVE].Time					:= 0.0;								//LR
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTTORQUECONTROLACTIVE].Enable					:= FALSE;							//BO
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTTORQUECONTROLACTIVE].Sev						:= 4;								//SD
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTTORQUECONTROLACTIVE].Time						:= 0.0;								//LR
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTTORQUEFEEDFORWARDACTIVE].Enable				:= FALSE;							//BO
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTTORQUEFEEDFORWARDACTIVE].Sev					:= 4;								//SD
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTTORQUEFEEDFORWARDACTIVE].Time					:= 0.0;								//LR
			gDriver.CS[i].DefaultPar.Mon[M_CS_TCAXISLIMITACTIVE].Enable							:= FALSE;							//BO
			gDriver.CS[i].DefaultPar.Mon[M_CS_TCAXISLIMITACTIVE].Sev							:= 4;								//SD
			gDriver.CS[i].DefaultPar.Mon[M_CS_TCAXISLIMITACTIVE].Time							:= 0.0;								//LR
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTTCINTORQUE].Enable								:= FALSE;							//BO
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTTCINTORQUE].Sev								:= 4;								//SD
			gDriver.CS[i].DefaultPar.Mon[M_CS_NOTTCINTORQUE].Time								:= 0.0;	

			brsmemcpy(ADR(gDriver.CS[i].Par),ADR(gDriver.CS[i].DefaultPar),SIZEOF(gDriver.CS[i].Par));
		END_IF;

		brsmemset(ADR(gDriver.CS[i].Sev),0,SIZEOF(gDriver.CS[i].Sev));
		brsmemset(ADR(gDriver.CS[i].Status),0,SIZEOF(gDriver.CS[i].Status));
		FOR j := 0 TO MAX_DRIVER_CS_MON_IDX DO
			IF gDriver.CS[i].Par.Mon[j].Enable THEN
				IF gDriver.CS[i].Mon[j] THEN
					gDriver.CS[i].CTON_Mon[j](IN := TRUE, PT := LREAL_TO_TIME(gDriver.CS[i].Par.Mon[j].Time*1000.0));
					IF gDriver.CS[i].CTON_Mon[j].Q THEN
						gDriver.CS[i].Sev[j] := gDriver.CS[i].Par.Mon[j].Sev;
						IF gDriver.CS[i].Status.Severity < gDriver.CS[i].Sev[j] THEN
							gDriver.CS[i].Status.Severity := gDriver.CS[i].Sev[j];
						END_IF;
					END_IF;
				ELSE
					gDriver.CS[i].CTON_Mon[j](IN := FALSE);
					gDriver.CS[i].Sev[j] := 0;
				END_IF;
			ELSE
				gDriver.CS[i].CTON_Mon[j](IN := FALSE);
				gDriver.CS[i].Sev[j] := 0;
			END_IF;
		END_FOR;
		IF gDriver.CS[i].Cmd[C_CS_RESET] THEN
			gDriver.CS[i].Cmd[C_CS_RESET] := FALSE;
			brsmemset(ADR(gDriver.CS[i].Cmd),0,SIZEOF(gDriver.CS[i].Cmd));
			brsmemset(ADR(gDriver.CS[i].Sev),0,SIZEOF(gDriver.CS[i].Sev));
			brsmemset(ADR(gDriver.CS[i].Status),0,SIZEOF(gDriver.CS[i].Status));
			brsmemcpy(ADR(gDriver.CS[i].Par),ADR(gDriver.CS[i].DefaultPar),SIZEOF(gDriver.CS[i].Par));
		END_IF;
		IF gDriver.CS[i].Cmd[C_CS_CLEARCMD] THEN
			gDriver.CS[i].Cmd[C_CS_CLEARCMD] := FALSE;
			brsmemset(ADR(gDriver.CS[i].Cmd),0,SIZEOF(gDriver.CS[i].Cmd));
		END_IF;
		IF gDriver.CS[i].Cmd[C_CS_CLEARMON] THEN
			gDriver.CS[i].Cmd[C_CS_CLEARMON] := FALSE;
			brsmemset(ADR(gDriver.CS[i].Status.Severity),0,SIZEOF(gDriver.CS[i].Status.Severity));
			brsmemset(ADR(gDriver.CS[i].Sev),0,SIZEOF(gDriver.CS[i].Sev));
			brsmemset(ADR(gDriver.CS[i].Par.Mon),0,SIZEOF(gDriver.CS[i].Par.Mon));
		END_IF;
		IF gDriver.CS[i].Cmd[C_CS_DEFAULTMON] THEN
			gDriver.CS[i].Cmd[C_CS_DEFAULTMON] := FALSE;
			brsmemcpy(ADR(gDriver.CS[i].Par.Mon),ADR(gDriver.CS[i].DefaultPar.Mon),SIZEOF(gDriver.CS[i].Par.Mon));
		END_IF;
		IF gDriver.CS[i].Cmd[C_CS_CLEARPAR] THEN
			gDriver.CS[i].Cmd[C_CS_CLEARPAR] := FALSE;
			brsmemset(ADR(gDriver.CS[i].Par),0,SIZEOF(gDriver.CS[i].Par));
		END_IF;
		IF gDriver.CS[i].Cmd[C_CS_DEFAULTPAR] THEN
			gDriver.CS[i].Cmd[C_CS_DEFAULTPAR] := FALSE;
			brsmemcpy(ADR(gDriver.CS[i].Par),ADR(gDriver.CS[i].DefaultPar),SIZEOF(gDriver.CS[i].Par));
		END_IF;

		gDriver.CS[i].MpAxisCyclicSet_0.ErrorReset						:= gDriver.CS[i].Cmd[C_CS_ERRORRESET] OR gMain.ErrorReset;
		gDriver.CS[i].MpAxisCyclicSet_0.MoveCyclicPosition				:= gDriver.CS[i].Cmd[C_CS_MOVECYCLICPOSITION];
		gDriver.CS[i].MpAxisCyclicSet_0.MoveCyclicVelocity				:= gDriver.CS[i].Cmd[C_CS_MOVECYCLICVELOCITY];
		gDriver.CS[i].MpAxisCyclicSet_0.TorqueControl					:= gDriver.CS[i].Cmd[C_CS_TORQUECONTROL];
		gDriver.CS[i].MpAxisCyclicSet_0.TorqueFeedForward				:= gDriver.CS[i].Cmd[C_CS_TORQUEFEEDFORWARD];
		gDriver.CS[i].MpAxisCyclicSet_0.Update							:= gDriver.CS[i].Cmd[C_CS_UPDATE];

		gDriver.CS[i].MpAxisCyclicSet_0.CyclicPosition					:= 0.0;
		IF gDriver.CS[i].Par.CyclicPositionSource <= MAX_DRIVER_CS_SOURCE_IDX THEN
			gDriver.CS[i].MpAxisCyclicSet_0.CyclicPosition				:= gDriver.CS[i].CyclicPositionSetpoint[gDriver.CS[i].Par.CyclicPositionSource];
		END_IF;
		gDriver.CS[i].MpAxisCyclicSet_0.CyclicVelocity					:= 0.0;
		IF gDriver.CS[i].Par.CyclicVelocitySource <= MAX_DRIVER_CS_SOURCE_IDX THEN
			gDriver.CS[i].MpAxisCyclicSet_0.CyclicVelocity				:= gDriver.CS[i].CyclicVelocitySetpoint[gDriver.CS[i].Par.CyclicVelocitySource];
		END_IF;
		gDriver.CS[i].MpAxisCyclicSet_0.CyclicTorque					:= 0.0;
		IF gDriver.CS[i].Par.CyclicTorqueSource <= MAX_DRIVER_CS_SOURCE_IDX THEN
			gDriver.CS[i].MpAxisCyclicSet_0.CyclicTorque 				:= gDriver.CS[i].CyclicTorqueSetpoint[gDriver.CS[i].Par.CyclicTorqueSource];
		END_IF;
		gDriver.CS[i].MpAxisCyclicSet_0.CyclicTorqueFeedForward			:= 0.0;
		IF gDriver.CS[i].Par.CyclicTorqueFeedForwardSource <= MAX_DRIVER_CS_SOURCE_IDX THEN
			gDriver.CS[i].MpAxisCyclicSet_0.CyclicTorqueFeedForward		:= gDriver.CS[i].CyclicTorqueFeedForwardSetpoint[gDriver.CS[i].Par.CyclicTorqueFeedForwardSource];
		END_IF;

		gDriver.CS[i].MpAxisCyclicSet_0(MpLink := gDriver.CS[i].MpLinkADR, Enable := TRUE, Parameters := ADR(gDriver.CS[i].Par.CS));

		gDriver.CS[i].Wait[W_CS_NOERROR]								:= BOOL_TO_DINT(NOT gDriver.CS[i].MpAxisCyclicSet_0.Error);
		gDriver.CS[i].Wait[W_CS_COMMANDABORTED]							:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.CommandAborted);
		gDriver.CS[i].Wait[W_CS_COMMANDBUSY]							:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.CommandBusy);
		gDriver.CS[i].Wait[W_CS_UPDATEDONE]								:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.UpdateDone);
		gDriver.CS[i].Wait[W_CS_MOVECYCLICPOSITIONACTIVE]				:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.MoveCyclicPositionActive);
		gDriver.CS[i].Wait[W_CS_MOVECYCLICVELOCITYACTIVE]				:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.MoveCyclicVelocityActive);
		gDriver.CS[i].Wait[W_CS_TORQUECONTROLACTIVE]					:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.TorqueControlActive);
		gDriver.CS[i].Wait[W_CS_TORQUEFEEDFORWARDACTIVE]				:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.TorqueFeedForwardActive);
		gDriver.CS[i].Wait[W_CS_TCAXISLIMITACTIVE]						:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.Info.TorqueControl.AxisLimitActive);
		gDriver.CS[i].Wait[W_CS_TCDATAINITIALIZED]						:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.Info.TorqueControl.DataInitialized);
		gDriver.CS[i].Wait[W_CS_TCINTORQUE]								:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.Info.TorqueControl.InTorque);
		gDriver.CS[i].Wait[W_CS_TCREADY]								:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.Info.TorqueControl.Ready);
		gDriver.CS[i].Wait[W_CS_AXISREADY]								:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.Info.AxisReady);

		gDriver.CS[i].Mon[M_CS_ERROR]									:= gDriver.CS[i].MpAxisCyclicSet_0.Error;
		gDriver.CS[i].Mon[M_CS_NOTMOVECYCLICPOSITIONACTIVE]				:= NOT gDriver.CS[i].MpAxisCyclicSet_0.MoveCyclicPositionActive;
		gDriver.CS[i].Mon[M_CS_NOTMOVECYCLICVELOCITYACTIVE]				:= NOT gDriver.CS[i].MpAxisCyclicSet_0.MoveCyclicVelocityActive;
		gDriver.CS[i].Mon[M_CS_NOTTORQUECONTROLACTIVE]					:= NOT gDriver.CS[i].MpAxisCyclicSet_0.TorqueControlActive;
		gDriver.CS[i].Mon[M_CS_NOTTORQUEFEEDFORWARDACTIVE]				:= NOT gDriver.CS[i].MpAxisCyclicSet_0.TorqueFeedForwardActive;
		gDriver.CS[i].Mon[M_CS_TCAXISLIMITACTIVE]						:= gDriver.CS[i].MpAxisCyclicSet_0.Info.TorqueControl.AxisLimitActive;
		gDriver.CS[i].Mon[M_CS_NOTTCINTORQUE]							:= NOT gDriver.CS[i].MpAxisCyclicSet_0.Info.TorqueControl.InTorque;
	END_FOR;

//	MpAxisMoveCyclicVelocityModeEnum : 
//	(
//		mcAXIS_MCV_MODE_MOVE_CYC_VEL, 	(*MoveCyclicVelocity mode*)
//		mcAXIS_MCV_MODE_MOVE_VEL_CTRL 	(*VelocityControl mode*)
//	);
//	McIplModeEnum :
//	(
//		mcIPLM_DEFAULT,					(*The most suitable available interpolation is used*)
//		mcIPLM_OFF,						(*Interpolation off*)
//		mcIPLM_LINEAR,					(*linear interpolation*)
//		mcIPLM_QUADRATIC,				(*quadratic interpolation*)
//		mcIPLM_QUADRATIC_NO_OVERSHOOT	(*quadratic interpolation without overshoot*)
//	);
//	McAltValueSrcEnum :
//	(
//		mcALT_VALUE_NOT_USED := 0,		(*No alternative value source is used*)
//		mcALT_VALUE1 := 1,				(*"Value source 1" of the feature "Alternative value source" is used*)
//		mcALT_VALUE2 := 2,				(*"Value source 2" of the feature "Alternative value source" is used*)
//		mcALT_VALUE3 := 3,				(*"Value source 3" of the feature "Alternative value source" is used*)
//		mcALT_VALUE4 := 4,				(*"Value source 4" of the feature "Alternative value source" is used*)
//		mcALT_VALUE5 := 5,				(*"Value source 5" of the feature "Alternative value source" is used*)
//		mcALT_VALUE6 := 6,				(*"Value source 6" of the feature "Alternative value source" is used*)
//		mcALT_VALUE7 := 7,				(*"Value source 7" of the feature "Alternative value source" is used*)
//		mcALT_VALUE8 := 8				(*"Value source 8" of the feature "Alternative value source" is used*)
//	);
//	McSwitchEnum :
//	(
//		mcSWITCH_OFF,					(*State/Behavior selection switched off*)
//		mcSWITCH_ON			 			(*State/Behavior selection switched on*)
//	);
//	McDisableModeEnum :
//	(
//		mcDISABLE_DEFAULT := 0, 		(*Switch to default setting at disable*)
//		mcDISABLE_KEEP_VALUE := 1 		(*Keep value at disable*)
//	);

END_ACTION
