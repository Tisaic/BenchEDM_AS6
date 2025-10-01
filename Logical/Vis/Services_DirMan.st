
ACTION Services_DirMan: 
	gVis.Services.DirMan.DirectoriesCreated										:= gMain.Services.DirMan.Out.DirectoriesCreated;
	gVis.Services.DirMan.Updating												:= gMain.Services.DirMan.Internal.CTON_Delay.IN = FALSE;
	IF NOT gVis.Services.DirMan.Updating THEN
		IF NOT gVis.Services.DirMan.UpdatingEdge THEN
			FOR Idx_FileList := 0 TO MAX_DIR_MAN_FILE_LIST_IDX DO
				gVis.Services.DirMan.FileList.Num[Idx_FileList]					:= INT_TO_UDINT(Idx_FileList);
				ascDT(UDINT_TO_DT(gMain.Services.DirMan.Out.FileList[Idx_FileList].DateUDINT), ADR(gVis.Services.DirMan.FileList.DateString[Idx_FileList]), SIZEOF(gVis.Services.DirMan.FileList.DateString[Idx_FileList]));
				gVis.Services.DirMan.FileList.Path[Idx_FileList]				:= gMain.Services.DirMan.Out.FileList[Idx_FileList].Path;
				IF Idx_FileList = 0 THEN
					gVis.Services.DirMan.FileList.Path[Idx_FileList]			:= '<ROOT>';
					gVis.Services.DirMan.FileList.DateString[Idx_FileList]		:= '-';
				END_IF;
				gVis.Services.DirMan.FileList.IsDir[Idx_FileList]				:= gMain.Services.DirMan.Out.FileList[Idx_FileList].IsDir;
				gVis.Services.DirMan.FileList.Size[Idx_FileList]				:= gMain.Services.DirMan.Out.FileList[Idx_FileList].Size;
	
				gVis.Services.DirMan.FileListUSB.Num[Idx_FileList]				:= INT_TO_UDINT(Idx_FileList);
				ascDT(UDINT_TO_DT(gMain.Services.DirMan.Out.FileListUSB[Idx_FileList].DateUDINT), ADR(gVis.Services.DirMan.FileListUSB.DateString[Idx_FileList]), SIZEOF(gVis.Services.DirMan.FileListUSB.DateString[Idx_FileList]));
				gVis.Services.DirMan.FileListUSB.Path[Idx_FileList]				:= gMain.Services.DirMan.Out.FileListUSB[Idx_FileList].Path;
				IF Idx_FileList = 0 AND gMain.Services.DirMan.Internal.TC_Dir_USB_Connect_0.connected THEN
					gVis.Services.DirMan.FileListUSB.Path[Idx_FileList]			:= '<ROOT>';
					gVis.Services.DirMan.FileListUSB.DateString[Idx_FileList]	:= '-';
				END_IF;
				gVis.Services.DirMan.FileListUSB.IsDir[Idx_FileList]			:= gMain.Services.DirMan.Out.FileListUSB[Idx_FileList].IsDir;
				gVis.Services.DirMan.FileListUSB.Size[Idx_FileList]				:= gMain.Services.DirMan.Out.FileListUSB[Idx_FileList].Size;
			END_FOR;
			brsmemset(ADR(gVis.Services.DirMan.TableConfig_USB),0,SIZEOF(gVis.Services.DirMan.TableConfig_USB));
			TC_brsstrcat(ADR(gVis.Services.DirMan.TableConfig_USB),ADR('{"specRows": [ {"from":'),SIZEOF(gVis.Services.DirMan.TableConfig_USB));
			gVis.Services.DirMan.TempINT										:= 0;
			FOR Idx_FileList := 0 TO MAX_DIR_MAN_FILE_LIST_IDX DO
				IF gMain.Services.DirMan.Out.FileListUSB[Idx_FileList].DateUDINT = 0 AND gMain.Services.DirMan.Out.FileListUSB[Idx_FileList].IsDir = FALSE THEN
					gVis.Services.DirMan.TempINT								:= Idx_FileList;
					EXIT;
				END_IF;
			END_FOR;
			gVis.Services.DirMan.TempSTRING 									:= INT_TO_STRING(gVis.Services.DirMan.TempINT);
			TC_brsstrcat(ADR(gVis.Services.DirMan.TableConfig_USB),ADR(gVis.Services.DirMan.TempSTRING),SIZEOF(gVis.Services.DirMan.TableConfig_USB));
			TC_brsstrcat(ADR(gVis.Services.DirMan.TableConfig_USB),ADR(', "to":'),SIZEOF(gVis.Services.DirMan.TableConfig_USB));
			gVis.Services.DirMan.TempINT										:= MAX_DIR_MAN_FILE_LIST_IDX;
			gVis.Services.DirMan.TempSTRING 									:= INT_TO_STRING(gVis.Services.DirMan.TempINT);
			TC_brsstrcat(ADR(gVis.Services.DirMan.TableConfig_USB),ADR(gVis.Services.DirMan.TempSTRING),SIZEOF(gVis.Services.DirMan.TableConfig_USB));
			TC_brsstrcat(ADR(gVis.Services.DirMan.TableConfig_USB),ADR(', "visible":false} ]}'),SIZEOF(gVis.Services.DirMan.TableConfig_USB));
		
			brsmemset(ADR(gVis.Services.DirMan.TableConfig_User),0,SIZEOF(gVis.Services.DirMan.TableConfig_User));
			TC_brsstrcat(ADR(gVis.Services.DirMan.TableConfig_User),ADR('{"specRows": [ {"from":'),SIZEOF(gVis.Services.DirMan.TableConfig_User));
			gVis.Services.DirMan.TempINT										:= 0;
			FOR Idx_FileList := 0 TO MAX_DIR_MAN_FILE_LIST_IDX DO
				IF gMain.Services.DirMan.Out.FileList[Idx_FileList].DateUDINT = 0 AND gMain.Services.DirMan.Out.FileList[Idx_FileList].IsDir = FALSE THEN
					gVis.Services.DirMan.TempINT								:= Idx_FileList;
					EXIT;
				END_IF;
			END_FOR;
			gVis.Services.DirMan.TempSTRING 									:= INT_TO_STRING(gVis.Services.DirMan.TempINT);
			TC_brsstrcat(ADR(gVis.Services.DirMan.TableConfig_User),ADR(gVis.Services.DirMan.TempSTRING),SIZEOF(gVis.Services.DirMan.TableConfig_User));
			TC_brsstrcat(ADR(gVis.Services.DirMan.TableConfig_User),ADR(', "to":'),SIZEOF(gVis.Services.DirMan.TableConfig_User));
			gVis.Services.DirMan.TempINT										:= MAX_DIR_MAN_FILE_LIST_IDX;
			gVis.Services.DirMan.TempSTRING 									:= INT_TO_STRING(gVis.Services.DirMan.TempINT);
			TC_brsstrcat(ADR(gVis.Services.DirMan.TableConfig_User),ADR(gVis.Services.DirMan.TempSTRING),SIZEOF(gVis.Services.DirMan.TableConfig_User));
			TC_brsstrcat(ADR(gVis.Services.DirMan.TableConfig_User),ADR(', "visible":false} ]}'),SIZEOF(gVis.Services.DirMan.TableConfig_User));
		END_IF;
		gVis.Services.DirMan.UpdatingEdge										:= TRUE;
	ELSE
		gVis.Services.DirMan.UpdatingEdge										:= FALSE;
	END_IF;
	IF gVis.Services.DirMan.SelectedIndexUSB >= 0 AND gVis.Services.DirMan.SelectedIndexUSB <= MAX_DIR_MAN_FILE_LIST_IDX THEN
		gVis.Services.DirMan.Cmd.PathUSB										:= gVis.Services.DirMan.FileListUSB.Path[gVis.Services.DirMan.SelectedIndexUSB];
		IF gVis.Services.DirMan.SelectedIndexUSB = 0 THEN
			gVis.Services.DirMan.Cmd.PathUSB									:= '/';
		END_IF;
		gVis.Services.DirMan.Cmd.DirUSB											:= gVis.Services.DirMan.FileListUSB.IsDir[gVis.Services.DirMan.SelectedIndexUSB];
	END_IF;
	IF gVis.Services.DirMan.SelectedIndexUser >= 0 AND gVis.Services.DirMan.SelectedIndexUser <= MAX_DIR_MAN_FILE_LIST_IDX THEN
		gVis.Services.DirMan.Cmd.PathUser										:= gVis.Services.DirMan.FileList.Path[gVis.Services.DirMan.SelectedIndexUser];
		IF gVis.Services.DirMan.SelectedIndexUser = 0 THEN
			gVis.Services.DirMan.Cmd.PathUser									:= '/';
		END_IF;
		gVis.Services.DirMan.Cmd.DirUser										:= gVis.Services.DirMan.FileList.IsDir[gVis.Services.DirMan.SelectedIndexUser];
	END_IF;
	gVis.Services.DirMan.USBConnected											:= gMain.Services.DirMan.Internal.TC_Dir_USB_Connect_0.connected;
	gVis.Services.DirMan.Enable_Command											:= (gVis.Services.DirMan.Cmd.Action = DIR_MAN_ACTION_COPY_TO_USB     AND gVis.Services.DirMan.Cmd.DirUSB   AND gVis.Services.DirMan.USBConnected AND NOT gVis.Services.DirMan.CmdActive)
																				OR (gVis.Services.DirMan.Cmd.Action = DIR_MAN_ACTION_COPY_TO_USER    AND gVis.Services.DirMan.Cmd.DirUser  AND gVis.Services.DirMan.USBConnected AND NOT gVis.Services.DirMan.CmdActive) 
																				OR (gVis.Services.DirMan.Cmd.Action = DIR_MAN_ACTION_CREATE_DIR_USB  AND gVis.Services.DirMan.Cmd.DirUSB   AND gVis.Services.DirMan.Cmd.ParString <> '' AND gVis.Services.DirMan.USBConnected AND NOT gVis.Services.DirMan.CmdActive)
																				OR (gVis.Services.DirMan.Cmd.Action = DIR_MAN_ACTION_CREATE_DIR_USER AND gVis.Services.DirMan.Cmd.DirUser  AND gVis.Services.DirMan.Cmd.ParString <> '' AND NOT gVis.Services.DirMan.CmdActive)
																				OR (gVis.Services.DirMan.Cmd.Action = DIR_MAN_ACTION_DELETE_USB      AND gVis.Services.DirMan.USBConnected AND NOT gVis.Services.DirMan.CmdActive)
																				OR (gVis.Services.DirMan.Cmd.Action = DIR_MAN_ACTION_DELETE_USER     AND NOT gVis.Services.DirMan.CmdActive)
																				;
	IF gVis.Services.DirMan.Command THEN	
		gVis.Services.DirMan.Command											:= FALSE;
		gVis.Services.DirMan.CmdActive											:= TRUE;
		gVis.Services.DirMan.ActiveCmd											:= gVis.Services.DirMan.Cmd;
	END_IF;	
	IF gVis.Services.DirMan.Refresh THEN	
		gVis.Services.DirMan.Refresh											:= FALSE;
		gMain.Services.DirMan.In.Refresh										:= TRUE;
	END_IF;	
	IF gVis.Services.DirMan.Confirm THEN	
		gVis.Services.DirMan.Confirm											:= FALSE;
		gVis.Services.DirMan.CmdActive											:= FALSE;
		IF gMain.Services.DirMan.In.TransferList[0].Valid THEN
			brsmemmove(ADR(gMain.Services.DirMan.In.TransferList)+SIZEOF(gMain.Services.DirMan.In.TransferList[0]),ADR(gMain.Services.DirMan.In.TransferList),SIZEOF(gMain.Services.DirMan.In.TransferList)-SIZEOF(gMain.Services.DirMan.In.TransferList[0]));
			brsmemset(ADR(gMain.Services.DirMan.In.TransferList[0]),0,SIZEOF(gMain.Services.DirMan.In.TransferList[0]));
		END_IF;
		CASE gVis.Services.DirMan.ActiveCmd.Action OF
			DIR_MAN_ACTION_COPY_TO_USER:
				gMain.Services.DirMan.In.TransferList[0].Valid					:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].SrcOrDestUSB			:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].IsDir					:= gVis.Services.DirMan.ActiveCmd.DirUSB;
				gMain.Services.DirMan.In.TransferList[0].SrcDev					:= 'USB_DEVICE';
				gMain.Services.DirMan.In.TransferList[0].SrcPath				:= gVis.Services.DirMan.ActiveCmd.PathUSB;
				gMain.Services.DirMan.In.TransferList[0].DestDev				:= gMain.Services.DeviceName;
				gMain.Services.DirMan.In.TransferList[0].DestPath				:= gVis.Services.DirMan.ActiveCmd.PathUser;
			DIR_MAN_ACTION_COPY_TO_USB:	
				gMain.Services.DirMan.In.TransferList[0].Valid					:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].SrcOrDestUSB			:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].IsDir					:= gVis.Services.DirMan.ActiveCmd.DirUser;
				gMain.Services.DirMan.In.TransferList[0].SrcDev					:= gMain.Services.DeviceName;
				gMain.Services.DirMan.In.TransferList[0].SrcPath				:= gVis.Services.DirMan.ActiveCmd.PathUser;
				gMain.Services.DirMan.In.TransferList[0].DestDev				:= 'USB_DEVICE';
				gMain.Services.DirMan.In.TransferList[0].DestPath				:= gVis.Services.DirMan.ActiveCmd.PathUSB;
			DIR_MAN_ACTION_DELETE_USER:	
				gMain.Services.DirMan.In.TransferList[0].Valid					:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].NoTransfer				:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].SrcDelete				:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].IsDir					:= gVis.Services.DirMan.ActiveCmd.DirUser;
				gMain.Services.DirMan.In.TransferList[0].SrcDev					:= gMain.Services.DeviceName;
				gMain.Services.DirMan.In.TransferList[0].SrcPath				:= gVis.Services.DirMan.ActiveCmd.PathUser;
				gMain.Services.DirMan.In.TransferList[0].DestDev				:= gMain.Services.DeviceName;
				gMain.Services.DirMan.In.TransferList[0].DestPath				:= gVis.Services.DirMan.ActiveCmd.PathUser;
			DIR_MAN_ACTION_DELETE_USB:	
				gMain.Services.DirMan.In.TransferList[0].Valid					:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].NoTransfer				:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].SrcDelete				:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].SrcOrDestUSB			:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].IsDir					:= gVis.Services.DirMan.ActiveCmd.DirUSB;
				gMain.Services.DirMan.In.TransferList[0].SrcDev					:= 'USB_DEVICE';
				gMain.Services.DirMan.In.TransferList[0].SrcPath				:= gVis.Services.DirMan.ActiveCmd.PathUSB;
				gMain.Services.DirMan.In.TransferList[0].DestDev				:= 'USB_DEVICE';
				gMain.Services.DirMan.In.TransferList[0].DestPath				:= gVis.Services.DirMan.ActiveCmd.PathUSB;
			DIR_MAN_ACTION_CREATE_DIR_USER:	
				gMain.Services.DirMan.In.TransferList[0].Valid					:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].NoTransfer				:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].SrcCreateDir			:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].IsDir					:= gVis.Services.DirMan.ActiveCmd.DirUser;
				gMain.Services.DirMan.In.TransferList[0].SrcDev					:= gMain.Services.DeviceName;
				gMain.Services.DirMan.In.TransferList[0].SrcPath				:= gVis.Services.DirMan.ActiveCmd.PathUser;
				IF gMain.Services.DirMan.In.TransferList[0].SrcPath <> '/' THEN
					TC_brsstrcat(ADR(gMain.Services.DirMan.In.TransferList[0].SrcPath),ADR('/'),SIZEOF(gMain.Services.DirMan.In.TransferList[0].SrcPath));
				END_IF;
				TC_brsstrcat(ADR(gMain.Services.DirMan.In.TransferList[0].SrcPath),ADR(gVis.Services.DirMan.ActiveCmd.ParString),SIZEOF(gMain.Services.DirMan.In.TransferList[0].SrcPath));
				gMain.Services.DirMan.In.TransferList[0].DestDev				:= gMain.Services.DeviceName;
				gMain.Services.DirMan.In.TransferList[0].DestPath				:= gVis.Services.DirMan.ActiveCmd.PathUser;
				IF gMain.Services.DirMan.In.TransferList[0].DestPath <> '/' THEN
					TC_brsstrcat(ADR(gMain.Services.DirMan.In.TransferList[0].DestPath),ADR('/'),SIZEOF(gMain.Services.DirMan.In.TransferList[0].DestPath));
				END_IF;
				TC_brsstrcat(ADR(gMain.Services.DirMan.In.TransferList[0].DestPath),ADR(gVis.Services.DirMan.ActiveCmd.ParString),SIZEOF(gMain.Services.DirMan.In.TransferList[0].DestPath));
			DIR_MAN_ACTION_CREATE_DIR_USB:
				gMain.Services.DirMan.In.TransferList[0].Valid					:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].NoTransfer				:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].SrcCreateDir			:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].SrcOrDestUSB			:= TRUE;
				gMain.Services.DirMan.In.TransferList[0].IsDir					:= gVis.Services.DirMan.ActiveCmd.DirUSB;
				gMain.Services.DirMan.In.TransferList[0].SrcDev					:= 'USB_DEVICE';
				gMain.Services.DirMan.In.TransferList[0].SrcPath				:= gVis.Services.DirMan.ActiveCmd.PathUSB;
				IF gMain.Services.DirMan.In.TransferList[0].SrcPath <> '/' THEN
					TC_brsstrcat(ADR(gMain.Services.DirMan.In.TransferList[0].SrcPath),ADR('/'),SIZEOF(gMain.Services.DirMan.In.TransferList[0].SrcPath));
				END_IF;
				TC_brsstrcat(ADR(gMain.Services.DirMan.In.TransferList[0].SrcPath),ADR(gVis.Services.DirMan.ActiveCmd.ParString),SIZEOF(gMain.Services.DirMan.In.TransferList[0].SrcPath));
				gMain.Services.DirMan.In.TransferList[0].DestDev				:= 'USB_DEVICE';
				gMain.Services.DirMan.In.TransferList[0].DestPath				:= gVis.Services.DirMan.ActiveCmd.PathUSB;
				IF gMain.Services.DirMan.In.TransferList[0].DestPath <> '/' THEN
					TC_brsstrcat(ADR(gMain.Services.DirMan.In.TransferList[0].DestPath),ADR('/'),SIZEOF(gMain.Services.DirMan.In.TransferList[0].DestPath));
				END_IF;
				TC_brsstrcat(ADR(gMain.Services.DirMan.In.TransferList[0].DestPath),ADR(gVis.Services.DirMan.ActiveCmd.ParString),SIZEOF(gMain.Services.DirMan.In.TransferList[0].DestPath));
		END_CASE;
		brsmemset(ADR(gVis.Services.DirMan.ActiveCmd),0,SIZEOF(gVis.Services.DirMan.ActiveCmd));
		gMain.Services.DirMan.In.Refresh										:= TRUE;
	END_IF;
	IF gVis.Services.DirMan.Cancel OR brsmemcmp(ADR(gVis.Services.DirMan.ActiveCmd),ADR(gVis.Services.DirMan.Cmd),SIZEOF(gVis.Services.DirMan.Cmd)) <> 0 THEN
		gVis.Services.DirMan.Cancel												:= FALSE;
		gVis.Services.DirMan.CmdActive											:= FALSE;
		brsmemset(ADR(gVis.Services.DirMan.ActiveCmd),0,SIZEOF(gVis.Services.DirMan.ActiveCmd));
	END_IF;
	gVis.Services.DirMan.CmdInactive											:= NOT gVis.Services.DirMan.CmdActive;
	gVis.Services.DirMan.Busy													:= gMain.Services.DirMan.Internal.State <> DIR_MAN_DELAY;
END_ACTION
