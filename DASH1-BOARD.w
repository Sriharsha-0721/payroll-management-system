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

  Author: 

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

/* Local Variable Definitions ---                                       */

DEFINE VARIABLE        opRes     AS CHARACTER NO-UNDO.
DEFINE VARIABLE        iEmpCount AS INTEGER   NO-UNDO.
DEFINE SHARED VARIABLE cUserName AS CHARACTER NO-UNDO.
/* Parameters Definitions ---                                           */
DEFINE TEMP-TABLE ttadmin      NO-UNDO LIKE EmployeeMaster.
DEFINE TEMP-TABLE ttdetails    NO-UNDO LIKE EmployeeDetails.
DEFINE TEMP-TABLE ttattendance NO-UNDO LIKE EMPLOYEEATTENADCE.
DEFINE TEMP-TABLE ttsalary     NO-UNDO LIKE EmployeeSalarysDetails.

DEFINE VARIABLE txtUser AS CHARACTER NO-UNDO
    VIEW-AS TEXT
    FORMAT "X(40)"
    FGCOLOR 15
    BGCOLOR 0
    FONT 6.

DEFINE FRAME frUser
    txtUser AT ROW 1 COL 8 NO-LABEL.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frDashboard

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-88 IMAGE-94 TXTLOGOUT XTXTEMP ~
TXTSALARY TXTREPORT TXTPAY fiusername fiTotal fiActive fiInactive 
&Scoped-Define DISPLAYED-OBJECTS fiusername fiTotal fiActive fiInactive 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VARIABLE C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON TXTLOGOUT 
     LABEL "LOGOUT" 
     SIZE 23 BY 1.1.

DEFINE BUTTON TXTPAY 
     LABEL " EMPLOYEE PAYSLIP" 
     SIZE 42.4 BY 1.43
     FONT 5.

DEFINE BUTTON TXTREPORT 
     LABEL "EMPLOYEE REPORTS" 
     SIZE 44 BY 1.43
     FONT 5.

DEFINE BUTTON TXTSALARY 
     LABEL "EMPLOYEE SALARY" 
     SIZE 42.8 BY 1.43
     FONT 5.

DEFINE BUTTON XTXTEMP 
     LABEL "EMPLOYEE DETAILS" 
     SIZE 41.2 BY 1.43
     FONT 5.

DEFINE VARIABLE fiActive AS CHARACTER FORMAT "X(26)":U 
      VIEW-AS TEXT 
     SIZE 8 BY 1.43
     BGCOLOR 17 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fiInactive AS CHARACTER FORMAT "X(256)":U 
      VIEW-AS TEXT 
     SIZE 8 BY 1.33
     BGCOLOR 32 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fiTotal AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
      VIEW-AS TEXT 
     SIZE 7 BY 1.48
     BGCOLOR 3 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE VARIABLE fiusername AS CHARACTER FORMAT "X(56)":U 
      VIEW-AS TEXT 
     SIZE 40 BY 1.29
     BGCOLOR 33 FGCOLOR 4 FONT 6 NO-UNDO.

DEFINE IMAGE IMAGE-88
     FILENAME "C:/Users/sriharsha.c/Downloads/dashboard(final).png":U
     STRETCH-TO-FIT
     SIZE 199 BY 28.57.

DEFINE IMAGE IMAGE-94
     FILENAME "C:/Users/sriharsha.c/Downloads/user-symbol-person_108512.ico":U
     SIZE 12.8 BY 3.67.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frDashboard
     TXTLOGOUT AT ROW 1.62 COL 175 WIDGET-ID 194
     XTXTEMP AT ROW 13.14 COL 69 WIDGET-ID 190
     TXTSALARY AT ROW 13.14 COL 140 WIDGET-ID 200
     TXTREPORT AT ROW 21.19 COL 140 WIDGET-ID 198
     TXTPAY AT ROW 21.24 COL 68 WIDGET-ID 196
     fiusername AT ROW 1.48 COL 7 COLON-ALIGNED NO-LABEL WIDGET-ID 204
     fiTotal AT ROW 13.1 COL 27 NO-LABEL WIDGET-ID 222
     fiActive AT ROW 19.81 COL 25.8 COLON-ALIGNED NO-LABEL WIDGET-ID 218
     fiInactive AT ROW 26.1 COL 25.6 COLON-ALIGNED NO-LABEL WIDGET-ID 220
     IMAGE-88 AT ROW 1 COL 1 WIDGET-ID 206
     IMAGE-94 AT ROW 1.38 COL 1.6 WIDGET-ID 224
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1.14
         SIZE 240 BY 36.24
         FGCOLOR 3  WIDGET-ID 100.


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
         TITLE              = " PAY-ROLL DASH BOARD"
         HEIGHT             = 28.62
         WIDTH              = 198.8
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
/* SETTINGS FOR FRAME frDashboard
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN fiTotal IN FRAME frDashboard
   ALIGN-L                                                              */
ASSIGN 
       fiusername:READ-ONLY IN FRAME frDashboard        = TRUE.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /*  PAY-ROLL DASH BOARD */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /*  PAY-ROLL DASH BOARD */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME fiTotal
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL fiTotal C-Win
ON LEAVE OF fiTotal IN FRAME frDashboard
DO:
/*   RUN P_COUNT. */
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME TXTLOGOUT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TXTLOGOUT C-Win
ON CHOOSE OF TXTLOGOUT IN FRAME frDashboard /* LOGOUT */
DO:
  APPLY "close" TO THIS-PROCEDURE.
  RUN login_payroll.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME TXTPAY
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TXTPAY C-Win
ON CHOOSE OF TXTPAY IN FRAME frDashboard /*  EMPLOYEE PAYSLIP */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.
  RUN Employee-payslip.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME TXTREPORT
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TXTREPORT C-Win
ON CHOOSE OF TXTREPORT IN FRAME frDashboard /* EMPLOYEE REPORTS */
DO:
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RUN EMPLOYEE-REPORTS.W.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME TXTSALARY
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TXTSALARY C-Win
ON CHOOSE OF TXTSALARY IN FRAME frDashboard /* EMPLOYEE SALARY */
DO:
APPLY "CLOSE" TO THIS-PROCEDURE.
  RUN Employee_salarys.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME XTXTEMP
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL XTXTEMP C-Win
ON CHOOSE OF XTXTEMP IN FRAME frDashboard /* EMPLOYEE DETAILS */
DO:
    APPLY "CLOSE" TO THIS-PROCEDURE.
    RUN PAYROLL/employee_details.w.
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
  RUN PAYROLL/Procedures/getemployeemastee.p (INPUT-OUTPUT TABLE ttadmin,
                                              OUTPUT opRes 
                                              ).

    /* Recalculate counts */
   RUN P_COUNT.
   RUN P_ACTIVE.
   RUN P_INACTIVE.
   ASSIGN fiusername:SCREEN-VALUE = "Logged in : " + cUserName.
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
  DISPLAY fiusername fiTotal fiActive fiInactive 
      WITH FRAME frDashboard IN WINDOW C-Win.
  ENABLE IMAGE-88 IMAGE-94 TXTLOGOUT XTXTEMP TXTSALARY TXTREPORT TXTPAY 
         fiusername fiTotal fiActive fiInactive 
      WITH FRAME frDashboard IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frDashboard}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_ACTIVE C-Win 
PROCEDURE P_ACTIVE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE ACTIVECOUNT AS INTEGER NO-UNDO.
DO WITH FRAME frDashboard:
    ACTIVECOUNT = 0.
    FOR EACH ttadmin WHERE UPPER(TRIM(EmpStatus)) = "ACTIVE" NO-LOCK:
        ACTIVECOUNT = ACTIVECOUNT + 1.
    END.
    ASSIGN fiActive:SCREEN-VALUE = STRING(ACTIVECOUNT).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_COUNT C-Win 
PROCEDURE P_COUNT :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE iEmpCount AS INTEGER NO-UNDO.
iEmpCount = 0.
FOR EACH ttadmin:
    iEmpCount = iEmpCount + 1.
END.

DO WITH FRAME frDashboard:
    ASSIGN fiTotal:SCREEN-VALUE = STRING(iEmpCount).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_INACTIVE C-Win 
PROCEDURE P_INACTIVE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE INACTIVECOUNT AS INTEGER NO-UNDO.
DO WITH FRAME frDashboard:
    INACTIVECOUNT = 0.
    FOR EACH ttadmin WHERE UPPER(TRIM(EmpStatus)) = "INACTIVE" NO-LOCK:
        INACTIVECOUNT = INACTIVECOUNT + 1.
    END.
    ASSIGN fiInactive:SCREEN-VALUE = STRING(INACTIVECOUNT).
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

