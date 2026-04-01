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

  Author:sriharsha.ch

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/



CREATE WIDGET-POOL.

//DEF VAR vMonthName AS CHARACTER NO-UNDO.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
DEF VAR vEmpID      AS INTEGER   NO-UNDO.
DEF VAR vMonthName  AS CHARACTER NO-UNDO.
DEF VAR vYear       AS CHAR      NO-UNDO.
DEF VAR vAnswer AS LOGICAL NO-UNDO.

DEFINE TEMP-TABLE ttadmin       LIKE EmployeeMaster.
DEFINE TEMP-TABLE ttdetail     LIKE EmployeeDetails.
DEFINE TEMP-TABLE ttattendance LIKE EMPLOYEEATTENADCE.
DEFINE TEMP-TABLE ttsalary      LIKE EmployeeSalarysDetails.
DEFINE VARIABLE opRes AS CHARACTER NO-UNDO.
     
     
DEFINE TEMP-TABLE ttPayroll NO-UNDO
    FIELD EmpId              AS INTEGER
    FIELD SalaryMonth        AS CHARACTER
    FIELD ITPAN              AS CHARACTER
    FIELD BasicSalary        AS DECIMAL
    FIELD HRA                AS DECIMAL
    FIELD SpecialAllowance   AS DECIMAL
    FIELD ProvidentFund      AS DECIMAL
    FIELD TotalEarings       AS DECIMAL
    FIELD PFContribution     AS DECIMAL
    FIELD ProfessionalTax    AS DECIMAL
    FIELD TotalDeducation    AS DECIMAL
    FIELD NetSalaryPaid      AS DECIMAL
    FIELD CompOffEncashment  AS DECIMAL
    FIELD EmployeeBankNum    AS CHARACTER   
    FIELD EmployeeIFCCode    AS CHARACTER   
    FIELD EmployeeUANNum     AS CHARACTER. 

/* Local Variable Definitions ---                                       */
DEFINE VARIABLE gPrevBasicSalary AS DECIMAL NO-UNDO.
DEFINE VARIABLE gPrevHRA AS DECIMAL NO-UNDO.
DEFINE VARIABLE gPrevSpecialAllowance AS DECIMAL NO-UNDO.
DEFINE VARIABLE gPrevCompOffEncash AS DECIMAL NO-UNDO.
DEFINE VARIABLE gPrevAccountNum AS CHARACTER NO-UNDO.
DEFINE VARIABLE gPrevIFCCode AS CHARACTER NO-UNDO.
DEFINE VARIABLE gPrevUANNum AS CHARACTER NO-UNDO.
DEFINE VARIABLE gPrevITPAN AS CHARACTER NO-UNDO.
DEFINE VARIABLE gSalaryEditMode AS LOGICAL NO-UNDO INITIAL FALSE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frsalary

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-31 BTSBACK fiEmpID btsbutton 
&Scoped-Define DISPLAYED-OBJECTS fiEmpID fiEmpName fiEmail 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VARIABLE C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON BTSBACK 
     LABEL "BACK" 
     SIZE 15 BY 1.14
     BGCOLOR 11 .

DEFINE BUTTON btsbutton 
     LABEL "SEARCH" 
     SIZE 15 BY 1.14
     BGCOLOR 11 .

DEFINE VARIABLE fiEmail AS CHARACTER FORMAT "X(256)":U 
     LABEL "Employee Mail" 
     VIEW-AS FILL-IN 
     SIZE 44 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiEmpID AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Employee ID" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiEmpName AS CHARACTER FORMAT "X(56)":U 
     LABEL "Employee Name" 
     VIEW-AS FILL-IN 
     SIZE 36 BY 1
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-31
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 213 BY 2.86
     BGCOLOR 8 .

DEFINE BUTTON BTSAVE 
     LABEL "SAVE" 
     SIZE 15 BY 1.14
     BGCOLOR 11 .

DEFINE BUTTON Btsnext 
     LABEL ">>>" 
     SIZE 15 BY 1.14
     BGCOLOR 11 .

DEFINE BUTTON Btsprev 
     LABEL "<<<" 
     SIZE 15 BY 1.14
     BGCOLOR 11 .

DEFINE BUTTON btsUpdate 
     LABEL "UPDATE" 
     SIZE 15 BY 1.14
     BGCOLOR 11 .

DEFINE VARIABLE cbSalaryMonth AS CHARACTER FORMAT "X(256)":U 
     LABEL "SALARY MONTH" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","January","February","March","April","May","June","July","August","September","October","November","December" 
     DROP-DOWN-LIST
     SIZE 20 BY 1
     BGCOLOR 4 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE cbSalaryYear AS CHARACTER FORMAT "X(256)":U 
     LABEL "YEAR" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","2024","2025","2026","2027","2028","2029" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     BGCOLOR 4 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiAccountNum AS CHARACTER FORMAT "X(56)":U 
     LABEL "Employee Bank Account No" 
     VIEW-AS FILL-IN 
     SIZE 28.4 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiBasicSalary AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Employee Basic Salary" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiCompOffEncash AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Comp Off Encashment" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiHRA AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Employee HRA" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiIFCCode AS CHARACTER FORMAT "X(56)":U 
     LABEL "Employee Bank IFC Code" 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiITPAN AS CHARACTER FORMAT "X(26)":U 
     LABEL "Employee Pan Num" 
     VIEW-AS FILL-IN 
     SIZE 26 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiSpecialAllowance AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Employee Special Allowance" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiTotalEarnings AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Employee Gross Salary" 
      VIEW-AS TEXT 
     SIZE 22 BY .95
     BGCOLOR 11 FGCOLOR 0 FONT 6.

DEFINE VARIABLE fiUANNum AS CHARACTER FORMAT "X(256)":U 
     LABEL "Employee UAN Num" 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-32
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 212.6 BY 2.86
     BGCOLOR 15 .

DEFINE RECTANGLE RECT-34
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 212.6 BY 2.86
     FGCOLOR 4 .

DEFINE RECTANGLE RECT-35
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 92 BY 10.33
     FGCOLOR 4 .

DEFINE RECTANGLE RECT-61
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 92 BY 6.67
     FGCOLOR 4 .


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frsalary
     BTSBACK AT ROW 1.48 COL 2 WIDGET-ID 28
     fiEmpID AT ROW 3.62 COL 29.6 COLON-ALIGNED WIDGET-ID 14
     fiEmpName AT ROW 3.62 COL 74 COLON-ALIGNED WIDGET-ID 16
     fiEmail AT ROW 3.62 COL 135 COLON-ALIGNED WIDGET-ID 18
     btsbutton AT ROW 3.62 COL 195 WIDGET-ID 24
     "                     EMPLOYEE SALARY DETAILS" VIEW-AS TEXT
          SIZE 75 BY 1.19 AT ROW 1.24 COL 68 WIDGET-ID 62
          BGCOLOR 7 FONT 6
     RECT-31 AT ROW 2.67 COL 1 WIDGET-ID 22
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1
         SIZE 261.6 BY 37.76
         BGCOLOR 8  WIDGET-ID 100.

DEFINE FRAME frSalaryDetails
     fiAccountNum AT ROW 2.43 COL 29.4 COLON-ALIGNED WIDGET-ID 4
     fiIFCCode AT ROW 2.43 COL 85 COLON-ALIGNED WIDGET-ID 52
     fiUANNum AT ROW 2.43 COL 135 COLON-ALIGNED WIDGET-ID 24
     fiITPAN AT ROW 2.43 COL 184 COLON-ALIGNED WIDGET-ID 80
     cbSalaryYear AT ROW 5.52 COL 72.4 COLON-ALIGNED WIDGET-ID 90
     cbSalaryMonth AT ROW 5.52 COL 118.2 COLON-ALIGNED WIDGET-ID 88
     fiBasicSalary AT ROW 8.14 COL 99 COLON-ALIGNED WIDGET-ID 6
     fiHRA AT ROW 9.81 COL 99 COLON-ALIGNED WIDGET-ID 8
     fiSpecialAllowance AT ROW 11.48 COL 99 COLON-ALIGNED WIDGET-ID 10
     fiCompOffEncash AT ROW 12.91 COL 99 COLON-ALIGNED WIDGET-ID 86
     Btsprev AT ROW 24.33 COL 4 WIDGET-ID 32
     btsUpdate AT ROW 24.33 COL 64 WIDGET-ID 44
     BTSAVE AT ROW 24.33 COL 136.6 WIDGET-ID 38
     Btsnext AT ROW 24.33 COL 196 WIDGET-ID 34
     fiTotalEarnings AT ROW 18.38 COL 99 COLON-ALIGNED WIDGET-ID 14
     "   MONTHLY TOTAL EARNINGS" VIEW-AS TEXT
          SIZE 39 BY .95 AT ROW 16.33 COL 84 WIDGET-ID 76
          BGCOLOR 8 FONT 6
     RECT-32 AT ROW 23.38 COL 1 WIDGET-ID 36
     RECT-34 AT ROW 1 COL 1 WIDGET-ID 50
     RECT-35 AT ROW 4.48 COL 59 WIDGET-ID 54
     RECT-61 AT ROW 15.05 COL 59 WIDGET-ID 92
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 5.52
         SIZE 213 BY 25.48
         BGCOLOR 0 FGCOLOR 4  WIDGET-ID 200.


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
         TITLE              = "EMPLOYEE-SALARY-DETAILS"
         HEIGHT             = 30.05
         WIDTH              = 213.6
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
/* REPARENT FRAME */
ASSIGN FRAME frSalaryDetails:FRAME = FRAME frsalary:HANDLE.

/* SETTINGS FOR FRAME frsalary
   FRAME-NAME                                                           */
/* SETTINGS FOR FILL-IN fiEmail IN FRAME frsalary
   NO-ENABLE                                                            */
/* SETTINGS FOR FILL-IN fiEmpName IN FRAME frsalary
   NO-ENABLE                                                            */
/* SETTINGS FOR FRAME frSalaryDetails
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* EMPLOYEE-SALARY-DETAILS */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* EMPLOYEE-SALARY-DETAILS */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME frsalary
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL frsalary C-Win
ON GO OF FRAME frsalary
DO:
  RUN importEmployeeSalary.p.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frSalaryDetails
&Scoped-define SELF-NAME BTSAVE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTSAVE C-Win
ON CHOOSE OF BTSAVE IN FRAME frSalaryDetails /* SAVE */
DO:
  RUN P_SAVE.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frsalary
&Scoped-define SELF-NAME BTSBACK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTSBACK C-Win
ON CHOOSE OF BTSBACK IN FRAME frsalary /* BACK */
DO:
  APPLY "close" TO THIS-PROCEDURE.
  RUN  DASH1-BOARD.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btsbutton
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btsbutton C-Win
ON CHOOSE OF btsbutton IN FRAME frsalary /* SEARCH */
DO:
  RUN P_FIND.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frSalaryDetails
&Scoped-define SELF-NAME Btsnext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btsnext C-Win
ON CHOOSE OF Btsnext IN FRAME frSalaryDetails /* >>> */
DO:
  RUN P_NEXT.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Btsprev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Btsprev C-Win
ON CHOOSE OF Btsprev IN FRAME frSalaryDetails /* <<< */
DO:
  RUN p_prev.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btsUpdate
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btsUpdate C-Win
ON CHOOSE OF btsUpdate IN FRAME frSalaryDetails /* UPDATE */
DO:
  IF INTEGER(fiEmpID:SCREEN-VALUE IN FRAME frSalary) = 0 THEN DO:
    MESSAGE "Load/select an employee first." VIEW-AS ALERT-BOX INFO.
    RETURN.
  END.

  RUN p_SetSalaryFieldsSensitive(TRUE).
  ASSIGN gSalaryEditMode = TRUE.

  /* Put cursor in the first editable field */
  APPLY "ENTRY" TO fiBasicSalary IN FRAME frSalaryDetails.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbSalaryMonth
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbSalaryMonth C-Win
ON VALUE-CHANGED OF cbSalaryMonth IN FRAME frSalaryDetails /* SALARY MONTH */
DO:
  RUN p_displaysalary.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbSalaryYear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbSalaryYear C-Win
ON VALUE-CHANGED OF cbSalaryYear IN FRAME frSalaryDetails /* YEAR */
DO:
  RUN p_displaysalary.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frsalary
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME}
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

ON CLOSE OF THIS-PROCEDURE 
    RUN disable_UI.

PAUSE 0 BEFORE-HIDE.

MAIN-BLOCK:
DO ON ERROR   UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

  RUN enable_UI.
  RUN PAYROLL\Procedures\EmployeeAllTables.p ( INPUT-OUTPUT TABLE ttadmin,
                                               INPUT-OUTPUT TABLE ttdetail,
                                               INPUT-OUTPUT TABLE ttattendance,
                                               INPUT-OUTPUT TABLE ttsalary,
                                               OUTPUT opRes                                          
                                              ).   
  RUN p_displaysalary.

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
  DISPLAY fiEmpID fiEmpName fiEmail 
      WITH FRAME frsalary IN WINDOW C-Win.
  ENABLE RECT-31 BTSBACK fiEmpID btsbutton 
      WITH FRAME frsalary IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frsalary}
  DISPLAY fiAccountNum fiIFCCode fiUANNum fiITPAN cbSalaryYear cbSalaryMonth 
          fiBasicSalary fiHRA fiSpecialAllowance fiCompOffEncash fiTotalEarnings 
      WITH FRAME frSalaryDetails IN WINDOW C-Win.
  ENABLE RECT-32 RECT-34 RECT-35 RECT-61 fiAccountNum fiIFCCode fiUANNum 
         fiITPAN cbSalaryYear cbSalaryMonth fiBasicSalary fiHRA 
         fiSpecialAllowance fiCompOffEncash Btsprev btsUpdate BTSAVE Btsnext 
         fiTotalEarnings 
      WITH FRAME frSalaryDetails IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frSalaryDetails}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_displaysalary C-Win 
PROCEDURE p_displaysalary :
/*------------------------------------------------------------------------------
  Purpose : 
------------------------------------------------------------------------------*/
DEFINE VARIABLE iEmpID      AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMonthNum   AS INTEGER   NO-UNDO.
DEFINE VARIABLE cMonthName  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iYear       AS INTEGER   NO-UNDO.
DEFINE VARIABLE cSelMonth   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cSelYear    AS CHARACTER NO-UNDO.

FIND FIRST ttAdmin 
     WHERE UPPER(TRIM(ttAdmin.EmpStatus)) = "ACTIVE"
     NO-LOCK NO-ERROR.

IF NOT AVAILABLE ttAdmin THEN DO:
    MESSAGE "No active employees found."
        VIEW-AS ALERT-BOX INFO.
    RETURN.
END.

iEmpID = ttAdmin.EmpID.

/*
   Step 2: Default Month/Year
*/
iMonthNum = MONTH(TODAY).
iYear     = YEAR(TODAY).

CASE iMonthNum:
    WHEN 1  THEN cMonthName = "January".
    WHEN 2  THEN cMonthName = "February".
    WHEN 3  THEN cMonthName = "March".
    WHEN 4  THEN cMonthName = "April".
    WHEN 5  THEN cMonthName = "May".
    WHEN 6  THEN cMonthName = "June".
    WHEN 7  THEN cMonthName = "July".
    WHEN 8  THEN cMonthName = "August".
    WHEN 9  THEN cMonthName = "September".
    WHEN 10 THEN cMonthName = "October".
    WHEN 11 THEN cMonthName = "November".
    WHEN 12 THEN cMonthName = "December".
END CASE.

/* If no selection done yet, set defaults */
cSelMonth = TRIM(cbSalaryMonth:SCREEN-VALUE IN FRAME frSalaryDetails).
cSelYear  = TRIM(cbSalaryYear:SCREEN-VALUE IN FRAME frSalaryDetails).

IF cSelMonth = "" THEN cSelMonth = cMonthName.
IF cSelYear  = "" THEN cSelYear  = STRING(iYear).

/*
   Step 3: Display Employee Profile
*/
FIND FIRST ttDetail WHERE ttDetail.EmpID = iEmpID NO-LOCK NO-ERROR.

DO WITH FRAME frSalary:
    ASSIGN fiEmpID:SCREEN-VALUE   = STRING(iEmpID)
           fiEmpName:SCREEN-VALUE = IF AVAILABLE ttDetail THEN ttDetail.EmpName ELSE ""
           fiEmail:SCREEN-VALUE   = IF AVAILABLE ttDetail THEN ttDetail.Email   ELSE ""
           fiEmpID:SENSITIVE      = TRUE
           fiEmpName:SENSITIVE    = FALSE
           fiEmail:SENSITIVE      = FALSE.
    END.

/*
   Step 4: Load salary info
*/
FIND FIRST ttSalary
     WHERE ttSalary.EmpID       = iEmpID
       AND ttSalary.SalaryMonth = cSelMonth
       AND ttSalary.Year        = cSelYear
     NO-LOCK NO-ERROR.

DO WITH FRAME frSalaryDetails:

    /* If record exists — load from ttsalary */
    IF AVAILABLE ttSalary THEN DO:
        ASSIGN cbSalaryMonth:SCREEN-VALUE      = ttSalary.SalaryMonth
               cbSalaryYear:SCREEN-VALUE       = ttSalary.Year
               fiBasicSalary:SCREEN-VALUE      = STRING(ttSalary.BasicSalary)
               fiHRA:SCREEN-VALUE              = STRING(ttSalary.HRA)
               fiSpecialAllowance:SCREEN-VALUE = STRING(ttSalary.SpecialAllowance)
               fiCompOffEncash:SCREEN-VALUE    = STRING(ttSalary.COMP-OFF-ENCASHMENT)
               fiTotalEarnings:SCREEN-VALUE    = STRING(ttSalary.TotalEarings)
               fiAccountNum:SCREEN-VALUE       = ttSalary.EemployeBankNum
               fiIFCCode:SCREEN-VALUE          = ttSalary.EmployeeIFCCode
               fiUANNum:SCREEN-VALUE           = ttSalary.EmployeeUANNum
               fiITPAN:SCREEN-VALUE            = ttSalary.ITPAN.
        END.
    ELSE DO:
        /* No record show defaults */
        ASSIGN cbSalaryMonth:SCREEN-VALUE      = cSelMonth
               cbSalaryYear:SCREEN-VALUE       = cSelYear
               fiBasicSalary:SCREEN-VALUE      = "0"
               fiHRA:SCREEN-VALUE              = "0"
               fiSpecialAllowance:SCREEN-VALUE = "0"
               fiCompOffEncash:SCREEN-VALUE    = "0"
               fiTotalEarnings:SCREEN-VALUE    = "0"
               fiAccountNum:SCREEN-VALUE       = ""
               fiIFCCode:SCREEN-VALUE          = ""
               fiUANNum:SCREEN-VALUE           = ""
               fiITPAN:SCREEN-VALUE            = "".
        END.

    /* Set sensitivity */
    ASSIGN cbSalaryMonth:SENSITIVE      = TRUE
           cbSalaryYear:SENSITIVE       = TRUE
           fiBasicSalary:SENSITIVE      = FALSE
           fiHRA:SENSITIVE              = FALSE
           fiSpecialAllowance:SENSITIVE = FALSE
           fiCompOffEncash:SENSITIVE    = FALSE
           fiTotalEarnings:SENSITIVE    = FALSE
           fiAccountNum:SENSITIVE       = FALSE
           fiIFCCode:SENSITIVE          = FALSE
           fiUANNum:SENSITIVE           = FALSE
           fiITPAN:SENSITIVE            = FALSE.
     END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_FIND C-Win 
PROCEDURE P_FIND :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE iEmployeeID     AS INTEGER   NO-UNDO.
DEFINE VARIABLE cMonthName      AS CHARACTER NO-UNDO.
DEFINE VARIABLE iYear           AS INTEGER   NO-UNDO. 

/* Retrieve User Input from UI Fields */
iEmployeeID = INTEGER(fiEmpID:SCREEN-VALUE IN FRAME frsalary).
cMonthName  = TRIM(cbSalaryMonth:SCREEN-VALUE IN FRAME frSalaryDetails).
iYear       = INTEGER(cbSalaryYear:SCREEN-VALUE IN FRAME frSalaryDetails). 

/* VALIDATE INPUT */
IF iEmployeeID = 0 THEN DO:
    MESSAGE "Please enter a valid Employee ID."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.

IF cMonthName = "" OR iYear = 0 THEN DO:
    MESSAGE "Please select a valid Salary Month and Year."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.

/*FIND EMPLOYEE DETAILS*/
FIND EmployeeDetails NO-LOCK
    WHERE EmployeeDetails.EmpID = iEmployeeID NO-ERROR.

IF NOT AVAILABLE EmployeeDetails THEN DO:
    MESSAGE "Employee ID " iEmployeeID " not found."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    //RUN ClearAllEmployeeAndSalaryFields.
    RETURN.
END.

/* ==============================
      FIND EMPLOYEE ADMIN DETAILS
   ============================== */
FIND ttadmin NO-LOCK
    WHERE ttadmin.EmpID = iEmployeeID NO-ERROR.

IF AVAILABLE ttadmin THEN DO:
    DO WITH FRAME frsalary:
        ASSIGN fiEmpID:SCREEN-VALUE    = STRING(EmployeeDetails.EmpID)
               fiEmpName:SCREEN-VALUE  = EmployeeDetails.EmpName
               fiEmail:SCREEN-VALUE    = EmployeeDetails.Email
               fiEmpID:SENSITIVE       = TRUE
               fiEmpName:SENSITIVE     = FALSE
               fiEmail:SENSITIVE       = FALSE.
         END.

    IF ttadmin.EmpStatus = "Inactive" THEN DO:
        MESSAGE "Employee " EmployeeDetails.EmpName " is inactive. Salary details cannot be displayed."
            VIEW-AS ALERT-BOX INFO BUTTONS OK.
                ASSIGN fiBasicSalary:SCREEN-VALUE = ""
               fiHRA:SCREEN-VALUE                 = ""
               fiSpecialAllowance:SCREEN-VALUE    = ""
               fiTotalEarnings:SCREEN-VALUE       = ""
               fiAccountNum:SCREEN-VALUE          = ""
               fiIFCCode:SCREEN-VALUE             = ""
               fiUANNum:SCREEN-VALUE              = ""
               fiITPAN:SCREEN-VALUE               = ""
               fiCompOffEncash:SCREEN-VALUE       = ""
               cbSalaryYear:SCREEN-VALUE          = "". 
        RETURN.
    END.
END.
ELSE DO:
    MESSAGE "Warning: Administrative details not found for employee " iEmployeeID "."
        VIEW-AS ALERT-BOX WARNING.
    DO WITH FRAME frsalary:
        ASSIGN fiEmpID:SCREEN-VALUE    = STRING(EmployeeDetails.EmpID)
               fiEmpName:SCREEN-VALUE  = EmployeeDetails.EmpName
               fiEmail:SCREEN-VALUE    = EmployeeDetails.Email
               fiEmpID:SENSITIVE       = TRUE
               fiEmpName:SENSITIVE     = FALSE
               fiEmail:SENSITIVE       = FALSE.
        END.
END.

/*FIND SALARY DETAILS FOR ACTIVE EMPLOYEE*/
FIND EmployeeSalary NO-LOCK
    WHERE EmployeeSalary.EmpID      = iEmployeeID
      AND EmployeeSalary.SalaryMonth = cMonthName
      AND EmployeeSalary.Year       = STRING(iYear) 
    NO-ERROR.

DO WITH FRAME frSalaryDetails:
    IF AVAILABLE EmployeeSalary THEN DO:
        ASSIGN fiBasicSalary:SCREEN-VALUE      = STRING(EmployeeSalary.BasicSalary)
               fiHRA:SCREEN-VALUE              = STRING(EmployeeSalary.HRA)
               fiSpecialAllowance:SCREEN-VALUE = STRING(EmployeeSalary.SpecialAllowance)
               fiTotalEarnings:SCREEN-VALUE    = STRING(EmployeeSalary.TotalEarings)
               fiAccountNum:SCREEN-VALUE       = STRING(EmployeeSalary.EemployeBankNum)
               fiIFCCode:SCREEN-VALUE          = EmployeeSalary.EmployeeIFCCode
               fiUANNum:SCREEN-VALUE           = EmployeeSalary.EmployeeUANNum
               fiITPAN:SCREEN-VALUE            = EmployeeSalary.ITPAN
               fiCompOffEncash:SCREEN-VALUE    = STRING(EmployeeSalarysDetails.COMP-OFF-ENCASHMENT)
               cbSalaryYear:SCREEN-VALUE       = STRING(EmployeeSalary.Year).
               fiBasicSalary:SENSITIVE         = FALSE.
               fiHRA:SENSITIVE                 = FALSE.
               fiSpecialAllowance:SENSITIVE    = FALSE.
               fiTotalEarnings:SENSITIVE       = FALSE.
               fiAccountNum:SENSITIVE          = FALSE.
               fiIFCCode:SENSITIVE             = FALSE.
               fiUANNum:SENSITIVE              = FALSE.
               fiITPAN:SENSITIVE               = FALSE.
               fiCompOffEncash:SENSITIVE       = FALSE.
               cbSalaryYear:SENSITIVE          = TRUE.
    END.
    ELSE DO:
             MESSAGE "Please select month and year before searching."
             VIEW-AS ALERT-BOX INFO.
        //RUN ClearSalaryFields.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_NEXT C-Win 
PROCEDURE P_NEXT :
/*------------------------------------------------------------------------------
  Purpose : Show NEXT Employee Salary using TEMP-TABLES (correct)
------------------------------------------------------------------------------*/

DEFINE VARIABLE iCurrentEmpID AS INTEGER   NO-UNDO.
DEFINE VARIABLE cMonthName    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iYear         AS INTEGER   NO-UNDO.

/* Read current selection */
iCurrentEmpID = INTEGER(fiEmpID:SCREEN-VALUE IN FRAME frsalary).
cMonthName    = TRIM(cbSalaryMonth:SCREEN-VALUE IN FRAME frSalaryDetails).
iYear         = INTEGER(cbSalaryYear:SCREEN-VALUE IN FRAME frSalaryDetails).

IF cMonthName = "" OR iYear = 0 THEN DO:
    MESSAGE "Please select both month and year to find salary details."
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* Find current employee in ttadmin */
FIND ttadmin WHERE ttadmin.EmpID = iCurrentEmpID NO-LOCK NO-ERROR.

/* Find NEXT ACTIVE employee */
FIND NEXT ttadmin
    WHERE ttadmin.EmpStatus <> "Inactive"
    NO-LOCK NO-ERROR.

IF AVAILABLE ttadmin THEN DO:

    /* Display employee details */
    FIND FIRST ttdetail WHERE ttdetail.EmpID = ttadmin.EmpID NO-LOCK NO-ERROR.

    DO WITH FRAME frsalary:
        ASSIGN
            fiEmpID:SCREEN-VALUE   = STRING(ttadmin.EmpID)
            fiEmpName:SCREEN-VALUE = (IF AVAILABLE ttdetail THEN ttdetail.EmpName ELSE "")
            fiEmail:SCREEN-VALUE   = (IF AVAILABLE ttdetail THEN ttdetail.Email   ELSE "")
            fiEmpID:SENSITIVE      = TRUE
            fiEmpName:SENSITIVE    = FALSE
            fiEmail:SENSITIVE      = FALSE.
    END.

    /* ============================================================
        Load SALARY from ttsalary (NOT from EmployeeSalary table)
       ============================================================ */
    FIND FIRST ttsalary
        WHERE ttsalary.EmpID       = ttadmin.EmpID
          AND ttsalary.SalaryMonth = cMonthName
          AND ttsalary.YEAR        = STRING(iYear)
        NO-LOCK NO-ERROR.

    DO WITH FRAME frSalaryDetails:

        IF AVAILABLE ttsalary THEN DO:
            ASSIGN
                fiBasicSalary:SCREEN-VALUE      = STRING(ttsalary.BasicSalary)
                fiHRA:SCREEN-VALUE              = STRING(ttsalary.HRA)
                fiSpecialAllowance:SCREEN-VALUE = STRING(ttsalary.SpecialAllowance)
                fiCompOffEncash:SCREEN-VALUE    = STRING(ttsalary.COMP-OFF-ENCASHMENT)
                fiTotalEarnings:SCREEN-VALUE    = STRING(ttsalary.TotalEarings)
                fiAccountNum:SCREEN-VALUE       = ttsalary.EemployeBankNum
                fiIFCCode:SCREEN-VALUE          = ttsalary.EmployeeIFCCode
                fiUANNum:SCREEN-VALUE           = ttsalary.EmployeeUANNum
                fiITPAN:SCREEN-VALUE            = ttsalary.ITPAN
                /* sensitivity */
                fiBasicSalary:SENSITIVE         = FALSE
                fiHRA:SENSITIVE                 = FALSE
                fiSpecialAllowance:SENSITIVE    = FALSE
                fiCompOffEncash:SENSITIVE       = FALSE
                fiTotalEarnings:SENSITIVE       = FALSE
                fiAccountNum:SENSITIVE          = FALSE
                fiIFCCode:SENSITIVE             = FALSE
                fiUANNum:SENSITIVE              = FALSE
                fiITPAN:SENSITIVE               = FALSE.
        END.
        ELSE DO:
            MESSAGE "Salary for selected month/year not found."
                VIEW-AS ALERT-BOX INFO.
        END.

    END.
END.
ELSE DO:
    MESSAGE "You are at the last active employee record."
        VIEW-AS ALERT-BOX INFORMATION.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_prev C-Win 
PROCEDURE p_prev :
/*------------------------------------------------------------------------------
  Purpose : 
------------------------------------------------------------------------------*/

DEFINE VARIABLE iCurrentEmpID AS INTEGER   NO-UNDO.
DEFINE VARIABLE cMonthName    AS CHARACTER NO-UNDO.
DEFINE VARIABLE iYear         AS INTEGER   NO-UNDO.

/* Read current selection */
iCurrentEmpID = INTEGER(fiEmpID:SCREEN-VALUE IN FRAME frsalary).
cMonthName    = TRIM(cbSalaryMonth:SCREEN-VALUE IN FRAME frSalaryDetails).
iYear         = INTEGER(cbSalaryYear:SCREEN-VALUE IN FRAME frSalaryDetails).

/* Validate */
IF cMonthName = "" OR iYear = 0 THEN DO:
    MESSAGE "Please select both month and year to find salary details."
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* Find current employee */
FIND ttAdmin WHERE ttAdmin.EmpID = iCurrentEmpID NO-LOCK NO-ERROR.

/* Find PREVIOUS ACTIVE employee */
FIND PREV ttAdmin
     WHERE ttAdmin.EmpStatus <> "Inactive"
     NO-LOCK NO-ERROR.

IF AVAILABLE ttAdmin THEN DO:

    /*-------------------------------------------
      DISPLAY EMPLOYEE DETAILS (from ttdetail)
    -------------------------------------------*/
    FIND FIRST ttdetail WHERE ttdetail.EmpID = ttAdmin.EmpID NO-LOCK NO-ERROR.

    DO WITH FRAME frsalary:
        ASSIGN
            fiEmpID:SCREEN-VALUE    = STRING(ttAdmin.EmpID)
            fiEmpName:SCREEN-VALUE  = (IF AVAILABLE ttdetail THEN ttdetail.EmpName ELSE "")
            fiEmail:SCREEN-VALUE    = (IF AVAILABLE ttdetail THEN ttdetail.Email ELSE "")
            fiEmpID:SENSITIVE       = TRUE
            fiEmpName:SENSITIVE     = FALSE
            fiEmail:SENSITIVE       = FALSE.
    END.

    /*---------------------------------------------------
      DISPLAY SALARY DETAILS FROM TTSALARY (not DB)
    ---------------------------------------------------*/
    FIND FIRST ttsalary
        WHERE ttsalary.EmpID       = ttAdmin.EmpID
          AND ttsalary.SalaryMonth = cMonthName
          AND ttsalary.YEAR        = STRING(iYear)
        NO-LOCK NO-ERROR.

    DO WITH FRAME frSalaryDetails:

        IF AVAILABLE ttsalary THEN DO:
            ASSIGN
                fiBasicSalary:SCREEN-VALUE      = STRING(ttsalary.BasicSalary)
                fiHRA:SCREEN-VALUE              = STRING(ttsalary.HRA)
                fiSpecialAllowance:SCREEN-VALUE = STRING(ttsalary.SpecialAllowance)
                fiCompOffEncash:SCREEN-VALUE    = STRING(ttsalary.COMP-OFF-ENCASHMENT)
                fiTotalEarnings:SCREEN-VALUE    = STRING(ttsalary.TotalEarings)
                fiAccountNum:SCREEN-VALUE       = ttsalary.EemployeBankNum
                fiIFCCode:SCREEN-VALUE          = ttsalary.EmployeeIFCCode
                fiUANNum:SCREEN-VALUE           = ttsalary.EmployeeUANNum
                fiITPAN:SCREEN-VALUE            = ttsalary.ITPAN
                /* sensitivity */
                fiBasicSalary:SENSITIVE         = FALSE
                fiHRA:SENSITIVE                 = FALSE
                fiSpecialAllowance:SENSITIVE    = FALSE
                fiCompOffEncash:SENSITIVE       = FALSE
                fiTotalEarnings:SENSITIVE       = FALSE
                fiAccountNum:SENSITIVE          = FALSE
                fiIFCCode:SENSITIVE             = FALSE
                fiUANNum:SENSITIVE              = FALSE
                fiITPAN:SENSITIVE               = FALSE.
        END.
        ELSE DO:
            MESSAGE "Salary not found for employee " STRING(ttAdmin.EmpID)
                    + " for " cMonthName + " " + STRING(iYear) + "."
                VIEW-AS ALERT-BOX INFO.
        END.
    END.

END.
ELSE DO:
    MESSAGE "You are at the first active employee record."
        VIEW-AS ALERT-BOX INFORMATION.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_save C-Win 
PROCEDURE p_save :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE lConfirm AS LOGICAL   NO-UNDO.
DEFINE VARIABLE cMsg     AS CHARACTER NO-UNDO.

/* If not in edit mode */
IF NOT gSalaryEditMode THEN DO:
    MESSAGE "Nothing to save. Click Update first."
        VIEW-AS ALERT-BOX INFO.
    RETURN.
END.

/* Confirm */
MESSAGE "Save changes to this employee's salary?"
    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE lConfirm.
IF NOT lConfirm THEN RETURN.

/* Validations */
IF cbSalaryMonth:SCREEN-VALUE IN FRAME frSalaryDetails = "" THEN DO:
    MESSAGE "Select Salary Month." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

IF cbSalaryYear:SCREEN-VALUE IN FRAME frSalaryDetails = "" THEN DO:
    MESSAGE "Enter Salary Year." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/*---------------------------------------------------------------
    STEP 1: Recompute Total Earnings
----------------------------------------------------------------*/
DO WITH FRAME frSalaryDetails:
    ASSIGN fiTotalEarnings:SCREEN-VALUE = STRING(
            DECIMAL(fiBasicSalary:SCREEN-VALUE)
          + DECIMAL(fiHRA:SCREEN-VALUE)
          + DECIMAL(fiSpecialAllowance:SCREEN-VALUE)
          + DECIMAL(fiCompOffEncash:SCREEN-VALUE)
        ).
END.

/*---------------------------------------------------------------
    STEP 2: CALL BACKEND SAVE (DB + CSV UPDATE)
----------------------------------------------------------------*/
RUN Procedures/employee_salaries/spEmployeeSalarySave.p (INPUT INTEGER(fiEmpID:SCREEN-VALUE IN FRAME frSalary),
                                                         INPUT cbSalaryMonth:SCREEN-VALUE IN FRAME frSalaryDetails,
                                                         INPUT INTEGER(cbSalaryYear:SCREEN-VALUE IN FRAME frSalaryDetails),
                                                         INPUT DECIMAL(fiBasicSalary:SCREEN-VALUE IN FRAME frSalaryDetails),
                                                         INPUT DECIMAL(fiHRA:SCREEN-VALUE IN FRAME frSalaryDetails),
                                                         INPUT DECIMAL(fiSpecialAllowance:SCREEN-VALUE IN FRAME frSalaryDetails),
                                                         INPUT DECIMAL(fiCompOffEncash:SCREEN-VALUE IN FRAME frSalaryDetails),
                                                         INPUT DECIMAL(fiTotalEarnings:SCREEN-VALUE IN FRAME frSalaryDetails),
                                                         INPUT fiAccountNum:SCREEN-VALUE IN FRAME frSalaryDetails,
                                                         INPUT fiIFCCode:SCREEN-VALUE IN FRAME frSalaryDetails,
                                                         INPUT fiUANNum:SCREEN-VALUE IN FRAME frSalaryDetails,
                                                         INPUT fiITPAN:SCREEN-VALUE IN FRAME frSalaryDetails,
                                                         OUTPUT cMsg
                                                         ).

/*----------------------------------------------------------------
    STEP 3: Update ttsalary temp-table (IMPORTANT)
----------------------------------------------------------------*/
FIND FIRST ttsalary
     WHERE ttsalary.EmpID       = INTEGER(fiEmpID:SCREEN-VALUE IN FRAME frSalary)
       AND ttsalary.SalaryMonth = cbSalaryMonth:SCREEN-VALUE IN FRAME frSalaryDetails
       AND ttsalary.YEAR        = cbSalaryYear:SCREEN-VALUE IN FRAME frSalaryDetails
     EXCLUSIVE-LOCK NO-ERROR.

IF AVAILABLE ttsalary THEN DO:
    ASSIGN
        ttsalary.BasicSalary       = DECIMAL(fiBasicSalary:SCREEN-VALUE IN FRAME frSalaryDetails)
        ttsalary.HRA               = DECIMAL(fiHRA:SCREEN-VALUE IN FRAME frSalaryDetails)
        ttsalary.SpecialAllowance  = DECIMAL(fiSpecialAllowance:SCREEN-VALUE IN FRAME frSalaryDetails)
        ttsalary.COMP-OFF-ENCASHMENT = DECIMAL(fiCompOffEncash:SCREEN-VALUE IN FRAME frSalaryDetails)
        ttsalary.TotalEarings      = DECIMAL(fiTotalEarnings:SCREEN-VALUE IN FRAME frSalaryDetails)
        ttsalary.EemployeBankNum   = fiAccountNum:SCREEN-VALUE IN FRAME frSalaryDetails
        ttsalary.EmployeeIFCCode   = fiIFCCode:SCREEN-VALUE IN FRAME frSalaryDetails
        ttsalary.EmployeeUANNum    = fiUANNum:SCREEN-VALUE IN FRAME frSalaryDetails
        ttsalary.ITPAN             = fiITPAN:SCREEN-VALUE IN FRAME frSalaryDetails.
END.
ELSE DO:
    /* Create New Record */
    CREATE ttsalary.
    ASSIGN
        ttsalary.EmpID             = INTEGER(fiEmpID:SCREEN-VALUE IN FRAME frSalary)
        ttsalary.SalaryMonth       = cbSalaryMonth:SCREEN-VALUE IN FRAME frSalaryDetails
        ttsalary.YEAR              = cbSalaryYear:SCREEN-VALUE IN FRAME frSalaryDetails
        ttsalary.BasicSalary       = DECIMAL(fiBasicSalary:SCREEN-VALUE IN FRAME frSalaryDetails)
        ttsalary.HRA               = DECIMAL(fiHRA:SCREEN-VALUE IN FRAME frSalaryDetails)
        ttsalary.SpecialAllowance  = DECIMAL(fiSpecialAllowance:SCREEN-VALUE IN FRAME frSalaryDetails)
        ttsalary.COMP-OFF-ENCASHMENT = DECIMAL(fiCompOffEncash:SCREEN-VALUE IN FRAME frSalaryDetails)
        ttsalary.TotalEarings      = DECIMAL(fiTotalEarnings:SCREEN-VALUE IN FRAME frSalaryDetails)
        ttsalary.EemployeBankNum   = fiAccountNum:SCREEN-VALUE IN FRAME frSalaryDetails
        ttsalary.EmployeeIFCCode   = fiIFCCode:SCREEN-VALUE IN FRAME frSalaryDetails
        ttsalary.EmployeeUANNum    = fiUANNum:SCREEN-VALUE IN FRAME frSalaryDetails
        ttsalary.ITPAN             = fiITPAN:SCREEN-VALUE IN FRAME frSalaryDetails.
END.

//RUN p_displaysalary.

MESSAGE (IF cMsg = "" THEN "Saved successfully." ELSE cMsg)
    VIEW-AS ALERT-BOX INFORMATION.

ASSIGN gSalaryEditMode = FALSE.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_SetSalaryFieldsSensitive C-Win 
PROCEDURE p_SetSalaryFieldsSensitive :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER plEnable AS LOGICAL NO-UNDO.

DO WITH FRAME frSalaryDetails:
  ASSIGN fiBasicSalary:SENSITIVE       = plEnable
         fiHRA:SENSITIVE               = plEnable
         fiSpecialAllowance:SENSITIVE  = plEnable
         fiCompOffEncash:SENSITIVE     = plEnable
         fiTotalEarnings:SENSITIVE     = FALSE
         fiAccountNum:SENSITIVE        = plEnable
         fiIFCCode:SENSITIVE           = plEnable
         fiUANNum:SENSITIVE            = plEnable
         fiITPAN:SENSITIVE             = plEnable
         cbSalaryMonth:SENSITIVE       = plEnable
         cbSalaryYear:SENSITIVE        = plEnable.
   END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_UPDATE C-Win 
PROCEDURE P_UPDATE :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE vEmpID     AS INTEGER   NO-UNDO.
DEFINE VARIABLE vMonthName AS CHARACTER NO-UNDO.
DEFINE VARIABLE vYear      AS CHARACTER NO-UNDO.

/* Get inputs */
ASSIGN
    vEmpID     = INTEGER(fiEmpID:SCREEN-VALUE IN FRAME frsalary)
    vMonthName = TRIM(cbSalaryMonth:SCREEN-VALUE IN FRAME frSalaryDetails)
    vYear      = TRIM(cbSalaryYear:SCREEN-VALUE IN FRAME frSalaryDetails).

IF vEmpID = 0 THEN DO:
    MESSAGE "Please enter a valid Employee ID." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

IF vMonthName = "" OR vYear = "" THEN DO:
    MESSAGE "Please select both a month and a year." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* ===========================================
   1) LOAD FROM TEMP-TABLE ttdetail (Employee)
   =========================================== */
FIND FIRST ttdetail NO-LOCK
    WHERE ttdetail.EmpID = vEmpID
    NO-ERROR.

IF NOT AVAILABLE ttdetail THEN DO:
    MESSAGE "Employee not found in system." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* Fill employee UI fields */
DO WITH FRAME frsalary:
    ASSIGN 
        fiEmpID:SCREEN-VALUE   = STRING(ttdetail.EmpID)
        fiEmpName:SCREEN-VALUE = ttdetail.EmpName
        fiEmail:SCREEN-VALUE   = ttdetail.Email.
END.

/* ===========================================
   2) LOAD SALARY FROM TTTSALARY
   =========================================== */
FIND FIRST ttsalary NO-LOCK
    WHERE STRING(ttsalary.EmpID) = STRING(vEmpID)
      AND CAPS(STRING(ttsalary.SalaryMonth)) = CAPS(vMonthName)
      AND STRING(ttsalary.Year) = STRING(vYear)
    NO-ERROR.


DO WITH FRAME frSalaryDetails:

    IF AVAILABLE ttsalary THEN DO:
        /* Existing salary record – fill UI */
        ASSIGN
            fiBasicSalary:SCREEN-VALUE      = STRING(ttsalary.BasicSalary)
            fiHRA:SCREEN-VALUE              = STRING(ttsalary.HRA)
            fiSpecialAllowance:SCREEN-VALUE = STRING(ttsalary.SpecialAllowance)
            fiTotalEarnings:SCREEN-VALUE    = STRING(ttsalary.TotalEarings)
            fiAccountNum:SCREEN-VALUE       = STRING(ttsalary.EemployeBankNum)
            fiIFCCode:SCREEN-VALUE          = ttsalary.EmployeeIFCCode
            fiUANNum:SCREEN-VALUE           = STRING(ttsalary.EmployeeUANNum)
            fiITPAN:SCREEN-VALUE            = ttsalary.ITPAN
            fiCompOffEncash:SCREEN-VALUE    = STRING(ttsalary.COMP-OFF-ENCASHMENT)
            cbSalaryYear:SCREEN-VALUE       = STRING(ttsalary.Year).
    END.
    ELSE DO:
        /* New salary entry — clear UI */
        ASSIGN
            fiBasicSalary:SCREEN-VALUE      = ""
            fiHRA:SCREEN-VALUE              = ""
            fiSpecialAllowance:SCREEN-VALUE = ""
            fiTotalEarnings:SCREEN-VALUE    = ""
            fiAccountNum:SCREEN-VALUE       = ""
            fiIFCCode:SCREEN-VALUE          = ""
            fiUANNum:SCREEN-VALUE           = ""
            fiITPAN:SCREEN-VALUE            = ""
            fiCompOffEncash:SCREEN-VALUE    = ""
            cbSalaryYear:SCREEN-VALUE       = "".

        MESSAGE "No salary record found for " 
                 + vMonthName + " " + vYear 
                 + ". You can enter new salary."
            VIEW-AS ALERT-BOX INFO.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

