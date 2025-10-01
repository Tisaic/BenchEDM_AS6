
ACTION DirMan: 
	gMain.Services.DirMan.Internal.TC_Dir_USB_Connect_0.enable 							:= TRUE;

	CASE gMain.Services.DirMan.Internal.State OF
		DIR_MAN_RESET:
			gMain.Services.DirMan.In.Refresh 											:= FALSE;
			brsmemset(ADR(gMain.Services.DirMan.Out.FileList),0,SIZEOF(gMain.Services.DirMan.Out.FileList));
			brsmemset(ADR(gMain.Services.DirMan.Out.FileListUSB),0,SIZEOF(gMain.Services.DirMan.Out.FileListUSB));
			gMain.Services.DirMan.Internal.TC_DirMake_0.enable 							:= FALSE;
			gMain.Services.DirMan.Internal.TC_DirSanitize_0.enable 						:= FALSE;
			gMain.Services.DirMan.Internal.TC_Dir_USB_Connect_0.enable 					:= FALSE;
			gMain.Services.DirMan.Internal.TC_Dir_Transfer_0.enable 					:= FALSE;
			gMain.Services.DirMan.Internal.TC_DirReadAll_0.enable						:= FALSE;
			gMain.Services.DirMan.Internal.TC_DirReadAll_USB.enable						:= FALSE;
			gMain.Services.DirMan.Internal.CTON_Delay(IN := FALSE);
			gMain.Services.DirMan.Internal.State 										:= DIR_MAN_DIRMAKE_CMD;
		DIR_MAN_DIRMAKE_CMD:
			gMain.Services.DirMan.Internal.TC_DirMake_0.enable							:= TRUE;
			gMain.Services.DirMan.Internal.TC_DirMake_0.pDevice							:= ADR(gMain.Services.DeviceName);
			gMain.Services.DirMan.Internal.TC_DirMake_0.pDirDef							:= ADR(gMain.Services.DirMan.In.DirDef);
			gMain.Services.DirMan.Internal.State 										:= DIR_MAN_DIRMAKE_WAIT;
		DIR_MAN_DIRMAKE_WAIT:
			IF gMain.Services.DirMan.Internal.TC_DirMake_0.status = ERR_OK THEN
				gMain.Services.DirMan.Internal.TC_DirMake_0.enable 						:= FALSE;
				gMain.Services.DirMan.Out.DirectoriesCreated							:= TRUE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_DIRREAD_CMD;	
			ELSIF gMain.Services.DirMan.Internal.TC_DirMake_0.status <> ERR_FUB_BUSY AND gMain.Services.DirMan.Internal.TC_DirMake_0.status <> ERR_FUB_ENABLE_FALSE THEN
				gMain.Services.DirMan.Out.DirectoriesCreated							:= FALSE;
				gMain.Services.DirMan.Internal.TC_DirMake_0.enable 						:= FALSE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_RESET;	
			END_IF;
		DIR_MAN_DIRREAD_CMD:
			gMain.Services.DirMan.Internal.TC_DirReadAll_0.enable						:= TRUE;
			gMain.Services.DirMan.Internal.TC_DirReadAll_0.pDevice						:= ADR(gMain.Services.DeviceName);
			gMain.Services.DirMan.Internal.TC_DirReadAll_0.pFileList					:= ADR(gMain.Services.DirMan.Out.FileList);
			gMain.Services.DirMan.Internal.State 										:= DIR_MAN_DIRREAD_WAIT;
		DIR_MAN_DIRREAD_WAIT:
			IF gMain.Services.DirMan.Internal.TC_DirReadAll_0.status = ERR_OK THEN
				gMain.Services.DirMan.Internal.TC_DirReadAll_0.enable 					:= FALSE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_DIRREAD_USB_CMD;	
			ELSIF gMain.Services.DirMan.Internal.TC_DirReadAll_0.status <> ERR_FUB_BUSY AND gMain.Services.DirMan.Internal.TC_DirReadAll_0.status <> ERR_FUB_ENABLE_FALSE THEN
				gMain.Services.DirMan.Internal.TC_DirReadAll_0.enable 					:= FALSE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_RESET;	
			END_IF;
		DIR_MAN_DIRREAD_USB_CMD:
			IF gMain.Services.DirMan.Internal.TC_Dir_USB_Connect_0.connected THEN
				gMain.Services.DirMan.Internal.TC_DirReadAll_USB.enable					:= TRUE;
				gMain.Services.DirMan.Internal.TC_DirReadAll_USB.pDevice				:= ADR('USB_DEVICE');
				gMain.Services.DirMan.Internal.TC_DirReadAll_USB.pFileList				:= ADR(gMain.Services.DirMan.Out.FileListUSB);
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_DIRREAD_USB_WAIT;
			ELSE
				brsmemset(ADR(gMain.Services.DirMan.Out.FileListUSB),0,SIZEOF(gMain.Services.DirMan.Out.FileListUSB));
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_DIRSANITIZE_CMD;	
			END_IF;
		DIR_MAN_DIRREAD_USB_WAIT:
			IF gMain.Services.DirMan.Internal.TC_DirReadAll_USB.status = ERR_OK THEN
				gMain.Services.DirMan.Internal.TC_DirReadAll_USB.enable 				:= FALSE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_DIRSANITIZE_CMD;	
			ELSIF gMain.Services.DirMan.Internal.TC_DirReadAll_USB.status <> ERR_FUB_BUSY AND gMain.Services.DirMan.Internal.TC_DirReadAll_USB.status <> ERR_FUB_ENABLE_FALSE THEN
				gMain.Services.DirMan.Internal.TC_DirReadAll_USB.enable 				:= FALSE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_RESET;	
			END_IF;
		DIR_MAN_DIRSANITIZE_CMD:
			gMain.Services.DirMan.Internal.TC_DirSanitize_0.enable						:= TRUE;
			gMain.Services.DirMan.Internal.TC_DirSanitize_0.pDevice						:= ADR(gMain.Services.DeviceName);
			gMain.Services.DirMan.Internal.TC_DirSanitize_0.pDirDef						:= ADR(gMain.Services.DirMan.In.DirDef);
			gMain.Services.DirMan.Internal.TC_DirSanitize_0.pFileList					:= ADR(gMain.Services.DirMan.Out.FileList);
			gMain.Services.DirMan.Internal.State 										:= DIR_MAN_DIRSANITIZE_WAIT;
		DIR_MAN_DIRSANITIZE_WAIT:
			IF gMain.Services.DirMan.Internal.TC_DirSanitize_0.status = ERR_OK THEN
				gMain.Services.DirMan.Internal.TC_DirSanitize_0.enable 					:= FALSE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_TRANSFER_CMD;	
			ELSIF gMain.Services.DirMan.Internal.TC_DirSanitize_0.status <> ERR_FUB_BUSY AND gMain.Services.DirMan.Internal.TC_DirSanitize_0.status <> ERR_FUB_ENABLE_FALSE THEN
				gMain.Services.DirMan.Internal.TC_DirSanitize_0.enable 					:= FALSE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_RESET;	
			END_IF;
 		DIR_MAN_TRANSFER_CMD:
			IF gMain.Services.DirMan.In.TransferList[0].Valid THEN
				gMain.Services.DirMan.Internal.TC_Dir_Transfer_0.enable 				:= TRUE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_TRANSFER_WAIT;	
			ELSE
				gMain.Services.DirMan.Internal.TC_Dir_Transfer_0.enable 				:= FALSE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_DELAY;	
			END_IF;
 		DIR_MAN_TRANSFER_WAIT:
			IF gMain.Services.DirMan.Internal.TC_Dir_Transfer_0.status = ERR_OK THEN
				gMain.Services.DirMan.Internal.TC_Dir_Transfer_0.enable 				:= FALSE;
				brsmemset(ADR(gMain.Services.DirMan.In.TransferList),0,SIZEOF(gMain.Services.DirMan.In.TransferList));
				gMain.Services.DirMan.In.Refresh 										:= TRUE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_DELAY;	
			ELSIF gMain.Services.DirMan.Internal.TC_Dir_Transfer_0.status <> ERR_FUB_BUSY AND gMain.Services.DirMan.Internal.TC_Dir_Transfer_0.status <> ERR_FUB_ENABLE_FALSE THEN
				gMain.Services.DirMan.Internal.TC_Dir_Transfer_0.enable 				:= FALSE;
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_DELAY;	
			END_IF;
		DIR_MAN_DELAY:
			IF gMain.Services.DirMan.Internal.CTON_Delay.Q OR gMain.Services.DirMan.In.Refresh THEN
				gMain.Services.DirMan.In.Refresh 										:= FALSE;
				gMain.Services.DirMan.Internal.CTON_Delay(IN := FALSE);
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_DIRMAKE_CMD;
			ELSIF gMain.Services.DirMan.In.TransferList[0].Valid THEN
				gMain.Services.DirMan.In.Refresh 										:= FALSE;
				gMain.Services.DirMan.Internal.CTON_Delay(IN := FALSE);
				gMain.Services.DirMan.Internal.State 									:= DIR_MAN_TRANSFER_CMD;
			ELSE
				gMain.Services.DirMan.Internal.CTON_Delay(IN := TRUE, PT := LREAL_TO_TIME(gMain.Services.DirMan.In.RefreshDelay*1000.0));
			END_IF;
	END_CASE;

	gMain.Services.DirMan.Internal.TC_DirMake_0();
	gMain.Services.DirMan.Internal.TC_DirSanitize_0();

	gMain.Services.DirMan.Internal.TC_DirReadAll_USB();		
	gMain.Services.DirMan.Internal.TC_DirReadAll_0();

	gMain.Services.DirMan.Internal.TC_Dir_USB_Connect_0(delay := 0.1);
	gMain.Services.DirMan.Internal.TC_Dir_Transfer_0(USB_Connected := gMain.Services.DirMan.Internal.TC_Dir_USB_Connect_0.connected, pTransferList := ADR(gMain.Services.DirMan.In.TransferList));

END_ACTION
