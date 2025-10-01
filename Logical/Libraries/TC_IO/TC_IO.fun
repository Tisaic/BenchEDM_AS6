
{REDUND_ERROR} FUNCTION_BLOCK TC_IO_DO (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		Logical : BOOL;
		Forcing : TC_IO_Digital_Forcing_typ;
		Par : TC_IO_Digital_Par_typ;
	END_VAR
	VAR_OUTPUT
		Signal : TC_IO_Digital_Signal_typ;
	END_VAR
	VAR
		Internal : TC_IO_Digital_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK TC_IO_DI (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		IOMapping : BOOL;
		Forcing : TC_IO_Digital_Forcing_typ;
		Par : TC_IO_Digital_Par_typ;
		Sim : TC_IO_Digital_Sim_typ;
	END_VAR
	VAR_OUTPUT
		Signal : TC_IO_Digital_Signal_typ;
	END_VAR
	VAR
		Internal : TC_IO_Digital_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK TC_IO_AI (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		VarType : TC_IO_ANALOG_TYPE_ENUM;
		IOMapping : TC_IO_Analog_Mapping_typ;
		Forcing : TC_IO_Analog_Forcing_typ;
		Sim : TC_IO_Analog_Sim_typ;
		Par : TC_IO_Analog_Par_typ;
	END_VAR
	VAR_OUTPUT
		Signal : TC_IO_Analog_Signal_typ;
	END_VAR
	VAR
		Internal : TC_IO_Analog_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK TC_IO_AO (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		VarType : TC_IO_ANALOG_TYPE_ENUM;
		Logical : LREAL;
		Forcing : TC_IO_Analog_Forcing_typ;
		Par : TC_IO_Analog_Par_typ;
	END_VAR
	VAR_OUTPUT
		Signal : TC_IO_Analog_Signal_typ;
	END_VAR
	VAR
		Internal : TC_IO_Analog_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK
