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

/* Parameters Definitions ---                                           */

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME DEFAULT-FRAME

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS IMAGE-2 RECT-31 RECT-32 txtid ~
txttotalEarings txtdeducations TXTSALARY txtfind 
&Scoped-Define DISPLAYED-OBJECTS txtid txttotalEarings txtdeducations ~
TXTSALARY 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VARIABLE C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON txtfind 
     LABEL "FIND" 
     SIZE 15 BY 1.14.

DEFINE VARIABLE txtdeducations AS CHARACTER FORMAT "X(256)":U 
     LABEL "TOTAL DEDUCTIONS" 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1 NO-UNDO.

DEFINE VARIABLE txtid AS CHARACTER FORMAT "X(256)":U 
     LABEL "EMPID" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1 NO-UNDO.

DEFINE VARIABLE TXTSALARY AS CHARACTER FORMAT "X(256)":U 
     LABEL "NET SALARY PADI(A-B+C)" 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1 NO-UNDO.

DEFINE VARIABLE txttotalEarings AS CHARACTER FORMAT "X(256)":U 
     LABEL "TOTAL EARNINGS" 
     VIEW-AS FILL-IN 
     SIZE 33 BY 1 NO-UNDO.

DEFINE IMAGE IMAGE-2
     FILENAME "C:/Users/venkatesh.pasupuleti/OneDrive - iSpace/Pictures/Screenshots/screenshot 2025-07-21 233304.png":U
     SIZE 177 BY 8.1.

DEFINE RECTANGLE RECT-31
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 177 BY 1.91.

DEFINE RECTANGLE RECT-32
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 99 BY 7.38.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     txtid AT ROW 12.67 COL 77 COLON-ALIGNED WIDGET-ID 24
     txttotalEarings AT ROW 16.95 COL 86 COLON-ALIGNED WIDGET-ID 14
     txtdeducations AT ROW 18.14 COL 86 COLON-ALIGNED WIDGET-ID 16
     TXTSALARY AT ROW 19.33 COL 86 COLON-ALIGNED WIDGET-ID 18
     txtfind AT ROW 21 COL 88 WIDGET-ID 22
     "  PAYSLIP" VIEW-AS TEXT
          SIZE 12 BY 1.1 AT ROW 12.67 COL 18 WIDGET-ID 6
          BGCOLOR 15 FGCOLOR 9 
     IMAGE-2 AT ROW 2.91 COL 11 WIDGET-ID 4
     RECT-31 AT ROW 12.19 COL 11 WIDGET-ID 12
     RECT-32 AT ROW 15.05 COL 42 WIDGET-ID 20
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1
         SIZE 207.2 BY 21.62 WIDGET-ID 100.


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
         TITLE              = "<insert window title>"
         HEIGHT             = 21.62
         WIDTH              = 207.2
         MAX-HEIGHT         = 37.76
         MAX-WIDTH          = 307.2
         VIRTUAL-HEIGHT     = 37.76
         VIRTUAL-WIDTH      = 307.2
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
/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* <insert window title> */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* <insert window title> */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME txtfind
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL txtfind C-Win
ON CHOOSE OF txtfind IN FRAME DEFAULT-FRAME /* FIND */
DO:
  RUN p_find.
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
  DISPLAY txtid txttotalEarings txtdeducations TXTSALARY 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  ENABLE IMAGE-2 RECT-31 RECT-32 txtid txttotalEarings txtdeducations TXTSALARY 
         txtfind 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_find C-Win 
PROCEDURE p_find :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME DEFAULT-FRAME:

    /* Validate Employee ID input */
    IF txtid:SCREEN-VALUE = "0" OR txtid:SCREEN-VALUE = "" THEN DO:
        MESSAGE "Employee ID cannot be 0 or blank."
            VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
        APPLY "ENTRY" TO txtid.
        RETURN.
    END.

    /* Fetch salary details with EXCLUSIVE-LOCK for update */
    FIND FIRST EmployeeSalarysDetails
        WHERE EmployeeSalarysDetails.EmpID = INTEGER(txtid:SCREEN-VALUE)
        EXCLUSIVE-LOCK NO-ERROR.

    /* Fetch leave details with NO-LOCK */
    FIND FIRST EmployeeLeaveDetails
        WHERE EmployeeLeaveDetails.EmpID = INTEGER(txtid:SCREEN-VALUE)
        NO-LOCK NO-ERROR.

    IF AVAILABLE EmployeeSalarysDetails THEN DO:

        DEFINE VARIABLE vLossOfPay  AS DECIMAL NO-UNDO.
        DEFINE VARIABLE vNetSalary  AS DECIMAL NO-UNDO.
        DEFINE VARIABLE vTotalEarn  AS DECIMAL NO-UNDO.
        DEFINE VARIABLE vDeductions AS DECIMAL NO-UNDO.
        DEFINE VARIABLE vMWD        AS INTEGER NO-UNDO. /* Monthly Working Days */
        DEFINE VARIABLE vEWD        AS INTEGER NO-UNDO. /* Employee Working Days */

        /* Assign values from tables */
        ASSIGN
            vTotalEarn  = EmployeeSalarysDetails.TotalEarings
            vDeductions = EmployeeSalarysDetails.TotalDeducation
            vMWD        = IF AVAILABLE EmployeeLeaveDetails THEN EmployeeLeaveDetails.MonthlyWorkingDays ELSE 0
            vEWD        = IF AVAILABLE EmployeeLeaveDetails THEN EmployeeLeaveDetails.EmployeeWorkingDays ELSE 0.

        /* Calculate Loss of Pay */
        IF vMWD > 0 THEN
            vLossOfPay = (vMWD - vEWD) * (vTotalEarn / vMWD).
        ELSE
            vLossOfPay = 0.

        /* Calculate Final Net Salary */
        vNetSalary = vTotalEarn - vDeductions - vLossOfPay.

        /* Update the table */
        ASSIGN
            EmployeeSalarysDetails.NetSalaryPaid = vNetSalary.

        /* Update the screen fields */
        ASSIGN
            txttotalEarings:SCREEN-VALUE = STRING(vTotalEarn)
            txtdeducations:SCREEN-VALUE  = STRING(vDeductions)
            txtsalary:SCREEN-VALUE       = STRING(vNetSalary).
    END.
    ELSE DO:
        MESSAGE "Record not found for given Employee ID: " + txtid:SCREEN-VALUE
            VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
    END.

END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

