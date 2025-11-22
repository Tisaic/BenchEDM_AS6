(* TC_NGRC Continuous Learning Function Block *)
FUNCTION_BLOCK TC_NGRC_Continuous

IF In.Cmd.Reset OR In.Cmd.Init THEN
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	brsmemset(ADR(Out),0,SIZEOF(Out));
END_IF;

IF In.Cmd.Enable THEN
	CASE Internal.State OF
		0:
			brsmemset(ADR(Internal),0,SIZEOF(Internal));
			brsmemset(ADR(Out),0,SIZEOF(Out));
			IF In.Cmd.Init THEN
				IF In.Par.NumVariables < 1 OR In.Par.NumVariables > 10 THEN
					Out.Status.Error := TRUE;
					Out.ErrorInfo.ErrorCode := 1;
					brsstrcpy(ADR(Out.ErrorInfo.FunctionName), ADR('TC_NGRC_Continuous'));
					brsstrcpy(ADR(Out.ErrorInfo.ErrorMsg), ADR('NumVariables must be 1-10'));
					Internal.State := 999;
				END_IF;
				IF In.Par.LagOrder < 1 OR In.Par.LagOrder > 10 THEN
					Out.Status.Error := TRUE;
					Out.ErrorInfo.ErrorCode := 2;
					brsstrcpy(ADR(Out.ErrorInfo.FunctionName), ADR('TC_NGRC_Continuous'));
					brsstrcpy(ADR(Out.ErrorInfo.ErrorMsg), ADR('LagOrder must be 1-10'));
					Internal.State := 999;
				END_IF;
				IF In.Par.PolyOrder < 1 OR In.Par.PolyOrder > 3 THEN
					Out.Status.Error := TRUE;
					Out.ErrorInfo.ErrorCode := 3;
					brsstrcpy(ADR(Out.ErrorInfo.FunctionName), ADR('TC_NGRC_Continuous'));
					brsstrcpy(ADR(Out.ErrorInfo.ErrorMsg), ADR('PolyOrder must be 1-3'));
					Internal.State := 999;
				END_IF;
				IF In.Par.PredictionSteps < 1 OR In.Par.PredictionSteps > 10 THEN
					Out.Status.Error := TRUE;
					Out.ErrorInfo.ErrorCode := 4;
					brsstrcpy(ADR(Out.ErrorInfo.FunctionName), ADR('TC_NGRC_Continuous'));
					brsstrcpy(ADR(Out.ErrorInfo.ErrorMsg), ADR('PredictionSteps must be 1-10'));
					Internal.State := 999;
				END_IF;
				IF In.Par.pTheta = 0 OR In.Par.pP = 0 OR In.Par.pHistory = 0 OR In.Par.pFeatures = 0 OR In.Par.pSharedWorkspace = 0 THEN
					Out.Status.Error := TRUE;
					Out.ErrorInfo.ErrorCode := TC_NGRC_ERR_NULL_POINTER;
					brsstrcpy(ADR(Out.ErrorInfo.FunctionName), ADR('TC_NGRC_Continuous'));
					brsstrcpy(ADR(Out.ErrorInfo.ErrorMsg), ADR('Null pointer in Par'));
					Internal.State := 999;
				END_IF;
				IF In.Par.ThetaStride_Bytes = 0 OR In.Par.PStride_Bytes = 0 OR In.Par.HistoryStride_Bytes = 0 THEN
					Out.Status.Error := TRUE;
					Out.ErrorInfo.ErrorCode := TC_NGRC_ERR_INVALID_DIMENSIONS;
					brsstrcpy(ADR(Out.ErrorInfo.FunctionName), ADR('TC_NGRC_Continuous'));
					brsstrcpy(ADR(Out.ErrorInfo.ErrorMsg), ADR('Stride parameters not set'));
					Internal.State := 999;
				END_IF;
				IF In.Par.Lambda <= 0.0 OR In.Par.Lambda > 1.0 THEN
					Out.Status.Error := TRUE;
					Out.ErrorInfo.ErrorCode := TC_NGRC_ERR_INVALID_LAMBDA;
					brsstrcpy(ADR(Out.ErrorInfo.FunctionName), ADR('TC_NGRC_Continuous'));
					brsstrcpy(ADR(Out.ErrorInfo.ErrorMsg), ADR('Lambda must be (0,1]'));
					Internal.State := 999;
				END_IF;
				IF In.Par.InitVariance <= 0.0 THEN
					Out.Status.Error := TRUE;
					Out.ErrorInfo.ErrorCode := TC_NGRC_ERR_INVALID_VARIANCE;
					brsstrcpy(ADR(Out.ErrorInfo.FunctionName), ADR('TC_NGRC_Continuous'));
					brsstrcpy(ADR(Out.ErrorInfo.ErrorMsg), ADR('InitVariance must be > 0'));
					Internal.State := 999;
				END_IF;
				IF NOT Out.Status.Error THEN
					Internal.NumVars := In.Par.NumVariables;
					Internal.LagOrder := In.Par.LagOrder;
					Internal.PolyOrder := In.Par.PolyOrder;
					Internal.UseBias := 0;
					IF In.Par.UseBias THEN
						Internal.UseBias := 1;
					END_IF;
					Internal.Stride := In.Par.Stride;
					IF Internal.Stride < 1 THEN
						Internal.Stride := 1;
					END_IF;
					Internal.PredSteps := In.Par.PredictionSteps;
					Internal.ThetaStride := In.Par.ThetaStride_Bytes;
					Internal.PStride := In.Par.PStride_Bytes;
					Internal.HistoryStride := In.Par.HistoryStride_Bytes;
					
					FOR Internal.i1 := 0 TO Internal.NumVars-1 DO
						Internal.FuncResult := TC_NGRC_RLS_Init(
							In.Par.pTheta + (DINT_TO_UDINT(Internal.i1) * Internal.ThetaStride),
							In.Par.pP + (DINT_TO_UDINT(Internal.i1) * Internal.PStride),
							In.Par.InitVariance,
							ADR(Out.ErrorInfo)
						);
						
						IF NOT Internal.FuncResult THEN
							Out.Status.Error := TRUE;
							Internal.State := 999;
						END_IF;
					END_FOR;
					
					(* Clear history buffers *)
					FOR Internal.i1 := 0 TO Internal.NumVars-1 DO
						brsmemset(In.Par.pHistory+(DINT_TO_UDINT(Internal.i1)*Internal.HistoryStride), 0, Internal.HistoryStride);
					END_FOR;
					
					(* Clear statistics *)
					brsmemset(ADR(Internal.RMSESum), 0, SIZEOF(Internal.RMSESum));
					brsmemset(ADR(Internal.RMSECount), 0, SIZEOF(Internal.RMSECount));
					brsmemset(ADR(Out.Status.UpdatesFailed), 0, SIZEOF(Out.Status.UpdatesFailed));
					Out.Status.SampleCount := 0;
					IF NOT Out.Status.Error THEN
						Out.Status.Initialized := TRUE;
						Internal.State := 10;
					END_IF;
				END_IF;
			END_IF;
		10:

		999:

	END_CASE;
	Out.Status.Busy := TRUE;
ELSE
	brsmemset(ADR(Internal),0,SIZEOF(Internal));
	brsmemset(ADR(Out),0,SIZEOF(Out));
END_IF;
		
		(* Update history with new samples *)
		FOR Internal.i1 := 0 TO Internal.NumVars-1 DO
			Internal.FuncResult := TC_NGRC_RollingUpdate(In.Par.pHistory + (DINT_TO_UDINT(Internal.i1) * Internal.HistoryStride),In.Signal.NewSample[Internal.i1],ADR(Out.ErrorInfo));
		END_FOR;
		
		(* Build feature vector *)
		Internal.FuncResult := TC_NGRC_BuildLagsStride(In.Par.pHistory,0,Internal.LagOrder,Internal.NumVars,0,Internal.Stride,In.Par.pSharedWorkspace,ADR(Out.ErrorInfo));
		
		IF NOT Internal.FuncResult THEN
			Out.Status.Error := TRUE;
			Internal.State := 999;
			RETURN;
		END_IF;
		
		(* Polynomial expansion if needed *)
		IF Internal.PolyOrder > 1 THEN
			Internal.FuncResult := TC_NGRC_PolyExpand(
				In.Par.pSharedWorkspace,
				Internal.PolyOrder,
				In.Par.pSharedWorkspace,
				ADR(Out.ErrorInfo)
			);
			
			IF NOT Internal.FuncResult THEN
				Out.Status.Error := TRUE;
				Internal.State := 3;
				RETURN;
			END_IF;
		END_IF;
		
		(* Add bias if needed *)
		IF Internal.UseBias = 1 THEN
			Internal.FuncResult := TC_NGRC_AddBias(
				In.Par.pSharedWorkspace,
				In.Par.pFeatures,
				ADR(Out.ErrorInfo)
			);
			
			IF NOT Internal.FuncResult THEN
				Out.Status.Error := TRUE;
				Internal.State := 3;
				RETURN;
			END_IF;
		ELSE
			(* Copy workspace to features - use actual feature vector size *)
			brsmemcpy(ADR(Internal.i2), In.Par.pSharedWorkspace+0, 4);  (* Read Row *)
			Internal.tempSize := 8 + (Internal.i2 * 8);  (* Calculate size *)
			brsmemcpy(In.Par.pFeatures, In.Par.pSharedWorkspace, Internal.tempSize);
		END_IF;
		
		(* Multi-step prediction and training for each variable *)
		Out.Status.Predicting := TRUE;
		Out.Status.Training := NOT In.Cmd.PredictOnly;
		
		FOR Internal.i1 := 0 TO Internal.NumVars-1 DO
			
			(* 1-step ahead prediction *)
			Internal.FuncResult := TC_NGRC_Predict(
				In.Par.pFeatures,
				In.Par.pTheta + (DINT_TO_UDINT(Internal.i1) * Internal.ThetaStride),
				In.Par.pSharedWorkspace,
				ADR(Out.ErrorInfo)
			);
			
			IF Internal.FuncResult THEN
				(* Store 1-step prediction *)
				brsmemcpy(
					ADR(Internal.temp1),
					In.Par.pSharedWorkspace + 8,
					8
				);
				Out.Signal.Prediction[Internal.i1, 0] := Internal.temp1;
				
				(* Update RMSE for this variable *)
				Internal.temp2 := In.Ref.TargetValues[Internal.i1] - Internal.temp1;
				Internal.RMSESum[Internal.i1] := Internal.RMSESum[Internal.i1] + (Internal.temp2 * Internal.temp2);
				Internal.RMSECount[Internal.i1] := Internal.RMSECount[Internal.i1] + 1;
			END_IF;
			
			(* Multi-step predictions (t+2, t+3, etc.) *)
			(* Simplified: Use current features repeatedly *)
			(* For true multi-step, would need to roll forward predictions *)
			FOR Internal.step := 1 TO Internal.PredSteps-1 DO
				Out.Signal.Prediction[Internal.i1, Internal.step] := Internal.temp1;
			END_FOR;
			
			(* RLS update if not PredictOnly *)
			IF NOT In.Cmd.PredictOnly THEN
				Internal.FuncResult := TC_NGRC_RLS(
					In.Par.pTheta + (DINT_TO_UDINT(Internal.i1) * Internal.ThetaStride),
					In.Par.pP + (DINT_TO_UDINT(Internal.i1) * Internal.PStride),
					In.Par.pFeatures,
					In.Signal.NewSample[Internal.i1],
					In.Par.Lambda,
					In.Par.pSharedWorkspace,
					ADR(Out.ErrorInfo)
				);
				
				IF NOT Internal.FuncResult THEN
					(* RLS failed - increment counter and continue *)
					Out.Status.UpdatesFailed[Internal.i1] := Out.Status.UpdatesFailed[Internal.i1] + 1;
				END_IF;
			END_IF;
			
		END_FOR;
		
		(* Calculate RMSE metrics *)
		Internal.temp2 := 0.0;  (* Overall RMSE sum *)
		Internal.i2 := 0;       (* Count of valid RMSEs *)
		FOR Internal.i1 := 0 TO Internal.NumVars-1 DO
			IF Internal.RMSECount[Internal.i1] > 0 THEN
				Internal.temp1 := Internal.RMSESum[Internal.i1] / UDINT_TO_LREAL(Internal.RMSECount[Internal.i1]);
				Out.Signal.RMSE[Internal.i1] := SQRT(Internal.temp1);
				Internal.temp2 := Internal.temp2 + Out.Signal.RMSE[Internal.i1];
				Internal.i2 := Internal.i2 + 1;
			END_IF;
		END_FOR;
		
		IF Internal.i2 > 0 THEN
			Out.Signal.OverallRMSE := Internal.temp2 / Internal.i2;
		END_IF;
		
		(* Increment sample count *)
		Out.Status.SampleCount := Out.Status.SampleCount + 1;

END_FUNCTION_BLOCK