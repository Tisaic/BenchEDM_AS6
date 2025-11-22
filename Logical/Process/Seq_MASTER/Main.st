
PROGRAM _INIT
	 
END_PROGRAM

PROGRAM _CYCLIC

	Eval_INIT;
	Eval_USER;
	Eval_SYS;

	Build_USER;
	Build_GEN;

	gMain.Process.Master.Internal.TC_Seq_Handler_0(Enable := TRUE, ErrorReset := gMain.ErrorReset, pJsonArray := ADR(JSONStrings));
	gMain.Process.Master.Internal.TC_Seq_Handler_0.ForceNext 			:= FALSE;
	gMain.Process.Master.Internal.TC_Seq_Handler_0.ClearBuffer 			:= FALSE;
	gMain.Process.Master.Internal.TC_Seq_Handler_0.Reset 				:= FALSE;

END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM

