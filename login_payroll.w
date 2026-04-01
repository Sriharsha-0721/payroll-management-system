&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author: Sriharsha.ch

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/

/* Create an unnamed pool to store all the widgets created 
     by this procedure. This is a good default which assures
     that this procedure's triggers and internal procedures 
     will execute in this procedure's storage, and that proper
     cleanup will occur on deletion of the procedure. */

CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */
DEFINE NEW GLOBAL SHARED VARIABLE CUserName     AS CHARACTER NO-UNDO.
DEFINE VARIABLE                   iRetryCount   AS INTEGER   NO-UNDO INIT 0.
DEFINE VARIABLE                   dtLockStart   AS DATETIME  NO-UNDO.
DEFINE VARIABLE                   iLockDuration AS INTEGER   NO-UNDO INIT 60.
DEFINE VARIABLE                   copRes        AS CHARACTER NO-UNDO.
DEFINE VARIABLE                   cUser         AS CHARACTER NO-UNDO.
DEFINE VARIABLE                   cPass         AS CHARACTER NO-UNDO.
DEFINE VARIABLE                   cResult       AS CHARACTER NO-UNDO.

{GetLoginDetail.i}




/* Define variables */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frlogin

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-84 IMAGE-105 IMAGE-110 IMAGE-112 ~
fiAdmin fiPassword btn_login btn_Exit 
&Scoped-Define DISPLAYED-OBJECTS fiAdmin fiPassword 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VARIABLE C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btn_Exit 
     LABEL "CLOSE" 
     SIZE 16 BY 1.19
     BGCOLOR 7 FONT 6.

DEFINE BUTTON btn_login 
     LABEL "LOGIN" 
     SIZE 26 BY 1.48
     BGCOLOR 0 FONT 6.

DEFINE VARIABLE fiAdmin AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 4 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiPassword AS CHARACTER FORMAT "X(20)":U 
     VIEW-AS FILL-IN 
     SIZE 45 BY 1
     BGCOLOR 7 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE IMAGE IMAGE-105
     FILENAME "C:/Users/sriharsha.c/Downloads/blackcg.png":U
     STRETCH-TO-FIT
     SIZE 57 BY 4.29.

DEFINE IMAGE IMAGE-110
     FILENAME "C:/Users/sriharsha.c/Downloads/blackcg.png":U
     STRETCH-TO-FIT
     SIZE 57 BY 4.29.

DEFINE IMAGE IMAGE-112
     FILENAME "C:/Users/sriharsha.c/Downloads/blackcg.png":U
     STRETCH-TO-FIT
     SIZE 57 BY 4.29.

DEFINE IMAGE IMAGE-84
     FILENAME "C:/Users/sriharsha.c/Downloads/login_page_final.png":U
     STRETCH-TO-FIT
     SIZE 153 BY 21.43.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frlogin
     fiAdmin AT ROW 10.48 COL 95.8 COLON-ALIGNED NO-LABEL WIDGET-ID 100
     fiPassword AT ROW 12.62 COL 95.8 COLON-ALIGNED NO-LABEL WIDGET-ID 102 PASSWORD-FIELD 
     btn_login AT ROW 14.52 COL 107 WIDGET-ID 90
     btn_Exit AT ROW 18.38 COL 131 WIDGET-ID 104
     IMAGE-84 AT ROW 1 COL 1 WIDGET-ID 84
     IMAGE-105 AT ROW 14.57 COL 89 WIDGET-ID 106
     IMAGE-110 AT ROW 14.57 COL 89 WIDGET-ID 108
     IMAGE-112 AT ROW 9.81 COL 97.2 WIDGET-ID 112
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1
         SIZE 203 BY 30.67
         BGCOLOR 8  WIDGET-ID 100.


/* *********************** Procedure Settings ************************ */

&ANALYZE-SUSPEND _PROCEDURE-SETTINGS
/* Settings for THIS-PROCEDURE
   Type: Window
   Allow: Basic,Browse,DB-Fields,Window,Query
   Other Settings: COMPILE
 */
&ANALYZE-RESUME _END-PROCEDURE-SETTINGS

/* *************************  Create Window  ************************** */

&ANALYZE-SUSPEND _CREATE-WINDOW
IF SESSION:DISPLAY-TYPE = "GUI":U THEN
  CREATE WINDOW C-Win ASSIGN
         HIDDEN             = YES
         TITLE              = "LOGIN-SCREEN"
         HEIGHT             = 21.43
         WIDTH              = 152.8
         MAX-HEIGHT         = 37.76
         MAX-WIDTH          = 307.2
         VIRTUAL-HEIGHT     = 37.76
         VIRTUAL-WIDTH      = 307.2
         MAX-BUTTON         = no
         RESIZE             = yes
         SCROLL-BARS        = no
         STATUS-AREA        = no
         BGCOLOR            = ?
         FGCOLOR            = ?
         KEEP-FRAME-Z-ORDER = yes
         THREE-D            = yes
         MESSAGE-AREA       = no
         SENSITIVE          = yes.
ELSE {&WINDOW-NAME} = CURRENT-WINDOW.
/* END WINDOW DEFINITION                                                */
&ANALYZE-RESUME



/* ***********  Runtime Attributes and AppBuilder Settings  *********** */

&ANALYZE-SUSPEND _RUN-TIME-ATTRIBUTES
/* SETTINGS FOR WINDOW C-Win
  VISIBLE,,RUN-PERSISTENT                                               */
/* SETTINGS FOR FRAME frlogin
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* LOGIN-SCREEN */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* LOGIN-SCREEN */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_Exit
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_Exit C-Win
ON CHOOSE OF btn_Exit IN FRAME frlogin /* CLOSE */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btn_login
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btn_login C-Win
ON CHOOSE OF btn_login IN FRAME frlogin /* LOGIN */
DO:
  RUN P_LOGIN.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW: this will parent dialog-boxes and frames.        */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME} 
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* The CLOSE event can be used from inside or outside the procedure to  */
/* terminate it.                                                        */
ON CLOSE OF THIS-PROCEDURE 
   RUN disable_UI.

/* Best default for GUI applications is...                              */
PAUSE 0 BEFORE-HIDE.

/* Now enable the interface and wait for the exit condition.            */
/* (NOTE: handle ERROR and END-KEY so cleanup code will always fire.    */
MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
  RUN enable_UI.
  RUN "C:\Main_Project\PAYROLL\Procedures\Login\LoadAdminDataFromCSV.p".
  IF NOT THIS-PROCEDURE:PERSISTENT THEN
    WAIT-FOR CLOSE OF THIS-PROCEDURE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE disable_UI C-Win  _DEFAULT-DISABLE
PROCEDURE disable_UI :
/*------------------------------------------------------------------------------
  Purpose:     DISABLE the User Interface
  Parameters:  <none>
  Notes:       Here we clean-up the user-interface by deleting
               dynamic widgets we have created and/or hide 
               frames.  This procedure is usually called when
               we are ready to "clean-up" after running.
------------------------------------------------------------------------------*/
  /* Delete the WINDOW we created */
  IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
  THEN DELETE WIDGET C-Win.
  IF THIS-PROCEDURE:PERSISTENT THEN DELETE PROCEDURE THIS-PROCEDURE.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE enable_UI C-Win  _DEFAULT-ENABLE
PROCEDURE enable_UI :
/*------------------------------------------------------------------------------
  Purpose:     ENABLE the User Interface
  Parameters:  <none>
  Notes:       Here we display/view/enable the widgets in the
               user-interface.  In addition, OPEN all queries
               associated with each FRAME and BROWSE.
               These statements here are based on the "Other 
               Settings" section of the widget Property Sheets.
------------------------------------------------------------------------------*/
  DISPLAY fiAdmin fiPassword 
      WITH FRAME frlogin IN WINDOW C-Win.
  ENABLE IMAGE-84 IMAGE-105 IMAGE-110 IMAGE-112 fiAdmin fiPassword btn_login 
         btn_Exit 
      WITH FRAME frlogin IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frlogin}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_LOGIN C-Win 
PROCEDURE P_LOGIN :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/* Check if account locked */
IF dtLockStart <> ?
   AND (DATETIME(TODAY, TIME) - dtLockStart) < iLockDuration THEN DO:

    MESSAGE "Account locked. Please wait 1 minute."
        VIEW-AS ALERT-BOX WARNING BUTTONS OK.
    RETURN NO-APPLY.
END.

/* Empty field validation */
IF TRIM(fiAdmin:SCREEN-VALUE IN FRAME frlogin) = ""
   OR TRIM(fiPassword:SCREEN-VALUE IN FRAME frlogin) = "" THEN DO:

    MESSAGE "Username or Password cannot be blank."
        VIEW-AS ALERT-BOX  WARNING BUTTONS OK.
    RETURN NO-APPLY.
END.

/* Call backend login logic */
RUN PAYROLL/Procedures/Login/spEmployeeLogin.p(INPUT fiAdmin:SCREEN-VALUE   IN FRAME frlogin,
                                               INPUT fiPassword:SCREEN-VALUE IN FRAME frlogin,
                                               INPUT-OUTPUT TABLE ttadmin, 
                                               OUTPUT copRes
                                               ).

/* Invalid login handling */
IF copRes = "Error" THEN DO:
    iRetryCount = iRetryCount + 1.
    IF iRetryCount >= 3 THEN DO:
        dtLockStart = DATETIME(TODAY, TIME).
        MESSAGE "Too many failed attempts. Locked for 1 minute."
            VIEW-AS ALERT-BOX ERROR BUTTONS OK.
        RETURN NO-APPLY.
    END.
    ELSE DO:
        MESSAGE "Invalid Username or Password. Attempt "
                + STRING(iRetryCount) + " of 3."
            VIEW-AS ALERT-BOX ERROR BUTTONS OK.

        RETURN NO-APPLY.
    END.
END.

/* Successful Login */
FIND FIRST ttadmin NO-ERROR.
IF AVAILABLE ttadmin THEN DO:
    MESSAGE "Login Successful. Welcome " + ttadmin.USERNAME + "!"
        SKIP "Date: " + STRING(TODAY, "99/99/9999")
        SKIP "Time: " + STRING(TIME, "HH:MM:SS")
        VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

    /* Reset lockout values */
    ASSIGN iRetryCount = 0
           dtLockStart = ?.

    /* Store logged-in username */
    ASSIGN cUserName = fiAdmin:SCREEN-VALUE.

    /* Close login window and open dashboard */
    //HIDE FRAME frlogin NO-PAUSE.
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RUN DASH1-BOARD.W.
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

