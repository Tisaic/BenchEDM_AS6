
ACTION OMD_FI:

	//TESTING
	//gDriver.CS[DRIVER_INST_CS_RX0_0].Par.CyclicPosition := gDriver.AB[DRIVER_INST_AB_VX_0].MpAxisBasic_0.Position;
//	gDriver.CS[DRIVER_INST_CS_RX0_0].MpLinkADR 							:= ADR(gAxisRX0_0);
//	gDriver.CS[DRIVER_INST_CS_RX0_0].CyclicPositionSetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VX_0].MpAxisBasic_0.Position;
//	gDriver.CS[DRIVER_INST_CS_RX0_0].CyclicVelocitySetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VX_0].MpAxisBasic_0.Velocity;
//	gDriver.CS[DRIVER_INST_CS_RX0_0].CyclicTorqueSetpoint[0]			:= 0.0;
//	gDriver.CS[DRIVER_INST_CS_RX0_0].CyclicTorqueFeedForwardSetpoint[0]	:= 0.0;
//
//	gDriver.CS[DRIVER_INST_CS_RY0_0].MpLinkADR 							:= ADR(gAxisRY0_0);
//	gDriver.CS[DRIVER_INST_CS_RY0_0].CyclicPositionSetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VY_0].MpAxisBasic_0.Position;
//	gDriver.CS[DRIVER_INST_CS_RY0_0].CyclicVelocitySetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VY_0].MpAxisBasic_0.Velocity;
//	gDriver.CS[DRIVER_INST_CS_RY0_0].CyclicTorqueSetpoint[0]			:= 0.0;
//	gDriver.CS[DRIVER_INST_CS_RY0_0].CyclicTorqueFeedForwardSetpoint[0]	:= 0.0;
//
//	gDriver.CS[DRIVER_INST_CS_RZ0_0].MpLinkADR 							:= ADR(gAxisRZ0_0);
//	gDriver.CS[DRIVER_INST_CS_RZ0_0].CyclicPositionSetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VZ_0].MpAxisBasic_0.Position;
//	gDriver.CS[DRIVER_INST_CS_RZ0_0].CyclicVelocitySetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VZ_0].MpAxisBasic_0.Velocity;
//	gDriver.CS[DRIVER_INST_CS_RZ0_0].CyclicTorqueSetpoint[0]			:= 0.0;
//	gDriver.CS[DRIVER_INST_CS_RZ0_0].CyclicTorqueFeedForwardSetpoint[0]	:= 0.0;
//
//	gDriver.CS[DRIVER_INST_CS_RT0_0].MpLinkADR 							:= ADR(gAxisRT0_0);
//	gDriver.CS[DRIVER_INST_CS_RT0_0].CyclicPositionSetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VT_0].MpAxisBasic_0.Position;
//	gDriver.CS[DRIVER_INST_CS_RT0_0].CyclicVelocitySetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VT_0].MpAxisBasic_0.Velocity;
//	gDriver.CS[DRIVER_INST_CS_RT0_0].CyclicTorqueSetpoint[0]			:= 0.0;
//	gDriver.CS[DRIVER_INST_CS_RT0_0].CyclicTorqueFeedForwardSetpoint[0]	:= 0.0;
//
//	gDriver.CS[DRIVER_INST_CS_RV0_0].MpLinkADR 							:= ADR(gAxisRV0_0);
//	gDriver.CS[DRIVER_INST_CS_RV0_0].CyclicPositionSetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VV_0].MpAxisBasic_0.Position;
//	gDriver.CS[DRIVER_INST_CS_RV0_0].CyclicVelocitySetpoint[0]			:= gDriver.AB[DRIVER_INST_AB_VV_0].MpAxisBasic_0.Velocity;
//	gDriver.CS[DRIVER_INST_CS_RV0_0].CyclicTorqueSetpoint[0]			:= 0.0;
//	gDriver.CS[DRIVER_INST_CS_RV0_0].CyclicTorqueFeedForwardSetpoint[0]	:= 0.0;
//	
//	FOR i := 0 TO MAX_DRIVER_CS_IDX DO
//		gDriver.CS[i].MpAxisCyclicSet_0.CyclicPosition					:= 0.0;
//		IF gDriver.CS[i].Par.CyclicPositionSource <= MAX_DRIVER_CS_SOURCE_IDX THEN
//			gDriver.CS[i].MpAxisCyclicSet_0.CyclicPosition				:= gDriver.CS[i].CyclicPositionSetpoint[gDriver.CS[i].Par.CyclicPositionSource];
//		END_IF;
//		gDriver.CS[i].MpAxisCyclicSet_0.CyclicVelocity					:= 0.0;
//		IF gDriver.CS[i].Par.CyclicVelocitySource <= MAX_DRIVER_CS_SOURCE_IDX THEN
//			gDriver.CS[i].MpAxisCyclicSet_0.CyclicVelocity				:= gDriver.CS[i].CyclicVelocitySetpoint[gDriver.CS[i].Par.CyclicVelocitySource];
//		END_IF;
//		gDriver.CS[i].MpAxisCyclicSet_0.CyclicTorque					:= 0.0;
//		IF gDriver.CS[i].Par.CyclicTorqueSource <= MAX_DRIVER_CS_SOURCE_IDX THEN
//			gDriver.CS[i].MpAxisCyclicSet_0.CyclicTorque 				:= gDriver.CS[i].CyclicTorqueSetpoint[gDriver.CS[i].Par.CyclicTorqueSource];
//		END_IF;
//		gDriver.CS[i].MpAxisCyclicSet_0.CyclicTorqueFeedForward			:= 0.0;
//		IF gDriver.CS[i].Par.CyclicTorqueFeedForwardSource <= MAX_DRIVER_CS_SOURCE_IDX THEN
//			gDriver.CS[i].MpAxisCyclicSet_0.CyclicTorqueFeedForward		:= gDriver.CS[i].CyclicTorqueFeedForwardSetpoint[gDriver.CS[i].Par.CyclicTorqueFeedForwardSource];
//		END_IF;
//
//		gDriver.CS[i].MpAxisCyclicSet_0.ErrorReset						:= gDriver.CS[i].Cmd[C_CS_ERRORRESET] OR gMain.ErrorReset;
//		gDriver.CS[i].MpAxisCyclicSet_0.MoveCyclicPosition				:= gDriver.CS[i].Cmd[C_CS_MOVECYCLICPOSITION];
//		gDriver.CS[i].MpAxisCyclicSet_0.MoveCyclicVelocity				:= gDriver.CS[i].Cmd[C_CS_MOVECYCLICVELOCITY];
//		gDriver.CS[i].MpAxisCyclicSet_0.TorqueControl					:= gDriver.CS[i].Cmd[C_CS_TORQUECONTROL];
//		gDriver.CS[i].MpAxisCyclicSet_0.TorqueFeedForward				:= gDriver.CS[i].Cmd[C_CS_TORQUEFEEDFORWARD];
//		gDriver.CS[i].MpAxisCyclicSet_0.Update							:= gDriver.CS[i].Cmd[C_CS_UPDATE];
//
//		gDriver.CS[i].MpAxisCyclicSet_0(MpLink := gDriver.CS[i].MpLinkADR, Enable := TRUE, Parameters := ADR(gDriver.CS[i].Par.CS));
//
//		gDriver.CS[i].Wait[W_CS_NOERROR]								:= BOOL_TO_DINT(NOT gDriver.CS[i].MpAxisCyclicSet_0.Error);
//		gDriver.CS[i].Wait[W_CS_COMMANDABORTED]							:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.CommandAborted);
//		gDriver.CS[i].Wait[W_CS_COMMANDBUSY]							:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.CommandBusy);
//		gDriver.CS[i].Wait[W_CS_UPDATEDONE]								:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.UpdateDone);
//		gDriver.CS[i].Wait[W_CS_MOVECYCLICPOSITIONACTIVE]				:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.MoveCyclicPositionActive);
//		gDriver.CS[i].Wait[W_CS_MOVECYCLICVELOCITYACTIVE]				:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.MoveCyclicVelocityActive);
//		gDriver.CS[i].Wait[W_CS_TORQUECONTROLACTIVE]					:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.TorqueControlActive);
//		gDriver.CS[i].Wait[W_CS_TORQUEFEEDFORWARDACTIVE]				:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.TorqueFeedForwardActive);
//		gDriver.CS[i].Wait[W_CS_TCAXISLIMITACTIVE]						:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.Info.TorqueControl.AxisLimitActive);
//		gDriver.CS[i].Wait[W_CS_TCDATAINITIALIZED]						:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.Info.TorqueControl.DataInitialized);
//		gDriver.CS[i].Wait[W_CS_TCINTORQUE]								:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.Info.TorqueControl.InTorque);
//		gDriver.CS[i].Wait[W_CS_TCREADY]								:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.Info.TorqueControl.Ready);
//		gDriver.CS[i].Wait[W_CS_AXISREADY]								:= BOOL_TO_DINT(gDriver.CS[i].MpAxisCyclicSet_0.Info.AxisReady);
//	END_FOR;

//	gDriver.CS[i].Par.CS.MoveCyclicPosition.Acceleration							//RR 
//	gDriver.CS[i].Par.CS.MoveCyclicPosition.AlternativeValueSource					//ENUM
//	gDriver.CS[i].Par.CS.MoveCyclicPosition.Deceleration							//RR 
//	gDriver.CS[i].Par.CS.MoveCyclicPosition.DisableJoltLimitation					//ENUM 
//	gDriver.CS[i].Par.CS.MoveCyclicPosition.InterpolationMode						//ENUM 
//	gDriver.CS[i].Par.CS.MoveCyclicPosition.Jerk									//RR 
//	gDriver.CS[i].Par.CS.MoveCyclicPosition.Velocity								//RR 
//	gDriver.CS[i].Par.CS.MoveCyclicVelocity.Acceleration							//RR 
//	gDriver.CS[i].Par.CS.MoveCyclicVelocity.AlternativeValueSource					//ENUM 
//	gDriver.CS[i].Par.CS.MoveCyclicVelocity.Deceleration							//RR 
//	gDriver.CS[i].Par.CS.MoveCyclicVelocity.DisableJoltLimitation					//ENUM 
//	gDriver.CS[i].Par.CS.MoveCyclicVelocity.InterpolationMode						//ENUM 
//	gDriver.CS[i].Par.CS.MoveCyclicVelocity.Jerk									//RR 
//	gDriver.CS[i].Par.CS.MoveCyclicVelocity.Mode									//ENUM 
//	gDriver.CS[i].Par.CS.TorqueControl.Acceleration									//RR 
//	gDriver.CS[i].Par.CS.TorqueControl.CmdIndependentActivation						//BO 
//	gDriver.CS[i].Par.CS.TorqueControl.Jerk											//RR 
//	gDriver.CS[i].Par.CS.TorqueControl.MaximumVelocity								//RR 
//	gDriver.CS[i].Par.CS.TorqueControl.MinimumVelocity								//RR 
//	gDriver.CS[i].Par.CS.TorqueControl.Options.CorrectVelocityLimits				//BO 
//	gDriver.CS[i].Par.CS.TorqueControl.Options.NoHomingCheck						//BO 
//	gDriver.CS[i].Par.CS.TorqueControl.Options.StartAlternativeValueSource			//ENUM 
//	gDriver.CS[i].Par.CS.TorqueControl.Options.TimeLimit							//RR 
//	gDriver.CS[i].Par.CS.TorqueControl.Options.TorqueAlternativeValueSource			//ENUM 
//	gDriver.CS[i].Par.CS.TorqueControl.Options.UseTimeLimit							//BO 
//	gDriver.CS[i].Par.CS.TorqueControl.Options.UseVelocityLimits					//BO 
//	gDriver.CS[i].Par.CS.TorqueControl.TorqueRamp									//RR 
//	gDriver.CS[i].Par.CS.TorqueControl.TorqueResolution								//RR 
//	gDriver.CS[i].Par.CS.TorqueFeedForward.InterpolationMode						//ENUM 
//	gDriver.CS[i].Par.CS.TorqueFeedForward.Options.DisableMode						//ENUM 
//	gDriver.CS[i].Par.CyclicPositionSource											//DINT 
//	gDriver.CS[i].Par.CyclicTorqueSource											//DINT 
//	gDriver.CS[i].Par.CyclicTorqueFeedForwardSource									//DINT 
//	gDriver.CS[i].Par.CyclicVelocitySource											//DINT 

END_ACTION
