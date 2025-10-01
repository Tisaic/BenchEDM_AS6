
ACTION Email:  
 
	gMain.Services.Email.In.Par.Port 															:= gPar.Services.Email.Port;
	gMain.Services.Email.In.Par.Timeout 														:= gPar.Services.Email.Timeout;
	gMain.Services.Email.In.Par.Host 															:= gPar.Services.Email.Host;
	gMain.Services.Email.In.Par.User 															:= gPar.Services.Email.User;
	gMain.Services.Email.In.Par.Password 														:= gPar.Services.Email.Password;
	gMain.Services.Email.In.Par.Sender 															:= gPar.Services.Email.Sender;
	gMain.Services.Email.In.Par.Receiver 														:= gPar.Services.Email.Receiver;
	gMain.Services.Email.In.Par.SSLConfigIdent													:= gMain.Services.Cert.SSLConfigIdent;

	gMain.Services.Email.In.Par.Subject															:= 'Automated Email Notification - Do Not Respond';
	gMain.Services.Email.In.Par.Text															:= 'Testing';

	IF gMain.Services.Email.In.Cmd.Reset THEN 
		gMain.Services.Email.In.Cmd.Reset														:= FALSE;
		gMain.Services.Email.Internal.State														:= EMAIL_RESET_C;
	END_IF;

	brsmemset(ADR(gMain.Services.Email.Out),0,SIZEOF(gMain.Services.Email.Out));
	CASE gMain.Services.Email.Internal.State OF
		EMAIL_RESET_C:
			gMain.Services.Email.Out.Status.CurrentState										:= 'EMAIL_RESET_C';
			gMain.Services.Email.Out.Status.InReset												:= TRUE;
			brsmemset(ADR(gMain.Services.Email.In),0,SIZEOF(gMain.Services.Email.In));
			brsmemset(ADR(gMain.Services.Email.Internal),0,SIZEOF(gMain.Services.Email.Internal));
			gMain.Services.Email.Internal.State 												:= EMAIL_CHECKPARREADY_W;
		EMAIL_CHECKPARREADY_W:
			gMain.Services.Email.Out.Status.CurrentState										:= 'EMAIL_CHECKPARREADY_W';
			gMain.Services.Email.Out.Status.Initializing										:= TRUE;
			gMain.Services.Email.Internal.CTON_Timeout.IN 										:= TRUE;
			gMain.Services.Email.Internal.CTON_Timeout.PT 										:= LREAL_TO_TIME(30.0*1000.0); //Hardcoded because parameters are not yet loaded
			
			IF gMain.Services.Recipes.Out.ParametersReady THEN
				gMain.Services.Email.Internal.State 											:= EMAIL_IDLE_I;
			ELSIF gMain.Services.Email.Internal.CTON_Timeout.Q THEN
				gMain.Services.Email.Out.Status.Error 											:= TRUE;
				gMain.Services.Email.Out.ErrorInfo.Severity										:= 1;
				gMain.Services.Email.Out.ErrorInfo.Text 										:= 'Timeout';
				gMain.Services.Email.Out.ErrorInfo.State 										:= gMain.Services.Email.Out.Status.CurrentState;
				gMain.Services.Email.Internal.State 											:= EMAIL_ERROR_I;
			END_IF;
		EMAIL_IDLE_I:
			gMain.Services.Email.Out.Status.CurrentState										:= 'EMAIL_IDLE_I';
			gMain.Services.Email.Out.Status.WaitingForCommand									:= TRUE;

			IF gMain.Services.Email.In.Cmd.Send THEN
				gMain.Services.Email.In.Cmd.Send												:= FALSE;
				gMain.Services.Email.Internal.State 											:= EMAIL_SEND_D;
			END_IF;
		EMAIL_SEND_D:
			gMain.Services.Email.Out.Status.CurrentState										:= 'EMAIL_SEND_D';
			gMain.Services.Email.Out.Status.Processing											:= TRUE;
			gMain.Services.Email.Internal.CTON_Delay.IN 										:= TRUE;
			gMain.Services.Email.Internal.CTON_Delay.PT 										:= LREAL_TO_TIME(0.0*1000.0);

			IF gMain.Services.Email.Internal.CTON_Delay.Q OR 0.0 < 0.0001 THEN
				gMain.Services.Email.Internal.State 											:= EMAIL_SEND_C;
			END_IF;
		EMAIL_SEND_C:
			gMain.Services.Email.Out.Status.CurrentState										:= 'EMAIL_SEND_C';
			gMain.Services.Email.Out.Status.Processing											:= TRUE;
			gMain.Services.Email.Internal.SmtpsSend_0.enable									:= TRUE;
			gMain.Services.Email.Internal.SmtpsSend_0.port										:= gMain.Services.Email.In.Par.Port;
			gMain.Services.Email.Internal.SmtpsSend_0.timeout									:= gMain.Services.Email.In.Par.Timeout;
			gMain.Services.Email.Internal.SmtpsSend_0.pHost										:= ADR(gMain.Services.Email.In.Par.Host);
			gMain.Services.Email.Internal.SmtpsSend_0.pUser										:= ADR(gMain.Services.Email.In.Par.User);
			gMain.Services.Email.Internal.SmtpsSend_0.pPassword									:= ADR(gMain.Services.Email.In.Par.Password);
			gMain.Services.Email.Internal.SmtpsSend_0.pSender									:= ADR(gMain.Services.Email.In.Par.Sender);
			gMain.Services.Email.Internal.SmtpsSend_0.pReceiver									:= ADR(gMain.Services.Email.In.Par.Receiver);
			gMain.Services.Email.Internal.SmtpsSend_0.pSubject									:= ADR(gMain.Services.Email.In.Par.Subject);
			gMain.Services.Email.Internal.SmtpsSend_0.pText										:= ADR(gMain.Services.Email.In.Par.Text);
			gMain.Services.Email.Internal.SmtpsSend_0.attcnt									:= gMain.Services.Email.In.Par.AttachmentCount;
			gMain.Services.Email.Internal.SmtpsSend_0.pAttachment								:= gMain.Services.Email.In.Par.pAttachment;
			gMain.Services.Email.Internal.SmtpsSend_0.pDomain									:= ADR('gmail.com');
			gMain.Services.Email.Internal.SmtpsSend_0.sslCfgIdent								:= gMain.Services.Email.In.Par.SSLConfigIdent;
			gMain.Services.Email.Internal.State 												:= EMAIL_SEND_W;
		EMAIL_SEND_W:
			gMain.Services.Email.Out.Status.CurrentState										:= 'EMAIL_SEND_W';
			gMain.Services.Email.Out.Status.Processing											:= TRUE;
			gMain.Services.Email.Internal.CTON_Timeout.IN 										:= TRUE;
			gMain.Services.Email.Internal.CTON_Timeout.PT 										:= LREAL_TO_TIME(30.0*1000.0);

			IF gMain.Services.Email.Internal.SmtpsSend_0.status = 0 THEN
				gMain.Services.Email.Internal.SmtpsSend_0.enable								:= FALSE;
				gMain.Services.Email.Internal.State 											:= EMAIL_RESET_C;
			ELSIF gMain.Services.Email.Internal.SmtpsSend_0.status <> 65535 AND gMain.Services.Email.Internal.SmtpsSend_0.status <> 65534 THEN
				gMain.Services.Email.Internal.SmtpsSend_0.enable								:= FALSE;
				gMain.Services.Email.Out.Status.Error 											:= TRUE;
				gMain.Services.Email.Out.ErrorInfo.Severity										:= 2;
				gMain.Services.Email.Out.ErrorInfo.Code											:= gMain.Services.Email.Internal.SmtpsSend_0.status;
				gMain.Services.Email.Out.ErrorInfo.Text 										:= 'FBError';
				gMain.Services.Email.Out.ErrorInfo.State										:= gMain.Services.Email.Out.Status.CurrentState;
				gMain.Services.Email.Internal.State 											:= EMAIL_ERROR_I;
			ELSIF gMain.Services.Email.Internal.CTON_Timeout.Q THEN
				gMain.Services.Email.Internal.SmtpsSend_0.enable								:= FALSE;
				gMain.Services.Email.Out.Status.Error 											:= TRUE;
				gMain.Services.Email.Out.ErrorInfo.Severity										:= 2;
				gMain.Services.Email.Out.ErrorInfo.Text 										:= 'Timeout';
				gMain.Services.Email.Internal.State 											:= EMAIL_ERROR_I;
			END_IF;
		EMAIL_ERROR_I:
			gMain.Services.Email.Out.Status.CurrentState										:= 'EMAIL_ERROR_I';
			gMain.Services.Email.Out.Status.InError 											:= TRUE;
			IF gMain.ErrorReset THEN
				gMain.Services.Email.Internal.State 											:= EMAIL_RESET_C;					
			END_IF;
	END_CASE;	
	//Check for Commands that are still true. If they are still true then they were not handled and we need to error.
	IF NOT gMain.Services.Email.Out.Status.WaitingForCommand THEN
		IF gMain.Services.Email.In.Cmd.Send THEN
			gMain.Services.Email.In.Cmd.Send													:= FALSE;
			gMain.Services.Email.Out.IgnoreInfo.Cmd												:= 'Send';			
			gMain.Services.Email.Out.IgnoreInfo.Reason											:= 'NotReady';
			gMain.Services.Email.Out.ErrorInfo.State											:= gMain.Services.Email.Out.Status.CurrentState;
			
			gMain.Services.Email.Internal.tempAlarm.name										:= 'EmailCmdIgnored';
			gMain.Services.Email.Internal.tempAlarm.allowMultiple								:= TRUE;
			gMain.Services.Email.Internal.tempAlarm.addText[0]									:= gMain.Services.Email.Out.IgnoreInfo.Cmd;
			gMain.Services.Email.Internal.tempAlarm.addText[1]									:= gMain.Services.Email.Out.IgnoreInfo.Reason;
			TC_Array_AddTop(ADR(gMain.Services.Alarms.In.AlarmList), SIZEOF(gMain.Services.Alarms.In.AlarmList), ADR(gMain.Services.Email.Internal.tempAlarm), SIZEOF(gMain.Services.Email.Internal.tempAlarm));
		END_IF;
	END_IF;
	brsmemset(ADR(gMain.Services.Email.Internal.BlankCmdCmp),0,SIZEOF(gMain.Services.Email.Internal.BlankCmdCmp));
	IF brsmemcmp(ADR(gMain.Services.Email.Internal.BlankCmdCmp),ADR(gMain.Services.Email.In.Cmd),SIZEOF(gMain.Services.Email.In.Cmd)) <> 0 THEN
		gMain.Services.Email.Out.ErrorInfo.State												:= gMain.Services.Email.Out.Status.CurrentState;

		gMain.Services.Email.Internal.tempAlarm.name											:= 'EmailUnhandledCmd';
		gMain.Services.Email.Internal.tempAlarm.allowMultiple									:= TRUE;
		gMain.Services.Email.Internal.tempAlarm.addText[0]										:= gMain.Services.Email.Out.ErrorInfo.State;
		TC_Array_AddTop(ADR(gMain.Services.Alarms.In.AlarmList), SIZEOF(gMain.Services.Alarms.In.AlarmList), ADR(gMain.Services.Email.Internal.tempAlarm), SIZEOF(gMain.Services.Email.Internal.tempAlarm));
	END_IF;
	brsmemset(ADR(gMain.Services.Email.In.Cmd),0,SIZEOF(gMain.Services.Email.In.Cmd));
	
	//Reset Timeout On State Change
	IF gMain.Services.Email.Internal.LastState <> gMain.Services.Email.Internal.State OR gMain.Services.Email.Internal.State = EMAIL_RESET_C THEN
		gMain.Services.Email.Internal.LastState													:= gMain.Services.Email.Internal.State;
		gMain.Services.Email.Internal.CTON_Timeout.IN											:= FALSE;
		gMain.Services.Email.Internal.CTON_Delay.IN												:= FALSE;
	END_IF;
		
	//Function Calls
	gMain.Services.Email.Internal.CTON_Timeout	(PAUSE := FALSE);
	gMain.Services.Email.Internal.CTON_Delay	(PAUSE := FALSE);
	gMain.Services.Email.Internal.SmtpsSend_0	();
								   
	//Error Collection
	IF gMain.Services.Email.Out.Status.Error THEN
		IF brsmemcmp(ADR(gMain.Services.Email.Internal.LastErrorInfo),ADR(gMain.Services.Email.Out.ErrorInfo),SIZEOF(gMain.Services.Email.Internal.LastErrorInfo)) <> 0 THEN
			brsmemcpy(ADR(gMain.Services.Email.Internal.LastErrorInfo),ADR(gMain.Services.Email.Out.ErrorInfo),SIZEOF(gMain.Services.Email.Internal.LastErrorInfo));
			CASE gMain.Services.Email.Out.ErrorInfo.Severity OF
				1:
					gMain.Services.Email.Internal.tempAlarm.name				:= 'EmailSeverity1';
					gMain.Services.Email.Internal.tempAlarm.allowMultiple		:= TRUE;
					gMain.Services.Email.Internal.tempAlarm.addText[0]			:= gMain.Services.Email.Out.ErrorInfo.State;
					gMain.Services.Email.Internal.tempAlarm.addText[1]			:= gMain.Services.Email.Out.ErrorInfo.Text;
					
					TC_Array_AddTop(ADR(gMain.Services.Alarms.In.AlarmList), SIZEOF(gMain.Services.Alarms.In.AlarmList), ADR(gMain.Services.Email.Internal.tempAlarm), SIZEOF(gMain.Services.Email.Internal.tempAlarm));
				2:
					gMain.Services.Email.Internal.tempAlarm.name				:= 'EmailSeverity2';
					gMain.Services.Email.Internal.tempAlarm.allowMultiple		:= TRUE;
					gMain.Services.Email.Internal.tempAlarm.addText[0]			:= gMain.Services.Email.Out.ErrorInfo.State;
					gMain.Services.Email.Internal.tempAlarm.addText[1]			:= gMain.Services.Email.Out.ErrorInfo.Text;
					brsitoa(gMain.Services.Email.Out.ErrorInfo.Code, ADR(gMain.Services.Email.Internal.tempAlarm.addText[2]));
					
					TC_Array_AddTop(ADR(gMain.Services.Alarms.In.AlarmList), SIZEOF(gMain.Services.Alarms.In.AlarmList), ADR(gMain.Services.Email.Internal.tempAlarm), SIZEOF(gMain.Services.Email.Internal.tempAlarm));
				3:
					gMain.Services.Email.Internal.tempAlarm.name				:= 'EmailSeverity3';
					gMain.Services.Email.Internal.tempAlarm.allowMultiple		:= TRUE;
					gMain.Services.Email.Internal.tempAlarm.addText[0]			:= gMain.Services.Email.Out.ErrorInfo.State;
					gMain.Services.Email.Internal.tempAlarm.addText[1]			:= gMain.Services.Email.Out.ErrorInfo.Text;
					
					TC_Array_AddTop(ADR(gMain.Services.Alarms.In.AlarmList), SIZEOF(gMain.Services.Alarms.In.AlarmList), ADR(gMain.Services.Email.Internal.tempAlarm), SIZEOF(gMain.Services.Email.Internal.tempAlarm));
				4:
					gMain.Services.Email.Internal.tempAlarm.name				:= 'EmailSeverity4';
					gMain.Services.Email.Internal.tempAlarm.allowMultiple		:= TRUE;
					gMain.Services.Email.Internal.tempAlarm.addText[0]			:= gMain.Services.Email.Out.ErrorInfo.State;
					gMain.Services.Email.Internal.tempAlarm.addText[1]			:= gMain.Services.Email.Out.ErrorInfo.Text;
					
					TC_Array_AddTop(ADR(gMain.Services.Alarms.In.AlarmList), SIZEOF(gMain.Services.Alarms.In.AlarmList), ADR(gMain.Services.Email.Internal.tempAlarm), SIZEOF(gMain.Services.Email.Internal.tempAlarm));
			END_CASE;
		END_IF;
	ELSE
		brsmemset(ADR(gMain.Services.Email.Internal.LastErrorInfo),0,SIZEOF(gMain.Services.Email.Internal.LastErrorInfo));
	END_IF;

END_ACTION
