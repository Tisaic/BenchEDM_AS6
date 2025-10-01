
ACTION Monitor_USER:

	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SYSTEM_PAR_NOT_READY].Operator						:= TC_MON_OP_AND;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SYSTEM_PAR_NOT_READY].Logical[0]					:= NOT gMain.Services.Recipes.Out.ParametersReady;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SYSTEM_PAR_NOT_READY].Sev							:= 4;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SYSTEM_PAR_NOT_READY].Mask[PROCESS_MASTER].Sev 		:= 4;

	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SYSTEM_HMI_STOP].Operator							:= TC_MON_OP_AND;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SYSTEM_HMI_STOP].Logical[0]							:= gIO.Safety.TC_IO_DI_HMI_STOP.Signal.Filtered;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SYSTEM_HMI_STOP].Sev								:= 4;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SYSTEM_HMI_STOP].Mask[PROCESS_MASTER].Sev 			:= 4;

	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SAFETY_ESTOP].Operator								:= TC_MON_OP_AND;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SAFETY_ESTOP].Logical[0]							:= NOT gIO.Safety.TC_IO_DI_ESTOP.Signal.Filtered;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SAFETY_ESTOP].Sev									:= 4;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_SAFETY_ESTOP].Mask[PROCESS_MASTER].Sev				:= 4;

	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_REM_LOST_PAR].Operator						:= TC_MON_OP_AND;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_REM_LOST_PAR].Logical[0]						:= gMain.Services.Recipes.Internal.TC_Recipe_Helper_0[RECIPE_ID_REM].RemLost;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_REM_LOST_PAR].Sev							:= 1;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_REM_LOST_PAR].Mask[PROCESS_MASTER].Sev 		:= 1;

	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_BAD_PAR].Operator						:= TC_MON_OP_AND;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_BAD_PAR].Logical[0]						:= gMain.Services.Recipes.Internal.TC_Recipe_Helper_0[RECIPE_ID_REM].AutoLoadFailed;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_BAD_PAR].Sev							:= 4;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_BAD_PAR].Mask[PROCESS_MASTER].Sev 		:= 1;

	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_GOOD_PAR].Operator						:= TC_MON_OP_AND;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_GOOD_PAR].Logical[0]					:= gMain.Services.Recipes.Internal.TC_Recipe_Helper_0[RECIPE_ID_REM].AutoLoadSuccess;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_GOOD_PAR].Sev							:= 0;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_GOOD_PAR].Mask[PROCESS_MASTER].Sev 		:= 1;

	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_GEN_ERR_PAR].Operator						:= TC_MON_OP_AND;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_GEN_ERR_PAR].Logical[0]						:= gMain.Services.Recipes.Internal.TC_Recipe_Helper_0[RECIPE_ID_REM].Error;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_GEN_ERR_PAR].Sev								:= 1;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_GEN_ERR_PAR].Mask[PROCESS_MASTER].Sev 		:= 1;

	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_REM_LOST_REM].Operator						:= TC_MON_OP_AND;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_REM_LOST_REM].Logical[0]						:= gMain.Services.Recipes.Internal.TC_Recipe_Helper_0[RECIPE_ID_PAR].RemLost;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_REM_LOST_REM].Sev							:= 1;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_REM_LOST_REM].Mask[PROCESS_MASTER].Sev 		:= 1;

	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_BAD_REM].Operator						:= TC_MON_OP_AND;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_BAD_REM].Logical[0]						:= gMain.Services.Recipes.Internal.TC_Recipe_Helper_0[RECIPE_ID_PAR].AutoLoadFailed;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_BAD_REM].Sev							:= 4;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_BAD_REM].Mask[PROCESS_MASTER].Sev 		:= 1;

	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_GOOD_REM].Operator						:= TC_MON_OP_AND;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_GOOD_REM].Logical[0]					:= gMain.Services.Recipes.Internal.TC_Recipe_Helper_0[RECIPE_ID_PAR].AutoLoadSuccess;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_GOOD_REM].Sev							:= 0;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_LOAD_GOOD_REM].Mask[PROCESS_MASTER].Sev 		:= 1;

	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_GEN_ERR_REM].Operator						:= TC_MON_OP_AND;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_GEN_ERR_REM].Logical[0]						:= gMain.Services.Recipes.Internal.TC_Recipe_Helper_0[RECIPE_ID_PAR].Error;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_GEN_ERR_REM].Sev								:= 1;
	gMain.Process.Monitor.Internal.TC_Mon_0[MON_RECIPE_GEN_ERR_REM].Mask[PROCESS_MASTER].Sev 		:= 1;

END_ACTION
