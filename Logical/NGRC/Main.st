PROGRAM _INIT

	(* Configure Transfer Function *)
	Omega := 4.0;
	Zeta := 0.1;
	
END_PROGRAM

PROGRAM _CYCLIC
	
	MTBasicsTransferFcn_0.Numerator[0] := Omega * Omega;
	MTBasicsTransferFcn_0.Denominator[0] := Omega * Omega;
	MTBasicsTransferFcn_0.Denominator[1] := 2.0 * Zeta * Omega;
	MTBasicsTransferFcn_0.Denominator[2] := 1.0;
	MTBasicsTransferFcn_0(Enable := TRUE, Mode := mtBASICS_CONTINUOUS_TRANSFER_FCN);
	
	IF NOT FirstScanComplete AND TC_NGRC_Continuous_0.In.Cmd.Enable THEN
		(* Configure TC_NGRC_Continuous_0 *)
		TC_NGRC_Continuous_0.In.Par.NumVariables := MY_MAX_VARIABLES_IDX+1;
		TC_NGRC_Continuous_0.In.Par.LagOrder := 5;
		TC_NGRC_Continuous_0.In.Par.PolyOrder := 2;
		TC_NGRC_Continuous_0.In.Par.UseBias := TRUE;
		TC_NGRC_Continuous_0.In.Par.PredictionSteps := 5;
		TC_NGRC_Continuous_0.In.Par.Lambda := 0.999;
		TC_NGRC_Continuous_0.In.Par.InitVariance := 1000.0;
		(* Assign memory pointers *)
		TC_NGRC_Continuous_0.In.Par.pTheta := ADR(Theta);
		TC_NGRC_Continuous_0.In.Par.ThetaStride_Bytes := SIZEOF(Theta[0]);
		TC_NGRC_Continuous_0.In.Par.pP := ADR(P);
		TC_NGRC_Continuous_0.In.Par.PStride_Bytes := SIZEOF(P[0]);
		TC_NGRC_Continuous_0.In.Par.pHistory := ADR(History);
		TC_NGRC_Continuous_0.In.Par.HistoryStride_Bytes := SIZEOF(History[0]);
		TC_NGRC_Continuous_0.In.Par.pFeatures := ADR(Features);
		TC_NGRC_Continuous_0.In.Par.pSharedWorkspace := ADR(SharedWorkspace);
	
		(* Initialize dimensions *)	
		FOR i := 0 TO MY_MAX_VARIABLES_IDX DO
			Theta[i].Row := MY_MAX_THETA_IDX+1; Theta[i].Col := 1;
			P[i].Row := MY_MAX_THETA_IDX+1; P[i].Col := MY_MAX_THETA_IDX+1;
			History[i].Row := MY_MAX_HISTORY_IDX+1; History[i].Col := 1;
		END_FOR;
		Features.Row := MY_MAX_FEATURES_IDX+1; Features.Col := 1;
		SharedWorkspace.Row := MY_MAX_SHARED_WORKSPACE_IDX+1; SharedWorkspace.Col := 1;
	
		TC_NGRC_Continuous_0.In.Cmd.Init := TRUE;
		FirstScanComplete := TRUE;
	END_IF;
	
	TC_NGRC_Continuous_0.In.Signal.NewSample[0] := (REAL_TO_LREAL(MTBasicsTransferFcn_0.Out)-TC_NGRC_Continuous_0.In.Signal.NewSample[1])/0.001;
	TC_NGRC_Continuous_0.In.Signal.NewSample[1] := REAL_TO_LREAL(MTBasicsTransferFcn_0.Out);
	TC_NGRC_Continuous_0();
	TC_NGRC_Continuous_0.In.Cmd.Init := FALSE;

	TC_NGRC_CalcMem(NumVariables,LagOrder,PolyOrder,UseBias,Stride,EnableWorkspaceReuse,ADR(Output));	
END_PROGRAM


	

//PROGRAM MyApplication
//VAR
//	(* Optimally-sized arrays from calculator *)
//	Theta : ARRAY[0..5] OF MyApp_Theta_typ;
//	P : ARRAY[0..5] OF MyApp_P_typ;
//	History : ARRAY[0..5] OF MyApp_History_typ;
//	Features : MyApp_Features_typ;
//	SharedWorkspace : MyApp_SharedWorkspace_typ;
//	
//	TC_NGRC_Continuous_0 : TC_NGRC_Continuous;
//	
//	FirstScan : BOOL := TRUE;
//END_VAR
//
//IF FirstScan THEN
//	
//	(* Configure TC_NGRC_Continuous_0 *)
//	TC_NGRC_Continuous_0.In.Par.NumVariables := 6;
//	TC_NGRC_Continuous_0.In.Par.LagOrder := 2;
//	TC_NGRC_Continuous_0.In.Par.PolyOrder := 1;
//	TC_NGRC_Continuous_0.In.Par.UseBias := TRUE;
//	TC_NGRC_Continuous_0.In.Par.PredictionSteps := 3;
//	TC_NGRC_Continuous_0.In.Par.Lambda := 0.999;
//	TC_NGRC_Continuous_0.In.Par.InitVariance := 1000.0;
//	
//	(* Assign memory pointers *)
//	TC_NGRC_Continuous_0.In.Par.pTheta := ADR(Theta[0]);
//	TC_NGRC_Continuous_0.In.Par.pP := ADR(P[0]);
//	TC_NGRC_Continuous_0.In.Par.pHistory := ADR(History[0]);
//	TC_NGRC_Continuous_0.In.Par.pFeatures := ADR(Features);
//	TC_NGRC_Continuous_0.In.Par.pSharedWorkspace := ADR(SharedWorkspace);
//	
//	(* NEW: Set stride values using SIZEOF *)
//	TC_NGRC_Continuous_0.In.Par.ThetaStride_Bytes := SIZEOF(MyApp_Theta_typ);
//	TC_NGRC_Continuous_0.In.Par.PStride_Bytes := SIZEOF(MyApp_P_typ);
//	TC_NGRC_Continuous_0.In.Par.HistoryStride_Bytes := SIZEOF(MyApp_History_typ);
//	
//	(* Initialize dimensions *)
//	FOR i := 0 TO 5 DO
//		Theta[i].Row := 13; Theta[i].Col := 1;
//		P[i].Row := 13; P[i].Col := 13;
//		History[i].Row := 2; History[i].Col := 1;
//	END_FOR;
//	Features.Row := 13; Features.Col := 1;
//	SharedWorkspace.Row := 13; SharedWorkspace.Col := 1;
//	
//	TC_NGRC_Continuous_0.In.Cmd.Init := TRUE;
//	FirstScan := FALSE;
//END_IF;
//
//(* Every cycle *)
//TC_NGRC_Continuous_0.In.Signal.NewSample := SensorValues;
//TC_NGRC_Continuous_0.In.Cmd.Enable := TRUE;
//TC_NGRC_Continuous_0();
//
//IF TC_NGRC_Continuous_0.Out.Status.Ready THEN
//	Predictions := TC_NGRC_Continuous_0.Out.Signal.Prediction[0, 0];
//END_IF;
//
//END_PROGRAM