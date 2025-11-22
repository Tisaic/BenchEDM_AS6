
PROGRAM _INIT
	 
END_PROGRAM

PROGRAM _CYCLIC

	OMD_CN;
	OMD_TR;
	OMD_AB;
	OMD_CS;
	OMD_MR;
	gDriver.ResetAll := FALSE;

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
//Stepper Z
	gIO.Stepper.SetPosition 												:= LREAL_TO_DINT(gDriver.AB[DRIVER_INST_AB_RZ_0_0].Status.Position*200.0); //200.0 is the scaling to get 1mm travel for 1000 dip switch setting on stepper drive
	gIO.Stepper.StepDelay 													:= STEPDELAY;
	gIO.Stepper.ENABLE														:= gIO.Stepper.ModuleOK;
	gIO.Stepper.SwitchedOn													:= gIO.Stepper.ENABLED AND gIO.Stepper.SwitchOn AND gIO.Safety.TC_IO_DI_ESTOP.Signal.Filtered;
	gIO.Stepper.Home														:= EDGEPOS(gDriver.AB[DRIVER_INST_AB_RZ_0_0].MpAxisBasic_0.IsHomed);
//MbRTU VFDs
	FOR i := 0 TO MAX_VFD_IDX DO
		gIO.VFD[i].DataWrite[0] := gIO.VFD[i].CMD;
		gIO.VFD[i].DataWrite[1] := gIO.VFD[i].LFRD;
		FOR j := 0 TO MAX_VFD_DATA_READ_IDX DO
			gIO.VFD[i].EventRead[j]											:= TRUE;
		END_FOR;
		gIO.VFD[i].CTON_AutoWrite(IN := NOT gIO.VFD[i].CTON_AutoWrite.Q, PT := T#500ms);
		FOR j := 0 TO MAX_VFD_DATA_WRITE_IDX DO
			IF gIO.VFD[i].DataWriteCmp[j] <> gIO.VFD[i].DataWrite[j] OR gIO.VFD[i].CTON_AutoWrite.Q THEN
				gIO.VFD[i].EventWrite[j]									:= TRUE;
				gIO.VFD[i].DataWriteCmp[j] 									:= gIO.VFD[i].DataWrite[j];
			END_IF;
		END_FOR;
		gIO.VFD[i].ETA := gIO.VFD[i].DataRead[0];
		gIO.VFD[i].RFRD := gIO.VFD[i].DataRead[1];
		gIO.VFD[i].LFT := gIO.VFD[i].DataRead[2];
	END_FOR;

END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM

