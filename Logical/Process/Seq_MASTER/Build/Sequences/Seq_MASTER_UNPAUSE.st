
ACTION Seq_MASTER_UNPAUSE:

	gMain.Process.Master.Internal.TC_Seq_Handler_0.Pause 	:= FALSE;
	gMain.Process.Master.Out.Status.Paused 					:= FALSE;

END_ACTION
