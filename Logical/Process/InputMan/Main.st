
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

END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM

