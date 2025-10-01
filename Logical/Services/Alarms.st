
ACTION Alarms:  
	// Reactions
	gMain.Services.Alarms.Out.AlarmActive 												:= gMain.Process.Monitor.Out.SevActiveAny;
	gMain.Services.Alarms.Internal.MpAlarmXHistory_0.DeviceName 						:= ADR(gMain.Services.DeviceName);
	gMain.Services.Alarms.Internal.MpAlarmXHistory_0.FileName 							:= ADR('AlarmHistory/Alarms.csv');
	gMain.Services.Alarms.Internal.MpAlarmXHistory_0.Overwrite							:= FALSE;
	gMain.Services.Alarms.Internal.MpAlarmXHistory_0.Language							:= ADR(gPar.System.LanguageCode);
	// Case for handling the alarm history
	CASE gMain.Services.Alarms.Internal.StateExportHistory OF
		0:
			IF gMain.Services.Alarms.In.ExportHistory THEN
				TC_AlarmX_Helper(gAlarmXCore,'',TC_ALARMX_ACTION_LOG_ONLY,'HISTORY EXPORTED',FALSE);
				gMain.Services.Alarms.In.ExportHistory 									:= FALSE;
				gMain.Services.Alarms.Internal.MpAlarmXHistory_0.Export 				:= TRUE;
				gMain.Services.Alarms.Internal.StateExportHistory 						:= 10;
			ELSIF gMain.Services.Alarms.In.ClearHistory THEN
				TC_AlarmX_Helper(gAlarmXCore,'',TC_ALARMX_ACTION_LOG_ONLY,'HISTORY CLEARED',FALSE);
				gMain.Services.Alarms.In.ClearHistory 									:= FALSE;
				gMain.Services.Alarms.Internal.MpAlarmXHistory_0.Clear					:= TRUE;
			END_IF;
		10:
			IF gMain.Services.Alarms.Internal.MpAlarmXHistory_0.CommandDone OR gMain.Services.Alarms.Internal.MpAlarmXHistory_0.Error THEN
				gMain.Services.Alarms.Internal.MpAlarmXHistory_0.Export 				:= FALSE;
				gMain.Services.Alarms.Internal.StateExportHistory 						:= 0;
				gMain.Services.Alarms.Internal.MpAlarmXHistory_0.Clear					:= 0;
			END_IF;
	END_CASE;

	IF gMain.ErrorReset THEN
		gMain.Services.Alarms.In.ResetAlarms 											:= TRUE;
	END_IF;

	// Case for handling the alarm resetting
	CASE gMain.Services.Alarms.Internal.StateResetAlarms OF
		0:
			IF gMain.Services.Alarms.In.ResetAlarms OR gMain.ErrorReset THEN
				TC_AlarmX_Helper(gAlarmXCore,'',TC_ALARMX_ACTION_LOG_ONLY,'ACKNOWLEDGE ALL',FALSE);
				gMain.Services.Alarms.In.ResetAlarms 									:= FALSE;
				gVis.Alarms.Active.UIConnect.AcknowledgeAll 							:= TRUE;
				gMain.Services.Alarms.Internal.CTON_ResetDelay(IN := FALSE);
				gMain.Services.Alarms.Internal.StateResetAlarms 						:= 10;
			END_IF;
		10:
			// give UI time to process the reset
			IF gMain.Services.Alarms.Internal.CTON_ResetDelay.Q THEN
				gMain.Services.Alarms.Internal.CTON_ResetDelay(IN := FALSE);
				gMain.Services.Alarms.Internal.StateResetAlarms 						:= 0;
				gMain.ErrorReset := FALSE;
			ELSE
				gMain.Services.Alarms.Internal.CTON_ResetDelay(IN := TRUE, PT := T#250ms);
			END_IF;
	END_CASE;
	
	gMain.Services.Alarms.Internal.MpAlarmXListUI_0.Language							:= ADR(gPar.System.LanguageCode);

	gMain.Services.Alarms.Internal.CTON_StartDelay(IN := TRUE, PT := T#1000ms);
	IF gMain.Services.Alarms.Internal.CTON_StartDelay.Q THEN
		gMain.Services.Alarms.Out.BufferInfo.Address	:= ADR(gMain.Services.Alarms.In.AlarmList);
		gMain.Services.Alarms.Out.BufferInfo.Size		:= SIZEOF(gMain.Services.Alarms.In.AlarmList);
		gMain.Services.Alarms.Internal.TC_AlarmXCore_0.delayTime := LREAL_TO_TIME(0.5*1000.0);
		gMain.Services.Alarms.Internal.TC_AlarmXCore_0(MpLink := gAlarmXCore, enable := TRUE, pBuffer := ADR(gMain.Services.Alarms.In.AlarmList), pOutputData := ADR(gAlarmAddData));
	END_IF;
	gMain.Services.Alarms.Internal.MpAlarmXCore_0(MpLink := ADR(gAlarmXCore), Enable := TRUE, ErrorReset := gMain.ErrorReset);
	gMain.Services.Alarms.Internal.MpAlarmXListUI_0(MpLink := ADR(gAlarmXCore), Enable := TRUE, ErrorReset := gMain.ErrorReset, UIConnect := ADR(gVis.Alarms.Active.UIConnect));
	gMain.Services.Alarms.Internal.MpAlarmXHistory_0(MpLink := ADR(gAlarmXHistory), Enable := TRUE, ErrorReset := gMain.ErrorReset);
	gMain.Services.Alarms.Internal.MpAlarmXHistoryUI_0(MpLink := ADR(gAlarmXHistory), Enable := TRUE, ErrorReset := gMain.ErrorReset, UIConnect := ADR(gVis.Alarms.History.UIConnect));

END_ACTION
