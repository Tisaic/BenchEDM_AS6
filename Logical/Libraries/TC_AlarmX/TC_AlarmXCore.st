
(* Alarm Core to handle setting multiple alarms in one cycle with different texts *)
FUNCTION_BLOCK TC_AlarmXCore

	IF enable = FALSE THEN
		internal.state := TC_ALARMX_CORE_RESET;
	END_IF

	CASE internal.state OF
			
		TC_ALARMX_CORE_RESET:
		
			brsmemset(ADR(internal.currentAlarm), 0, SIZEOF(internal.currentAlarm));
			internal.state := TC_ALARMX_CORE_IDLE;	
		
		TC_ALARMX_CORE_IDLE:
		
			IF TC_Array_PeekBtm(pBuffer, SIZEOF(internal.currentAlarm) * TC_ALARMX_BUFFER_IDX, ADR(internal.currentAlarm), SIZEOF(internal.currentAlarm)) > 0 THEN
				TC_Array_Dequeue(pBuffer, SIZEOF(internal.currentAlarm) * TC_ALARMX_BUFFER_IDX, ADR(internal.currentAlarm), SIZEOF(internal.currentAlarm));
				internal.state := TC_ALARMX_CORE_SET_C;
			END_IF		
		
		TC_ALARMX_CORE_SET_C:
					
			FOR internal.i := 0 TO TC_ALARMX_MAX_ADD_DATA_IDX DO
				pOutputData.AddData[internal.i]	:= internal.currentAlarm.addText[internal.i];
			END_FOR
			TC_AlarmX_Helper(MpLink, internal.currentAlarm.name, TC_ALARMX_ACTION_SET, '', internal.currentAlarm.allowMultiple);
			
			internal.state := TC_ALARMX_CORE_SET_W;

		TC_ALARMX_CORE_SET_W:
		
			internal.tDelay.IN	:= TRUE;
			internal.tDelay.PT	:= delayTime;
		
			IF internal.tDelay.Q THEN
				internal.tDelay.IN	:= FALSE;
				internal.state 		:= TC_ALARMX_CORE_IDLE;
			END_IF
			
	END_CASE
	
	internal.tDelay();

END_FUNCTION_BLOCK
