
{REDUND_ERROR} FUNCTION_BLOCK TC_DirMake (* *) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		enable : BOOL;
		pDevice : UDINT;
		pDirDef : UDINT;
	END_VAR
	VAR_OUTPUT
		status : UINT;
	END_VAR
	VAR
		Internal : TC_DirMake_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK TC_DirReadAll (*Reads Entire File Device*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		enable : BOOL;
		pDevice : UDINT;
		pFileList : UDINT;
	END_VAR
	VAR_OUTPUT
		status : UINT;
	END_VAR
	VAR
		Internal : TC_DirReadAll_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK TC_DirSanitize (*Sanitizes File Device*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		enable : BOOL;
		pDevice : UDINT;
		pDirDef : UDINT;
		pFileList : UDINT;
	END_VAR
	VAR_OUTPUT
		status : UINT;
	END_VAR
	VAR
		Internal : TC_DirSanitize_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK TC_Dir_USB_Connect (*TODO: Add your comment here*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		enable : BOOL;
		reset : BOOL;
		refresh : BOOL;
		delay : REAL;
	END_VAR
	VAR_OUTPUT
		status : UINT;
		connected : BOOL;
	END_VAR
	VAR
		Internal : TC_Dir_USB_Connect_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK

{REDUND_ERROR} FUNCTION_BLOCK TC_Dir_Transfer (*Transfer List from Device to Another*) (*$GROUP=User,$CAT=User,$GROUPICON=User.png,$CATICON=User.png*)
	VAR_INPUT
		enable : BOOL;
		USB_Connected : BOOL;
		pTransferList : UDINT;
	END_VAR
	VAR_OUTPUT
		index : INT;
		status : UINT;
	END_VAR
	VAR
		Internal : TC_Dir_Transfer_Internal_typ;
	END_VAR
END_FUNCTION_BLOCK
