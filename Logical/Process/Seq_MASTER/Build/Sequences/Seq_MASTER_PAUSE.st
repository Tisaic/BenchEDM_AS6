
ACTION Seq_MASTER_PAUSE:

	gMain.Process.Master.Internal.TC_Seq_Handler_0.Pause 	:= TRUE;
	gMain.Process.Master.Out.Status.Paused 					:= TRUE;

END_ACTION
