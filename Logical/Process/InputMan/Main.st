
PROGRAM _INIT
	 
	gIO.Safety.TC_IO_DI_ESTOP.Sim.Logical := TRUE;

END_PROGRAM

PROGRAM _CYCLIC

// Safety
	IF (gIO.Safety.TC_IO_DI_HMI_STOP.Forcing.On AND gIO.Safety.TC_IO_DI_HMI_STOP.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.Safety.TC_IO_DI_HMI_STOP.Forcing.On									:= FALSE;
		gIO.Safety.TC_IO_DI_HMI_STOP.Forcing.Off								:= FALSE;
	END_IF;
	gIO.Safety.TC_IO_DI_HMI_STOP.Sim.Active										:= gSim.Full OR gSim.IO;
	gIO.Safety.TC_IO_DI_HMI_STOP(Par := gPar.IO.Safety.TC_IO_DI_ESTOP);

	IF (gIO.Safety.TC_IO_DI_ESTOP.Forcing.On AND gIO.Safety.TC_IO_DI_ESTOP.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.Safety.TC_IO_DI_ESTOP.Forcing.On									:= FALSE;
		gIO.Safety.TC_IO_DI_ESTOP.Forcing.Off									:= FALSE;
	END_IF;
	gIO.Safety.TC_IO_DI_ESTOP.Sim.Active										:= gSim.Full OR gSim.IO;
	gIO.Safety.TC_IO_DI_ESTOP(Par := gPar.IO.Safety.TC_IO_DI_ESTOP);

// BX18

	gIO.BX18.TC_IO_DI_ReqSettingsInvalid.IOMapping 								:= gIO.BX18.Inputs_status.00;
	gIO.BX18.TC_IO_DI_ReqStateInvalid.IOMapping         					    := gIO.BX18.Inputs_status.01;
	gIO.BX18.TC_IO_DI_EDMOutputActive.IOMapping         					    := gIO.BX18.Inputs_status.02;
	gIO.BX18.TC_IO_DI_EdgefindModeEnabled.IOMapping     					    := gIO.BX18.Inputs_status.03;
	gIO.BX18.TC_IO_DI_EdgeFound.IOMapping               					    := gIO.BX18.Inputs_status.04;
	gIO.BX18.TC_IO_DI_ISOPulseMode.IOMapping            					    := gIO.BX18.Inputs_status.05;
	gIO.BX18.TC_IO_DI_ElectrodePositiveMode.IOMapping   					    := gIO.BX18.Inputs_status.06;
	gIO.BX18.TC_IO_DI_PowerFault.IOMapping              					    := gIO.BX18.Inputs_status.07;
	gIO.BX18.TC_IO_DI_LowVoltageFault.IOMapping         					    := gIO.BX18.Inputs_status.08;
	gIO.BX18.TC_IO_DI_HighVoltageFault.IOMapping        					    := gIO.BX18.Inputs_status.09;
	gIO.BX18.TC_IO_DI_EstopActive.IOMapping             					    := gIO.BX18.Inputs_status.10;
	gIO.BX18.TC_IO_DI_OnTimeChanged.IOMapping           					    := gIO.BX18.Inputs_status.11;
	gIO.BX18.TC_IO_DI_OffTimeChanged.IOMapping          					    := gIO.BX18.Inputs_status.12;
	gIO.BX18.TC_IO_DI_CurrentChanged.IOMapping          					    := gIO.BX18.Inputs_status.13;
	gIO.BX18.TC_IO_AI_Feedback.IOMapping.VarUINT								:= gIO.BX18.Inputs_EDMservofeedback;
	gIO.BX18.TC_IO_AI_Power.IOMapping.VarUINT									:= gIO.BX18.Inputs_power;

	IF (gIO.BX18.TC_IO_DI_ReqSettingsInvalid.Forcing.On AND gIO.BX18.TC_IO_DI_ReqSettingsInvalid.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_ReqSettingsInvalid.Forcing.On							:= FALSE;
		gIO.BX18.TC_IO_DI_ReqSettingsInvalid.Forcing.Off						:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_ReqSettingsInvalid.Sim.Active								:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_ReqSettingsInvalid(Par := gPar.IO.BX18.TC_IO_DI_ReqSettingsInvalid);

	IF (gIO.BX18.TC_IO_DI_ReqStateInvalid.Forcing.On AND gIO.BX18.TC_IO_DI_ReqStateInvalid.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_ReqStateInvalid.Forcing.On							:= FALSE;
		gIO.BX18.TC_IO_DI_ReqStateInvalid.Forcing.Off							:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_ReqStateInvalid.Sim.Active								:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_ReqStateInvalid(Par := gPar.IO.BX18.TC_IO_DI_ReqStateInvalid);

	IF (gIO.BX18.TC_IO_DI_EDMOutputActive.Forcing.On AND gIO.BX18.TC_IO_DI_EDMOutputActive.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_EDMOutputActive.Forcing.On							:= FALSE;
		gIO.BX18.TC_IO_DI_EDMOutputActive.Forcing.Off							:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_EDMOutputActive.Sim.Active								:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_EDMOutputActive(Par := gPar.IO.BX18.TC_IO_DI_EDMOutputActive);

	IF (gIO.BX18.TC_IO_DI_EdgefindModeEnabled.Forcing.On AND gIO.BX18.TC_IO_DI_EdgefindModeEnabled.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_EdgefindModeEnabled.Forcing.On						:= FALSE;
		gIO.BX18.TC_IO_DI_EdgefindModeEnabled.Forcing.Off						:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_EdgefindModeEnabled.Sim.Active							:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_EdgefindModeEnabled(Par := gPar.IO.BX18.TC_IO_DI_EdgefindModeEnabled);

	IF (gIO.BX18.TC_IO_DI_EdgeFound.Forcing.On AND gIO.BX18.TC_IO_DI_EdgeFound.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_EdgeFound.Forcing.On									:= FALSE;
		gIO.BX18.TC_IO_DI_EdgeFound.Forcing.Off									:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_EdgeFound.Sim.Active										:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_EdgeFound(Par := gPar.IO.BX18.TC_IO_DI_EdgeFound);

	IF (gIO.BX18.TC_IO_DI_ISOPulseMode.Forcing.On AND gIO.BX18.TC_IO_DI_ISOPulseMode.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_ISOPulseMode.Forcing.On								:= FALSE;
		gIO.BX18.TC_IO_DI_ISOPulseMode.Forcing.Off								:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_ISOPulseMode.Sim.Active									:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_ISOPulseMode(Par := gPar.IO.BX18.TC_IO_DI_ISOPulseMode);

	IF (gIO.BX18.TC_IO_DI_ElectrodePositiveMode.Forcing.On AND gIO.BX18.TC_IO_DI_ElectrodePositiveMode.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_ElectrodePositiveMode.Forcing.On						:= FALSE;
		gIO.BX18.TC_IO_DI_ElectrodePositiveMode.Forcing.Off						:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_ElectrodePositiveMode.Sim.Active							:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_ElectrodePositiveMode(Par := gPar.IO.BX18.TC_IO_DI_ElectrodePositiveMode);

	IF (gIO.BX18.TC_IO_DI_PowerFault.Forcing.On AND gIO.BX18.TC_IO_DI_PowerFault.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_PowerFault.Forcing.On									:= FALSE;
		gIO.BX18.TC_IO_DI_PowerFault.Forcing.Off								:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_PowerFault.Sim.Active										:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_PowerFault(Par := gPar.IO.BX18.TC_IO_DI_PowerFault);

	IF (gIO.BX18.TC_IO_DI_LowVoltageFault.Forcing.On AND gIO.BX18.TC_IO_DI_LowVoltageFault.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_LowVoltageFault.Forcing.On							:= FALSE;
		gIO.BX18.TC_IO_DI_LowVoltageFault.Forcing.Off							:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_LowVoltageFault.Sim.Active								:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_LowVoltageFault(Par := gPar.IO.BX18.TC_IO_DI_LowVoltageFault);

	IF (gIO.BX18.TC_IO_DI_HighVoltageFault.Forcing.On AND gIO.BX18.TC_IO_DI_HighVoltageFault.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_HighVoltageFault.Forcing.On							:= FALSE;
		gIO.BX18.TC_IO_DI_HighVoltageFault.Forcing.Off							:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_HighVoltageFault.Sim.Active								:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_HighVoltageFault(Par := gPar.IO.BX18.TC_IO_DI_HighVoltageFault);

	IF (gIO.BX18.TC_IO_DI_EstopActive.Forcing.On AND gIO.BX18.TC_IO_DI_EstopActive.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_EstopActive.Forcing.On								:= FALSE;
		gIO.BX18.TC_IO_DI_EstopActive.Forcing.Off								:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_EstopActive.Sim.Active									:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_EstopActive(Par := gPar.IO.BX18.TC_IO_DI_EstopActive);

	IF (gIO.BX18.TC_IO_DI_OnTimeChanged.Forcing.On AND gIO.BX18.TC_IO_DI_OnTimeChanged.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_OnTimeChanged.Forcing.On								:= FALSE;
		gIO.BX18.TC_IO_DI_OnTimeChanged.Forcing.Off								:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_OnTimeChanged.Sim.Active									:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_OnTimeChanged(Par := gPar.IO.BX18.TC_IO_DI_OnTimeChanged);

	IF (gIO.BX18.TC_IO_DI_OffTimeChanged.Forcing.On AND gIO.BX18.TC_IO_DI_OffTimeChanged.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_OffTimeChanged.Forcing.On								:= FALSE;
		gIO.BX18.TC_IO_DI_OffTimeChanged.Forcing.Off							:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_OffTimeChanged.Sim.Active									:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_OffTimeChanged(Par := gPar.IO.BX18.TC_IO_DI_OffTimeChanged);

	IF (gIO.BX18.TC_IO_DI_CurrentChanged.Forcing.On AND gIO.BX18.TC_IO_DI_CurrentChanged.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DI_CurrentChanged.Forcing.On								:= FALSE;
		gIO.BX18.TC_IO_DI_CurrentChanged.Forcing.Off							:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DI_CurrentChanged.Sim.Active									:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_DI_CurrentChanged(Par := gPar.IO.BX18.TC_IO_DI_CurrentChanged);

	IF (gIO.BX18.TC_IO_AI_Feedback.Forcing.On AND gIO.BX18.TC_IO_AI_Feedback.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_AI_Feedback.Forcing.On									:= FALSE;
		gIO.BX18.TC_IO_AI_Feedback.Forcing.Off									:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_AI_Feedback.Sim.Active										:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_AI_Feedback(Par := gPar.IO.BX18.TC_IO_AI_Feedback, VarType := TC_IO_ANALOG_TYPE_UINT);

	IF (gIO.BX18.TC_IO_AI_Power.Forcing.On AND gIO.BX18.TC_IO_AI_Power.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_AI_Power.Forcing.On										:= FALSE;
		gIO.BX18.TC_IO_AI_Power.Forcing.Off										:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_AI_Power.Sim.Active											:= gSim.Full OR gSim.IO;
	gIO.BX18.TC_IO_AI_Power(Par := gPar.IO.BX18.TC_IO_AI_Power, VarType := TC_IO_ANALOG_TYPE_UINT);

//Motion

	IF (gIO.Motion.TC_IO_DI_HomeSwitchZ.Forcing.On AND gIO.Motion.TC_IO_DI_HomeSwitchZ.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.Motion.TC_IO_DI_HomeSwitchZ.Forcing.On								:= FALSE;
		gIO.Motion.TC_IO_DI_HomeSwitchZ.Forcing.Off								:= FALSE;
	END_IF;	
	gIO.Motion.TC_IO_DI_HomeSwitchZ.Sim.Active									:= gSim.Full OR gSim.IO;
	gIO.Motion.TC_IO_DI_HomeSwitchZ(Par := gPar.IO.Motion.TC_IO_DI_HomeSwitchZ);

END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM

