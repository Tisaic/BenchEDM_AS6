
ACTION Time: 

	brsmemset(ADR(gMain.Services.Time.Out), 0, SIZEOF(gMain.Services.Time.Out));
	
	CASE gMain.Services.Time.Internal.state OF
	
		TIME_RESET_C:
		
			gMain.Services.Time.Out.Status.CurrentState		:= 'TIME_RESET_C';
			gMain.Services.Time.Out.Status.InReset			:= TRUE;
			
			brsmemset(ADR(gMain.Services.Time), 0, SIZEOF(gMain.Services.Time));
			
			gMain.Services.Time.Internal.state				:= TIME_CHECKPARREADY_W;
			
		TIME_CHECKPARREADY_W:
		
			gMain.Services.Time.Out.Status.CurrentState		:= 'TIME_CHECKPARREADY_W';
			gMain.Services.Time.Out.Status.Initializing		:= TRUE;
	
			gMain.Services.Time.Internal.CTON_Timeout.PT	:= T#30s;
			
			IF gMain.Services.Recipes.Out.ParametersReady THEN
				gMain.Services.Time.Internal.state			:= TIME_IDLE_I;
			ELSIF gMain.Services.Time.Internal.CTON_Timeout.Q THEN
				gMain.Services.Time.Out.Status.Error		:= TRUE;
				gMain.Services.Time.Out.ErrorInfo.Severity	:= 1;
				gMain.Services.Time.Out.ErrorInfo.Text		:= 'Timeout';
				gMain.Services.Time.Out.ErrorInfo.State		:= gMain.Services.Time.Out.Status.CurrentState;
				gMain.Services.Time.Internal.state			:= TIME_ERROR;
			END_IF			
			
		TIME_IDLE_I:
		
			gMain.Services.Time.Out.Status.CurrentState			:= 'TIME_IDLE_I';
			gMain.Services.Time.Out.Status.WaitingForCommand	:= TRUE;
			
			IF gMain.Services.Time.In.Cmd.setTime THEN
				gMain.Services.Time.In.Cmd.setTime				:= FALSE;
				gMain.Services.Time.Internal.state				:= TIME_SET_C;
			END_IF
			
		TIME_SET_C:
		
			gMain.Services.Time.Out.Status.CurrentState			:= 'TIME_SET_C';
			gMain.Services.Time.Out.Status.Processing			:= TRUE;
			
			gMain.Services.Time.Internal.DTSetTime_0.enable		:= TRUE;
			gMain.Services.Time.Internal.DTSetTime_0.DT1		:= gMain.Services.Time.In.Par.newTime;
			
			gMain.Services.Time.Internal.state					:= TIME_SET_W;

		TIME_SET_W:
		
			gMain.Services.Time.Out.Status.CurrentState			:= 'TIME_SET_W';
			gMain.Services.Time.Out.Status.Processing			:= TRUE;
			
			gMain.Services.Time.Internal.CTON_Timeout.PT		:= LREAL_TO_TIME(30.0*1000.0);
			
			IF gMain.Services.Time.Internal.DTSetTime_0.status = ERR_OK THEN
				gMain.Services.Time.Internal.DTSetTime_0.enable	:= FALSE;
				gMain.Services.Time.Internal.state				:= TIME_IDLE_I;
			ELSIF gMain.Services.Time.Internal.DTSetTime_0.status <> ERR_FUB_BUSY AND gMain.Services.Time.Internal.DTSetTime_0.status <> ERR_FUB_ENABLE_FALSE THEN
				gMain.Services.Time.Internal.DTSetTime_0.enable	:= FALSE;
				gMain.Services.Time.Out.ErrorInfo.Severity		:= 2;
				gMain.Services.Time.Out.ErrorInfo.Text			:= UINT_TO_STRING(gMain.Services.Time.Internal.DTSetTime_0.status);
				gMain.Services.Time.Out.ErrorInfo.State			:= gMain.Services.Time.Out.Status.CurrentState;
				gMain.Services.Time.Internal.state				:= TIME_ERROR;
			ELSIF gMain.Services.Time.Internal.CTON_Timeout.Q THEN
				gMain.Services.Time.Internal.DTSetTime_0.enable	:= FALSE;
				gMain.Services.Time.Out.ErrorInfo.Severity		:= 2;
				gMain.Services.Time.Out.ErrorInfo.Text			:= 'Timeout';
				gMain.Services.Time.Out.ErrorInfo.State			:= gMain.Services.Time.Out.Status.CurrentState;
				gMain.Services.Time.Internal.state				:= TIME_ERROR;
			END_IF
			
		TIME_ERROR:
		
			gMain.Services.Time.Out.Status.CurrentState			:= 'TIME_ERROR';
			gMain.Services.Time.Out.Status.InError				:= TRUE;

			IF gMain.ErrorReset THEN
				gMain.Services.Time.Internal.state				:= TIME_RESET_C;
			END_IF
	
	END_CASE;
	
	//Update Current Time output
	
	gMain.Services.Time.Out.Status.CurrentTime 		:= gMain.Services.Time.Internal.DTGetTime_0.DT1;
	
	IF gMain.Services.Time.Out.Status.CurrentTime > DT#2024-01-01-00:00:00 THEN
		gMain.Services.Time.Out.Status.TimeValid	:= TRUE;
	END_IF
	
	IF NOT gMain.Services.Time.Out.Status.WaitingForCommand THEN
		IF gMain.Services.Time.In.Cmd.setTime THEN
			gMain.Services.Time.In.Cmd.setTime												:= FALSE;
			gMain.Services.Time.Out.IgnoreInfo.Cmd											:= 'Set Time';			
			gMain.Services.Time.Out.IgnoreInfo.Reason										:= 'Not in Waiting for Command';
			gMain.Services.Time.Out.ErrorInfo.State											:= gMain.Services.Time.Out.Status.CurrentState;
			TC_AlarmX_Helper(gAlarmXCore,'TimeCmdIgnored',TC_ALARMX_ACTION_SET,'',TRUE);
		END_IF;
	END_IF;
	brsmemset(ADR(gMain.Services.Time.Internal.BlankCmdCmp),0,SIZEOF(gMain.Services.Time.Internal.BlankCmdCmp));
	IF brsmemcmp(ADR(gMain.Services.Time.Internal.BlankCmdCmp),ADR(gMain.Services.Time.In.Cmd),SIZEOF(gMain.Services.Time.In.Cmd)) <> 0 THEN
		gMain.Services.Time.Out.ErrorInfo.State													:= gMain.Services.Time.Out.Status.CurrentState;
		TC_AlarmX_Helper(gAlarmXCore,'TimeUnhandledCmd',TC_ALARMX_ACTION_SET,'',TRUE);
	END_IF;
	brsmemset(ADR(gMain.Services.Time.In.Cmd),0,SIZEOF(gMain.Services.Time.In.Cmd));
	
	IF gMain.Services.Time.Out.Status.Error THEN
		IF brsmemcmp(ADR(gMain.Services.Time.Internal.LastErrorInfo),ADR(gMain.Services.Time.Out.ErrorInfo),SIZEOF(gMain.Services.Time.Internal.LastErrorInfo)) <> 0 THEN
			brsmemcpy(ADR(gMain.Services.Time.Internal.LastErrorInfo),ADR(gMain.Services.Time.Out.ErrorInfo),SIZEOF(gMain.Services.Time.Internal.LastErrorInfo));
			CASE gMain.Services.Time.Out.ErrorInfo.Severity OF
				1:
					gMain.Services.Time.Internal.tempAlarm.name				:= 'TimeSeverity1';
					gMain.Services.Time.Internal.tempAlarm.allowMultiple		:= TRUE;
					gMain.Services.Time.Internal.tempAlarm.addText[0]			:= gMain.Services.Time.Out.ErrorInfo.State;
					gMain.Services.Time.Internal.tempAlarm.addText[1]			:= gMain.Services.Time.Out.ErrorInfo.Text;
					
					TC_Array_AddTop(ADR(gMain.Services.Alarms.In.AlarmList), SIZEOF(gMain.Services.Alarms.In.AlarmList), ADR(gMain.Services.Time.Internal.tempAlarm), SIZEOF(gMain.Services.Time.Internal.tempAlarm));
				2:
					gMain.Services.Time.Internal.tempAlarm.name				:= 'TimeSeverity2';
					gMain.Services.Time.Internal.tempAlarm.allowMultiple		:= TRUE;
					gMain.Services.Time.Internal.tempAlarm.addText[0]			:= gMain.Services.Time.Out.ErrorInfo.State;
					gMain.Services.Time.Internal.tempAlarm.addText[1]			:= gMain.Services.Time.Out.ErrorInfo.Text;
					brsitoa(gMain.Services.Time.Out.ErrorInfo.Code, ADR(gMain.Services.Time.Internal.tempAlarm.addText[2]));
					
					TC_Array_AddTop(ADR(gMain.Services.Alarms.In.AlarmList), SIZEOF(gMain.Services.Alarms.In.AlarmList), ADR(gMain.Services.Time.Internal.tempAlarm), SIZEOF(gMain.Services.Time.Internal.tempAlarm));
				3:
					gMain.Services.Time.Internal.tempAlarm.name				:= 'TimeSeverity3';
					gMain.Services.Time.Internal.tempAlarm.allowMultiple		:= TRUE;
					gMain.Services.Time.Internal.tempAlarm.addText[0]			:= gMain.Services.Time.Out.ErrorInfo.State;
					gMain.Services.Time.Internal.tempAlarm.addText[1]			:= gMain.Services.Time.Out.ErrorInfo.Text;
					
					TC_Array_AddTop(ADR(gMain.Services.Alarms.In.AlarmList), SIZEOF(gMain.Services.Alarms.In.AlarmList), ADR(gMain.Services.Time.Internal.tempAlarm), SIZEOF(gMain.Services.Time.Internal.tempAlarm));
				4:
					gMain.Services.Time.Internal.tempAlarm.name				:= 'TimeSeverity4';
					gMain.Services.Time.Internal.tempAlarm.allowMultiple		:= TRUE;
					gMain.Services.Time.Internal.tempAlarm.addText[0]			:= gMain.Services.Time.Out.ErrorInfo.State;
					gMain.Services.Time.Internal.tempAlarm.addText[1]			:= gMain.Services.Time.Out.ErrorInfo.Text;
					
					TC_Array_AddTop(ADR(gMain.Services.Alarms.In.AlarmList), SIZEOF(gMain.Services.Alarms.In.AlarmList), ADR(gMain.Services.Time.Internal.tempAlarm), SIZEOF(gMain.Services.Time.Internal.tempAlarm));
			END_CASE;
		END_IF;
	ELSE
		brsmemset(ADR(gMain.Services.Time.Internal.LastErrorInfo),0,SIZEOF(gMain.Services.Time.Internal.LastErrorInfo));
	END_IF;

	//Reset Timers on state change
	IF gMain.Services.Time.Internal.lastState <> gMain.Services.Time.Internal.state OR gMain.Services.Time.Internal.state = TIME_RESET_C THEN
		gMain.Services.Time.Internal.lastState													:= gMain.Services.Time.Internal.state;
		gMain.Services.Time.Internal.CTON_Timeout.IN											:= FALSE;
		gMain.Services.Time.Internal.CTON_Delay.IN												:= FALSE;
	END_IF;
	
	//Function Calls
	gMain.Services.Time.Internal.CTON_Timeout(PAUSE := FALSE);
	gMain.Services.Time.Internal.CTON_Delay(PAUSE := FALSE);
	gMain.Services.Time.Internal.DTGetTime_0(enable:=TRUE);
	gMain.Services.Time.Internal.DTSetTime_0();


END_ACTION
