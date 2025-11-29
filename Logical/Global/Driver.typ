
TYPE
	Driver_typ : 	STRUCT 
		ResetAll : BOOL;
		IN : ARRAY[0..MAX_DRIVER_IN_IDX]OF Driver_IN_typ;
		AA : ARRAY[0..MAX_DRIVER_AA_IDX]OF Driver_AA_typ;
		AB : ARRAY[0..MAX_DRIVER_AB_IDX]OF Driver_AB_typ;
		CS : ARRAY[0..MAX_DRIVER_CS_IDX]OF Driver_CS_typ;
		CN : ARRAY[0..MAX_DRIVER_CN_IDX]OF Driver_CN_typ;
		TR : ARRAY[0..MAX_DRIVER_TR_IDX]OF Driver_TR_typ;
		MR : ARRAY[0..MAX_DRIVER_MR_IDX]OF Driver_MR_typ;
		FI : ARRAY[0..MAX_DRIVER_FI_IDX]OF Driver_FI_typ;
		OU : ARRAY[0..MAX_DRIVER_OU_IDX]OF Driver_OU_typ;
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
		ParametersLoaded : BOOL;
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
		ParametersLoaded : BOOL;
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
		MC_GroupReadActualPosition_15_0 : MC_GroupReadActualPosition_15;
		MpLinkADR : UDINT;
		OverrideSetpoint : ARRAY[0..MAX_DRIVER_CN_SOURCE_IDX]OF REAL;
		RapidOverrideSetpoint : ARRAY[0..MAX_DRIVER_CN_SOURCE_IDX]OF REAL;
		FeedrateOverrideSetpoint : ARRAY[0..MAX_DRIVER_CN_SOURCE_IDX]OF REAL;
		FirstScanComplete : BOOL;
		ParametersLoaded : BOOL;
	END_STRUCT;
	Driver_CN_Par_typ : 	STRUCT 
		Mon : ARRAY[0..MAX_DRIVER_CN_MON_IDX]OF Driver_Par_Mon_typ;
		CN : MpCncFlexParType;
		OverrideSource : DINT;
		RapidOverrideSource : DINT;
		FeedrateOverrideSource : DINT;
		Kinematics : ARRAY[0..14]OF LREAL;
	END_STRUCT;
	Driver_CN_Status_typ : 	STRUCT 
		Severity : DINT;
		Position : ARRAY[0..14]OF LREAL;
		Position_mcJACS : ARRAY[0..14]OF LREAL;
		PathVelocity : REAL;
		Info : MpCncFlexInfoType;
	END_STRUCT;
	Driver_IN_typ : 	STRUCT 
		Cmd : ARRAY[0..MAX_DRIVER_IN_CMD_IDX]OF BOOL;
		Wait : ARRAY[0..MAX_DRIVER_IN_WAIT_IDX]OF DINT;
		Mon : ARRAY[0..MAX_DRIVER_IN_MON_IDX]OF BOOL;
		Sev : ARRAY[0..MAX_DRIVER_IN_MON_IDX]OF DINT;
		CTON_Mon : ARRAY[0..MAX_DRIVER_IN_MON_IDX]OF CTON;
		Par : Driver_IN_Par_typ;
		DefaultPar : Driver_IN_Par_typ;
		Status : Driver_IN_Status_typ;
		FirstScanComplete : BOOL;
		New_Member : USINT;
		DI_Estop : TC_IO_DI;
	END_STRUCT;
	Driver_IN_Par_typ : 	STRUCT 
		Mon : ARRAY[0..MAX_DRIVER_IN_MON_IDX]OF Driver_Par_Mon_typ;
		ForceEnable : BOOL;
		DI_Estop_Par : TC_IO_Digital_Par_typ;
		DI_Estop_Forcing : TC_IO_Digital_Forcing_typ;
		DI_Estop_Sim : TC_IO_Digital_Sim_typ;
	END_STRUCT;
	Driver_IN_Status_typ : 	STRUCT 
		Severity : DINT;
	END_STRUCT;
	Driver_OU_typ : 	STRUCT 
		Cmd : ARRAY[0..MAX_DRIVER_OU_CMD_IDX]OF BOOL;
		Wait : ARRAY[0..MAX_DRIVER_OU_WAIT_IDX]OF DINT;
		Mon : ARRAY[0..MAX_DRIVER_OU_MON_IDX]OF BOOL;
		Sev : ARRAY[0..MAX_DRIVER_OU_MON_IDX]OF DINT;
		CTON_Mon : ARRAY[0..MAX_DRIVER_OU_MON_IDX]OF CTON;
		Par : Driver_OU_Par_typ;
		DefaultPar : Driver_OU_Par_typ;
		Status : Driver_OU_Status_typ;
		FirstScanComplete : BOOL;
	END_STRUCT;
	Driver_OU_Par_typ : 	STRUCT 
		Mon : ARRAY[0..MAX_DRIVER_OU_MON_IDX]OF Driver_Par_Mon_typ;
		DO_Enable : TC_IO_Digital_Par_typ;
	END_STRUCT;
	Driver_OU_Status_typ : 	STRUCT 
		Severity : DINT;
	END_STRUCT;
	Driver_TR_typ : 	STRUCT 
		Cmd : ARRAY[0..MAX_DRIVER_TR_CMD_IDX]OF BOOL;
		Wait : ARRAY[0..MAX_DRIVER_TR_WAIT_IDX]OF DINT;
		Mon : ARRAY[0..MAX_DRIVER_TR_MON_IDX]OF BOOL;
		Sev : ARRAY[0..MAX_DRIVER_TR_MON_IDX]OF DINT;
		CTON_Mon : ARRAY[0..MAX_DRIVER_TR_MON_IDX]OF CTON;
		DefaultPar : Driver_TR_Par_typ;
		Par : Driver_TR_Par_typ;
		Status : Driver_TR_Status_typ;
		FirstScanComplete : BOOL;
		ParametersLoaded : BOOL;
	END_STRUCT;
	Driver_TR_Par_typ : 	STRUCT 
		Mon : ARRAY[0..MAX_DRIVER_TR_MON_IDX]OF Driver_Par_Mon_typ;
		ControlMode : TR_CONTROL_MODE_ENUM;
		WorldCoordMode : BOOL;
		VelocityFactor : LREAL;
		Filter : LREAL;
		Gain : REAL;
		IntegralTime : REAL;
	END_STRUCT;
	Driver_TR_Status_typ : 	STRUCT 
		Active : BOOL;
		Severity : DINT;
		TotalLag : LREAL;
		Lag : ARRAY[0..14]OF LREAL;
		SetTCP : ARRAY[0..14]OF LREAL;
		SetJoint : ARRAY[0..14]OF LREAL;
		TcpMatrix : ARRAY[0..3,0..3]OF LREAL;
		TcpSetpoint : ARRAY[0..14]OF LREAL;
		TcpSetpointLastStable : ARRAY[0..14]OF LREAL;
		InputCmd : ARRAY[0..14]OF LREAL;
		LimitedCmd : ARRAY[0..14]OF LREAL;
		VelCmd : ARRAY[0..14]OF LREAL;
		VelCmd_World : ARRAY[0..14]OF LREAL;
		Override : LREAL;
		MTBasicsPID_0 : ARRAY[0..14]OF MTBasicsPID;
	END_STRUCT;
	Driver_MR_typ : 	STRUCT 
		Cmd : ARRAY[0..MAX_DRIVER_MR_CMD_IDX]OF BOOL;
		Wait : ARRAY[0..MAX_DRIVER_MR_WAIT_IDX]OF DINT;
		Mon : ARRAY[0..MAX_DRIVER_MR_MON_IDX]OF BOOL;
		Sev : ARRAY[0..MAX_DRIVER_MR_MON_IDX]OF DINT;
		CTON_Mon : ARRAY[0..MAX_DRIVER_MR_MON_IDX]OF CTON;
		DefaultPar : Driver_MR_Par_typ;
		Par : Driver_MR_Par_typ;
		Status : Driver_MR_Status_typ;
		FirstScanComplete : BOOL;
		ParametersLoaded : BOOL;
		Ident : UDINT;
		MBMOpen_0 : MBMOpen;
		MBMaster_0 : MBMaster;
		MBMCmd_0 : MBMCmd;
		MBMClose_0 : MBMClose;
	END_STRUCT;
	Driver_MR_Par_typ : 	STRUCT 
		Mon : ARRAY[0..MAX_DRIVER_TR_MON_IDX]OF Driver_Par_Mon_typ;
		Device : STRING[255];
		Mode : STRING[255];
		DataObject : STRING[255];
		IsAscii : BOOL;
		Timeout : LREAL;
		CmdNode : UDINT;
		CmdFunctionCall : UDINT;
		CmdOffset : UDINT;
		CmdData : UINT;
	END_STRUCT;
	Driver_MR_Status_typ : 	STRUCT 
		Active : BOOL;
		Severity : DINT;
	END_STRUCT;
	Driver_AA_typ : 	STRUCT 
		Cmd : ARRAY[0..MAX_DRIVER_AA_CMD_IDX]OF BOOL;
		Wait : ARRAY[0..MAX_DRIVER_AA_WAIT_IDX]OF DINT;
		Mon : ARRAY[0..MAX_DRIVER_AA_MON_IDX]OF BOOL;
		Sev : ARRAY[0..MAX_DRIVER_AA_MON_IDX]OF DINT;
		CTON_Mon : ARRAY[0..MAX_DRIVER_AA_MON_IDX]OF CTON;
		Par : Driver_AA_Par_typ;
		DefaultPar : Driver_AA_Par_typ;
		Status : Driver_AA_Status_typ;
		MpAxisBasic_0 : MpAxisBasic;
		MpLinkADR : UDINT;
		FirstScanComplete : BOOL;
		ParametersLoaded : BOOL;
	END_STRUCT;
	Driver_AA_Par_typ : 	STRUCT 
		Mon : ARRAY[0..MAX_DRIVER_AA_MON_IDX]OF Driver_Par_Mon_typ;
		AA : MpAxisBasicParType;
	END_STRUCT;
	Driver_AA_Status_typ : 	STRUCT 
		Position : LREAL;
		Velocity : LREAL;
		Severity : DINT;
	END_STRUCT;
END_TYPE
