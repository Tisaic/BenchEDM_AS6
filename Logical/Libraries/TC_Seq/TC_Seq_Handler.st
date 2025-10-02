
(* Sequence Handler *)
FUNCTION_BLOCK TC_Seq_Handler
	IF NOT Enable OR Reset OR pJsonArray = 0 THEN
		Internal.State									:= TC_SEQ_HANDLER_RESET;
	ELSIF ClearBuffer THEN
		brsmemset(pJsonArray,0,SIZEOF(Internal.TempJson)*DINT_TO_UDINT((MAX_TC_SEQ_BUFFER_IDX+1)));
	END_IF;
	brsmemset(ADR(Out.Status),0,SIZEOF(Out.Status));
	CASE Internal.State OF
		TC_SEQ_HANDLER_RESET:
			brsmemset(ADR(Internal),0,SIZEOF(Internal));
			brsmemset(ADR(Out),0,SIZEOF(Out));
			Out.Status.CurrentState						:= 'TC_SEQ_HANDLER_RESET';
			IF Enable AND NOT Reset THEN
				Internal.State							:= TC_SEQ_HANDLER_EVAL;
			END_IF;
		TC_SEQ_HANDLER_EVAL:
			Out.Status.CurrentState						:= 'TC_SEQ_HANDLER_EVAL';
			Out.Status.Processing						:= TRUE;
			brsmemset(ADR(Internal.CurrentBuffer),0,SIZEOF(Internal.CurrentBuffer));
			brsmemset(ADR(Internal.TempJson),0,SIZEOF(Internal.TempJson));
			IF Pause THEN
				Out.Status.Processing					:= FALSE;
				Out.Status.Paused						:= TRUE;
			ELSE
				FOR Internal.i := MAX_TC_SEQ_BUFFER_IDX TO 0 BY -1 DO
					brsmemcpy(ADR(Internal.TempJson),pJsonArray+Internal.i*SIZEOF(Internal.TempJson),SIZEOF(Internal.TempJson));
					IF Internal.TempJson <> '' THEN
						Internal.Status := TC_Seq_JsonToElem(ADR(Internal.TempJson),ADR(Internal.CurrentBuffer));
						IF Internal.Status = 0 THEN
							brsmemset(pJsonArray+Internal.i*SIZEOF(Internal.TempJson),0,SIZEOF(Internal.TempJson));
						ELSE
							Out.Status.ErrorID 	:= Internal.Status;
							Out.Status.Error 	:= TRUE;
						END_IF;
						EXIT;
					END_IF;
				END_FOR;
				IF NOT Out.Status.Error THEN
					CASE Internal.CurrentBuffer.Type OF
						TC_SEQ_TYPE_NONE:
							Out.Status.Processing			:= FALSE;
							Out.Status.Ready				:= TRUE;
						TC_SEQ_TYPE_CMD:
							Out.Status.Processing			:= TRUE;
							IF Internal.CurrentBuffer.Time <> 0 THEN
								Internal.State				:= TC_SEQ_HANDLER_CMD;
							END_IF;
						TC_SEQ_TYPE_WAIT:
							Out.Status.Processing			:= TRUE;
							Internal.State					:= TC_SEQ_HANDLER_WAIT;
						TC_SEQ_TYPE_MON:
							Out.Status.Processing			:= TRUE;
						TC_SEQ_TYPE_DELAY:
							Out.Status.Processing			:= TRUE;
							IF Internal.CurrentBuffer.Time > 0.0 THEN
								Internal.RTInfo_0(enable := TRUE);
								Internal.TimeIncrement		:= UDINT_TO_LREAL(Internal.RTInfo_0.cycle_time)/1000000.0;
								Internal.CurrentDelay		:= Internal.CurrentBuffer.Time - Internal.TimeIncrement*3.0;
								IF Internal.CurrentDelay >= 0.0 THEN
									Internal.State			:= TC_SEQ_HANDLER_DELAY;
								END_IF;
							END_IF;
						TC_SEQ_TYPE_BREAK:
							Out.Status.Processing			:= TRUE;
							Internal.State					:= TC_SEQ_HANDLER_EVAL;
						ELSE
							Out.Status.Processing			:= FALSE;
							Out.Status.Error				:= TRUE;
							Internal.ErrorID.28				:= 1;
							Internal.State					:= TC_SEQ_HANDLER_ERROR;
					END_CASE;
				END_IF;
			END_IF;
		TC_SEQ_HANDLER_CMD:
			Out.Status.CurrentState						:= 'TC_SEQ_HANDLER_CMD';
			Out.Status.Processing						:= TRUE;
			Internal.CTON_0.IN							:= TRUE;
			Internal.CTON_0.PT							:= LREAL_TO_TIME(Internal.CurrentBuffer.Time*1000.0);
			Internal.CTON_0.PAUSE						:= FALSE;
			Internal.State								:= TC_SEQ_HANDLER_EVAL;
		TC_SEQ_HANDLER_WAIT:
			Out.Status.CurrentState						:= 'TC_SEQ_HANDLER_WAIT';
			Out.Status.Processing						:= TRUE;
			Internal.CTON_0.IN							:= TRUE;
			Internal.CTON_0.PT							:= LREAL_TO_TIME(Internal.CurrentBuffer.Time*1000.0);
			Internal.CTON_0.PAUSE						:= FALSE;
			brsmemcpy(ADR(Internal.CurrentWait),Internal.CurrentBuffer.WaitPvAddress,SIZEOF(Internal.CurrentWait));
			IF ForceNext = TRUE THEN
				Internal.State							:= TC_SEQ_HANDLER_EVAL;
			ELSE
				CASE Internal.CurrentWait OF
					TC_SEQ_WAIT_FALSE:
						IF Internal.CTON_0.Q THEN
							Out.Status.Timeout				:= TRUE;
							Internal.State					:= TC_SEQ_HANDLER_INTERRUPT;
						END_IF;
					TC_SEQ_WAIT_TRUE:
						Internal.State						:= TC_SEQ_HANDLER_EVAL;
					TC_SEQ_WAIT_INTERRUPT:
						Out.Status.Interrupt				:= TRUE;
						Internal.State						:= TC_SEQ_HANDLER_INTERRUPT;
					TC_SEQ_WAIT_ERROR:
						Out.Status.Processing				:= FALSE;
						Out.Status.Error					:= TRUE;
						Internal.ErrorID.30					:= 1;
						Internal.State						:= TC_SEQ_HANDLER_ERROR;
					ELSE
						Out.Status.Processing				:= FALSE;
						Out.Status.Error					:= TRUE;
						Internal.ErrorID.29					:= 1;
						Internal.State						:= TC_SEQ_HANDLER_ERROR;
				END_CASE;
			END_IF
		TC_SEQ_HANDLER_DELAY:
			Out.Status.CurrentState						:= 'TC_SEQ_HANDLER_DELAY';
			Out.Status.Processing						:= TRUE;
			Internal.CTON_0.IN							:= TRUE;
			Internal.CTON_0.PT							:= LREAL_TO_TIME(Internal.CurrentDelay*1000.0);
			Internal.CTON_0.PAUSE						:= FALSE;
			IF ForceNext = TRUE THEN
				Internal.State							:= TC_SEQ_HANDLER_EVAL;
			ELSIF Internal.CTON_0.Q OR Internal.CurrentDelay = 0 THEN
				Internal.State							:= TC_SEQ_HANDLER_EVAL;
			END_IF;
		TC_SEQ_HANDLER_INTERRUPT:
			Out.Status.CurrentState						:= 'TC_SEQ_HANDLER_INTERRUPT';
			Out.Status.Processing						:= TRUE;
			IF ForceNext = TRUE THEN
				Internal.State							:= TC_SEQ_HANDLER_EVAL;
			ELSIF Pause THEN
				Out.Status.Processing					:= FALSE;
				Out.Status.Paused						:= TRUE;
			ELSIF ClearBuffer THEN
				Internal.State							:= TC_SEQ_HANDLER_EVAL;
			ELSE
				Out.Status.Processing					:= FALSE;
				Out.Status.Error						:= TRUE;
				Internal.ErrorID.31						:= 1;
				Internal.State							:= TC_SEQ_HANDLER_ERROR;
			END_IF
		TC_SEQ_HANDLER_ERROR:
			Out.Status.CurrentState						:= 'TC_SEQ_HANDLER_ERROR';
			Out.Status.Error							:= TRUE;
			IF ErrorReset THEN
				Internal.State							:= TC_SEQ_HANDLER_RESET;
			END_IF;
	END_CASE;
	IF Internal.LastState <> Internal.State THEN
		Internal.LastState 								:= Internal.State;
		Internal.CTON_0(IN := FALSE, PT := T#0ms, PAUSE := FALSE);	  
	ELSE
		Internal.CTON_0();
		Out.Status.Elapsed								:= TIME_TO_LREAL(Internal.CTON_0.ET)/1000.0;
		Out.Status.Remaining							:= TIME_TO_LREAL(Internal.CTON_0.PT)/1000.0 - Out.Status.Elapsed;
	END_IF;
	IF brsmemcmp(ADR(Out.Buffer.Current),ADR(Internal.CurrentBuffer),SIZEOF(Internal.CurrentBuffer)) <> 0 AND Internal.CurrentBuffer.Type <> TC_SEQ_TYPE_NONE THEN
		IF MAX_TC_SEQ_BUFFER_LAST_IDX > 0 THEN
			brsmemmove(ADR(Out.Buffer.Last[1]),ADR(Out.Buffer.Last[0]),SIZEOF(Out.Buffer.Last)-SIZEOF(Out.Buffer.Last[0]));
		END_IF;
		brsmemcpy(ADR(Out.Buffer.Last[0]),ADR(Internal.CurrentBuffer),SIZEOF(Internal.CurrentBuffer));
	END_IF;
	brsmemcpy(ADR(Out.Buffer.Current),ADR(Internal.CurrentBuffer),SIZEOF(Internal.CurrentBuffer));
	Out.Status.ErrorID									:= Internal.ErrorID;
END_FUNCTION_BLOCK
