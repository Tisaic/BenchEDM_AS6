ACTION OMD_TR:

//	FOR i := 0 TO MAX_DRIVER_TR_IDX DO
//		IF gIO.SpacePilot.TC_IO_DI_Button[BUTTON_ESC].Signal.EdgePosFiltered THEN
//			gDriver.TR[i].Cmd[C_TR_RESET] := TRUE;
//		END_IF;
//	
//		IF gIO.SpacePilot.TC_IO_DI_Button[BUTTON_CTRL].Signal.EdgePosFiltered THEN
//			gDriver.TR[i].Cmd[C_TR_ENABLE] := NOT gDriver.TR[i].Cmd[C_TR_ENABLE];
//		END_IF;
//	
//		IF gIO.SpacePilot.TC_IO_DI_Button[BUTTON_ROT].Signal.EdgePosFiltered THEN
//			gDriver.TR[i].Par.ControlMode := TR_CONTROL_MODE_ROTATE;
//		ELSIF gIO.SpacePilot.TC_IO_DI_Button[BUTTON_TRANS].Signal.EdgePosFiltered THEN
//			gDriver.TR[i].Par.ControlMode := TR_CONTROL_MODE_TRANS;
//		ELSIF gIO.SpacePilot.TC_IO_DI_Button[BUTTON_COORD].Signal.EdgePosFiltered THEN
//			gDriver.TR[i].Par.ControlMode := TR_CONTROL_MODE_COORD;
//		END_IF;
//	
//		IF gIO.SpacePilot.TC_IO_DI_Button[BUTTON_PLUS].Signal.EdgePosFiltered THEN
//			gDriver.TR[i].Par.VelocityFactor := gDriver.TR[i].Par.VelocityFactor + 0.00001;
//		ELSIF gIO.SpacePilot.TC_IO_DI_Button[BUTTON_MINUS].Signal.EdgePosFiltered THEN
//			gDriver.TR[i].Par.VelocityFactor := gDriver.TR[i].Par.VelocityFactor - 0.00001;
//		END_IF;
//
//		FOR j := 0 TO MAX_AXIS_V_IDX DO
//			gDriver.TR[i].Status.InputCmd[j] := gIO.SpacePilot.TC_IO_AI_Joystick[j].Signal.Filtered;
//		END_FOR;
//
//		IF NOT gDriver.TR[i].FirstScanComplete THEN
//			gDriver.TR[i].FirstScanComplete 													:= TRUE;	
//			gDriver.TR[i].DefaultPar.ControlMode												:= TR_CONTROL_MODE_COORD; 	//TR_CONTROL_MODE_ENUM 
//			gDriver.TR[i].DefaultPar.Filter														:= 0.99;						//LR
//			gDriver.TR[i].DefaultPar.VelocityFactor												:= 0.00005;					//LR
//			gDriver.TR[i].DefaultPar.Gain														:= 10.0;						//RR
//			gDriver.TR[i].DefaultPar.IntegralTime												:= 0.1;						//RR
//			brsmemcpy(ADR(gDriver.TR[i].Par),ADR(gDriver.TR[i].DefaultPar),SIZEOF(gDriver.TR[i].Par));
//			
//			brsmemcpy(ADR(gDriver.TR[i].Par),ADR(gDriver.TR[i].DefaultPar),SIZEOF(gDriver.TR[i].Par));
//		ELSIF NOT gDriver.TR[i].ParametersLoaded AND gMain.Services.Recipes.Out.ParametersReady THEN
//			gDriver.TR[i].ParametersLoaded := TRUE;
//			brsmemcpy(ADR(gDriver.TR[i].Par),ADR(gPar.Driver.TR[i]),SIZEOF(gDriver.TR[i].Par));
//		END_IF;
//
//		brsmemset(ADR(gDriver.TR[i].Sev),0,SIZEOF(gDriver.TR[i].Sev));
//		FOR j := 0 TO MAX_DRIVER_TR_MON_IDX DO
//			IF gDriver.TR[i].Par.Mon[j].Enable THEN
//				IF gDriver.TR[i].Mon[j] THEN
//					gDriver.TR[i].CTON_Mon[j](IN := TRUE, PT := LREAL_TO_TIME(gDriver.TR[i].Par.Mon[j].Time*1000.0));
//					IF gDriver.TR[i].CTON_Mon[j].Q THEN
//						gDriver.TR[i].Sev[j] := gDriver.TR[i].Par.Mon[j].Sev;
//						IF gDriver.TR[i].Status.Severity < gDriver.TR[i].Sev[j] THEN
//							gDriver.TR[i].Status.Severity := gDriver.TR[i].Sev[j];
//						END_IF;
//					END_IF;
//				ELSE
//					gDriver.TR[i].CTON_Mon[j](IN := FALSE);
//					gDriver.TR[i].Sev[j] := 0;
//				END_IF;
//			ELSE
//				gDriver.TR[i].CTON_Mon[j](IN := FALSE);
//				gDriver.TR[i].Sev[j] := 0;
//			END_IF;
//		END_FOR;
//		
//		IF gDriver.TR[i].Cmd[C_TR_RESET] OR gDriver.ResetAll THEN
//			gDriver.TR[i].Cmd[C_TR_RESET] := FALSE;
//			brsmemset(ADR(gDriver.TR[i].Mon),0,SIZEOF(gDriver.TR[i].Mon));
//			brsmemset(ADR(gDriver.TR[i].Cmd),0,SIZEOF(gDriver.TR[i].Cmd));
//			brsmemset(ADR(gDriver.TR[i].Sev),0,SIZEOF(gDriver.TR[i].Sev));
//			brsmemset(ADR(gDriver.TR[i].Status),0,SIZEOF(gDriver.TR[i].Status));
//		END_IF;
//		IF gDriver.TR[i].Cmd[C_TR_CLEARCMD] THEN
//			gDriver.TR[i].Cmd[C_TR_CLEARCMD] := FALSE;
//			brsmemset(ADR(gDriver.TR[i].Cmd),0,SIZEOF(gDriver.TR[i].Cmd));
//		END_IF;
//		IF gDriver.TR[i].Cmd[C_TR_CLEARMON] THEN
//			gDriver.TR[i].Cmd[C_TR_CLEARMON] := FALSE;
//			brsmemset(ADR(gDriver.TR[i].Status.Severity),0,SIZEOF(gDriver.TR[i].Status.Severity));
//			brsmemset(ADR(gDriver.TR[i].Sev),0,SIZEOF(gDriver.TR[i].Sev));
//			brsmemset(ADR(gDriver.TR[i].Par.Mon),0,SIZEOF(gDriver.TR[i].Par.Mon));
//		END_IF;
//		IF gDriver.TR[i].Cmd[C_TR_DEFAULTMON] THEN
//			gDriver.TR[i].Cmd[C_TR_DEFAULTMON] := FALSE;
//			brsmemcpy(ADR(gDriver.TR[i].Par.Mon),ADR(gDriver.TR[i].DefaultPar.Mon),SIZEOF(gDriver.TR[i].Par.Mon));
//		END_IF;
//		IF gDriver.TR[i].Cmd[C_TR_CLEARPAR] THEN
//			gDriver.TR[i].Cmd[C_TR_CLEARPAR] := FALSE;
//			brsmemset(ADR(gDriver.TR[i].Par),0,SIZEOF(gDriver.TR[i].Par));
//		END_IF;
//		IF gDriver.TR[i].Cmd[C_TR_DEFAULTPAR] THEN
//			gDriver.TR[i].Cmd[C_TR_DEFAULTPAR] := FALSE;
//			brsmemcpy(ADR(gDriver.TR[i].Par),ADR(gDriver.TR[i].DefaultPar),SIZEOF(gDriver.TR[i].Par));
//		END_IF;
//		IF gDriver.TR[i].Cmd[C_TR_SAVEPAR] THEN
//			gDriver.TR[i].Cmd[C_TR_SAVEPAR] := FALSE;
//			brsmemcpy(ADR(gPar.Driver.TR[i]),ADR(gDriver.TR[i].Par),SIZEOF(gDriver.TR[i].Par));
//		END_IF;
//		IF gDriver.TR[i].Cmd[C_TR_LOADPAR] THEN
//			gDriver.TR[i].Cmd[C_TR_LOADPAR] := FALSE;
//			brsmemcpy(ADR(gDriver.TR[i].Par),ADR(gPar.Driver.TR[i]),SIZEOF(gDriver.TR[i].Par));
//		END_IF;
//
////
//// Implementation
////
//	    gDriver.TR[i].Status.McPathGenCusMechDir.Input.JointPos := gDriver.CN[i].Status.Position_mcJACS;
//	    gDriver.TR[i].Status.McPathGenCusMechDir.Input.TcpRefPos := gDriver.TR[i].Status.McPathGenCusMechDir.Output.TcpPos;
//	    gDriver.TR[i].Status.McPathGenCusMechDir.Parameter.CustomDataAddr := ADR(gDriver.TR[i].Status.CusMechData);
//	    gDriver.TR[i].Status.McPathGenCusMechDir.Parameter.JointCount := MAX_AXIS_V_IDX+1;
//	    customDirect(gDriver.TR[i].Status.McPathGenCusMechDir);
//
//		IF gDriver.TR[i].Cmd[C_TR_ENABLE] THEN
//			IF NOT gDriver.TR[i].Status.Active THEN
//				gDriver.TR[i].Status.TcpSetpoint := gDriver.TR[i].Status.McPathGenCusMechDir.Output.TcpPos;
//				gDriver.TR[i].Status.TcpSetpointLastStable := gDriver.TR[i].Status.McPathGenCusMechDir.Output.TcpPos;
//				brsmemset(ADR(gDriver.TR[i].Status.VelCmd),0,SIZEOF(gDriver.TR[i].Status.VelCmd));
//			ELSE
//				FOR j := 0 TO 14 DO
//					IF j <=2 THEN
//						IF gDriver.TR[i].Par.ControlMode = TR_CONTROL_MODE_COORD OR gDriver.TR[i].Par.ControlMode = TR_CONTROL_MODE_TRANS THEN
//							gDriver.TR[i].Status.LimitedCmd[j] := gDriver.TR[i].Status.InputCmd[j]*gDriver.TR[i].Par.VelocityFactor*20.0;
//						ELSE
//							gDriver.TR[i].Status.LimitedCmd[j] := 0.0;
//						END_IF;
//					ELSE
//						IF gDriver.TR[i].Par.ControlMode = TR_CONTROL_MODE_COORD OR gDriver.TR[i].Par.ControlMode = TR_CONTROL_MODE_ROTATE THEN
//							gDriver.TR[i].Status.LimitedCmd[j] := gDriver.TR[i].Status.InputCmd[j]*gDriver.TR[i].Par.VelocityFactor;
//						ELSE
//							gDriver.TR[i].Status.LimitedCmd[j] := 0.0;
//						END_IF;
//					END_IF;
//					IF gDriver.TR[i].Status.MTBasicsPID_0[j].PIDParameters.Gain <> gDriver.TR[i].Par.Gain THEN
//						gDriver.TR[i].Status.MTBasicsPID_0[j].PIDParameters.Gain := gDriver.TR[i].Par.Gain;
//						gDriver.TR[i].Status.MTBasicsPID_0[j].Update := TRUE;
//					END_IF;
//					IF gDriver.TR[i].Status.MTBasicsPID_0[j].PIDParameters.IntegrationTime <> gDriver.TR[i].Par.IntegralTime THEN
//						gDriver.TR[i].Status.MTBasicsPID_0[j].PIDParameters.IntegrationTime := gDriver.TR[i].Par.IntegralTime;
//						gDriver.TR[i].Status.MTBasicsPID_0[j].Update := TRUE;
//					END_IF;
//					gDriver.TR[i].Status.MTBasicsPID_0[j](Enable := TRUE, SetValue := 0.05, ActValue := ABS(LREAL_TO_REAL(gDriver.TR[i].Status.Lag[j])), MinOut := -0.999, MaxOut := 0.0);
//					gDriver.TR[i].Status.MTBasicsPID_0[j].Update := FALSE;
//					gDriver.TR[i].Status.Override := 1.0;
//					FOR k := 0 TO 14 DO
//						IF gDriver.TR[i].Status.Override > (1.0+gDriver.TR[i].Status.MTBasicsPID_0[k].Out) THEN
//							gDriver.TR[i].Status.Override := (1.0+gDriver.TR[i].Status.MTBasicsPID_0[k].Out);
//						END_IF;
//					END_FOR;
//					gDriver.TR[i].Status.LimitedCmd[j] := gDriver.TR[i].Status.LimitedCmd[j]*gDriver.TR[i].Status.Override;
//					gDriver.TR[i].Status.VelCmd[j] := gDriver.TR[i].Par.Filter*gDriver.TR[i].Status.VelCmd[j] + (1.0-gDriver.TR[i].Par.Filter)*gDriver.TR[i].Status.LimitedCmd[j];
//				END_FOR;
//				IF gDriver.TR[i].Par.WorldCoordMode THEN
//				    gDriver.TR[i].Status.VelCmd_World := gDriver.TR[i].Status.VelCmd;
//				ELSE
//	    			BuildTransform(gDriver.TR[i].Status.TcpSetpoint[0], gDriver.TR[i].Status.TcpSetpoint[1], gDriver.TR[i].Status.TcpSetpoint[2], gDriver.TR[i].Status.TcpSetpoint[3], gDriver.TR[i].Status.TcpSetpoint[4], gDriver.TR[i].Status.TcpSetpoint[5], ADR(gDriver.TR[i].Status.TcpMatrix));
//				    gDriver.TR[i].Status.VelCmd_World[0] := gDriver.TR[i].Status.TcpMatrix[0,0]*gDriver.TR[i].Status.VelCmd[0] + gDriver.TR[i].Status.TcpMatrix[0,1]*gDriver.TR[i].Status.VelCmd[1] + gDriver.TR[i].Status.TcpMatrix[0,2]*gDriver.TR[i].Status.VelCmd[2];
//				    gDriver.TR[i].Status.VelCmd_World[1] := gDriver.TR[i].Status.TcpMatrix[1,0]*gDriver.TR[i].Status.VelCmd[0] + gDriver.TR[i].Status.TcpMatrix[1,1]*gDriver.TR[i].Status.VelCmd[1] + gDriver.TR[i].Status.TcpMatrix[1,2]*gDriver.TR[i].Status.VelCmd[2];
//				    gDriver.TR[i].Status.VelCmd_World[2] := gDriver.TR[i].Status.TcpMatrix[2,0]*gDriver.TR[i].Status.VelCmd[0] + gDriver.TR[i].Status.TcpMatrix[2,1]*gDriver.TR[i].Status.VelCmd[1] + gDriver.TR[i].Status.TcpMatrix[2,2]*gDriver.TR[i].Status.VelCmd[2];
//				    gDriver.TR[i].Status.VelCmd_World[3] := gDriver.TR[i].Status.TcpMatrix[0,0]*gDriver.TR[i].Status.VelCmd[3] + gDriver.TR[i].Status.TcpMatrix[0,1]*gDriver.TR[i].Status.VelCmd[4] + gDriver.TR[i].Status.TcpMatrix[0,2]*gDriver.TR[i].Status.VelCmd[5];
//				    gDriver.TR[i].Status.VelCmd_World[4] := gDriver.TR[i].Status.TcpMatrix[1,0]*gDriver.TR[i].Status.VelCmd[3] + gDriver.TR[i].Status.TcpMatrix[1,1]*gDriver.TR[i].Status.VelCmd[4] + gDriver.TR[i].Status.TcpMatrix[1,2]*gDriver.TR[i].Status.VelCmd[5];
//				    gDriver.TR[i].Status.VelCmd_World[5] := gDriver.TR[i].Status.TcpMatrix[2,0]*gDriver.TR[i].Status.VelCmd[3] + gDriver.TR[i].Status.TcpMatrix[2,1]*gDriver.TR[i].Status.VelCmd[4] + gDriver.TR[i].Status.TcpMatrix[2,2]*gDriver.TR[i].Status.VelCmd[5];
//				END_IF;
//	
//			    FOR j := 0 TO 14 DO
//			        IF gDriver.TR[i].Status.InverseStatus <> mcPATHGEN_CUSMECH_ERROR THEN
//			            gDriver.TR[i].Status.TcpSetpoint[j] := gDriver.TR[i].Status.TcpSetpoint[j] + gDriver.TR[i].Status.VelCmd_World[j];
//			        ELSE
//			            gDriver.TR[i].Status.TcpSetpoint[j] := gDriver.TR[i].Status.TcpSetpointLastStable[j] + gDriver.TR[i].Status.VelCmd_World[j];
//			        END_IF;
//			    END_FOR;
//			    gDriver.TR[i].Status.McPathGenCusMechInv.Parameter.CustomDataAddr := ADR(gDriver.TR[i].Status.CusMechData);
//			    gDriver.TR[i].Status.McPathGenCusMechInv.Input.JointRefPos := gDriver.TR[i].Status.McPathGenCusMechDir.Input.JointPos;
//			    gDriver.TR[i].Status.McPathGenCusMechInv.Parameter.JointCount := MAX_AXIS_V_IDX+1;
//			    gDriver.TR[i].Status.McPathGenCusMechInv.Input.TcpPos := gDriver.TR[i].Status.TcpSetpoint;
//			    gDriver.TR[i].Status.InverseStatus := customInverse(gDriver.TR[i].Status.McPathGenCusMechInv);
//			    IF gDriver.TR[i].Status.InverseStatus <> mcPATHGEN_CUSMECH_ERROR THEN
//					gDriver.TR[i].Status.TcpSetpointLastStable := gDriver.TR[i].Status.TcpSetpoint;
//			        gDriver.TR[i].Status.SetTCP := gDriver.TR[i].Status.McPathGenCusMechInv.Input.TcpPos;
//			        gDriver.TR[i].Status.SetJoint := gDriver.TR[i].Status.McPathGenCusMechInv.Output.JointPos;
//			    	gDriver.TR[i].Status.TotalLag := 0.0;
//					FOR j := 0 TO 14 DO
//			        	gDriver.TR[i].Status.Lag[j] := gDriver.TR[i].Status.SetJoint[j]-gDriver.TR[i].Status.McPathGenCusMechDir.Input.JointPos[j];
//			    		gDriver.TR[i].Status.TotalLag := gDriver.TR[i].Status.TotalLag + ABS(gDriver.TR[i].Status.Lag[j]);
//					END_FOR;
//			    END_IF;
//			END_IF;
//			gDriver.TR[i].Status.Active := TRUE;
//		ELSE
//			brsmemset(ADR(gDriver.TR[i].Status),0,SIZEOF(gDriver.TR[i].Status));
//		END_IF;
//
//		gDriver.TR[i].Wait[W_TR_NOERROR] := BOOL_TO_DINT(gDriver.TR[i].Status.InverseStatus <> mcPATHGEN_CUSMECH_ERROR);
//		gDriver.TR[i].Mon[M_TR_ERROR] := gDriver.TR[i].Status.InverseStatus = mcPATHGEN_CUSMECH_ERROR;
//	END_FOR;

END_ACTION