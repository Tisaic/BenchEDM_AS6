
ACTION Monitor_INIT:

	brsmemset(ADR(gMain.Process.Monitor.Out),0,SIZEOF(gMain.Process.Monitor.Out));
	FOR i := 0 TO MAX_MON_IDX DO
		IF gMain.Process.Monitor.Internal.TC_Mon_0[i].Operator = TC_MON_OP_AND THEN
			brsmemset(ADR(gMain.Process.Monitor.Internal.TC_Mon_0[i].Logical),1,SIZEOF(gMain.Process.Monitor.Internal.TC_Mon_0[i].Logical));
		ELSIF gMain.Process.Monitor.Internal.TC_Mon_0[i].Operator = TC_MON_OP_OR THEN
			brsmemset(ADR(gMain.Process.Monitor.Internal.TC_Mon_0[i].Logical),0,SIZEOF(gMain.Process.Monitor.Internal.TC_Mon_0[i].Logical));
		END_IF;
	END_FOR;

END_ACTION
