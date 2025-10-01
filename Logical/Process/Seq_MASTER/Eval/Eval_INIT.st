
ACTION Eval_INIT:

	FOR i := 0 TO MAX_MASTER_EVAL_IDX DO
		IF gMain.Process.Master.Internal.TC_Eval_0[i].Operator = TC_EVAL_OP_AND THEN
			brsmemset(ADR(gMain.Process.Master.Internal.TC_Eval_0[i].Logical),1,SIZEOF(gMain.Process.Master.Internal.TC_Eval_0[i].Logical));
		ELSIF gMain.Process.Master.Internal.TC_Eval_0[i].Operator = TC_EVAL_OP_OR THEN
			brsmemset(ADR(gMain.Process.Master.Internal.TC_Eval_0[i].Logical),0,SIZEOF(gMain.Process.Master.Internal.TC_Eval_0[i].Logical));
		END_IF;
	END_FOR;

END_ACTION
