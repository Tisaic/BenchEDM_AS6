
ACTION Eval_USER:
	
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_RESET].Operator								:= TC_EVAL_OP_AND;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_RESET].Logical[0]							:= gMain.Process.Master.In.Cmd.Reset;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_RESET].Call									:= MASTER_CALL_RESET;

	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_INIT].Operator								:= TC_EVAL_OP_OR;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_INIT].Logical[0]							:= NOT gRemOK;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_INIT].Call									:= MASTER_CALL_RESET;

	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_STOP_UNCONTROLLED].Operator					:= TC_EVAL_OP_AND;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_STOP_UNCONTROLLED].Logical[0]				:= gMain.Process.Master.In.Cmd.UncontrolledStop;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_STOP_UNCONTROLLED].Call						:= MASTER_CALL_STOP_UNCONTROLLED;

	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_STOP_CONTROLLED].Operator					:= TC_EVAL_OP_AND;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_STOP_CONTROLLED].Logical[0]					:= gMain.Process.Master.In.Cmd.ControlledStop;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_STOP_CONTROLLED].Call						:= MASTER_CALL_STOP_CONTROLLED;
	
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_STOP_NORMAL].Operator						:= TC_EVAL_OP_AND;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_STOP_NORMAL].Logical[0]						:= gMain.Process.Master.In.Cmd.NormalStop;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_STOP_NORMAL].Call							:= MASTER_CALL_STOP_NORMAL;
	
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_WAIT_BUFFER_EMPTY].Operator					:= TC_EVAL_OP_AND;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_WAIT_BUFFER_EMPTY].Logical[0]				:= JSONStrings[0] <> '';
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_WAIT_BUFFER_EMPTY].Call						:= MASTER_CALL_IDLE;

	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_UNPAUSE].Operator							:= TC_EVAL_OP_AND;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_UNPAUSE].Logical[0]							:= gMain.Process.Master.Out.Status.Paused;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_UNPAUSE].Logical[1]							:= gMain.Process.Master.In.Cmd.Start OR gMain.Process.Master.In.Cmd.Unpause;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_UNPAUSE].Call								:= MASTER_CALL_UNPAUSE;

	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_PAUSE].Operator								:= TC_EVAL_OP_OR;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_PAUSE].Logical[0]							:= gMain.Process.Master.In.Cmd.Pause;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_PAUSE].Logical[1]							:= gMain.Process.Master.Out.Status.Paused;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_PAUSE].Call									:= MASTER_CALL_PAUSE;

	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_START].Operator								:= TC_EVAL_OP_AND;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_START].Logical[0]							:= gMain.Process.Master.In.Cmd.Start;
	gMain.Process.Master.Internal.TC_Eval_0[MASTER_EVAL_START].Call									:= MASTER_CALL_START;

END_ACTION
