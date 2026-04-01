&ANALYZE-SUSPEND _VERSION-NUMBER AB_v10r12 GUI
&ANALYZE-RESUME
/* Connected Databases 
*/
&Scoped-define WINDOW-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _DEFINITIONS C-Win 
/*------------------------------------------------------------------------

  File: 

  Description: 

  Input Parameters:
      <none>

  Output Parameters:
      <none>

  Author:sriharsha.ch

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

//{ttsalary.i}.
DEFINE VARIABLE opRes         AS CHARACTER NO-UNDO.
/* Temp-tables needed for Payslip window */
DEFINE TEMP-TABLE ttadmin      LIKE EmployeeMaster.
DEFINE TEMP-TABLE ttdetails    LIKE EmployeeDetails.
DEFINE TEMP-TABLE ttattendance LIKE EmployeeAttenadce.
DEFINE TEMP-TABLE ttsalary     LIKE EmployeeSalarysDetails.

DEFINE VARIABLE cMonth AS CHARACTER NO-UNDO.
DEFINE VARIABLE cYear  AS CHARACTER NO-UNDO.


/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME browse-frame1
&Scoped-define BROWSE-NAME brwSalaryReport

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES ttsalary ttadmin

/* Definitions for BROWSE brwSalaryReport                               */
&Scoped-define FIELDS-IN-QUERY-brwSalaryReport ttsalary.EmpID ttsalary.BasicSalary ttsalary.COMP-OFF-ENCASHMENT ttsalary.EemployeBankNum ttsalary.EmployeeIFCCode ttsalary.EmployeeUANNum ttsalary.HRA ttsalary.ITPAN ttsalary.NetSalaryPaid ttsalary.ProfessionalTax ttsalary.ProvidentFund ttsalary.SpecialAllowance ttsalary.TotalDeducation ttsalary.TotalEarings   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brwSalaryReport   
&Scoped-define SELF-NAME brwSalaryReport
&Scoped-define QUERY-STRING-brwSalaryReport FOR EACH ttsalary NO-LOCK, ~
               EACH ttadmin NO-LOCK             WHERE ttsalary.EmpID = ttadmin.EmpID               AND UPPER(ttadmin.EmpStatus) = "ACTIVE"
&Scoped-define OPEN-QUERY-brwSalaryReport OPEN QUERY brwSalaryReport     FOR EACH ttsalary NO-LOCK, ~
               EACH ttadmin NO-LOCK             WHERE ttsalary.EmpID = ttadmin.EmpID               AND UPPER(ttadmin.EmpStatus) = "ACTIVE".
&Scoped-define TABLES-IN-QUERY-brwSalaryReport ttsalary ttadmin
&Scoped-define FIRST-TABLE-IN-QUERY-brwSalaryReport ttsalary
&Scoped-define SECOND-TABLE-IN-QUERY-brwSalaryReport ttadmin


/* Definitions for FRAME browse-frame1                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-browse-frame1 ~
    ~{&OPEN-QUERY-brwSalaryReport}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-69 IMAGE-107 IMAGE-108 btxback cbMonth ~
cbYear brwSalaryReport 
&Scoped-Define DISPLAYED-OBJECTS cbMonth cbYear 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VARIABLE C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btxback 
     LABEL "BACK" 
     SIZE 15 BY 1.14
     BGCOLOR 11 .

DEFINE VARIABLE cbMonth AS CHARACTER FORMAT "X(256)":U 
     LABEL "SALARY MONTH" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","","January","February","March","April","May","June","July","August","September","October","November","December" 
     DROP-DOWN-LIST
     SIZE 28.6 BY 1
     BGCOLOR 4 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE cbYear AS CHARACTER FORMAT "X(256)":U 
     LABEL "SALARY YEAR" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","2024","2025","2026","2027","2028","2029" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 4 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE IMAGE IMAGE-107
     FILENAME "C:/Users/sriharsha.c/Downloads/reports.png":U
     STRETCH-TO-FIT
     SIZE 304 BY 27.38.

DEFINE IMAGE IMAGE-108
     FILENAME "C:/Users/sriharsha.c/Downloads/logo_final.png":U
     STRETCH-TO-FIT
     SIZE 43 BY 3.05.

DEFINE RECTANGLE RECT-69
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 286 BY 3.1
     BGCOLOR 4 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brwSalaryReport FOR 
      ttsalary, 
      ttadmin SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brwSalaryReport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brwSalaryReport C-Win _FREEFORM
  QUERY brwSalaryReport NO-LOCK DISPLAY
      ttsalary.EmpID                     COLUMN-LABEL "Emp ID"             WIDTH 10
ttsalary.BasicSalary               COLUMN-LABEL "Basic Salary"              WIDTH 17
ttsalary.COMP-OFF-ENCASHMENT      COLUMN-LABEL "Comp-Off"           WIDTH 18
ttsalary.EemployeBankNum                 COLUMN-LABEL "Bank Account"       WIDTH 22
ttsalary.EmployeeIFCCode                COLUMN-LABEL "IFSC Code"          WIDTH 20
ttsalary.EmployeeUANNum                 COLUMN-LABEL "UAN"                WIDTH 16
ttsalary.HRA                       COLUMN-LABEL "HRA"                WIDTH 17
ttsalary.ITPAN                           COLUMN-LABEL "PAN"                WIDTH 20
ttsalary.NetSalaryPaid        COLUMN-LABEL "Net Salary"         WIDTH 20
ttsalary.ProfessionalTax          COLUMN-LABEL "Prof Tax"           WIDTH 16
ttsalary.ProvidentFund             COLUMN-LABEL "PF"                 WIDTH 20
ttsalary.SpecialAllowance         COLUMN-LABEL "Special Allowance"      WIDTH 25
ttsalary.TotalDeducation           COLUMN-LABEL "Total Deduction"    WIDTH 20
ttsalary.TotalEarings            COLUMN-LABEL "Total Earnings"     WIDTH 16
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 295 BY 16.71
         BGCOLOR 0 FGCOLOR 4 FONT 6 ROW-HEIGHT-CHARS .86 NO-EMPTY-SPACE.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME browse-frame1
     btxback AT ROW 1.48 COL 3 WIDGET-ID 16
     cbMonth AT ROW 6.38 COL 56.4 COLON-ALIGNED WIDGET-ID 24
     cbYear AT ROW 6.43 COL 20 COLON-ALIGNED WIDGET-ID 22
     brwSalaryReport AT ROW 8.1 COL 6 WIDGET-ID 200
     RECT-69 AT ROW 1 COL 1 WIDGET-ID 26
     IMAGE-107 AT ROW 1 COL 1 WIDGET-ID 30
     IMAGE-108 AT ROW 24.81 COL 247 WIDGET-ID 32
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1
         SIZE 306.4 BY 34.86
         BGCOLOR 3 FGCOLOR 4  WIDGET-ID 100.


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
         TITLE              = "EMPLOYEE-REPORTS"
         HEIGHT             = 27.57
         WIDTH              = 303.4
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
/* SETTINGS FOR FRAME browse-frame1
   FRAME-NAME                                                           */
/* BROWSE-TAB brwSalaryReport cbYear browse-frame1 */
ASSIGN 
       brwSalaryReport:SEPARATOR-FGCOLOR IN FRAME browse-frame1      = 4.

IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brwSalaryReport
/* Query rebuild information for BROWSE brwSalaryReport
     _START_FREEFORM
OPEN QUERY brwSalaryReport
    FOR EACH ttsalary NO-LOCK,
        EACH ttadmin NO-LOCK
            WHERE ttsalary.EmpID = ttadmin.EmpID
              AND UPPER(ttadmin.EmpStatus) = "ACTIVE".
     _END_FREEFORM
     _Options          = "NO-LOCK INDEXED-REPOSITION"
     _Query            is OPENED
*/  /* BROWSE brwSalaryReport */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* EMPLOYEE-REPORTS */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* EMPLOYEE-REPORTS */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brwSalaryReport
&Scoped-define SELF-NAME brwSalaryReport
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL brwSalaryReport C-Win
ON ROW-DISPLAY OF brwSalaryReport IN FRAME browse-frame1
DO:
    /* === Basic Salary === */
    IF ttsalary.BasicSalary = 0 THEN
        ttsalary.BasicSalary:FGCOLOR IN BROWSE brwSalaryReport = 12.
    ELSE
        ttsalary.BasicSalary:FGCOLOR IN BROWSE brwSalaryReport = 15.
        

    /* === COMP-OFF-ENCASHMENT === */
    IF ttsalary.COMP-OFF-ENCASHMENT = 0 THEN
        ttsalary.COMP-OFF-ENCASHMENT:FGCOLOR IN BROWSE brwSalaryReport = 12.
    ELSE
        ttsalary.COMP-OFF-ENCASHMENT:FGCOLOR IN BROWSE brwSalaryReport = 15.

    /* === HRA === */
    IF ttsalary.HRA = 0 THEN
        ttsalary.HRA:FGCOLOR IN BROWSE brwSalaryReport = 12.
    ELSE
        ttsalary.HRA:FGCOLOR IN BROWSE brwSalaryReport = 15.

    /* === Net Salary === */
    IF ttsalary.NetSalaryPaid = 0 THEN
        ttsalary.NetSalaryPaid:FGCOLOR IN BROWSE brwSalaryReport = 12.
    ELSE
        ttsalary.NetSalaryPaid:FGCOLOR IN BROWSE brwSalaryReport = 15.

    /* === Professional Tax === */
    IF ttsalary.ProfessionalTax = 0 THEN
        ttsalary.ProfessionalTax:FGCOLOR IN BROWSE brwSalaryReport = 12.
    ELSE
        ttsalary.ProfessionalTax:FGCOLOR IN BROWSE brwSalaryReport = 15.

    /* === Provident Fund === */
    IF ttsalary.ProvidentFund = 0 THEN
        ttsalary.ProvidentFund:FGCOLOR IN BROWSE brwSalaryReport = 12.
    ELSE
        ttsalary.ProvidentFund:FGCOLOR IN BROWSE brwSalaryReport = 15.

    /* === Special Allowance === */
    IF ttsalary.SpecialAllowance = 0 THEN
        ttsalary.SpecialAllowance:FGCOLOR IN BROWSE brwSalaryReport = 12.
    ELSE
        ttsalary.SpecialAllowance:FGCOLOR IN BROWSE brwSalaryReport = 15.

    /* === Total Deducation === */
    IF ttsalary.TotalDeducation = 0 THEN
        ttsalary.TotalDeducation:FGCOLOR IN BROWSE brwSalaryReport = 12.
    ELSE
        ttsalary.TotalDeducation:FGCOLOR IN BROWSE brwSalaryReport = 15.

    /* === Total Earings (Blue if >0, Red if 0) === */
    IF ttsalary.TotalEarings = 0 THEN
        ttsalary.TotalEarings:FGCOLOR IN BROWSE brwSalaryReport = 12.
    ELSE DO:
        ttsalary.TotalEarings:FGCOLOR IN BROWSE brwSalaryReport = 10. /* Brighter Blue */
        //ttsalary.TotalEarings:BGCOLOR IN BROWSE brwSalaryReport = 1.   /* Bold text */
    END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btxback
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btxback C-Win
ON CHOOSE OF btxback IN FRAME browse-frame1 /* BACK */
DO:
  APPLY "close":U TO THIS-PROCEDURE.
  RUN DASH1-BOARD.W.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbMonth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbMonth C-Win
ON VALUE-CHANGED OF cbMonth IN FRAME browse-frame1 /* SALARY MONTH */
DO:
    RUN  p_FilterReport.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbYear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbYear C-Win
ON VALUE-CHANGED OF cbYear IN FRAME browse-frame1 /* SALARY YEAR */
DO:
  RUN  p_FilterReport.  
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
      RUN PAYROLL\Procedures\getEmployeePayslip.p (
        INPUT-OUTPUT TABLE ttadmin,
        INPUT-OUTPUT TABLE ttdetails,       
        INPUT-OUTPUT TABLE ttattendance,
        INPUT-OUTPUT TABLE ttsalary,
        OUTPUT opRes
    ).



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
  DISPLAY cbMonth cbYear 
      WITH FRAME browse-frame1 IN WINDOW C-Win.
  ENABLE RECT-69 IMAGE-107 IMAGE-108 btxback cbMonth cbYear brwSalaryReport 
      WITH FRAME browse-frame1 IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-browse-frame1}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_FilterReport C-Win 
PROCEDURE p_FilterReport :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VARIABLE cMonth AS CHARACTER NO-UNDO.
    DEFINE VARIABLE cYear  AS CHARACTER NO-UNDO.

    ASSIGN
        cMonth = TRIM(cbMonth:SCREEN-VALUE IN FRAME browse-frame1)
        cYear  = TRIM(cbYear:SCREEN-VALUE  IN FRAME browse-frame1).

OPEN QUERY brwSalaryReport
    FOR EACH ttsalary NO-LOCK,
        EACH ttadmin NO-LOCK
            WHERE ttSalary.EmpID = ttadmin.EmpID
              AND UPPER(ttadmin.EmpStatus) = "ACTIVE"
              AND (cMonth = "" OR UPPER(ttsalary.SalaryMonth) = UPPER(cMonth))
              AND (cYear  = "" OR STRING(ttsalary.Year) = cYear).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

