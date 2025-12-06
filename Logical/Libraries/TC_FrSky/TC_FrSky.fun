
{REDUND_ERROR} FUNCTION_BLOCK TC_FrSky_USB (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		enable : BOOL;
	END_VAR
	VAR_OUTPUT
		connected : BOOL;
		status : UINT;
		data : ARRAY[0..15] OF UINT;
	END_VAR
	VAR
		Internal : TC_FrSky_USB_Internal_typ;
	END_VAR
	VAR_INPUT
		reset : BOOL;
	END_VAR
END_FUNCTION_BLOCK
