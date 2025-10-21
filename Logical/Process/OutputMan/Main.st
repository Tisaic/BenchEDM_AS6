
PROGRAM _INIT
	 
END_PROGRAM

PROGRAM _CYCLIC

	OMD_AB;
	OMD_CS;

//BX18

	IF (gIO.BX18.TC_IO_DO_Enable.Forcing.On AND gIO.BX18.TC_IO_DO_Enable.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DO_Enable.Forcing.On									:= FALSE;
		gIO.BX18.TC_IO_DO_Enable.Forcing.Off								:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DO_Enable(Par := gPar.IO.BX18.TC_IO_DO_Enable);

	IF (gIO.BX18.TC_IO_DO_ISOFreqMode.Forcing.On AND gIO.BX18.TC_IO_DO_ISOFreqMode.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DO_ISOFreqMode.Forcing.On							:= FALSE;
		gIO.BX18.TC_IO_DO_ISOFreqMode.Forcing.Off							:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DO_ISOFreqMode(Par := gPar.IO.BX18.TC_IO_DO_ISOFreqMode);

	IF (gIO.BX18.TC_IO_DO_EdgeFindMode.Forcing.On AND gIO.BX18.TC_IO_DO_EdgeFindMode.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DO_EdgeFindMode.Forcing.On							:= FALSE;
		gIO.BX18.TC_IO_DO_EdgeFindMode.Forcing.Off							:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DO_EdgeFindMode(Par := gPar.IO.BX18.TC_IO_DO_EdgeFindMode);

	IF (gIO.BX18.TC_IO_DO_ElectrodePositiveMode.Forcing.On AND gIO.BX18.TC_IO_DO_ElectrodePositiveMode.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DO_ElectrodePositiveMode.Forcing.On					:= FALSE;
		gIO.BX18.TC_IO_DO_ElectrodePositiveMode.Forcing.Off					:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DO_ElectrodePositiveMode(Par := gPar.IO.BX18.TC_IO_DO_ElectrodePositiveMode);

	IF (gIO.BX18.TC_IO_DO_ChangeRequest.Forcing.On AND gIO.BX18.TC_IO_DO_ChangeRequest.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_DO_ChangeRequest.Forcing.On							:= FALSE;
		gIO.BX18.TC_IO_DO_ChangeRequest.Forcing.Off							:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_DO_ChangeRequest(Par := gPar.IO.BX18.TC_IO_DO_ChangeRequest);

	IF (gIO.BX18.TC_IO_AO_OnTime.Forcing.On AND gIO.BX18.TC_IO_AO_OnTime.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_AO_OnTime.Forcing.On									:= FALSE;
		gIO.BX18.TC_IO_AO_OnTime.Forcing.Off								:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_AO_OnTime(Par := gPar.IO.BX18.TC_IO_AO_OnTime, VarType := TC_IO_ANALOG_TYPE_UINT);

	IF (gIO.BX18.TC_IO_AO_OffTime.Forcing.On AND gIO.BX18.TC_IO_AO_OffTime.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_AO_OffTime.Forcing.On								:= FALSE;
		gIO.BX18.TC_IO_AO_OffTime.Forcing.Off								:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_AO_OffTime(Par := gPar.IO.BX18.TC_IO_AO_OffTime, VarType := TC_IO_ANALOG_TYPE_UINT);

	IF (gIO.BX18.TC_IO_AO_Current.Forcing.On AND gIO.BX18.TC_IO_AO_Current.Forcing.Off) OR NOT gIO.ForceEnable THEN
		gIO.BX18.TC_IO_AO_Current.Forcing.On								:= FALSE;
		gIO.BX18.TC_IO_AO_Current.Forcing.Off								:= FALSE;
	END_IF;
	gIO.BX18.TC_IO_AO_Current(Par := gPar.IO.BX18.TC_IO_AO_Current, VarType := TC_IO_ANALOG_TYPE_UINT);

	gIO.BX18.Outputs_control.0												:= gIO.BX18.TC_IO_DO_Enable.Signal.IOMapping;
	gIO.BX18.Outputs_control.1												:= gIO.BX18.TC_IO_DO_ISOFreqMode.Signal.IOMapping;
	gIO.BX18.Outputs_control.2												:= gIO.BX18.TC_IO_DO_EdgeFindMode.Signal.IOMapping;
	gIO.BX18.Outputs_control.3												:= gIO.BX18.TC_IO_DO_ElectrodePositiveMode.Signal.IOMapping;
	gIO.BX18.Outputs_control.4												:= gIO.BX18.TC_IO_DO_ChangeRequest.Signal.IOMapping;
	gIO.BX18.Outputs_onTime													:= gIO.BX18.TC_IO_AO_OnTime.Signal.IOMapping.VarUINT;
	gIO.BX18.Outputs_offTime												:= gIO.BX18.TC_IO_AO_OffTime.Signal.IOMapping.VarUINT;
	gIO.BX18.Outputs_current												:= gIO.BX18.TC_IO_AO_Current.Signal.IOMapping.VarUINT;

END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM

