
ACTION OMD_BX:

	FOR i := 0 TO MAX_DRIVER_BX_IDX DO
		IF NOT gDriver.BX[i].FirstScanComplete THEN
			gDriver.BX[i].FirstScanComplete 				:= TRUE;
			gDriver.BX[i].DefaultPar.EdgeFindMode			:= FALSE; 	//BO
			gDriver.BX[i].DefaultPar.ISOPulseMode			:= FALSE; 	//BO
			gDriver.BX[i].DefaultPar.ElectrodePositiveMode	:= FALSE; 	//BO
			gDriver.BX[i].DefaultPar.Current				:= 0.0; 	//RR
			gDriver.BX[i].DefaultPar.OnTime					:= 0.0; 	//RR
			gDriver.BX[i].DefaultPar.OffTime				:= 0.0; 	//RR
			gDriver.BX[i].DefaultPar.SetFeedback			:= 0.0; 	//RR
			gDriver.BX[i].DefaultPar.MinOverrideFactor		:= -1.0; 	//RR
			gDriver.BX[i].DefaultPar.MaxOverrideFactor		:= 1.0; 	//RR
			gDriver.BX[i].DefaultPar.PID.Gain				:= 0.1; 	//RR
			gDriver.BX[i].DefaultPar.PID.IntegrationTime	:= 0.0; 	//RR
			gDriver.BX[i].DefaultPar.PID.DerivativeTime		:= 0.0; 	//RR
			gDriver.BX[i].DefaultPar.PID.FilterTime			:= 0.0; 	//RR
			brsmemcpy(ADR(gDriver.BX[i].Par),ADR(gDriver.BX[i].DefaultPar),SIZEOF(gDriver.BX[i].Par));
		ELSIF NOT gDriver.BX[i].ParametersLoaded AND gMain.Services.Recipes.Out.ParametersReady THEN
			gDriver.BX[i].ParametersLoaded 					:= TRUE;
			brsmemcpy(ADR(gDriver.BX[i].Par),ADR(gPar.Driver.BX[i]),SIZEOF(gDriver.BX[i].Par));
		END_IF;

		brsmemset(ADR(gDriver.BX[i].Sev),0,SIZEOF(gDriver.BX[i].Sev));
		brsmemset(ADR(gDriver.BX[i].Status),0,SIZEOF(gDriver.BX[i].Status));
		FOR j := 0 TO MAX_DRIVER_BX_MON_IDX DO
			IF gDriver.BX[i].Par.Mon[j].Enable THEN
				IF gDriver.BX[i].Mon[j] THEN
					gDriver.BX[i].CTON_Mon[j](IN := TRUE, PT := LREAL_TO_TIME(gDriver.BX[i].Par.Mon[j].Time*1000.0));
					IF gDriver.BX[i].CTON_Mon[j].Q THEN
						gDriver.BX[i].Sev[j] 				:= gDriver.BX[i].Par.Mon[j].Sev;
						IF gDriver.BX[i].Status.Severity < gDriver.BX[i].Sev[j] THEN
							gDriver.BX[i].Status.Severity 	:= gDriver.BX[i].Sev[j];
						END_IF;
					END_IF;
				ELSE
					gDriver.BX[i].CTON_Mon[j](IN := FALSE);
					gDriver.BX[i].Sev[j] 					:= 0;
				END_IF;
			ELSE
				gDriver.BX[i].CTON_Mon[j](IN := FALSE);
				gDriver.BX[i].Sev[j] 						:= 0;
			END_IF;
		END_FOR;
		IF gDriver.BX[i].Cmd[C_BX_RESET] OR gDriver.ResetAll THEN
			gDriver.BX[i].Cmd[C_BX_RESET] 					:= FALSE;
			brsmemset(ADR(gDriver.BX[i].Mon),0,SIZEOF(gDriver.BX[i].Mon));
			brsmemset(ADR(gDriver.BX[i].Cmd),0,SIZEOF(gDriver.BX[i].Cmd));
			brsmemset(ADR(gDriver.BX[i].Sev),0,SIZEOF(gDriver.BX[i].Sev));
			brsmemset(ADR(gDriver.BX[i].Status),0,SIZEOF(gDriver.BX[i].Status));
		END_IF;
		IF gDriver.BX[i].Cmd[C_BX_CLEARCMD] THEN
			gDriver.BX[i].Cmd[C_BX_CLEARCMD] 				:= FALSE;
			brsmemset(ADR(gDriver.BX[i].Cmd),0,SIZEOF(gDriver.BX[i].Cmd));
		END_IF;
		IF gDriver.BX[i].Cmd[C_BX_CLEARMON] THEN
			gDriver.BX[i].Cmd[C_BX_CLEARMON] 				:= FALSE;
			brsmemset(ADR(gDriver.BX[i].Status.Severity),0,SIZEOF(gDriver.BX[i].Status.Severity));
			brsmemset(ADR(gDriver.BX[i].Sev),0,SIZEOF(gDriver.BX[i].Sev));
			brsmemset(ADR(gDriver.BX[i].Par.Mon),0,SIZEOF(gDriver.BX[i].Par.Mon));
		END_IF;
		IF gDriver.BX[i].Cmd[C_BX_DEFAULTMON] THEN
			gDriver.BX[i].Cmd[C_BX_DEFAULTMON] 				:= FALSE;
			brsmemcpy(ADR(gDriver.BX[i].Par.Mon),ADR(gDriver.BX[i].DefaultPar.Mon),SIZEOF(gDriver.BX[i].Par.Mon));
		END_IF;
		IF gDriver.BX[i].Cmd[C_BX_CLEARPAR] THEN
			gDriver.BX[i].Cmd[C_BX_CLEARPAR] 				:= FALSE;
			brsmemset(ADR(gDriver.BX[i].Par),0,SIZEOF(gDriver.BX[i].Par));
		END_IF;
		IF gDriver.BX[i].Cmd[C_BX_DEFAULTPAR] THEN
			gDriver.BX[i].Cmd[C_BX_DEFAULTPAR] 				:= FALSE;
			brsmemcpy(ADR(gDriver.BX[i].Par),ADR(gDriver.BX[i].DefaultPar),SIZEOF(gDriver.BX[i].Par));
		END_IF;
		IF gDriver.BX[i].Cmd[C_BX_SAVEPAR] THEN
			gDriver.BX[i].Cmd[C_BX_SAVEPAR] 				:= FALSE;
			brsmemcpy(ADR(gPar.Driver.BX[i]),ADR(gDriver.BX[i].Par),SIZEOF(gDriver.BX[i].Par));
		END_IF;
		IF gDriver.BX[i].Cmd[C_BX_LOADPAR] THEN
			gDriver.BX[i].Cmd[C_BX_LOADPAR] 				:= FALSE;
			brsmemcpy(ADR(gDriver.BX[i].Par),ADR(gPar.Driver.BX[i]),SIZEOF(gDriver.BX[i].Par));
		END_IF;
		
		gDriver.BX[i].Status.SetOffTime						:= gDriver.BX[i].Par.OffTime;
		gDriver.BX[i].Status.SetOnTime						:= gDriver.BX[i].Par.OnTime;
		gDriver.BX[i].Status.SetCurrent						:= gDriver.BX[i].Par.Current;
		gDriver.BX[i].Status.SetFeedback					:= gDriver.BX[i].Par.SetFeedback;
		gDriver.BX[i].Status.ActualPower					:= LREAL_TO_REAL(gIO.BX18.TC_IO_AI_Power.Signal.Filtered);
		gDriver.BX[i].Status.ActualFeedback					:= LREAL_TO_REAL(gIO.BX18.TC_IO_AI_Feedback.Signal.Filtered);
		gDriver.BX[i].Status.OutputActive					:= gIO.BX18.TC_IO_DI_EDMOutputActive.Signal.Filtered;
		gDriver.BX[i].Status.EdgeFindEnabled				:= gIO.BX18.TC_IO_DI_EdgefindModeEnabled.Signal.Filtered;
		gDriver.BX[i].Status.EdgeFound						:= gIO.BX18.TC_IO_DI_EdgeFound.Signal.Filtered;
		gDriver.BX[i].Status.StateInvalid					:= gIO.BX18.TC_IO_DI_ReqStateInvalid.Signal.Filtered;
		gDriver.BX[i].Status.SettingsInvalid				:= gIO.BX18.TC_IO_DI_ReqSettingsInvalid.Signal.Filtered;
		gDriver.BX[i].Status.PowerFault						:= gIO.BX18.TC_IO_DI_PowerFault.Signal.Filtered;
		gDriver.BX[i].Status.LowVoltageFault				:= gIO.BX18.TC_IO_DI_LowVoltageFault.Signal.Filtered;
		gDriver.BX[i].Status.HighVoltageFault				:= gIO.BX18.TC_IO_DI_HighVoltageFault.Signal.Filtered;
		gDriver.BX[i].Status.EstopActive					:= gIO.BX18.TC_IO_DI_EstopActive.Signal.Filtered;
		gDriver.BX[i].Status.ISOPulseMode					:= gIO.BX18.TC_IO_DI_ISOPulseMode.Signal.Filtered;
		gDriver.BX[i].Status.ElectrodePositiveMode			:= gIO.BX18.TC_IO_DI_ElectrodePositiveMode.Signal.Filtered;
				
		IF gDriver.BX[i].MTBasicsPID_0.PIDParameters.Gain <> gDriver.BX[i].Par.PID.Gain OR gDriver.BX[i].MTBasicsPID_0.PIDParameters.IntegrationTime <> gDriver.BX[i].Par.PID.IntegrationTime OR gDriver.BX[i].MTBasicsPID_0.PIDParameters.DerivativeTime <> gDriver.BX[i].Par.PID.DerivativeTime OR gDriver.BX[i].MTBasicsPID_0.PIDParameters.FilterTime <> gDriver.BX[i].Par.PID.FilterTime OR gDriver.BX[i].MTBasicsPID_0.MinOut <> gDriver.BX[i].Par.MinOverrideFactor OR gDriver.BX[i].MTBasicsPID_0.MaxOut <> gDriver.BX[i].Par.MaxOverrideFactor THEN
			gDriver.BX[i].MTBasicsPID_0.Update 				:= TRUE;
		END_IF;
		gDriver.BX[i].MTBasicsPID_0(Enable := gDriver.BX[i].Cmd[C_BX_ENABLE] AND gDriver.BX[i].Wait[W_BX_NOERROR] = 1, PIDParameters := gDriver.BX[i].Par.PID, MinOut := gDriver.BX[i].Par.MinOverrideFactor, MaxOut := gDriver.BX[i].Par.MaxOverrideFactor, SetValue := gDriver.BX[i].Par.SetFeedback, ActValue := gDriver.BX[i].Status.ActualFeedback);
		gDriver.BX[i].MTBasicsPID_0.Update 					:= FALSE;			   

		gDriver.BX[i].Status.OverrideFactor					:= gDriver.BX[i].MTBasicsPID_0.Out;
			
		gDriver.BX[i].Wait[W_BX_NOERROR]					:= BOOL_TO_DINT(NOT gDriver.BX[i].Status.StateInvalid AND NOT gDriver.BX[i].Status.SettingsInvalid AND NOT gDriver.BX[i].Status.PowerFault AND NOT gDriver.BX[i].Status.LowVoltageFault AND NOT gDriver.BX[i].Status.HighVoltageFault AND NOT gDriver.BX[i].Status.EstopActive);
		gDriver.BX[i].Wait[W_BX_ACTIVE]						:= BOOL_TO_DINT(gDriver.BX[i].Wait[W_BX_NOERROR] = 1 AND gDriver.BX[i].Status.OutputActive);
		gDriver.BX[i].Mon[M_BX_ERROR]						:= gDriver.BX[i].Wait[W_BX_NOERROR] <> 1;

		gIO.BX18.TC_IO_AO_Current.Logical					:= gDriver.BX[i].Par.Current;
		gIO.BX18.TC_IO_AO_OffTime.Logical					:= gDriver.BX[i].Par.OffTime;
		gIO.BX18.TC_IO_AO_OnTime.Logical					:= gDriver.BX[i].Par.OnTime;
		gIO.BX18.TC_IO_DO_ChangeRequest.Logical				:= gIO.BX18.TC_IO_DI_CurrentChanged.Signal.Filtered OR gIO.BX18.TC_IO_DI_OnTimeChanged.Signal.Filtered OR gIO.BX18.TC_IO_DI_OffTimeChanged.Signal.Filtered;
		gIO.BX18.TC_IO_DO_EdgeFindMode.Logical				:= gDriver.BX[i].Par.EdgeFindMode;
		gIO.BX18.TC_IO_DO_ElectrodePositiveMode.Logical		:= gDriver.BX[i].Par.ElectrodePositiveMode;
		gIO.BX18.TC_IO_DO_ISOFreqMode.Logical				:= gDriver.BX[i].Par.ISOPulseMode;
		gIO.BX18.TC_IO_DO_Enable.Logical					:= gDriver.BX[i].Cmd[C_BX_ENABLE];
	END_FOR;

END_ACTION
