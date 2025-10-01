
PROGRAM _INIT
	 
//	MC_BR_TorqueControl_R_T.Torque 				:= 0.1;
//	MC_BR_TorqueControl_R_T.TorqueRamp 			:= 0.01;
//	MC_BR_TorqueControl_R_T.Acceleration 		:= 1000000.0;
//	MC_BR_TorqueControl_R_T.MaximumVelocity 	:= 100.0;
//	MC_BR_TorqueControl_R_T.MinimumVelocity 	:= -100.0;
//
//	RTEnable;
//	RTActual;
//	RTSetpoint;
//	RTHome;
//	START;
//	AMP;
//	INCR;
//	X;
//	LAST;

END_PROGRAM

PROGRAM _CYCLIC

//	IF START THEN
//		X := X + INCR;
//		RTSetpoint := REAL_TO_DINT(AMP * SIN(X));
//		RTDelayCount := 0;
//	END_IF;
//
//	MpAxisBasic_R_X(MpLink := ADR(gAxis_R_X), Enable := TRUE, ErrorReset := gMain.ErrorReset, Parameters := ADR(MpAxisBasicPar_R_X));
//	IF MpAxisBasic_R_X.UpdateDone THEN
//		MpAxisBasic_R_X.Update := FALSE;
//	END_IF;
//
//	MpAxisBasic_R_Y(MpLink := ADR(gAxis_R_Y), Enable := TRUE, ErrorReset := gMain.ErrorReset, Parameters := ADR(MpAxisBasicPar_R_Y));
//	IF MpAxisBasic_R_Y.UpdateDone THEN
//		MpAxisBasic_R_Y.Update := FALSE;
//	END_IF;
//
//	MpAxisBasic_R_V(MpLink := ADR(gAxis_R_V), Enable := TRUE, ErrorReset := gMain.ErrorReset, Parameters := ADR(MpAxisBasicPar_R_V));
//	IF MpAxisBasic_R_V.UpdateDone THEN
//		MpAxisBasic_R_V.Update := FALSE;
//	END_IF;
//
//	MpAxisBasic_R_T(MpLink := ADR(gAxis_R_T), Enable := TRUE, ErrorReset := gMain.ErrorReset, Parameters := ADR(MpAxisBasicPar_R_T));
//	IF MpAxisBasic_R_T.UpdateDone THEN
//		MpAxisBasic_R_T.Update := FALSE;
//	END_IF;
//	
//	IF MC_BR_TorqueControl_R_T.Error THEN
//		EnableTorqueControl := FALSE;
//	END_IF;
//	IF MC_BR_TorqueControl_R_T.Ready THEN
//		IF EnableTorqueControl AND NOT MC_BR_TorqueControl_R_T.Active THEN
//			MC_BR_TorqueControl_R_T.Start := TRUE;
//		ELSIF NOT EnableTorqueControl AND MC_BR_TorqueControl_R_T.Active THEN
//			MC_BR_TorqueControl_R_T.Stop := TRUE;
//		END_IF;
//	END_IF;
//	MC_BR_TorqueControl_R_T(Axis := ADR(gAxis_R_T));
//	MC_BR_TorqueControl_R_T.Start := FALSE;
//	MC_BR_TorqueControl_R_T.Stop := FALSE;
//	IF MC_BR_TorqueControl_R_T.DataInitialized THEN
//		MC_BR_TorqueControl_R_T.InitData := FALSE;
//	END_IF;

END_PROGRAM

PROGRAM _EXIT
	 
END_PROGRAM

