
TYPE
    MyApp_Theta_typ : STRUCT
	    Row : DINT;
        Col : DINT;
        M : ARRAY[0..MY_MAX_THETA_IDX] OF LREAL;
    END_STRUCT;
    MyApp_P_typ : STRUCT
        Row : DINT;
        Col : DINT;
        M : ARRAY[0..MY_MAX_P_IDX] OF LREAL;
    END_STRUCT;
    MyApp_History_typ : STRUCT
        Row : DINT;
        Col : DINT;
        M : ARRAY[0..MY_MAX_HISTORY_IDX] OF LREAL;
    END_STRUCT;
    MyApp_Features_typ : STRUCT
	    Row : DINT;
        Col : DINT;
        M : ARRAY[0..MY_MAX_FEATURES_IDX] OF LREAL;
    END_STRUCT;
    MyApp_SharedWorkspace_typ : STRUCT
        Row : DINT;
        Col : DINT;
        M : ARRAY[0..MY_MAX_SHARED_WORKSPACE_IDX] OF LREAL;
    END_STRUCT;
END_TYPE
