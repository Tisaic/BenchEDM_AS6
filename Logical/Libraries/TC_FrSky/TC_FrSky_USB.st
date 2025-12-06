
// This function only supports a single USB connected teensy, additional will be ignored.

FUNCTION_BLOCK TC_FrSky_USB
			   
	IF enable = FALSE OR reset THEN
		Internal.State											:= FRSKY_USB_RESET;
	END_IF;

	CASE Internal.State OF
		FRSKY_USB_RESET:
			status												:= 65534;
			brsmemset(ADR(Internal),0,SIZEOF(Internal));
			connected											:= FALSE;
			Internal.State										:= FRSKY_USB_IDLE;
		FRSKY_USB_IDLE:
			status												:= 65534;
			IF enable THEN
				status											:= 65535;
				Internal.State									:= FRSKY_USB_GET_LIST_CMD;
			END_IF;
		FRSKY_USB_GET_LIST_CMD:
			status												:= 65535;
			Internal.UsbNodeListGet_0.enable 					:= TRUE;
			Internal.UsbNodeListGet_0.pBuffer 					:= ADR(Internal.NodeList);
			Internal.UsbNodeListGet_0.bufferSize 				:= SIZEOF(Internal.NodeList);
//			Internal.UsbNodeListGet_0.filterInterfaceClass 		:= 3; // FIND ONLY HID (must set Teensy to HID to find it)
//			Internal.UsbNodeListGet_0.filterInterfaceSubClass 	:= 1; // 
			Internal.State 										:= FRSKY_USB_GET_LIST_WAIT;
		FRSKY_USB_GET_LIST_WAIT:
			status												:= 65535;
			IF Internal.UsbNodeListGet_0.status = 0 THEN
				Internal.UsbNodeListGet_0.enable 				:= FALSE;
				Internal.State 									:= FRSKY_USB_GET_NODE_CMD;
			ELSIF Internal.UsbNodeListGet_0.status <> ERR_FUB_BUSY AND Internal.UsbNodeListGet_0.status <> ERR_FUB_ENABLE_FALSE THEN
				IF Internal.UsbNodeListGet_0.status <> asusbERR_USB_NOTFOUND THEN
					Internal.UsbNodeListGet_0.enable 			:= FALSE;
					status										:= Internal.UsbNodeListGet_0.status;
					Internal.State 								:= FRSKY_USB_ERROR;
				ELSE
					Internal.UsbNodeListGet_0.enable 			:= FALSE;
					Internal.State 								:= FRSKY_USB_DELAY;
				END_IF;
			END_IF;
		FRSKY_USB_GET_NODE_CMD:
			status												:= 65535;
			Internal.UsbNodeGet_0.enable 						:= TRUE;
			Internal.UsbNodeGet_0.pBuffer 						:= ADR(Internal.Node[0]);
			Internal.UsbNodeGet_0.bufferSize 					:= SIZEOF(Internal.Node[0]);
			Internal.UsbNodeGet_0.nodeId 						:= Internal.NodeList[1];
			Internal.State 										:= FRSKY_USB_GET_NODE_WAIT;
		FRSKY_USB_GET_NODE_WAIT:
			status												:= 65535;
			IF Internal.UsbNodeGet_0.status = 0 THEN
				IF TRUE THEN //Internal.Node.vendorId = 5824 AND Internal.Node.productId = 1159 THEN
					Internal.UsbNodeGet_0.enable 				:= FALSE;
					brsmemset(ADR(Internal.ParString),0,SIZEOF(Internal.ParString));
					brsstrcat(ADR(Internal.ParString), ADR(Internal.Node[0].ifName));	
					Internal.State 								:= FRSKY_USB_XOPEN_CMD;
				ELSE
					Internal.UsbNodeGet_0.enable 				:= FALSE;
					Internal.State 								:= FRSKY_USB_DELAY;
				END_IF;
			ELSIF Internal.UsbNodeGet_0.status <> ERR_FUB_BUSY AND Internal.UsbNodeGet_0.status <> ERR_FUB_ENABLE_FALSE THEN
				IF Internal.UsbNodeGet_0.status <> asusbERR_USB_NOTFOUND THEN
					Internal.UsbNodeGet_0.enable 				:= FALSE;
					status										:= Internal.UsbNodeGet_0.status;
					Internal.State 								:= FRSKY_USB_ERROR;
				ELSE
					Internal.UsbNodeGet_0.enable 				:= FALSE;
					Internal.State 								:= FRSKY_USB_DELAY;
				END_IF;
			END_IF;
		FRSKY_USB_XOPEN_CMD:
			status												:= 65535;
			Internal.FRM_xopen_0.enable 						:= TRUE;
			Internal.FRM_xopen_0.device 						:= ADR(Internal.ParString);
			Internal.State 										:= FRSKY_USB_XOPEN_WAIT;
		FRSKY_USB_XOPEN_WAIT:
			status												:= 65535;
			IF Internal.FRM_xopen_0.status = 0 THEN
				Internal.FRM_xopen_0.enable 					:= FALSE;
				Internal.Ident									:= Internal.FRM_xopen_0.ident;
				Internal.State 									:= FRSKY_USB_READ;
			ELSIF Internal.FRM_xopen_0.status <> ERR_FUB_BUSY AND Internal.FRM_xopen_0.status <> ERR_FUB_ENABLE_FALSE THEN
				//Internal.FRM_xopen_0.enable 					:= FALSE;
				//Internal.State 									:= FRSKY_USB_ERROR;
			END_IF;
		FRSKY_USB_READ:
			status												:= 0;
			connected											:= TRUE;
			Internal.FRM_read_0(enable := TRUE, ident := Internal.Ident);
			IF Internal.FRM_read_0.status = 0 THEN
				IF Internal.FRM_read_0.buflng < SIZEOF(Internal.Data) AND Internal.FRM_read_0.buffer <> 0 THEN
					brsmemset(ADR(Internal.Data),0,SIZEOF(Internal.Data));
					brsmemcpy(ADR(Internal.Data),Internal.FRM_read_0.buffer,UINT_TO_UDINT(Internal.FRM_read_0.buflng));
				END_IF;
				Internal.FRM_rbuf_0(enable := TRUE, ident := Internal.Ident, buffer := Internal.FRM_read_0.buffer, buflng := Internal.FRM_read_0.buflng);
			ELSE
				Internal.FRM_rbuf_0(enable := FALSE);
			END_IF;
//			REPEAT    
//				Internal.FRM_read_0();			
//				IF Internal.FRM_read_0.status = ERR_OK THEN
//					IF (BarcodeReader.readLen+Internal.FRM_read_0.buflng) < SIZEOF(BarcodeReader.readData) THEN
//						(* copy read data into array and check for end of barcode string *)
//						FOR BarcodeReader.i := 0 TO (Internal.FRM_read_0.buflng-1) BY 1 DO
//							brsmemcpy(ADR(BarcodeReader.readData[BarcodeReader.readLen]), Internal.FRM_read_0.buffer+BarcodeReader.i, 1);
//							BarcodeReader.readLen := BarcodeReader.readLen + 1;
//							IF BarcodeReader.readData[BarcodeReader.readLen-1] = ENDOF_BARCODE_STRING THEN  
//								(* store the new barcode *)	
//								brsmemcpy(ADR(BarcodeReader.barCodeScanCodeData), ADR(BarcodeReader.readData),BarcodeReader.readLen);	
//								BarcodeReader.barCodeLen := BarcodeReader.readLen;
//								BarcodeReader.readLen := 0;                  
//								BarcodeReader.scanCount := BarcodeReader.scanCount + 1;
//							END_IF
//						END_FOR
//					END_IF
//				
//					(* Release receiver buffer *)
//					Internal.FRM_rbuf_0.enable := TRUE;
//					Internal.FRM_rbuf_0.ident := Internal.Ident;
//					Internal.FRM_rbuf_0.buffer := Internal.FRM_read_0.buffer;		
//				
//					Internal.FRM_rbuf_0();
//				
//					IF Internal.FRM_rbuf_0.status <> ERR_OK THEN
//						BarcodeReader.step := STEP_ERROR;
//					END_IF;			
//				END_IF
//				UNTIL    
//				(Internal.FRM_read_0.status <> ERR_OK OR BarcodeReader.step = STEP_ERROR OR BarcodeReader.readLen >= SIZEOF(BarcodeReader.readData))
//			END_REPEAT;

		FRSKY_USB_CLOSE_CMD:
			status												:= 65535;
			Internal.FRM_close_0.enable 						:= TRUE;
			Internal.FRM_close_0.ident 							:= Internal.Ident;
			Internal.State 										:= FRSKY_USB_CLOSE_WAIT;
		FRSKY_USB_CLOSE_WAIT:
			status												:= 65535;
			IF Internal.FRM_close_0.status = 0 OR (Internal.FRM_close_0.status <> ERR_FUB_BUSY AND Internal.FRM_close_0.status <> ERR_FUB_ENABLE_FALSE) THEN
				Internal.FRM_close_0.enable 					:= FALSE;
				Internal.Ident									:= 0;
				Internal.State 									:= FRSKY_USB_DELAY;
			END_IF;
		FRSKY_USB_DELAY:
			status												:= 65535;
			IF Internal.CTON_Delay.Q THEN
				Internal.CTON_Delay(IN := FALSE);
				Internal.State 									:= FRSKY_USB_GET_LIST_CMD;
			ELSE
				Internal.CTON_Delay(IN := TRUE, PT := REAL_TO_TIME(2.0*1000.0));
			END_IF;
 		FRSKY_USB_ERROR:
			connected 											:= FALSE;
	END_CASE;

	Internal.UsbNodeListGet_0();
	Internal.UsbNodeGet_0();
	Internal.FRM_xopen_0();						   
	Internal.FRM_close_0();

END_FUNCTION_BLOCK
