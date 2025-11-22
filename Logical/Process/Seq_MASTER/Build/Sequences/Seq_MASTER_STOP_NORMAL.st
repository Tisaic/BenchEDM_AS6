
ACTION Seq_MASTER_STOP_NORMAL:

	brsmemset(ADR(JSONStrings),0,SIZEOF(JSONStrings));
	gMain.Process.Master.Internal.TC_Seq_Handler_0.Reset := TRUE;
	gDriver.ResetAll := TRUE;

END_ACTION
