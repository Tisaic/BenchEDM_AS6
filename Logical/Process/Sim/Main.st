
PROGRAM _INIT

	// Debugger Tool Option. Used to hold runtime in the init so that a breakpoint can be hit for troubleshooting.
	WHILE gPar.System.Debugger.HoldProcessInInit DO
		gPar.System.Debugger.HoldProcessInInit;	  
	END_WHILE;

	gSim.Full := DiagCpuIsARsim() OR DiagCpuIsSimulated();

	IF gSim.Full THEN		
		gMain.Services.DeviceName 									:= 'USER_DEVICE_SIM';
	ELSE		
		gMain.Services.DeviceName 									:= 'USER_DEVICE';
	END_IF;		
//Time Basis
	gSim.Time.RTInfo_0(enable := TRUE);
	gSim.Time.TimeInc												:= UDINT_TO_LREAL(gSim.Time.RTInfo_0.cycle_time)/1000000.0;

END_PROGRAM

PROGRAM _CYCLIC
//General
	gSim.Time.Time													:= gSim.Time.Time + gSim.Time.TimeInc;
	gSim.IO															:= gPar.IO.Simulate;

	IF (gSim.Full OR gSim.IO) AND gMain.Services.Recipes.Out.ParametersReady THEN
		//Safety
		gIO.Safety.TC_IO_DI_ESTOP.Sim.Logical						:= TRUE;
	END_IF;

END_PROGRAM

PROGRAM _EXIT

END_PROGRAM

