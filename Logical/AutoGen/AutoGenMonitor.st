{
	MON_SYSTEM_PAR_NOT_READY : {
	  Text: {
	      en: "Parameters NOT Loaded: {&TestKey}",
	      es: "Parámetros No Cargados: {&TestKey}",
	      fr: "Paramètres Non Chargés: {&TestKey}",
	      de: "Parameter Nicht Geladen: {&TestKey}"
	  },
	  Snippets: {
	      TestKey: `gRem.RuntimeHours`,
	  },
	  Sev: 4,
	  Mask: {
	      PROCESS_MASTER: 4
	  },
	  gPar: TRUE,
	  HardCodedPar: {
		DebounceOn : 2,
		DebounceOff : 2,
	  },
	  Operator: "TC_MON_OP_AND",
	  Logical: [
		`NOT gMain.Services.Recipes.Out.ParametersReady`
	  ]
	},
	MON_SYSTEM_HMI_STOP : {
	  Text: {
	      en: "HMI STOP Pressed",
	      es: "PARADA HMI Presionada",
	      fr: "ARRÊT IHM Appuyé",
	      de: "HMI-STOPP Gedrückt"
	    },
	  Sev: 4,
	  Mask: {
	      PROCESS_MASTER: 4
	  },
	  gPar: TRUE,
	  HardCodedPar: {
		DebounceOn : 2,
		DebounceOff : 2,
	  },
	  Operator: "TC_MON_OP_AND",
	  Logical: [
		`gIO.Safety.TC_IO_DI_HMI_STOP.Signal.Filtered`
	  ]
	}
}