
ACTION Settings: 

	gVis.Settings.Save.Modified												:= FALSE;
	IF brsmemcmp(ADR(gVis.Settings.ParCmp),ADR(gVis.Settings.Par),SIZEOF(gPar)) <> 0 THEN
		gVis.Settings.Save.Modified											:= TRUE;
		IF gVis.Settings.Save.Save THEN
			gPar 															:= gVis.Settings.Par;
			gVis.Settings.ParCmp 											:= gPar;
		ELSIF gVis.Settings.Save.Cancel THEN
			gVis.Settings.Par 												:= gPar;
			gVis.Settings.ParCmp 											:= gPar;
		END_IF;
	END_IF;
	gVis.Settings.Save.Save 												:= FALSE;
	gVis.Settings.Save.Cancel 												:= FALSE;
	IF brsmemcmp(ADR(gVis.Settings.ParCmp),ADR(gPar),SIZEOF(gPar)) <> 0 THEN
		// Vis structures needs to be updated from gPar because gPar changed
		gVis.Settings.Par 													:= gPar;
		gVis.Settings.ParCmp 												:= gPar;
	END_IF;

END_ACTION
