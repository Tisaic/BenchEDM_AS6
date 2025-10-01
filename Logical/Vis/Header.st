
ACTION Header: 

//Monitor
	gVis.Header.Monitor.Styles.Text											:= '#888888';
	gVis.Header.Monitor.Styles.Background									:= '#111111';
	gVis.Header.Monitor.Styles.GridColor									:= '#888888';
	gVis.Header.Monitor.Styles.Line0										:= '#00FF00';
	gVis.Header.Monitor.Styles.Line1										:= '#FFFF00';
	gVis.Header.Monitor.Styles.Line2										:= '#FF00FF';
	gVis.Header.Monitor.Styles.Line3										:= '#00FFFF';

//Notifications
	gVis.Header.Notifications.Visible[0]									:= gMain.Services.Alarms.Out.AlarmActive;
	gVis.Header.Notifications.Visible[1]									:= gMain.Services.Alarms.Out.AlarmActive;
	gVis.Header.Notifications.Visible[2]									:= gVis.Settings.Save.Modified;
	gVis.Header.Notifications.Visible[3]									:= gIO.ForceEnable;

END_ACTION
