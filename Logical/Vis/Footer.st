
ACTION Footer: 

	gVis.Footer.IdentifyConfig_0();
	gVis.Footer.Revision 													:= gVis.Footer.IdentifyConfig_0.ConfigID;
	brsstrcat(ADR(gVis.Footer.Revision),ADR(' - '));
	brsstrcat(ADR(gVis.Footer.Revision),ADR(gVis.Footer.IdentifyConfig_0.ConfigVersion));
	
	gVis.Footer.currentTime													:= gMain.Services.Time.Out.Status.CurrentTime;

	IF gVis.Footer.CTON_Init.Q AND gMain.Services.Time.Out.Status.TimeValid = FALSE THEN
		gVis.Footer.TimeNotValid := TRUE;
	ELSE
		gVis.Footer.TimeNotValid := FALSE;
	END_IF
	
	//Handle Time
	IF gVis.Footer.SetTime THEN
		gVis.Footer.SetTime 												:= FALSE;
		gMain.Services.Time.In.Cmd.setTime									:= TRUE;
		gMain.Services.Time.In.Par.newTime									:= gVis.Footer.newTime;
	END_IF
	
	IF gVis.Footer.Start THEN
		gMain.Process.Master.In.Cmd.Start									:= TRUE;
	END_IF;
	gVis.Footer.Start														:= FALSE;
	IF gVis.Footer.Pause THEN
		gMain.Process.Master.In.Cmd.Pause									:= TRUE;	
	END_IF;
	gVis.Footer.Pause														:= FALSE;
	IF gVis.Footer.Stop THEN
		gMain.Process.Master.In.Cmd.NormalStop								:= TRUE;
	END_IF;
	gVis.Footer.Stop														:= FALSE;

	gVis.Footer.CTON_Init(IN:=TRUE, PT:=T#5s);
	
END_ACTION
