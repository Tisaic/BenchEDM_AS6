(* Calculate Memory Requirements *)
FUNCTION TC_NGRC_CalcMem
	TC_NGRC_CalcMem := TRUE;
	brsmemset(ADR(Internal), 0, SIZEOF(Internal));
	
	(* Validate output pointer *)
	IF pOutput = 0 THEN
		TC_NGRC_CalcMem := FALSE;
		RETURN;
	END_IF;
	
	(* Copy inputs to Internal *)
	Internal.NumVars := NumVariables;
	Internal.LagOrder := LagOrder;
	Internal.PolyOrder := PolyOrder;
	Internal.Stride := Stride;
	IF UseBias THEN
		Internal.UseBias := 1;
	ELSE
		Internal.UseBias := 0;
	END_IF;
	IF EnableWorkspaceReuse THEN
		Internal.EnableReuse := 1;
	ELSE
		Internal.EnableReuse := 0;
	END_IF;
	
	(* Validate NumVariables *)
	IF Internal.NumVars < 1 OR Internal.NumVars > 10 THEN
		Internal.Output.ConfigValid := FALSE;
		Internal.Output.ErrorCode := 1;
		brsmemcpy(pOutput, ADR(Internal.Output), SIZEOF(TC_NGRC_CalcMem_Output_typ));
		TC_NGRC_CalcMem := FALSE;
		RETURN;
	END_IF;
	
	(* Validate LagOrder *)
	IF Internal.LagOrder < 1 OR Internal.LagOrder > 10 THEN
		Internal.Output.ConfigValid := FALSE;
		Internal.Output.ErrorCode := 2;
		brsmemcpy(pOutput, ADR(Internal.Output), SIZEOF(TC_NGRC_CalcMem_Output_typ));
		TC_NGRC_CalcMem := FALSE;
		RETURN;
	END_IF;
	
	(* Validate PolyOrder *)
	IF Internal.PolyOrder < 1 OR Internal.PolyOrder > 3 THEN
		Internal.Output.ConfigValid := FALSE;
		Internal.Output.ErrorCode := 3;
		brsmemcpy(pOutput, ADR(Internal.Output), SIZEOF(TC_NGRC_CalcMem_Output_typ));
		TC_NGRC_CalcMem := FALSE;
		RETURN;
	END_IF;
	
	(* Fix Stride if invalid *)
	IF Internal.Stride < 1 THEN
		Internal.Stride := 1;
	END_IF;
	
	(* Calculate base dimensions *)
	Internal.BaseDim := Internal.NumVars * Internal.LagOrder;
	
	(* Calculate number of features based on polynomial order *)
	IF Internal.PolyOrder = 1 THEN
		Internal.NumFeatures := Internal.BaseDim;
	ELSIF Internal.PolyOrder = 2 THEN
		Internal.temp1 := Internal.BaseDim * (Internal.BaseDim + 1);
		Internal.temp1 := Internal.temp1 / 2;
		Internal.NumFeatures := Internal.BaseDim + Internal.temp1;
	ELSIF Internal.PolyOrder = 3 THEN
		Internal.temp1 := Internal.BaseDim * (Internal.BaseDim + 1);
		Internal.temp1 := Internal.temp1 / 2;
		Internal.temp2 := Internal.BaseDim * (Internal.BaseDim + 1);
		Internal.temp2 := Internal.temp2 * (Internal.BaseDim + 2);
		Internal.temp2 := Internal.temp2 / 6;
		Internal.NumFeatures := Internal.BaseDim + Internal.temp1 + Internal.temp2;
	END_IF;
	
	(* Add bias term if enabled *)
	IF Internal.UseBias = 1 THEN
		Internal.NumFeatures := Internal.NumFeatures + 1;
	END_IF;
	
	(* Calculate individual array sizes (element counts) *)
	Internal.ThetaSize := Internal.NumFeatures;
	Internal.PSize := Internal.NumFeatures * Internal.NumFeatures;
	Internal.HistorySize := Internal.LagOrder;
	Internal.FeaturesSize := Internal.NumFeatures;
	Internal.LagWorkSize := Internal.BaseDim;
	Internal.PolyWorkSize := Internal.NumFeatures;
	Internal.TempWorkSize := Internal.NumFeatures;
	Internal.WorkspaceSize := Internal.NumFeatures;
	
	(* Calculate shared workspace size *)
	Internal.MaxWorkspace := Internal.LagWorkSize;
	IF Internal.PolyWorkSize > Internal.MaxWorkspace THEN
		Internal.MaxWorkspace := Internal.PolyWorkSize;
	END_IF;
	IF Internal.TempWorkSize > Internal.MaxWorkspace THEN
		Internal.MaxWorkspace := Internal.TempWorkSize;
	END_IF;
	Internal.SharedWorkspaceSize := Internal.MaxWorkspace;
	
	(* Sanity check - warn if unreasonably large *)
	IF Internal.PSize > 10000 THEN
		Internal.Output.ConfigValid := FALSE;
		Internal.Output.ErrorCode := 4;
		brsmemcpy(pOutput, ADR(Internal.Output), SIZEOF(TC_NGRC_CalcMem_Output_typ));
		TC_NGRC_CalcMem := FALSE;
		RETURN;
	END_IF;
	
	(* Calculate memory requirements *)
	Internal.temp3 := Internal.ThetaSize + Internal.PSize + Internal.TempWorkSize;
	Internal.MemoryPerModel := Internal.temp3 * 8;
	
	(* Total memory WITHOUT workspace reuse *)
	Internal.temp3 := DINT_TO_UDINT(Internal.NumVars) * Internal.MemoryPerModel;
	Internal.temp3 := Internal.temp3 + (Internal.HistorySize * Internal.NumVars * 8);
	Internal.temp3 := Internal.temp3 + (Internal.FeaturesSize * 8);
	Internal.temp3 := Internal.temp3 + (Internal.LagWorkSize * 8);
	Internal.temp3 := Internal.temp3 + (Internal.PolyWorkSize * 8);
	Internal.temp3 := Internal.temp3 + (Internal.WorkspaceSize * 8);
	Internal.temp3 := Internal.temp3 + (Internal.TempWorkSize * Internal.NumVars * 8);
	Internal.TotalMemory := Internal.temp3;
	
	(* Total memory WITH workspace reuse *)
	IF Internal.EnableReuse = 1 THEN
		Internal.temp3 := (Internal.NumVars * (Internal.ThetaSize + Internal.PSize) * 8);
		Internal.temp3 := Internal.temp3 + (Internal.HistorySize * Internal.NumVars * 8);
		Internal.temp3 := Internal.temp3 + (Internal.FeaturesSize * 8);
		Internal.temp3 := Internal.temp3 + (Internal.SharedWorkspaceSize * 8);
		Internal.TotalMemoryReuse := Internal.temp3;
		Internal.MemorySaved := Internal.TotalMemory - Internal.TotalMemoryReuse;
	ELSE
		Internal.TotalMemoryReuse := Internal.TotalMemory;
		Internal.MemorySaved := 0;
	END_IF;
	
	(* Fill output structure *)
	IF Internal.ThetaSize > 0 THEN
		Internal.Output.MAX_THETA_IDX := Internal.ThetaSize - 1;
	END_IF;
	IF Internal.PSize > 0 THEN
		Internal.Output.MAX_P_IDX := Internal.PSize - 1;
	END_IF;
	IF Internal.HistorySize > 0 THEN
		Internal.Output.MAX_HISTORY_IDX := Internal.HistorySize - 1;
	END_IF;
	IF Internal.FeaturesSize > 0 THEN
		Internal.Output.MAX_FEATURES_IDX := Internal.FeaturesSize - 1;
	END_IF;
	IF Internal.LagWorkSize > 0 THEN
		Internal.Output.MAX_LAGWORK_IDX := Internal.LagWorkSize - 1;
	END_IF;
	IF Internal.PolyWorkSize > 0 THEN
		Internal.Output.MAX_POLYWORK_IDX := Internal.PolyWorkSize - 1;
	END_IF;
	IF Internal.WorkspaceSize > 0 THEN
		Internal.Output.MAX_WORKSPACE_IDX := Internal.WorkspaceSize - 1;
	END_IF;
	IF Internal.TempWorkSize > 0 THEN
		Internal.Output.MAX_TEMPWORK_IDX := Internal.TempWorkSize - 1;
	END_IF;
	IF Internal.SharedWorkspaceSize > 0 THEN
		Internal.Output.MAX_SHARED_WORKSPACE_IDX := Internal.SharedWorkspaceSize - 1;
	END_IF;
	
	Internal.Output.NumFeatures := Internal.NumFeatures;
	Internal.Output.MemoryPerModel_Bytes := Internal.MemoryPerModel;
	Internal.Output.TotalMemory_Bytes := Internal.TotalMemory;
	Internal.Output.TotalMemory_WithReuse_Bytes := Internal.TotalMemoryReuse;
	Internal.Output.MemorySavedByReuse_Bytes := Internal.MemorySaved;
	Internal.Output.ConfigValid := TRUE;
	Internal.Output.ErrorCode := 0;
	
	Internal.IsValid := 1;
	
	(* Copy entire output structure *)
	brsmemcpy(pOutput, ADR(Internal.Output), SIZEOF(TC_NGRC_CalcMem_Output_typ));
	
END_FUNCTION