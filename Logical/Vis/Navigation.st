
ACTION Navigation: 
	IF gVis.Navigation.STOP THEN
		gVis.Navigation.STOP := FALSE;
		gIO.Safety.TC_IO_DI_HMI_STOP.IOMapping 		:= TRUE;
		gIO.Safety.TC_IO_DI_HMI_STOP.Sim.Logical 	:= TRUE;
	ELSIF gMain.ErrorReset THEN
		gIO.Safety.TC_IO_DI_HMI_STOP.IOMapping 		:= FALSE;
		gIO.Safety.TC_IO_DI_HMI_STOP.Sim.Logical 	:= FALSE;
	END_IF;
END_ACTION
