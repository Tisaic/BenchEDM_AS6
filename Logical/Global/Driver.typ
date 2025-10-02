
TYPE
	Driver_typ : 	STRUCT 
		FI : ARRAY[0..MAX_DRIVER_FI_IDX]OF Driver_FI_typ;
		AB : ARRAY[0..MAX_DRIVER_AB_IDX]OF Driver_AB_typ;
		CS : ARRAY[0..MAX_DRIVER_CS_IDX]OF Driver_CS_typ;
		CN : ARRAY[0..MAX_DRIVER_CN_IDX]OF Driver_CN_typ;
	END_STRUCT;
	Driver_Par_Mon_typ : 	STRUCT 
		Enable : BOOL;
		Sev : DINT;
		Time : LREAL;
	END_STRUCT;
	Driver_CS_typ : 	STRUCT 
		Cmd : ARRAY[0..MAX_DRIVER_CS_CMD_IDX]OF BOOL;
		Wait : ARRAY[0..MAX_DRIVER_CS_WAIT_IDX]OF DINT;
		Mon : ARRAY[0..MAX_DRIVER_CS_MON_IDX]OF BOOL;
		Sev : ARRAY[0..MAX_DRIVER_CS_MON_IDX]OF DINT;
		CTON_Mon : ARRAY[0..MAX_DRIVER_CS_MON_IDX]OF CTON;
		DefaultPar : Driver_CS_Par_typ;
		Par : Driver_CS_Par_typ;
		Status : Driver_CS_Status_typ;
		MpAxisCyclicSet_0 : MpAxisCyclicSet;
		MpLinkADR : UDINT;
		CyclicPositionSetpoint : ARRAY[0..MAX_DRIVER_CS_SOURCE_IDX]OF LREAL;
		CyclicTorqueSetpoint : ARRAY[0..MAX_DRIVER_CS_SOURCE_IDX]OF REAL;
		CyclicTorqueFeedForwardSetpoint : ARRAY[0..MAX_DRIVER_CS_SOURCE_IDX]OF REAL;
		CyclicVelocitySetpoint : ARRAY[0..MAX_DRIVER_CS_SOURCE_IDX]OF REAL;
		FirstScanComplete : BOOL;
	END_STRUCT;
	Driver_CS_Par_typ : 	STRUCT 
		Mon : ARRAY[0..MAX_DRIVER_CS_MON_IDX]OF Driver_Par_Mon_typ;
		CS : MpAxisCyclicSetParType;
		CyclicPositionSource : DINT;
		CyclicTorqueSource : DINT;
		CyclicTorqueFeedForwardSource : DINT;
		CyclicVelocitySource : DINT;
	END_STRUCT;
	Driver_CS_Status_typ : 	STRUCT 
		Severity : DINT;
	END_STRUCT;
	Driver_AB_typ : 	STRUCT 
		Cmd : ARRAY[0..MAX_DRIVER_AB_CMD_IDX]OF BOOL;
		Wait : ARRAY[0..MAX_DRIVER_AB_WAIT_IDX]OF DINT;
		Mon : ARRAY[0..MAX_DRIVER_AB_MON_IDX]OF BOOL;
		Sev : ARRAY[0..MAX_DRIVER_AB_MON_IDX]OF DINT;
		CTON_Mon : ARRAY[0..MAX_DRIVER_AB_MON_IDX]OF CTON;
		Par : Driver_AB_Par_typ;
		DefaultPar : Driver_AB_Par_typ;
		Status : Driver_AB_Status_typ;
		MpAxisBasic_0 : MpAxisBasic;
		MpLinkADR : UDINT;
		FirstScanComplete : BOOL;
	END_STRUCT;
	Driver_AB_Par_typ : 	STRUCT 
		Mon : ARRAY[0..MAX_DRIVER_AB_MON_IDX]OF Driver_Par_Mon_typ;
		AB : MpAxisBasicParType;
	END_STRUCT;
	Driver_AB_Status_typ : 	STRUCT 
		Position : LREAL;
		Velocity : LREAL;
		Severity : DINT;
	END_STRUCT;
	Driver_FI_typ : 	STRUCT 
		Cmd : ARRAY[0..MAX_DRIVER_FI_CMD_IDX]OF BOOL;
		Wait : ARRAY[0..MAX_DRIVER_FI_WAIT_IDX]OF DINT;
		Par : Driver_FI_Par_typ;
		FileClose : FileClose;
		FileCopy : FileCopy;
		FileCreate : FileCreate;
		FileDelete : FileDelete;
		FileInfo : FileInfo;
		FileOpen : FileOpen;
		FileReadEx : FileReadEx;
		FileRename : FileRename;
		FileTruncate : FileTruncate;
		FileWriteEx : FileWriteEx;
		DirCopy : DirCopy;
		DirCreate : DirCreate;
		DirDeleteEx : DirDeleteEx;
		DirInfo : DirInfo;
		DirOpen : DirOpen;
		DirReadEx : DirReadEx;
		DirRename : DirRename;
		DirClose : DirClose;
		GetAttributes : GetAttributes;
		SetAttributes : SetAttributes;
		GetVolumeLabel : GetVolumeLabel;
		GetVolumeSerialNo : GetVolumeSerialNo;
		DevLink : DevLink;
		DevMemInfo : DevMemInfo;
		DevUnlink : DevUnlink;
	END_STRUCT;
	Driver_FI_Par_typ : 	STRUCT 
		FileName : STRING[255];
	END_STRUCT;
	Driver_CN_typ : 	STRUCT 
		Cmd : ARRAY[0..MAX_DRIVER_CN_CMD_IDX]OF BOOL;
		Wait : ARRAY[0..MAX_DRIVER_CN_WAIT_IDX]OF DINT;
		Mon : ARRAY[0..MAX_DRIVER_CN_MON_IDX]OF BOOL;
		Sev : ARRAY[0..MAX_DRIVER_CN_MON_IDX]OF DINT;
		CTON_Mon : ARRAY[0..MAX_DRIVER_CN_MON_IDX]OF CTON;
		Par : Driver_CN_Par_typ;
		DefaultPar : Driver_CN_Par_typ;
		Status : Driver_CN_Status_typ;
		MpCncFlex_0 : MpCncFlex;
		MpLinkADR : UDINT;
		OverrideSetpoint : ARRAY[0..MAX_DRIVER_CN_SOURCE_IDX]OF REAL;
		RapidOverrideSetpoint : ARRAY[0..MAX_DRIVER_CN_SOURCE_IDX]OF REAL;
		FeedrateOverrideSetpoint : ARRAY[0..MAX_DRIVER_CN_SOURCE_IDX]OF REAL;
		FirstScanComplete : BOOL;
	END_STRUCT;
	Driver_CN_Par_typ : 	STRUCT 
		Mon : ARRAY[0..MAX_DRIVER_CN_MON_IDX]OF Driver_Par_Mon_typ;
		CN : MpCncFlexParType;
		OverrideSource : DINT;
		RapidOverrideSource : DINT;
		FeedrateOverrideSource : DINT;
	END_STRUCT;
	Driver_CN_Status_typ : 	STRUCT 
		Severity : DINT;
		Position : ARRAY[0..14]OF LREAL;
		PathVelocity : REAL;
		Info : MpCncFlexInfoType;
	END_STRUCT;
END_TYPE
