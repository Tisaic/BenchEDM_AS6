

FUNCTION_BLOCK TC_Mon
//Usage for warning supression
	ES_ID;
	Sev;
	Mask;
//Interaction
	IF Forcing.Off THEN
		Signal.Logical					:= FALSE;
	ELSIF Forcing.On THEN
		Signal.Logical					:= TRUE;
	ELSIF Sim.Active THEN
		Signal.Logical					:= Sim.Logical;
	ELSIF Operator = TC_MON_OP_AND THEN
		Signal.Logical					:= TRUE;
		FOR Internal.i := 0 TO MAX_MON_LOGICAL_IDX DO
			IF NOT Logical[Internal.i] THEN
				Signal.Logical			:= FALSE;
				EXIT;
			END_IF;
		END_FOR;
	ELSIF Operator = TC_MON_OP_OR THEN
		Signal.Logical					:= FALSE;
		FOR Internal.i := 0 TO MAX_MON_LOGICAL_IDX DO
			IF Logical[Internal.i] THEN
				Signal.Logical			:= TRUE;
				EXIT;
			END_IF;
		END_FOR;
	ELSE
		Signal.Logical					:= FALSE;
	END_IF;
//Debouncing
	IF Signal.Logical THEN
		Internal.CTON_DB_Off(IN := FALSE);
		Internal.CTON_DB_On(IN := TRUE, PT := LREAL_TO_TIME(Par.FilterOnTime*1000.0));
		IF Internal.CTON_DB_On.Q OR Par.FilterOnTime <= 0.0 THEN
			Signal.Result				:= TRUE;
		END_IF;
	ELSE
		Internal.CTON_DB_On(IN := FALSE);
		Internal.CTON_DB_Off(IN := TRUE, PT := LREAL_TO_TIME(Par.FilterOffTime*1000.0));
		IF Internal.CTON_DB_Off.Q OR Par.FilterOffTime <= 0.0 THEN
			Signal.Result				:= FALSE;
		END_IF;
	END_IF;
//Edges
	IF EdgeReset THEN
		Signal.EdgePosResult			:= FALSE;
		Signal.EdgeNegResult			:= FALSE;
		Internal.StatusResult			:= FALSE;
	ELSE
		Signal.EdgeNegResult			:= FALSE;
		IF Internal.StatusResult AND NOT Signal.Result THEN
			Signal.EdgeNegResult		:= TRUE;
		END_IF;
		Signal.EdgePosResult			:= FALSE;
		IF NOT Internal.StatusResult AND Signal.Result THEN
			Signal.EdgePosResult		:= TRUE;
		END_IF;
		Internal.StatusResult 			:= Signal.Result;
	END_IF;
END_FUNCTION_BLOCK
