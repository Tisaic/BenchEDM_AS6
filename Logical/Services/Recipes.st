
ACTION Recipes:

	gMain.Services.Recipes.Out.ParametersReady 									:= TRUE;
	FOR i := 0 TO MAX_TC_RECIPE_IDX DO
		gMain.Services.Recipes.Internal.TC_Recipe_Helper_0[i](Enable := TRUE, Def := gMain.Services.Recipes.In.RecipeDefinitions[i], RemOK := gRemOK, ErrorReset := gMain.ErrorReset, ForceLoad := gMain.Services.Recipes.In.ForceLoad, ForceSave := gMain.Services.Recipes.In.ForceSave, ForceDefaults := gMain.Services.Recipes.In.ForceDefaults);
		IF NOT gMain.Services.Recipes.Internal.TC_Recipe_Helper_0[i].Initialized THEN
			gMain.Services.Recipes.Out.ParametersReady 							:= FALSE;
		END_IF;
	END_FOR;
	IF gMain.Services.Recipes.Out.ParametersReady THEN
		gRemOK																	:= TRUE;
	END_IF;
	gMain.Services.Recipes.In.ForceDefaults										:= FALSE;
	gMain.Services.Recipes.In.ForceSave											:= FALSE;
	gMain.Services.Recipes.In.ForceLoad											:= FALSE;

END_ACTION
