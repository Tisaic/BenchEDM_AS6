
ACTION Eval_SYS:

	gMain.Process.Master.Internal.CALL												:= MASTER_CALL_IDLE;
	FOR i := 0 TO MAX_MASTER_EVAL_IDX DO
		IF gMain.Process.Master.Internal.TC_Eval_0[i].Forcing.Off AND gMain.Process.Master.Internal.TC_Eval_0[i].Forcing.On THEN
			gMain.Process.Master.Internal.TC_Eval_0[i].Forcing.Off					:= FALSE;
			gMain.Process.Master.Internal.TC_Eval_0[i].Forcing.On					:= FALSE;
		END_IF;			
//		gMain.Process.Master.Internal.TC_Eval_0[i].Sim.Active						:= gSim.Full;
//		gMain.Process.Master.Internal.TC_Eval_0[i].Sim.Logical						:= gMain.Process.Master.Internal.TC_Eval_0[i].Logical;
		IF i <= ((SIZEOF(gES.MASTER_EVAL_ENUM) / 33) - 1) THEN
			gMain.Process.Master.Internal.TC_Eval_0[i].ES_ID						:= gES.MASTER_EVAL_ENUM[i];
		END_IF;
		IF gMain.Process.Master.Internal.TC_Eval_0[i].Call <= ((SIZEOF(gES.MASTER_EVAL_ENUM) / 33) - 1) THEN
			gMain.Process.Master.Internal.TC_Eval_0[i].ES_Call						:= gES.MASTER_CALL_ENUM[gMain.Process.Master.Internal.TC_Eval_0[i].Call];
		END_IF;

		IF gMain.Services.Recipes.Out.ParametersReady THEN
			gMain.Process.Master.Internal.TC_Eval_0[i].Par 							:= gPar.Process.Master.Eval[i];
		END_IF;
		gMain.Process.Master.Internal.TC_Eval_0[i](EdgeReset := gMain.ErrorReset);
	END_FOR;
	FOR i := 0 TO MAX_MASTER_EVAL_IDX DO
		IF gMain.Process.Master.Internal.TC_Eval_0[i].Signal.Result THEN
			gMain.Process.Master.Internal.CALL										:= gMain.Process.Master.Internal.TC_Eval_0[i].Call;
			EXIT;
		END_IF;
	END_FOR;

	brsmemset(ADR(gMain.Process.Master.In.Cmd),0,SIZEOF(gMain.Process.Master.In.Cmd));
	brsmemset(ADR(gMain.Process.Master.Out),0,SIZEOF(gMain.Process.Master.Out));

END_ACTION
