
PROGRAM _INIT
// Build Scripts
	//FirstStart
		TC_Seq_Add(ADR(gScripts.FirstStart),ADR('{"type":"D","time":"0.1"}'));
		//Seq_FirstStart_T;
		//Seq_FirstStart_V;
	    Seq_FirstStart_MR;
	    Seq_FirstStart_Z;
	    Seq_FirstStart_X;
	    Seq_FirstStart_Y;
	    Seq_FirstStart_P;
	    Seq_FirstStart_CNC;

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

