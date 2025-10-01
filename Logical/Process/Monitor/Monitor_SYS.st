
ACTION Monitor_SYS:

	FOR i := 0 TO MAX_MON_IDX DO
		IF gMain.Process.Monitor.Internal.TC_Mon_0[i].Forcing.Off AND gMain.Process.Monitor.Internal.TC_Mon_0[i].Forcing.On THEN
			gMain.Process.Monitor.Internal.TC_Mon_0[i].Forcing.Off					:= FALSE;
			gMain.Process.Monitor.Internal.TC_Mon_0[i].Forcing.On					:= FALSE;
		END_IF;			
//		gMain.Process.Monitor.Internal.TC_Mon_0[i].Sim.Active						:= gSim.Full;
//		gMain.Process.Monitor.Internal.TC_Mon_0[i].Sim.Logical						:= gMain.Process.Monitor.Internal.TC_Mon_0[i].Logical;
		IF i <= ((SIZEOF(gES.MON_ENUM) / 33) - 1) THEN
			gMain.Process.Monitor.Internal.TC_Mon_0[i].ES_ID						:= gES.MON_ENUM[i];
		END_IF;
		IF MAX_PROCESS_IDX <= MAX_TC_MON_PROCESS_IDX THEN	
			FOR j := 0 TO MAX_PROCESS_IDX DO
				IF j <= ((SIZEOF(gES.PROCESS_ENUM) / 33) - 1) THEN
					gMain.Process.Monitor.Internal.TC_Mon_0[i].Mask[j].ES_ID		:= gES.PROCESS_ENUM[j];
				END_IF;	
			END_FOR;
			IF gMain.Services.Recipes.Out.ParametersReady THEN
				gMain.Process.Monitor.Internal.TC_Mon_0[i].Par 						:= gPar.Process.Monitor.Mon[i];
			END_IF;
			gMain.Process.Monitor.Internal.TC_Mon_0[i](EdgeReset := gMain.ErrorReset);
			IF gMain.Process.Monitor.Internal.TC_Mon_0[i].ES_ID <> '' THEN
				IF gMain.Process.Monitor.Internal.TC_Mon_0[i].Signal.Result THEN
					FOR j := 0 TO MAX_PROCESS_IDX DO
						IF gMain.Process.Monitor.Out.ProcessErrorSev[j] < gMain.Process.Monitor.Internal.TC_Mon_0[i].Mask[j].Sev THEN
							gMain.Process.Monitor.Out.ProcessErrorSev[j] 			:= gMain.Process.Monitor.Internal.TC_Mon_0[i].Mask[j].Sev;
						END_IF;
					END_FOR;
				END_IF;
				IF gMain.Process.Monitor.Internal.TC_Mon_0[i].Signal.EdgePosResult THEN
					brsmemset(ADR(gMain.Process.Monitor.Internal.tempAlarm),0,SIZEOF(gMain.Process.Monitor.Internal.tempAlarm));
					brsmemset(ADR(gMain.Process.Monitor.Internal.TempSTRING),0,SIZEOF(gMain.Process.Monitor.Internal.TempSTRING));
					gMain.Process.Monitor.Internal.TempSTRING 						:= DINT_TO_STRING(gMain.Process.Monitor.Internal.TC_Mon_0[i].Sev);
					gMain.Process.Monitor.Internal.tempAlarm.name					:= 'MonitorSeverity';
					TC_brsstrcat(ADR(gMain.Process.Monitor.Internal.tempAlarm.name),ADR(gMain.Process.Monitor.Internal.TempSTRING),SIZEOF(gMain.Process.Monitor.Internal.tempAlarm.name));
					gMain.Process.Monitor.Internal.tempAlarm.allowMultiple			:= TRUE;
					gMain.Process.Monitor.Internal.tempAlarm.addText[0]				:= gMain.Process.Monitor.Internal.TC_Mon_0[i].ES_ID;
					TC_Array_AddTop(ADR(gMain.Services.Alarms.In.AlarmList), SIZEOF(gMain.Services.Alarms.In.AlarmList), ADR(gMain.Process.Monitor.Internal.tempAlarm), SIZEOF(gMain.Process.Monitor.Internal.tempAlarm));
				END_IF;
			END_IF;
		END_IF;
	END_FOR;

	gMain.Process.Monitor.Out.SevActive[0] 											:= MpAlarmXCheckReaction(gAlarmXCore, 'Severity0');
	gMain.Process.Monitor.Out.SevActive[1] 											:= MpAlarmXCheckReaction(gAlarmXCore, 'Severity1');
	gMain.Process.Monitor.Out.SevActive[2] 											:= MpAlarmXCheckReaction(gAlarmXCore, 'Severity2');
	gMain.Process.Monitor.Out.SevActive[3] 											:= MpAlarmXCheckReaction(gAlarmXCore, 'Severity3');
	gMain.Process.Monitor.Out.SevActive[4] 											:= MpAlarmXCheckReaction(gAlarmXCore, 'Severity4');
	gMain.Process.Monitor.Out.SevActiveAny 											:= MpAlarmXCheckReaction(gAlarmXCore, 'SeverityAny');

	

END_ACTION
