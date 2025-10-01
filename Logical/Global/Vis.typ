
TYPE
	Vis_typ : 	STRUCT 
		Navigation : Vis_Navigation_typ;
		Header : Vis_Header_typ;
		Footer : Vis_Footer_typ;
		Alarms : Vis_Alarms_typ;
		Settings : Vis_Settings_typ;
		Services : Vis_Services_typ;
	END_STRUCT;
	Vis_Navigation_typ : 	STRUCT 
		STOP : BOOL;
	END_STRUCT;
	Vis_Footer_typ : 	STRUCT 
		IdentifyConfig_0 : IdentifyConfig;
		Revision : STRING[300];
		Start : BOOL;
		Pause : BOOL;
		Stop : BOOL;
		SetTime : BOOL;
		currentTime : DATE_AND_TIME;
		newTime : DATE_AND_TIME;
		TimeNotValid : BOOL;
		CTON_Init : CTON;
	END_STRUCT;
	Vis_Header_typ : 	STRUCT 
		Monitor : Vis_Header_Monitor_typ;
		Notifications : Vis_Header_Notifications_typ;
	END_STRUCT;
	Vis_Header_Notifications_typ : 	STRUCT 
		Visible : ARRAY[0..MAX_NOTIFICATION_IDX]OF BOOL;
	END_STRUCT;
	Vis_Header_Monitor_typ : 	STRUCT 
		Styles : Vis_Header_Monitor_Styles_typ;
	END_STRUCT;
	Vis_Header_Monitor_Styles_typ : 	STRUCT 
		Text : STRING[8];
		Background : STRING[8];
		GridColor : STRING[8];
		Line0 : STRING[8];
		Line1 : STRING[8];
		Line2 : STRING[8];
		Line3 : STRING[8];
	END_STRUCT;
	Vis_Alarms_typ : 	STRUCT 
		Active : Vis_Alarms_Active_typ;
		History : Vis_Alarms_History_typ;
	END_STRUCT;
	Vis_Alarms_Active_typ : 	STRUCT 
		UIConnect : MpAlarmXListUIConnectType;
		Reset : BOOL;
		PageDown : BOOL;
		PageUp : BOOL;
		SelectedIndex : UINT;
		TableConfig : STRING[255];
		TempINT : INT;
		TempSTRING : STRING[30];
	END_STRUCT;
	Vis_Alarms_History_typ : 	STRUCT 
		UIConnect : MpAlarmXHistoryUIConnectType;
		State : ARRAY[0..49]OF UINT;
		Clear : BOOL;
		PageDown : BOOL;
		PageUp : BOOL;
		Export : BOOL;
		SelectedIndex : UINT;
		TableConfig : STRING[255];
		TempINT : INT;
		TempSTRING : STRING[30];
	END_STRUCT;
	Vis_Settings_Save_typ : 	STRUCT 
		Modified : BOOL;
		Save : BOOL;
		Cancel : BOOL;
	END_STRUCT;
	Vis_Settings_typ : 	STRUCT 
		Par : Par_typ;
		ParCmp : Par_typ;
		Save : Vis_Settings_Save_typ;
	END_STRUCT;
	Vis_Services_typ : 	STRUCT 
		DirMan : Vis_Services_DirMan_typ;
	END_STRUCT;
	Vis_Services_DirMan_typ : 	STRUCT 
		FileList : Vis_Services_DirMan_FileList_typ;
		FileListUSB : Vis_Services_DirMan_FileList_typ;
		DirectoriesCreated : BOOL;
		UpdatingEdge : BOOL;
		Updating : BOOL;
		Refresh : BOOL;
		Cancel : BOOL;
		Confirm : BOOL;
		Command : BOOL;
		USBConnected : BOOL;
		CmdInactive : BOOL;
		CmdActive : BOOL;
		ActiveCmd : Vis_Services_DirMan_Cmd_typ;
		Cmd : Vis_Services_DirMan_Cmd_typ;
		Enable_Command : BOOL;
		Busy : BOOL;
		SelectedIndexUser : INT;
		SelectedIndexUSB : INT;
		TempSTRING : STRING[80];
		TempINT : INT;
		TableConfig_USB : STRING[255];
		TableConfig_User : STRING[255];
	END_STRUCT;
	Vis_Services_DirMan_FileList_typ : 	STRUCT 
		Num : ARRAY[0..MAX_DIR_MAN_FILE_LIST_IDX]OF UDINT;
		Path : ARRAY[0..MAX_DIR_MAN_FILE_LIST_IDX]OF STRING[260];
		DateString : ARRAY[0..MAX_DIR_MAN_FILE_LIST_IDX]OF STRING[25];
		Size : ARRAY[0..MAX_DIR_MAN_FILE_LIST_IDX]OF UDINT;
		IsDir : ARRAY[0..MAX_DIR_MAN_FILE_LIST_IDX]OF BOOL;
	END_STRUCT;
	Vis_Services_DirMan_Cmd_typ : 	STRUCT 
		Action : DIR_MAN_ACTION_ENUM;
		DirUSB : BOOL;
		DirUser : BOOL;
		PathUSB : STRING[260];
		PathUser : STRING[260];
		ParString : STRING[260];
	END_STRUCT;
END_TYPE
