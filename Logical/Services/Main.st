
PROGRAM _INIT

	gMain.Services.DirMan.In.RefreshDelay										:= 10.0;

	gMain.Services.DirMan.In.DirDef[0].Valid									:= TRUE;
	gMain.Services.DirMan.In.DirDef[0].DirPath									:= '';
	gMain.Services.DirMan.In.DirDef[0].Sanitize.AllowUndefinedDir				:= FALSE;
	gMain.Services.DirMan.In.DirDef[0].Sanitize.SanitizeFilesByRoot				:= FALSE;
	gMain.Services.DirMan.In.DirDef[0].Sanitize.SanitizeFilesByExt				:= TRUE;
	gMain.Services.DirMan.In.DirDef[0].Sanitize.FileExtension					:= '.~';
	gMain.Services.DirMan.In.DirDef[0].Sanitize.FileRoot						:= '';
	gMain.Services.DirMan.In.DirDef[0].Sanitize.MaxFiles						:= 4294967295;
	gMain.Services.DirMan.In.DirDef[0].Sanitize.MaxSize							:= 4294967295;

	gMain.Services.DirMan.In.DirDef[1].Valid									:= TRUE;
	gMain.Services.DirMan.In.DirDef[1].DirPath									:= 'Machine';
	gMain.Services.DirMan.In.DirDef[1].Sanitize.AllowUndefinedDir				:= FALSE;
	gMain.Services.DirMan.In.DirDef[1].Sanitize.SanitizeFilesByRoot				:= FALSE;
	gMain.Services.DirMan.In.DirDef[1].Sanitize.SanitizeFilesByExt				:= TRUE;
	gMain.Services.DirMan.In.DirDef[1].Sanitize.FileExtension					:= '.txt';
	gMain.Services.DirMan.In.DirDef[1].Sanitize.FileRoot						:= '';
	gMain.Services.DirMan.In.DirDef[1].Sanitize.MaxFiles						:= 4294967295;
	gMain.Services.DirMan.In.DirDef[1].Sanitize.MaxSize							:= 4294967295;

	gMain.Services.DirMan.In.DirDef[2].Valid									:= TRUE;
	gMain.Services.DirMan.In.DirDef[2].DirPath									:= 'GCODE';
	gMain.Services.DirMan.In.DirDef[2].Sanitize.AllowUndefinedDir				:= FALSE;
	gMain.Services.DirMan.In.DirDef[2].Sanitize.SanitizeFilesByRoot				:= FALSE;
	gMain.Services.DirMan.In.DirDef[2].Sanitize.SanitizeFilesByExt				:= FALSE;
	gMain.Services.DirMan.In.DirDef[2].Sanitize.FileExtension					:= '';
	gMain.Services.DirMan.In.DirDef[2].Sanitize.FileRoot						:= '';
	gMain.Services.DirMan.In.DirDef[2].Sanitize.MaxFiles						:= 100;
	gMain.Services.DirMan.In.DirDef[2].Sanitize.MaxSize							:= 4294967295;

	gMain.Services.DirMan.In.DirDef[3].Valid									:= TRUE;
	gMain.Services.DirMan.In.DirDef[3].DirPath									:= 'AlarmHistory';
	gMain.Services.DirMan.In.DirDef[3].Sanitize.AllowUndefinedDir				:= FALSE;
	gMain.Services.DirMan.In.DirDef[3].Sanitize.SanitizeFilesByRoot				:= TRUE;
	gMain.Services.DirMan.In.DirDef[3].Sanitize.SanitizeFilesByExt				:= TRUE;
	gMain.Services.DirMan.In.DirDef[3].Sanitize.FileExtension					:= '.csv';
	gMain.Services.DirMan.In.DirDef[3].Sanitize.FileRoot						:= 'Alarms';
	gMain.Services.DirMan.In.DirDef[3].Sanitize.MaxFiles						:= 10;
	gMain.Services.DirMan.In.DirDef[3].Sanitize.MaxSize							:= 4294967295;

	gMain.Services.Recipes.In.RecipeDefinitions[0].MpLink						:= gRecipeXml_Rem;
	gMain.Services.Recipes.In.RecipeDefinitions[0].DeviceName					:= gMain.Services.DeviceName;
	gMain.Services.Recipes.In.RecipeDefinitions[0].FileName						:= 'Machine/gRem.txt';
	gMain.Services.Recipes.In.RecipeDefinitions[0].VarName						:= 'gRem';
	gMain.Services.Recipes.In.RecipeDefinitions[0].pVar							:= ADR(gRem);
	gMain.Services.Recipes.In.RecipeDefinitions[0].SizeVar						:= SIZEOF(gRem);
	gMain.Services.Recipes.In.RecipeDefinitions[0].pCmpVar						:= 0;
	gMain.Services.Recipes.In.RecipeDefinitions[0].pDefaultVar					:= 0;

	gMain.Services.Recipes.In.RecipeDefinitions[1].MpLink						:= gRecipeXml_Par;
	gMain.Services.Recipes.In.RecipeDefinitions[1].DeviceName					:= gMain.Services.DeviceName;
	gMain.Services.Recipes.In.RecipeDefinitions[1].FileName						:= 'Machine/gPar.txt';
	gMain.Services.Recipes.In.RecipeDefinitions[1].VarName						:= 'gPar';
	gMain.Services.Recipes.In.RecipeDefinitions[1].pVar							:= ADR(gPar);
	gMain.Services.Recipes.In.RecipeDefinitions[1].SizeVar						:= SIZEOF(gPar);
	gMain.Services.Recipes.In.RecipeDefinitions[1].pCmpVar						:= ADR(ParCmp);
	gMain.Services.Recipes.In.RecipeDefinitions[1].pDefaultVar					:= ADR(ParDefaults);

	gMain.Services.Alarms.Internal.MpAlarmXHistoryUI_0.UISetup.AlarmListSize 	:= 50;
	gMain.Services.Alarms.Internal.MpAlarmXListUI_0.UISetup.AlarmListSize 		:= 50;
	
	gMain.Services.Alarms.Internal.MpAlarmXCore_0(MpLink := ADR(gAlarmXCore), Enable := TRUE, ErrorReset := gMain.ErrorReset);
	gMain.Services.Alarms.Internal.MpAlarmXListUI_0(MpLink := ADR(gAlarmXCore), Enable := TRUE, ErrorReset := gMain.ErrorReset, UIConnect := ADR(gVis.Alarms.Active.UIConnect));
	gMain.Services.Alarms.Internal.MpAlarmXHistory_0(MpLink := ADR(gAlarmXHistory), Enable := TRUE, ErrorReset := gMain.ErrorReset);
	gMain.Services.Alarms.Internal.MpAlarmXHistoryUI_0(MpLink := ADR(gAlarmXHistory), Enable := TRUE, ErrorReset := gMain.ErrorReset, UIConnect := ADR(gVis.Alarms.History.UIConnect));
	
END_PROGRAM

PROGRAM _CYCLIC

	Alarms;
	Recipes;
	DirMan;
	Time;
	
END_PROGRAM

PROGRAM _EXIT

END_PROGRAM

