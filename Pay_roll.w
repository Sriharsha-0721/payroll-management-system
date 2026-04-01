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

DEF VAR vEmpID         AS INTEGER   NO-UNDO.
DEF VAR vSelectedMonth AS CHARACTER NO-UNDO.
DEF VAR vSelectedYear  AS CHARACTER NO-UNDO.
DEF VAR lFirstTry      AS LOGICAL   NO-UNDO.


//DEFINE VARIABLE vSelectedMonth   AS CHARACTER   NO-UNDO.
//DEFINE VARIABLE vSelectedYear    AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vTXTFile         AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vToday           AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vMonthlyDays     AS INTEGER     NO-UNDO.
DEFINE VARIABLE vEmpWorkingDays  AS INTEGER     NO-UNDO.
DEFINE VARIABLE vTotalEarnings   AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vTotalDeducation AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vLOPAmount       AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vNetSalary       AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vEmpName         AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vProvidentFund AS DECIMAL NO-UNDO. 
DEFINE VARIABLE vProfessionalTax AS DECIMAL NO-UNDO.
DEFINE VARIABLE vEmpMail         AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vBodyText        AS LONGCHAR    NO-UNDO.


    
DEFINE TEMP-TABLE ttadmin       LIKE EmployeeMaster.
DEFINE TEMP-TABLE ttdetails     LIKE EmployeeDetails.
DEFINE TEMP-TABLE ttattendance  LIKE EMPLOYEEATTENADCE.
DEFINE TEMP-TABLE ttsalary      LIKE EmployeeSalarysDetails.
DEFINE VARIABLE opRes AS CHARACTER NO-UNDO.



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
&Scoped-Define ENABLED-OBJECTS BTSSEARCH txtsback Txtprev TXTSALARYMONTHS1 ~
txtnext 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VARIABLE C-Win AS WIDGET-HANDLE NO-UNDO.

/* Menu Definitions                                                     */
DEFINE MENU POPUP-MENU-TXTSALARYMONTHS1 
       MENU-ITEM m_Monthly2     LABEL "Monthly"       
       MENU-ITEM m_Yearly2      LABEL "JAN-DEC"       
       MENU-ITEM m_ALL_EMPLOYEE LABEL "ALL EMPLOYEE"  .


/* Definitions of the field level widgets                               */
DEFINE BUTTON BTSSEARCH 
     LABEL "SEARCH" 
     SIZE 15 BY 1.14
     FONT 6.

DEFINE BUTTON txtnext 
     LABEL ">>>" 
     SIZE 38 BY 1.14
     BGCOLOR 11 FGCOLOR 0 FONT 6.

DEFINE BUTTON Txtprev 
     LABEL "<<<" 
     SIZE 36 BY 1.14
     BGCOLOR 11 FONT 6.

DEFINE BUTTON TXTSALARYMONTHS1 
     LABEL "DOWNLOAD" 
     SIZE 36 BY 1.14
     BGCOLOR 11 FONT 6.

DEFINE BUTTON txtsback 
     LABEL "BACK" 
     SIZE 15 BY 1.14
     FGCOLOR 1 FONT 6.

DEFINE VARIABLE TxtBank AS CHARACTER FORMAT "X(56)":U 
     LABEL "Bank Account num" 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE Txtbasic AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Basic Salary" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtd AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Provident Fund contributions" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtgg AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "TOTAL DEDUCTIONS (B" 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txthouse AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "House Rent Allowance" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtnet AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Net Salary Paid (A - B )" 
     VIEW-AS FILL-IN 
     SIZE 23 BY 1
     BGCOLOR 11 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE TxtPan AS CHARACTER FORMAT "X(56)":U 
     LABEL "Pan Number" 
     VIEW-AS FILL-IN 
     SIZE 36 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtpf AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "COMP-OFF ENCASHMENT" 
     VIEW-AS FILL-IN 
     SIZE 31 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtsp AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Special allowance" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txttotal AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "TOTAL EARNINGS (A)" 
     VIEW-AS FILL-IN 
     SIZE 31 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txttx AS DECIMAL FORMAT "->>,>>9.99":U INITIAL 0 
     LABEL "Professional Tax" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE TxtUn AS CHARACTER FORMAT "X(256)":U 
     LABEL "UAN Number" 
     VIEW-AS FILL-IN 
     SIZE 27 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-65
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 98 BY 13.57.

DEFINE RECTANGLE RECT-67
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 100 BY 13.57.

DEFINE VARIABLE TXTSALARYMONTHS AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","January","February","March","April","May","June","July","August","September","October","November","December" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE TXTYEAR AS CHARACTER FORMAT "X(256)":U 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","2024","2025","2026","2027","2028","2029" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE txtemployeeid AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Employee ID" 
     VIEW-AS FILL-IN 
     SIZE 19 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtemployeename AS CHARACTER FORMAT "X(256)":U 
     LABEL "Employee Name" 
     VIEW-AS FILL-IN 
     SIZE 62 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtDepartment AS CHARACTER FORMAT "X(56)":U 
     LABEL "Department" 
     VIEW-AS FILL-IN 
     SIZE 31 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtdesignation AS CHARACTER FORMAT "X(56)":U 
     LABEL "Designation" 
     VIEW-AS FILL-IN 
     SIZE 28 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtjoindate AS DATE FORMAT "99/99/99":U 
     LABEL "Joining Date" 
     VIEW-AS FILL-IN 
     SIZE 21 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtemployeedays AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Days in month" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtemployeeleave AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Total Leave" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.

DEFINE VARIABLE txtMonthdays AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Days Paid" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 7 FONT 6 NO-UNDO.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     BTSSEARCH AT ROW 2.91 COL 187 WIDGET-ID 152
     txtsback AT ROW 3.14 COL 1 WIDGET-ID 144
     Txtprev AT ROW 35.76 COL 3 WIDGET-ID 142
     TXTSALARYMONTHS1 AT ROW 35.76 COL 85.6 WIDGET-ID 154
     txtnext AT ROW 35.76 COL 162 WIDGET-ID 122
     "        EMPLOYEE PAY SLIP" VIEW-AS TEXT
          SIZE 40 BY 1.19 AT ROW 1.95 COL 81 WIDGET-ID 146
          BGCOLOR 15 FGCOLOR 1 FONT 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 2.4 ROW 1.86
         SIZE 201 BY 36.48
         BGCOLOR 1  WIDGET-ID 100.

DEFINE FRAME FRAME-I
     TxtBank AT ROW 1.71 COL 25 COLON-ALIGNED WIDGET-ID 166
     TxtUn AT ROW 1.95 COL 82 COLON-ALIGNED WIDGET-ID 170
     TxtPan AT ROW 1.95 COL 143 COLON-ALIGNED WIDGET-ID 172
     Txtbasic AT ROW 6.48 COL 29 COLON-ALIGNED WIDGET-ID 70
     txthouse AT ROW 7.91 COL 29 COLON-ALIGNED WIDGET-ID 72
     txtd AT ROW 7.95 COL 149 COLON-ALIGNED WIDGET-ID 88
     txtsp AT ROW 9.33 COL 29 COLON-ALIGNED WIDGET-ID 74
     txttx AT ROW 9.86 COL 149 COLON-ALIGNED WIDGET-ID 90
     txtpf AT ROW 11 COL 29 COLON-ALIGNED WIDGET-ID 78
     txtgg AT ROW 13.19 COL 150 COLON-ALIGNED WIDGET-ID 92
     txttotal AT ROW 13.86 COL 29 COLON-ALIGNED WIDGET-ID 80
     txtnet AT ROW 18.14 COL 87 COLON-ALIGNED WIDGET-ID 1592
     RECT-65 AT ROW 3.62 COL 101 WIDGET-ID 1586
     RECT-67 AT ROW 3.62 COL 1 WIDGET-ID 1588
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 2 ROW 15.33
         SIZE 199 BY 19.52 WIDGET-ID 700.

DEFINE FRAME FRAME-M
     txtMonthdays AT ROW 1.95 COL 19 COLON-ALIGNED WIDGET-ID 160
     txtemployeeleave AT ROW 1.95 COL 152 COLON-ALIGNED WIDGET-ID 164
     txtemployeedays AT ROW 2.19 COL 85 COLON-ALIGNED WIDGET-ID 162
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 11.71
         SIZE 200 BY 3.33 WIDGET-ID 1000.

DEFINE FRAME FRAME-L
     txtjoindate AT ROW 1.48 COL 23 COLON-ALIGNED WIDGET-ID 150
     txtdesignation AT ROW 1.48 COL 89 COLON-ALIGNED WIDGET-ID 156
     txtDepartment AT ROW 1.48 COL 159 COLON-ALIGNED WIDGET-ID 154
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 7.91
         SIZE 200 BY 2.86 WIDGET-ID 900.

DEFINE FRAME FRAME-J
     TXTYEAR AT ROW 1.95 COL 13 COLON-ALIGNED NO-LABEL WIDGET-ID 152
     TXTSALARYMONTHS AT ROW 1.95 COL 40 NO-LABEL WIDGET-ID 150
     txtemployeeid AT ROW 1.95 COL 82 COLON-ALIGNED WIDGET-ID 144
     txtemployeename AT ROW 1.95 COL 127 COLON-ALIGNED WIDGET-ID 148
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 4.33
         SIZE 200 BY 2.86 WIDGET-ID 800.


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
         TITLE              = "PayRoll"
         HEIGHT             = 37.33
         WIDTH              = 203.6
         MAX-HEIGHT         = 40.05
         MAX-WIDTH          = 307.2
         VIRTUAL-HEIGHT     = 40.05
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
/* REPARENT FRAME */
ASSIGN FRAME FRAME-I:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME FRAME-J:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME FRAME-L:FRAME = FRAME DEFAULT-FRAME:HANDLE
       FRAME FRAME-M:FRAME = FRAME DEFAULT-FRAME:HANDLE.

/* SETTINGS FOR FRAME DEFAULT-FRAME
   FRAME-NAME                                                           */
ASSIGN 
       TXTSALARYMONTHS1:POPUP-MENU IN FRAME DEFAULT-FRAME       = MENU POPUP-MENU-TXTSALARYMONTHS1:HANDLE.

/* SETTINGS FOR FRAME FRAME-I
                                                                        */
/* SETTINGS FOR FRAME FRAME-J
                                                                        */
/* SETTINGS FOR COMBO-BOX TXTSALARYMONTHS IN FRAME FRAME-J
   ALIGN-L                                                              */
/* SETTINGS FOR FRAME FRAME-L
                                                                        */
/* SETTINGS FOR FRAME FRAME-M
                                                                        */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* PayRoll */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* PayRoll */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTSSEARCH
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTSSEARCH C-Win
ON CHOOSE OF BTSSEARCH IN FRAME DEFAULT-FRAME /* SEARCH */
DO:
  RUN P_SEARCH.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_ALL_EMPLOYEE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_ALL_EMPLOYEE C-Win
ON CHOOSE OF MENU-ITEM m_ALL_EMPLOYEE /* ALL EMPLOYEE */
// TEAMP-TABLE USING CODE 
DO:
  DEFINE VARIABLE vSelectedMonth   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vSelectedYear    AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vTXTFile         AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vToday           AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vMonthlyDays     AS INTEGER     NO-UNDO.
DEFINE VARIABLE vEmpWorkingDays  AS INTEGER     NO-UNDO.
DEFINE VARIABLE vTotalEarnings   AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vTotalDeducation AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vLOPAmount       AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vNetSalary       AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vEmpName         AS CHARACTER   NO-UNDO.
//DEFINE VARIABLE cMonths AS CHARACTER   NO-UNDO.

/* Step 1: Get selected month */
vSelectedMonth = TRIM(UPPER(TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J)).
IF vSelectedMonth = "" OR vSelectedMonth = ? THEN DO:
    MESSAGE "Please select month name."
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

    vToday = STRING(DAY(TODAY),"99") + "-"
       + ENTRY(MONTH(TODAY),
         "JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC")
       + "-" + STRING(YEAR(TODAY)).


/* Step 2: Get selected year */
vSelectedYear = TRIM(txtyear:SCREEN-VALUE IN FRAME FRAME-J).
IF vSelectedYear = "" OR vSelectedYear = ? THEN DO:
    MESSAGE "Please select year."
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* Today’s date */
vToday = STRING(DAY(TODAY),"99") + "-"
       + SUBSTRING("JANFEBMARAPRMAYJUNJULAUGSEPOCTNOVDEC",
                   (MONTH(TODAY) - 1) * 3 + 1, 3)
       + "-" + STRING(YEAR(TODAY)).
/* ===============================
   LOOP THROUGH ALL ACTIVE EMPLOYEES
   =============================== */
FOR EACH ttdetails NO-LOCK:

    /* Get Employee Master */
    FIND ttadmin NO-LOCK
         WHERE ttadmin.EmpID = ttdetails.EmpID
           AND ttadmin.EmpStatus = "ACTIVE"
         NO-ERROR.

    IF NOT AVAILABLE ttadmin THEN NEXT.

    /* Get Salary details for selected month/year */
    FIND ttsalary NO-LOCK
         WHERE ttsalary.EmpID = ttdetails.EmpID
           AND CAPS(ttsalary.SALARYMONTH) = vSelectedMonth
           AND STRING(ttsalary.YEAR) = vSelectedYear
         NO-ERROR.

    /* Get Attendance for selected month/year */
    FIND ttattendance NO-LOCK
         WHERE ttattendance.EmpID = ttdetails.EmpID
           AND CAPS(ttattendance.MonthNames) = vSelectedMonth
           AND STRING(ttattendance.Year) = vSelectedYear
         NO-ERROR.

    /* Skip if any required data is missing */
    IF NOT AVAILABLE ttsalary OR NOT AVAILABLE ttattendance THEN NEXT.

    /* Prepare TXT file path for current employee */
    vTXTFile = "C:\Main_Project\PAYROLL\All_employeepayslips\Payslip_" 
             + STRING(ttdetails.EmpID) + "_" 
             + REPLACE(vSelectedMonth," ","_") + "_" + vSelectedYear + ".txt".

    /* Assign variables */
    ASSIGN
        vMonthlyDays     = ttattendance.MonthlyWorkingDays
        vEmpWorkingDays  = ttattendance.EmployeeWorkingDays
        vTotalEarnings   = ttsalary.TotalEarings
        vTotalDeducation = ttsalary.TotalDeducation
        vEmpName         = ttdetails.EmpName.

    vLOPAmount = (vMonthlyDays - vEmpWorkingDays) * (vTotalEarnings / vMonthlyDays).
    vNetSalary = vTotalEarnings - vLOPAmount - vTotalDeducation.
    IF vNetSalary < 0 THEN vNetSalary = 0.

    /* OUTPUT Payslip */
    OUTPUT TO VALUE(vTXTFile).

    PUT UNFORMATTED
        "                  *** PAY SLIP REPORT - " + vSelectedMonth + "-" + vSelectedYear + " ***" SKIP
        "Generated on: " vToday SKIP
        FILL("-",55) SKIP
        "Employee ID   : " ttdetails.EmpID SKIP
        "Employee Name : " vEmpName SKIP
        "Designation   : " ttadmin.Designation SKIP
        "Department    : " ttadmin.Department SKIP
        "Joining Date  : " STRING(ttadmin.DOJ) SKIP
        FILL("-",55) SKIP
        "Total Working Days      : " vMonthlyDays SKIP
        "Employee working Days   : " vEmpWorkingDays SKIP
        "Employee Leaves         : " (vMonthlyDays - vEmpWorkingDays) SKIP
        FILL("-",55) SKIP
        "Basic Salary            : " STRING(ttsalary.BasicSalary,"->>,>>>,>>9") SKIP
        "HRA                     : " STRING(ttsalary.HRA,"->>,>>>,>>9") SKIP
        "Special Allow           : " STRING(ttsalary.SpecialAllowance,"->>,>>>,>>9") SKIP
        "COMP-OFF ENCASHMENT     : " STRING(ttsalary.COMP-OFF-ENCASHMENT,"->>,>>>,>>9") SKIP
        "Total Earnings          : " STRING(vTotalEarnings,"->>,>>>,>>9") SKIP
        "PF                      : " STRING(ttsalary.ProvidentFund,"->>,>>>,>>9") SKIP
        "PF TAX                  : "  STRING(ttsalary.ProfessionalTax,"->>,>>>,>>9") SKIP
        "Total Deduction         : "  STRING(vTotalDeducation,"->>,>>>,>>9") SKIP
        "LOP Amount              : " STRING(vLOPAmount,"->>,>>>,>>9") SKIP
        FILL("-",55) SKIP
        "Net Salary              : " STRING(vNetSalary,"->>,>>>,>>9") SKIP
        FILL("-",55) SKIP
        "     *** INCOME-TAX DEDUCTION DETAILS ***" SKIP
        "APR-" + vSelectedYear + " :-   "    "JUL-" + vSelectedYear + " :-   " 
        "OCT-" + vSelectedYear + " :-   "    "JAN-" + vSelectedYear + " :-" SKIP
        "MAY-" + vSelectedYear + " :-   "    "AUG-" + vSelectedYear + " :-   " 
        "NOV-" + vSelectedYear + " :-   "    "FEB-" + vSelectedYear + " :-" SKIP
        "JUN-" + vSelectedYear + " :-   "    "SEP-" + vSelectedYear + " :-   " 
        "DEC-" + vSelectedYear + " :-   "    "MAR-" + vSelectedYear + " :-" SKIP
        FILL("-",55) SKIP.


    OUTPUT CLOSE.

    /* Optional: Success message for this employee */
    /* MESSAGE "Payslip exported successfully for " vEmpName SKIP "File saved at: " vTXTFile VIEW-AS ALERT-BOX INFORMATION BUTTONS OK. */

END.

/* Final message */
MESSAGE "Payslips generated successfully for all employees for " vSelectedMonth + "-" + vSelectedYear
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Monthly2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Monthly2 C-Win
ON CHOOSE OF MENU-ITEM m_Monthly2 /* Monthly */
DO:
  RUN P-DOWNLOAD.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME m_Yearly2
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL m_Yearly2 C-Win
ON CHOOSE OF MENU-ITEM m_Yearly2 /* JAN-DEC */
// TEAMP-TABLE UISNG CODE
DO:
   /* ------------------------- VARIABLES ------------------------- */
DEFINE VARIABLE vSelectedYear    AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vTXTFile         AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vToday           AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vMonthlyDays     AS INTEGER     NO-UNDO.
DEFINE VARIABLE vEmpWorkingDays  AS INTEGER     NO-UNDO.
DEFINE VARIABLE vTotalEarnings   AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vTotalDeducation AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vLOPAmount       AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vNetSalary       AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vEmpName         AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vProvidentFund   AS DECIMAL     NO-UNDO. 
DEFINE VARIABLE vProfessionalTax AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vMonthIndex      AS INTEGER     NO-UNDO.
DEFINE VARIABLE vMonthName       AS CHARACTER   NO-UNDO.

DEFINE VARIABLE cMonths AS CHARACTER NO-UNDO.
DEFINE VARIABLE cFolder AS CHARACTER NO-UNDO.

cMonths = "January,February,March,April,May,June,July,August,September,October,November,December".
cFolder = "C:\Main_Project\PAYROLL\All_employeepayslips\Montly_combined(payslip's)".

/* ------------------------- CREATE FOLDER ------------------------- */
OS-COMMAND SILENT VALUE('IF NOT EXIST "' + cFolder + '" MKDIR "' + cFolder + '"').

/* ------------------------- GET YEAR ------------------------- */
vSelectedYear = TRIM(TXTYEAR:SCREEN-VALUE IN FRAME FRAME-J).

IF vSelectedYear = "" OR vSelectedYear = ? THEN DO:
    MESSAGE "Please select a year."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.


/* ------------------------- TODAY'S DATE ------------------------- */
vToday = STRING(DAY(TODAY),"99") + "-"
       + CAPS(ENTRY(MONTH(TODAY), cMonths))
       + "-" + STRING(YEAR(TODAY)).

/* ------------------------- GET EMPLOYEE DETAILS ------------------------- */
FIND ttdetails NO-LOCK
     WHERE ttdetails.EmpID = INTEGER(txtemployeeid:SCREEN-VALUE)
     NO-ERROR.

IF NOT AVAILABLE ttdetails THEN DO:
    MESSAGE "No Employee details found for this ID."
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* Employee Master */
FIND ttadmin NO-LOCK
     WHERE ttadmin.EmpID = ttdetails.EmpID
       AND ttadmin.EmpStatus = "ACTIVE"
     NO-ERROR.

IF NOT AVAILABLE ttadmin THEN DO:
    MESSAGE "Active employee master record not found."
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* ------------------------- LOOP THROUGH ALL MONTHS ------------------------- */
DO vMonthIndex = 1 TO 12:

    vMonthName = ENTRY(vMonthIndex, cMonths, ",").

    /* Salary for selected month */
    FIND ttsalary NO-LOCK
         WHERE ttsalary.EmpID = ttdetails.EmpID
           AND CAPS(ttsalary.SALARYMONTH) = vMonthName
           AND STRING(ttsalary.YEAR) = vSelectedYear
         NO-ERROR.

    /* Attendance for selected month */
    FIND ttattendance NO-LOCK
         WHERE ttattendance.EmpID = ttdetails.EmpID
           AND CAPS(ttattendance.MonthNames) = vMonthName
           AND STRING(ttattendance.Year) = vSelectedYear
         NO-ERROR.

    /* Skip if no data */
    IF NOT AVAILABLE ttsalary OR NOT AVAILABLE ttattendance THEN NEXT.

    /* ------------------------- CALCULATE NET SALARY ------------------------- */
    ASSIGN
        vMonthlyDays     = ttattendance.MonthlyWorkingDays
        vEmpWorkingDays  = ttattendance.EmployeeWorkingDays
        vTotalEarnings   = ttsalary.TotalEarings
        vTotalDeducation = ttsalary.TotalDeducation
        vEmpName         = ttdetails.EmpName.

    vLOPAmount = (vMonthlyDays - vEmpWorkingDays) * (vTotalEarnings / vMonthlyDays).
    vNetSalary = vTotalEarnings - vLOPAmount - vTotalDeducation.
    IF vNetSalary < 0 THEN vNetSalary = 0.

    /* ------------------------- PREPARE TXT FILE ------------------------- */
    vTXTFile = cFolder + "\\PaySlip_" 
             + STRING(ttdetails.EmpID) + "_" 
             + REPLACE(vMonthName," ","_") + "_" + vSelectedYear + ".txt".

    /* ------------------------- OUTPUT PAYSLIP ------------------------- */
    OUTPUT TO VALUE(vTXTFile).

    PUT UNFORMATTED
        "                  *** PAY SLIP REPORT - " + vMonthName + "-" + vSelectedYear + " ***" SKIP
        "Generated on: " vToday SKIP
        FILL("-",55) SKIP
        "Employee ID   : " ttdetails.EmpID SKIP
        "Employee Name : " vEmpName SKIP
        "Designation   : " ttadmin.Designation SKIP
        "Department    : " ttadmin.Department SKIP
        "Joining Date  : " STRING(ttadmin.DOJ) SKIP
        FILL("-",55) SKIP
        "Total Working Days      : " vMonthlyDays SKIP
        "Employee working Days   : " vEmpWorkingDays SKIP
        "Employee Leaves         : " (vMonthlyDays - vEmpWorkingDays) SKIP
        FILL("-",55) SKIP
        "Basic Salary            : " STRING(ttsalary.BasicSalary,"->>,>>>,>>9") SKIP
        "HRA                     : " STRING(ttsalary.HRA,"->>,>>>,>>9") SKIP
        "Special Allow           : " STRING(ttsalary.SpecialAllowance,"->>,>>>,>>9") SKIP
        "COMP-OFF ENCASHMENT     : " STRING(ttsalary.COMP-OFF-ENCASHMENT,"->>,>>>,>>9") SKIP
        "Total Earnings          : " STRING(vTotalEarnings,"->>,>>>,>>9") SKIP
        "PF                      : " STRING(ttsalary.ProvidentFund,"->>,>>>,>>9") SKIP
        "PF TAX                  : "  STRING(ttsalary.ProfessionalTax,"->>,>>>,>>9") SKIP
        "Total Deductions        : "  STRING(ttsalary.TotalDeducation,"->>,>>>,>>9") SKIP
        "LOP Amount              : " STRING(vLOPAmount,"->>,>>>,>>9") SKIP
        FILL("-",55) SKIP
        "Net Salary              : " STRING(vNetSalary,"->>,>>>,>>9") SKIP
            FILL("-",55) SKIP
    "     *** INCOME-TAX DEDUCTION DETAILS ***" SKIP
    "APR-" + vSelectedYear + " :-   "    "JUL-" + vSelectedYear + " :-   " 
    "OCT-" + vSelectedYear + " :-   "    "JAN-" + vSelectedYear + " :-" SKIP
    "MAY-" + vSelectedYear + " :-   "    "AUG-" + vSelectedYear + " :-   " 
    "NOV-" + vSelectedYear + " :-   "    "FEB-" + vSelectedYear + " :-" SKIP
    "JUN-" + vSelectedYear + " :-   "    "SEP-" + vSelectedYear + " :-   " 
    "DEC-" + vSelectedYear + " :-   "    "MAR-" + vSelectedYear + " :-" SKIP
    FILL("-",55) SKIP.
        

    OUTPUT CLOSE.

END. /* END OF MONTH LOOP */

/* ------------------------- SUCCESS MESSAGE ------------------------- */
MESSAGE "Payslips generated successfully for all available months of " vSelectedYear
        SKIP "Check folder: " cFolder
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

         END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME txtnext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL txtnext C-Win
ON CHOOSE OF txtnext IN FRAME DEFAULT-FRAME /* >>> */
DO:
  RUN P_next.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME Txtprev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL Txtprev C-Win
ON CHOOSE OF Txtprev IN FRAME DEFAULT-FRAME /* <<< */
DO:
  RUN p_prev.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-J
&Scoped-define SELF-NAME TXTSALARYMONTHS
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TXTSALARYMONTHS C-Win
ON VALUE-CHANGED OF TXTSALARYMONTHS IN FRAME FRAME-J /* Month */
DO:
  RUN p_LoadSelectedRecord.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define SELF-NAME TXTSALARYMONTHS1
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TXTSALARYMONTHS1 C-Win
ON CHOOSE OF TXTSALARYMONTHS1 IN FRAME DEFAULT-FRAME /* DOWNLOAD */
DO:
  
/* RUN sp_GeneratePayslip.p (                                      */
/*     INPUT INTEGER(txtemployeeid:SCREEN-VALUE IN FRAME FRAME-J), */
/*     INPUT TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J,        */
/*     INPUT TXTYEAR:SCREEN-VALUE IN FRAME FRAME-J,                */
/*     INPUT-OUTPUT TABLE ttadmin,                                 */
/*     INPUT-OUTPUT TABLE ttdetails,                               */
/*     INPUT-OUTPUT TABLE ttattendance,                            */
/*     INPUT-OUTPUT TABLE ttsalary                                 */
/* ).                                                              */

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME txtsback
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL txtsback C-Win
ON CHOOSE OF txtsback IN FRAME DEFAULT-FRAME /* BACK */
DO:
  RUN p_back.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME FRAME-J
&Scoped-define SELF-NAME TXTYEAR
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TXTYEAR C-Win
ON VALUE-CHANGED OF TXTYEAR IN FRAME FRAME-J /* Year */
DO:
  RUN p_LoadSelectedRecord.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME DEFAULT-FRAME
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */

/* Set CURRENT-WINDOW */
ASSIGN CURRENT-WINDOW                = {&WINDOW-NAME}
       THIS-PROCEDURE:CURRENT-WINDOW = {&WINDOW-NAME}.

/* Close handler */
ON CLOSE OF THIS-PROCEDURE DO:
    RUN disable_UI.
END.

/* Prevent PAUSE on hide */
PAUSE 0 BEFORE-HIDE.

/* ============================ MAIN BLOCK ============================ */
MAIN-BLOCK:
DO ON ERROR    UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY  UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:

    /* Enable the screen */
    RUN enable_UI.

    /* Declare required variables */
    DEFINE VARIABLE month_num AS INTEGER NO-UNDO.
    DEFINE VARIABLE month_name AS CHARACTER NO-UNDO.
    DEFINE VARIABLE d_year AS INTEGER NO-UNDO.
   

    /* Load all employee-related temp-tables */
    RUN PAYROLL\Procedures\getEmployeePayslip.p (
        INPUT-OUTPUT TABLE ttadmin,
        INPUT-OUTPUT TABLE ttdetails,
        INPUT-OUTPUT TABLE ttattendance,
        INPUT-OUTPUT TABLE ttsalary,
        OUTPUT opRes
    ).

    /* -------------------------------
       Load FIRST record immediately
       ------------------------------- */
    FIND FIRST ttdetails NO-LOCK NO-ERROR.
    IF AVAILABLE ttdetails THEN DO:
        /* Reuse your existing initializer */
        RUN p_initialize.

    END.
    ELSE DO:
        MESSAGE "No employee records found." VIEW-AS ALERT-BOX ERROR BUTTONS OK.
        RETURN.
    END.

    /* -------------------------------
       Assign current month & year
       ------------------------------- */
    ASSIGN
        month_num = MONTH(TODAY)
        d_year    = YEAR(TODAY).

    CASE month_num:
        WHEN 1  THEN month_name = "January".
        WHEN 2  THEN month_name = "February".
        WHEN 3  THEN month_name = "March".
        WHEN 4  THEN month_name = "April".
        WHEN 5  THEN month_name = "May".
        WHEN 6  THEN month_name = "June".
        WHEN 7  THEN month_name = "July".
        WHEN 8  THEN month_name = "August".
        WHEN 9  THEN month_name = "September".
        WHEN 10 THEN month_name = "October".
        WHEN 11 THEN month_name = "November".
        WHEN 12 THEN month_name = "December".
    END CASE.

    ASSIGN
        TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J = month_name
        TXTYEAR:SCREEN-VALUE IN FRAME FRAME-J         = STRING(d_year).

    /* -------------------------------
       Keep window open
       ------------------------------- */
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
  ENABLE BTSSEARCH txtsback Txtprev TXTSALARYMONTHS1 txtnext 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  DISPLAY TXTYEAR TXTSALARYMONTHS txtemployeeid txtemployeename 
      WITH FRAME FRAME-J IN WINDOW C-Win.
  ENABLE TXTYEAR TXTSALARYMONTHS txtemployeeid txtemployeename 
      WITH FRAME FRAME-J IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-J}
  DISPLAY txtjoindate txtdesignation txtDepartment 
      WITH FRAME FRAME-L IN WINDOW C-Win.
  ENABLE txtjoindate txtdesignation txtDepartment 
      WITH FRAME FRAME-L IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-L}
  DISPLAY txtMonthdays txtemployeeleave txtemployeedays 
      WITH FRAME FRAME-M IN WINDOW C-Win.
  ENABLE txtMonthdays txtemployeeleave txtemployeedays 
      WITH FRAME FRAME-M IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-M}
  DISPLAY TxtBank TxtUn TxtPan Txtbasic txthouse txtd txtsp txttx txtpf txtgg 
          txttotal txtnet 
      WITH FRAME FRAME-I IN WINDOW C-Win.
  ENABLE RECT-65 RECT-67 TxtBank TxtUn TxtPan Txtbasic txthouse txtd txtsp 
         txttx txtpf txtgg txttotal txtnet 
      WITH FRAME FRAME-I IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-FRAME-I}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p-DOWNLOAD C-Win 
PROCEDURE p-DOWNLOAD :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
// selected month 
vSelectedMonth = TRIM(UPPER(TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J)).
IF vSelectedMonth = "" OR vSelectedMonth = ? THEN DO:
    MESSAGE "Please select month name."
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

//  selected year
vSelectedYear = TRIM(txtyear:SCREEN-VALUE IN FRAME FRAME-J).
IF vSelectedYear = "" OR vSelectedYear = ? THEN DO:
    MESSAGE "Please select year."
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

// Prepare TXT file path
vTXTFile = "C:\Main_Project\PAYROLL\Monthly_payslips\PaySlip_"
         + STRING(txtemployeeid:SCREEN-VALUE) + "_"
         + REPLACE(vSelectedMonth," ","_") + "_" + vSelectedYear + ".txt".

// Today’s date
vToday = STRING(DAY(TODAY),"99") + "-"
       + CAPS(ENTRY(MONTH(TODAY),
         "JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC"))
       + "-" + STRING(YEAR(TODAY)).

//  CURRENT employee
FIND ttdetails NO-LOCK
     WHERE ttdetails.EmpID = INTEGER(txtemployeeid:SCREEN-VALUE)
     NO-ERROR.

IF NOT AVAILABLE ttdetails THEN DO:
    MESSAGE "No Employee details found for this ID."
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

// Employee Master
FIND ttadmin NO-LOCK
     WHERE ttadmin.EmpID = ttdetails.EmpID
       AND ttadmin.EmpStatus = "ACTIVE"
     NO-ERROR.

//  Salary for selected month & year
FIND ttsalary NO-LOCK
     WHERE ttsalary.EmpID = ttdetails.EmpID
       AND CAPS(ttsalary.SALARYMONTH) = vSelectedMonth
       AND STRING(ttsalary.YEAR) = vSelectedYear
     NO-ERROR.

//  Attendance for selected month & year
FIND EMPLOYEEATTENADCE NO-LOCK
     WHERE EMPLOYEEATTENADCE.EmpID = ttdetails.EmpID
       AND CAPS(EMPLOYEEATTENADCE.MonthNames) = vSelectedMonth
       AND STRING(EMPLOYEEATTENADCE.Year) = vSelectedYear
     NO-ERROR.

// Validate
IF NOT AVAILABLE ttadmin
   OR NOT AVAILABLE ttsalary
   OR NOT AVAILABLE EMPLOYEEATTENADCE THEN DO:
    MESSAGE "Payslip not available for " + vSelectedMonth + "-" + vSelectedYear
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

//   Calculate Net Salary
ASSIGN
    vMonthlyDays     = EMPLOYEEATTENADCE.MonthlyWorkingDays
    vEmpWorkingDays  = EMPLOYEEATTENADCE.EmployeeWorkingDays
    vTotalEarnings   = ttsalary.TotalEarings
    vTotalDeducation = ttsalary.TotalDeducation
    vEmpName         = ttdetails.EmpName.

vLOPAmount = (vMonthlyDays - vEmpWorkingDays) * (vTotalEarnings / vMonthlyDays).
/* vNetSalary = vTotalEarnings - vLOPAmount - vTotalDeducation. */
/* IF vNetSalary < 0 THEN vNetSalary = 0.                       */
vNetSalary=ttsalary.NetSalaryPaid.

// OUTPUT Payslip
OUTPUT TO VALUE(vTXTFile).

PUT UNFORMATTED
    "                  *** PAY SLIP REPORT - " + vSelectedMonth + "-" + vSelectedYear + " ***" SKIP

    "Generated on: " vToday SKIP
    FILL("-",55) SKIP
    "Employee ID   : " ttdetails.EmpID SKIP
    "Employee Name : " vEmpName SKIP
    "Designation   : " ttadmin.Designation SKIP
    "Department    : " ttadmin.Department SKIP
    "Joining Date  : " STRING(ttadmin.DOJ) SKIP
    FILL("-",55) SKIP
    "Total Working Days      : " vMonthlyDays SKIP
    "Employee working Days   : " vEmpWorkingDays SKIP
    "Employee Leaves         : " (vMonthlyDays - vEmpWorkingDays) SKIP
    FILL("-",55) SKIP
    "Basic Salary            : " STRING(ttsalary.BasicSalary,"->>,>>>,>>9") SKIP
    "HRA                     : " STRING(ttsalary.HRA,"->>,>>>,>>9") SKIP
    "Special Allow           : " STRING(ttsalary.SpecialAllowance,"->>,>>>,>>9") SKIP
    "COMP-OFF ENCASHMENT     : " STRING(ttsalary.COMP-OFF-ENCASHMENT,"->>,>>>,>>9") SKIP
    "Total Earnings          : " STRING(vTotalEarnings,"->>,>>>,>>9") SKIP
    "PF                      : " STRING(ttsalary.ProvidentFund,"->>,>>>,>>9") SKIP
    "PF TAX                  : "  STRING(ttsalary.ProfessionalTax,"->>,>>>,>>9") SKIP
    "totalDeducation         : "  STRING(ttsalary.TotalDeducation,"->>,>>>,>>9") SKIP
    //"TotalDeducation     : " STRING(vTotalDeducation,"->>,>>>,>>9") SKIP
    "LOP Amount              : " STRING(vLOPAmount,"->>,>>>,>>9") SKIP
    FILL("-",55) SKIP
    "Net Salary              : " STRING(vNetSalary,"->>,>>>,>>9") SKIP
    FILL("-",55) SKIP
    "     *** INCOME-TAX DEDUCTION DETAILS ***" SKIP
    "APR-" + vSelectedYear + " :-   "    "JUL-" + vSelectedYear + " :-   "
    "OCT-" + vSelectedYear + " :-   "    "JAN-" + vSelectedYear + " :-" SKIP
    "MAY-" + vSelectedYear + " :-   "    "AUG-" + vSelectedYear + " :-   "
    "NOV-" + vSelectedYear + " :-   "    "FEB-" + vSelectedYear + " :-" SKIP
    "JUN-" + vSelectedYear + " :-   "    "SEP-" + vSelectedYear + " :-   "
    "DEC-" + vSelectedYear + " :-   "    "MAR-" + vSelectedYear + " :-" SKIP
    FILL("-",55) SKIP.

OUTPUT CLOSE.

// Success message
MESSAGE "Payslip exported successfully for " vEmpName
        SKIP "File saved at: " vTXTFile
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_back C-Win 
PROCEDURE p_back :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
   
   APPLY "CLOSE" TO THIS-PROCEDURE.
   RUN Employee-payslip.w.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_initialize C-Win 
PROCEDURE p_initialize :
/*------------------------------------------------------------------------------
   Purpose: 
------------------------------------------------------------------------------*/
DEFINE VARIABLE iEmpID AS INTEGER NO-UNDO.

/*==========================
  1. Find FIRST ACTIVE EMPLOYEE
============================*/
FIND FIRST ttadmin
    WHERE UPPER(ttadmin.EmpStatus) = "ACTIVE"
    NO-LOCK NO-ERROR.

IF NOT AVAILABLE ttadmin THEN DO:
    MESSAGE "No active employees found." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* Save selected EmpID */
iEmpID = ttadmin.EmpID.

/*==========================
  2. Load Employee Details (ttdetails)
============================*/
FIND FIRST ttdetails
    WHERE ttdetails.EmpID = iEmpID
    NO-LOCK NO-ERROR.

DO WITH FRAME FRAME-J:
    ASSIGN
        txtemployeeid:SCREEN-VALUE   = STRING(iEmpID)
        txtemployeename:SCREEN-VALUE = (IF AVAILABLE ttdetails THEN ttdetails.EmpName ELSE "")
        txtemployeeid:SENSITIVE      = TRUE
        txtemployeename:SENSITIVE    = FALSE.
END.

/*==========================
  3. Load Salary Month/Year (ttsalary)
============================*/
FIND FIRST ttsalary
    WHERE ttsalary.EmpID = iEmpID
    NO-LOCK NO-ERROR.

DO WITH FRAME FRAME-J:
    IF AVAILABLE ttsalary THEN
        ASSIGN
            TXTYEAR:SCREEN-VALUE         = STRING(ttsalary.YEAR)
            TXTSALARYMONTHS:SCREEN-VALUE = ttsalary.SalaryMonth
            TXTYEAR:SENSITIVE            = TRUE
            TXTSALARYMONTHS:SENSITIVE    = TRUE.
END.

/*==========================
  4. Load Admin Details
============================*/
DO WITH FRAME FRAME-L:
    ASSIGN 
        txtjoindate:SCREEN-VALUE    = STRING(ttadmin.DOJ)
        txtdesignation:SCREEN-VALUE = ttadmin.Designation
        txtDepartment:SCREEN-VALUE  = ttadmin.Department
        txtjoindate:SENSITIVE       = FALSE
        txtdesignation:SENSITIVE    = FALSE
        txtDepartment:SENSITIVE     = FALSE.
END.

/*==========================
  5. Load Attendance (ttattendance)
============================*/
FIND FIRST ttattendance
    WHERE ttattendance.EmpID = iEmpID
    NO-LOCK NO-ERROR.

DO WITH FRAME FRAME-M:
    IF AVAILABLE ttattendance THEN
        ASSIGN 
            txtMonthdays:SCREEN-VALUE     = STRING(ttattendance.MonthlyWorkingDays)
            txtemployeedays:SCREEN-VALUE  = STRING(ttattendance.EmployeeWorkingDays)
            txtemployeeleave:SCREEN-VALUE = STRING(ttattendance.TotalLeaves)
            txtMonthdays:SENSITIVE        = FALSE
            txtemployeedays:SENSITIVE     = FALSE
            txtemployeeleave:SENSITIVE    = FALSE.
END.

/*==========================
  6. Load Salary Breakup (ttsalary)
============================*/
FIND FIRST ttsalary
    WHERE ttsalary.EmpID = iEmpID
    NO-LOCK NO-ERROR.

DO WITH FRAME FRAME-I:
    IF AVAILABLE ttsalary THEN
        ASSIGN 
            Txtbank:SCREEN-VALUE    = STRING(ttsalary.EemployeBankNum)
            TxtPan:SCREEN-VALUE     = ttsalary.ITPAN
            TxtUn:SCREEN-VALUE      = STRING(ttsalary.EmployeeUANNum)
            Txtbasic:SCREEN-VALUE   = STRING(ttsalary.BasicSalary)
            txthouse:SCREEN-VALUE   = STRING(ttsalary.HRA)
            txtsp:SCREEN-VALUE      = STRING(ttsalary.SpecialAllowance)
            txtpf:SCREEN-VALUE      = STRING(ttsalary.COMP-OFF-ENCASHMENT)
            txttotal:SCREEN-VALUE   = STRING(ttsalary.TotalEarings)
            txttx:SCREEN-VALUE      = STRING(ttsalary.ProfessionalTax)
            txtd:SCREEN-VALUE       = STRING(ttsalary.ProvidentFund)
            txtgg:SCREEN-VALUE      = STRING(ttsalary.TotalDeducation)
            txtnet:SCREEN-VALUE     = STRING(ttsalary.NetSalaryPaid)
            /* make read-only */
            Txtbank:SENSITIVE       = FALSE
            TxtPan:SENSITIVE        = FALSE
            TxtUn:SENSITIVE         = FALSE
            Txtbasic:SENSITIVE      = FALSE
            txthouse:SENSITIVE      = FALSE
            txtsp:SENSITIVE         = FALSE
            txtpf:SENSITIVE         = FALSE
            txttx:SENSITIVE         = FALSE
            txtd:SENSITIVE          = FALSE
            txtgg:SENSITIVE         = FALSE
            txtnet:SENSITIVE        = FALSE
            txttotal:SENSITIVE      = FALSE.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_LoadSelectedRecord C-Win 
PROCEDURE p_LoadSelectedRecord :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    DEFINE VARIABLE vEmp   AS INTEGER   NO-UNDO.
    DEFINE VARIABLE vMonth AS CHARACTER NO-UNDO.
    DEFINE VARIABLE vYear  AS INTEGER   NO-UNDO.

    ASSIGN
        vEmp   = INTEGER(txtemployeeid:SCREEN-VALUE IN FRAME FRAME-J)
        vMonth = TRIM(TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J)
        vYear  = INTEGER(TXTYEAR:SCREEN-VALUE IN FRAME FRAME-J).

    IF vEmp = 0 OR vMonth = "" OR vYear = 0 THEN RETURN.

    /* ========================
       SALARY (case-insensitive)
       ======================== */
    FIND FIRST ttsalary
         WHERE ttsalary.EmpID = vEmp
           AND UPPER(TRIM(ttsalary.SalaryMonth)) = UPPER(vMonth)
           AND TRIM(ttsalary.Year) = STRING(vYear)
         NO-LOCK NO-ERROR.

    DO WITH FRAME FRAME-I:
        IF AVAILABLE ttsalary THEN
            ASSIGN 
                Txtbank:SCREEN-VALUE    = ttsalary.EemployeBankNum
                TxtPan:SCREEN-VALUE     = ttsalary.ITPAN
                TxtUn:SCREEN-VALUE      = STRING(ttsalary.EmployeeUANNum)
                Txtbasic:SCREEN-VALUE   = STRING(ttsalary.BasicSalary)
                txthouse:SCREEN-VALUE   = STRING(ttsalary.HRA)
                txtsp:SCREEN-VALUE      = STRING(ttsalary.SpecialAllowance)
                txtpf:SCREEN-VALUE      = STRING(ttsalary.COMP-OFF-ENCASHMENT)
                txttotal:SCREEN-VALUE   = STRING(ttsalary.TotalEarings)
                txttx:SCREEN-VALUE      = STRING(ttsalary.ProfessionalTax)
                txtd:SCREEN-VALUE       = STRING(ttsalary.ProvidentFund)
                txtgg:SCREEN-VALUE      = STRING(ttsalary.TotalDeducation)
                txtnet:SCREEN-VALUE     = STRING(ttsalary.NetSalaryPaid).
        ELSE DO:
            ASSIGN
                Txtbank:SCREEN-VALUE = ""
                TxtPan:SCREEN-VALUE  = ""
                TxtUn:SCREEN-VALUE   = ""
                Txtbasic:SCREEN-VALUE = ""
                txthouse:SCREEN-VALUE = ""
                txtsp:SCREEN-VALUE = ""
                txtpf:SCREEN-VALUE = ""
                txttotal:SCREEN-VALUE = ""
                txttx:SCREEN-VALUE = ""
                txtd:SCREEN-VALUE = ""
                txtgg:SCREEN-VALUE = ""
                txtnet:SCREEN-VALUE = "".
        END.
    END. /* FRAME-I */

    /* ========================
       ATTENDANCE (case-insensitive)
       ======================== */
    FIND FIRST ttattendance
         WHERE ttattendance.EmpID = vEmp
           AND UPPER(TRIM(ttattendance.MonthNames)) = UPPER(vMonth)
         NO-LOCK NO-ERROR.

    DO WITH FRAME FRAME-M:
        IF AVAILABLE ttattendance THEN
            ASSIGN
                txtMonthdays:SCREEN-VALUE     = STRING(ttattendance.MonthlyWorkingDays)
                txtemployeedays:SCREEN-VALUE  = STRING(ttattendance.EmployeeWorkingDays)
                txtemployeeleave:SCREEN-VALUE = STRING(ttattendance.TotalLeaves).
        ELSE DO:
            ASSIGN
                txtMonthdays:SCREEN-VALUE = ""
                txtemployeedays:SCREEN-VALUE = ""
                txtemployeeleave:SCREEN-VALUE = "".
        END.
    END. /* FRAME-M */

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_MAIL C-Win 
PROCEDURE P_MAIL :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
  /*

DEFINE VARIABLE vSelectedMonth   AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vToday           AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vMonthlyDays     AS INTEGER     NO-UNDO.
DEFINE VARIABLE vEmpWorkingDays  AS INTEGER     NO-UNDO.
DEFINE VARIABLE vTotalEarnings   AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vTotalDeducation AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vLOPAmount       AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vNetSalary       AS DECIMAL     NO-UNDO.
DEFINE VARIABLE vEmpName         AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vEmpMail         AS CHARACTER   NO-UNDO.
DEFINE VARIABLE vBodyText        AS LONGCHAR    NO-UNDO.
DEFINE VARIABLE vSelectedYear AS CHARACTER NO-UNDO. */

//  selected month 
vSelectedMonth = TRIM(UPPER(TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J)).

IF vSelectedMonth = "" OR vSelectedMonth = ? THEN DO:
    MESSAGE "Please select month name."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.




vSelectedYear = TRIM(TXTYEAR:SCREEN-VALUE IN FRAME FRAME-J).

IF vSelectedYear = "" OR vSelectedYear = ? THEN DO:
    MESSAGE "Please select a year."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.


vToday = STRING(DAY(TODAY),"99") + "-"
       + CAPS(ENTRY(MONTH(TODAY),
         "JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC"))
       + "-" + STRING(YEAR(TODAY)).

//  CURRENT employee 
FIND EmployeeDetails NO-LOCK
     WHERE EmployeeDetails.EmpID = INTEGER(txtemployeeid:SCREEN-VALUE)
     NO-ERROR.

IF NOT AVAILABLE EmployeeDetails THEN DO:
    MESSAGE "No Employee details found for this ID."
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

ASSIGN 
    vEmpName = EmployeeDetails.EmpName
    vEmpMail = EmployeeDetails.EMail.

// Employee Master 
FIND EmployeeMaster NO-LOCK
     WHERE EmployeeMaster.EmpID = EmployeeDetails.EmpID
       AND EmployeeMaster.EmpStatus = "ACTIVE"
     NO-ERROR.

// Salary DETAILS
FIND EmployeeSalarysDetails NO-LOCK
     WHERE EmployeeSalarysDetails.EmpID = EmployeeDetails.EmpID
       AND CAPS(EmployeeSalarysDetails.SALARYMONTH) = vSelectedMonth
     NO-ERROR.

// Attendance EMPLOYEE
FIND EMPLOYEEATTENADCE NO-LOCK
     WHERE EMPLOYEEATTENADCE.EmpID = EmployeeDetails.EmpID
       AND CAPS(EMPLOYEEATTENADCE.MonthNames) = vSelectedMonth
     NO-ERROR.

//     Validate 
IF NOT AVAILABLE EmployeeMaster 
   OR NOT AVAILABLE EmployeeSalarysDetails 
   OR NOT AVAILABLE EMPLOYEEATTENADCE THEN DO:
    MESSAGE "Payslip not available for this employee in " + vSelectedMonth
        VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

// Calculate Net Salary EMPLOYEE
ASSIGN
    vMonthlyDays     = EMPLOYEEATTENADCE.MonthlyWorkingDays
    vEmpWorkingDays  = EMPLOYEEATTENADCE.EmployeeWorkingDays
    vTotalEarnings   = EmployeeSalarysDetails.TotalEarings
    vTotalDeducation = EmployeeSalarysDetails.TotalDeducation.

vLOPAmount = (vMonthlyDays - vEmpWorkingDays) * (vTotalEarnings / vMonthlyDays).
vNetSalary = vTotalEarnings - vLOPAmount - vTotalDeducation.
IF vNetSalary < 0 THEN vNetSalary = 0.

// Build Payslip Text (as email body) 
vBodyText = "                  *** PAY SLIP REPORT - " + vSelectedMonth + " ***" + CHR(10)
          + "Generated on: " + vToday + CHR(10)
          + FILL("-",50) + CHR(10)
          + "Employee ID   : " + STRING(EmployeeDetails.EmpID) + CHR(10)
          + "Employee Name : " + vEmpName + CHR(10)
          + "Designation   : " + EmployeeMaster.Designation + CHR(10)
          + "Department    : " + EmployeeMaster.Department + CHR(10)
          + "Joining Date  : " + STRING(EmployeeMaster.DOJ) + CHR(10)
          + FILL("-",50) + CHR(10)
          + "Total Working Days      : " + STRING(vMonthlyDays) + CHR(10)
          + "Employee working Days   : " + STRING(vEmpWorkingDays) + CHR(10)
          + "Employee Leaves         : " + STRING(vMonthlyDays - vEmpWorkingDays) + CHR(10)
          + FILL("-",50) + CHR(10)
          + "Basic Salary   :  " + STRING(EmployeeSalarysDetails.BasicSalary,"->>,>>>,>>9") + CHR(10)
          + "HRA            :  " + STRING(EmployeeSalarysDetails.HRA,"->>,>>>,>>9") + CHR(10)
          + "Special Allow  : " + STRING(EmployeeSalarysDetails.SpecialAllowance,"->>,>>>,>>9") + CHR(10)
          + "Total Earnings :  " + STRING(vTotalEarnings,"->>,>>>,>>9") + CHR(10)
          + "Deductions     : " + STRING(vTotalDeducation,"->>,>>>,>>9") + CHR(10)
          + "LOP Amount     : " + STRING(vLOPAmount,"->>,>>>,>>9") + CHR(10)
          + FILL("-",50) + CHR(10)
          + "Net Salary     : " + STRING(vNetSalary,"->>,>>>,>>9") + CHR(10)
          + FILL("-",50) + CHR(10)
          + "     *** INCOME-TAX DEDUCTION DETAILS ***" + CHR(10)
          + "APR-25 :-     JULY-25:-     OCT-25 :-     JAN-25 :-" + CHR(10)
          + "MAY-25 :-     AUG-25 :-     NOV-25 :-     FEB-25 :-" + CHR(10)
          + "JUN-25 :-     SEP-25 :-     DEC-25 :-     MAR-25 :-" + CHR(10)
          + FILL("-",50) + CHR(10).

// Send Email (no TXT file, just body) 
DEFINE VARIABLE chMessage AS COM-HANDLE NO-UNDO.
DEFINE VARIABLE chConfig  AS COM-HANDLE NO-UNDO.

CREATE "CDO.Message" chMessage.
CREATE "CDO.Configuration" chConfig.

/* === SMTP CONFIGURATION (edit as per your server) === */
chConfig:Fields("http://schemas.microsoft.com/cdo/configuration/sendusing"):Value = 2.
chConfig:Fields("http://schemas.microsoft.com/cdo/configuration/smtpserver"):Value = "smtp.gmail.com".
chConfig:Fields("http://schemas.microsoft.com/cdo/configuration/smtpserverport"):Value = 587.
chConfig:Fields("http://schemas.microsoft.com/cdo/configuration/smtpauthenticate"):Value = 1.
chConfig:Fields("http://schemas.microsoft.com/cdo/configuration/sendusername"):Value = "pasupuletivenkatesh@gmail.com".
chConfig:Fields("http://schemas.microsoft.com/cdo/configuration/sendpassword"):Value = "kdjz ojja bqwx axhc".
chConfig:Fields("http://schemas.microsoft.com/cdo/configuration/smtpusessl"):Value = TRUE.
chConfig:Fields:Update().
chMessage:Configuration = chConfig.
chMessage:Subject = "Payslip for " + vSelectedMonth.
chMessage:From    = "hr@yourcompany.com".
chMessage:To      = vEmpMail.
chMessage:TextBody = "Dear " + vEmpName + "," + CHR(10) + CHR(10)
                   + "Please find your payslip for " + vSelectedMonth + " below:" + CHR(10) + CHR(10)
                   + vBodyText.

chMessage:Send().

RELEASE OBJECT chMessage.
RELEASE OBJECT chConfig.

/* Step 6: Show success */
//MESSAGE "Payslip sent successfully to " vEmpName + " (" + vEmpMail + ")"
  //  VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.

     MESSAGE "Payslip for " + vSelectedMonth + " " + vSelectedYear
        + " sent successfully to " + vEmpName + " (" + vEmpMail + ")"
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END. /* ON CHOOSE btnDownload */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_NEXT C-Win 
PROCEDURE P_NEXT :
/* NEXT button: load next active employee (month + year filtered salary) */
/*DEF VAR vEmpID         AS INTEGER   NO-UNDO.
DEF VAR vSelectedMonth AS CHARACTER NO-UNDO.
DEF VAR vSelectedYear  AS CHARACTER NO-UNDO.
DEF VAR lFirstTry      AS LOGICAL   NO-UNDO. */

// EMPLOYEE SELECTING MONTH AND YEAR 
/* vSelectedMonth = TRIM(TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J).                        */
/* IF vSelectedMonth = "" THEN DO:                                                              */
/*     MESSAGE "Please select a month first."                                                   */
/*         VIEW-AS ALERT-BOX ERROR BUTTONS OK.                                                  */
/*     RETURN.                                                                                  */
/* END.                                                                                         */
/*                                                                                              */
/* vSelectedYear = TRIM(TXTYEAR:SCREEN-VALUE IN FRAME FRAME-J).                                 */
/* IF vSelectedYear = "" THEN DO:                                                               */
/*     MESSAGE "Please select a year first."                                                    */
/*         VIEW-AS ALERT-BOX ERROR BUTTONS OK.                                                  */
/*     RETURN.                                                                                  */
/* END.                                                                                         */
/*                                                                                              */
/* // Get current employee id shown on screen (FRAME-J)                                         */
/* vEmpID = INTEGER(txtemployeeid:SCREEN-VALUE IN FRAME FRAME-J).                               */
/*                                                                                              */
/* // Find next active EmployeeDetails (skip INACTIVE employees)                                */
/* IF vEmpID > 0 THEN DO:                                                                       */
/*     FIND EmployeeDetails NO-LOCK                                                             */
/*         WHERE EmployeeDetails.EmpID = vEmpID NO-ERROR.                                       */
/* END.                                                                                         */
/*                                                                                              */
/* lFirstTry = TRUE.                                                                            */
/* REPEAT:                                                                                      */
/*     IF lFirstTry THEN DO:                                                                    */
/*         IF AVAILABLE EmployeeDetails THEN                                                    */
/*             FIND NEXT EmployeeDetails NO-LOCK NO-ERROR.                                      */
/*         ELSE                                                                                 */
/*             FIND FIRST EmployeeDetails NO-LOCK NO-ERROR.                                     */
/*         lFirstTry = FALSE.                                                                   */
/*     END.                                                                                     */
/*     ELSE                                                                                     */
/*         FIND NEXT EmployeeDetails NO-LOCK NO-ERROR.                                          */
/*                                                                                              */
/*     IF NOT AVAILABLE EmployeeDetails THEN DO:                                                */
/*         MESSAGE "You are at the last record."                                                */
/*             VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.                                        */
/*         RETURN.                                                                              */
/*     END.                                                                                     */
/*                                                                                              */
/* // Check EmployeeMaster status                                                               */
/*     FIND FIRST EmployeeMaster NO-LOCK                                                        */
/*          WHERE EmployeeMaster.EmpID = EmployeeDetails.EmpID                                  */
/*          NO-ERROR.                                                                           */
/*                                                                                              */
/*     IF AVAILABLE EmployeeMaster AND                                                          */
/*        UPPER(TRIM(EmployeeMaster.EmpStatus)) <> "INACTIVE" THEN LEAVE.                       */
/* END.                                                                                         */
/*                                                                                              */
/* //                                                                                           */
/* DO WITH FRAME FRAME-J:                                                                       */
/*     ASSIGN txtemployeeid:SCREEN-VALUE   = ""                                                 */
/*            txtemployeename:SCREEN-VALUE = "".                                                */
/* END.                                                                                         */
/*                                                                                              */
/* DO WITH FRAME FRAME-L:                                                                       */
/*     ASSIGN txtjoindate:SCREEN-VALUE     = ""                                                 */
/*            txtdesignation:SCREEN-VALUE  = ""                                                 */
/*            txtDepartment:SCREEN-VALUE   = "".                                                */
/* END.                                                                                         */
/*                                                                                              */
/* DO WITH FRAME FRAME-M:                                                                       */
/*     ASSIGN //txtmonth:SCREEN-VALUE         = ""                                              */
/*            txtMonthdays:SCREEN-VALUE     = ""                                                */
/*            txtemployeedays:SCREEN-VALUE  = ""                                                */
/*            txtemployeeleave:SCREEN-VALUE = "".                                               */
/* END.                                                                                         */
/*                                                                                              */
/* DO WITH FRAME FRAME-I:                                                                       */
/*     ASSIGN Txtbank:SCREEN-VALUE   = ""                                                       */
/*            TxtPan:SCREEN-VALUE    = ""                                                       */
/*            TxtUn:SCREEN-VALUE     = ""                                                       */
/*            Txtbasic:SCREEN-VALUE  = ""                                                       */
/*            txthouse:SCREEN-VALUE  = ""                                                       */
/*            txtsp:SCREEN-VALUE     = ""                                                       */
/*            txtpf:SCREEN-VALUE     = ""                                                       */
/*            txttotal:SCREEN-VALUE  = ""                                                       */
/*            txttx:SCREEN-VALUE     = ""                                                       */
/*            txtd:SCREEN-VALUE      = ""                                                       */
/*            txtgg:SCREEN-VALUE     = ""                                                       */
/*            txtnet:SCREEN-VALUE    = "".                                                      */
/*            //txtprovide:SCREEN-VALUE = "".                                                   */
/* END.                                                                                         */
/*                                                                                              */
/* //  Load EmployeeDetails into FRAME-J                                                        */
/* DO WITH FRAME FRAME-J:                                                                       */
/*     ASSIGN txtemployeeid:SCREEN-VALUE   = STRING(EmployeeDetails.EmpID)                      */
/*            txtemployeename:SCREEN-VALUE = EmployeeDetails.EmpName                            */
/*            txtemployeeid:SENSITIVE      = TRUE                                               */
/*            txtemployeename:SENSITIVE    = FALSE.                                             */
/* END.                                                                                         */
/*                                                                                              */
/* // Load EmployeeMaster into FRAME-L                                                          */
/* IF AVAILABLE EmployeeMaster THEN                                                             */
/*     DO WITH FRAME FRAME-L:                                                                   */
/*         ASSIGN txtjoindate:SCREEN-VALUE    = STRING(EmployeeMaster.DOJ)                      */
/*                txtdesignation:SCREEN-VALUE = EmployeeMaster.Designation                      */
/*                txtDepartment:SCREEN-VALUE  = EmployeeMaster.Department                       */
/*                txtjoindate:SENSITIVE       = FALSE                                           */
/*                txtdesignation:SENSITIVE    = FALSE                                           */
/*                txtDepartment:SENSITIVE     = FALSE.                                          */
/*     END.                                                                                     */


/* FIND FIRST EMPLOYEEATTENADCE NO-LOCK                                                         */

/*        AND UPPER(TRIM(EMPLOYEEATTENADCE.MonthNames)) = UPPER(TRIM(vSelectedMonth))           */
/*        AND STRING(EMPLOYEEATTENADCE.YEAR) = vSelectedYear                                    */




/*         ASSIGN //txtmonth:SCREEN-VALUE         = EMPLOYEEATTENADCE.MonthNames                */
/*                txtMonthdays:SCREEN-VALUE     = STRING(EMPLOYEEATTENADCE.MonthlyWorkingDays)  */
/*                txtemployeedays:SCREEN-VALUE  = STRING(EMPLOYEEATTENADCE.EmployeeWorkingDays) */
/*                txtemployeeleave:SCREEN-VALUE = STRING(EMPLOYEEATTENADCE.TotalLeaves)         */

/*                txtMonthdays:SENSITIVE       = FALSE                                          */

/*                txtemployeeleave:SENSITIVE   = FALSE.                                         */



/* FIND FIRST EmployeeSalarysDetails NO-LOCK                                                    */
/*      WHERE EmployeeSalarysDetails.EmpID       = EmployeeDetails.EmpID                        */
/*        AND UPPER(TRIM(EmployeeSalarysDetails.SALARYMONTH)) = UPPER(TRIM(vSelectedMonth))     */



/* IF AVAILABLE EmployeeSalarysDetails THEN                                                     */

/*         ASSIGN Txtbank:SCREEN-VALUE   = STRING(EmployeeSalarysDetails.EemployeBankNum)       */
/*                TxtPan:SCREEN-VALUE    = EmployeeSalarysDetails.ITPAN                         */

/*                Txtbasic:SCREEN-VALUE  = STRING(EmployeeSalarysDetails.BasicSalary)           */
/*                txthouse:SCREEN-VALUE  = STRING(EmployeeSalarysDetails.HRA)                   */
/*                txtsp:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.SpecialAllowance)      */
/*                txtpf:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.COMP-OFF-ENCASHMENT)   */
/*                txttotal:SCREEN-VALUE  = STRING(EmployeeSalarysDetails.TotalEarings)          */
/*                txttx:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.ProfessionalTax)       */

/*                txtgg:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.TotalDeducation)       */
/*                txtnet:SCREEN-VALUE    = STRING(EmployeeSalarysDetails.NetSalaryPaid)         */
/*                //txtprovide:SCREEN-VALUE = STRING(EmployeeSalarysDetails.ProvidentFund)      */


/*                TxtPan:SENSITIVE       = FALSE                                                */

/*                Txtbasic:SENSITIVE     = FALSE                                                */

/*                txtsp:SENSITIVE        = FALSE                                                */

/*                txttx:SENSITIVE        = FALSE                                                */

/*                txtgg:SENSITIVE        = FALSE                                                */

/*                txttotal:SENSITIVE     = FALSE.                                               */




//----------------------------------------------------------------------------------------

// teamp-table uisng code 
vSelectedMonth = TRIM(TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J).
 IF vSelectedMonth = "" THEN DO:
     MESSAGE "Please select a month first."
         VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN.
 END.
 
 vSelectedYear = TRIM(TXTYEAR:SCREEN-VALUE IN FRAME FRAME-J).
 IF vSelectedYear = "" THEN DO:
     MESSAGE "Please select a year first."
         VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN.
 END.
 // UISNG EMPLOYEE ID 
 
 vEmpID = INTEGER(txtemployeeid:SCREEN-VALUE IN FRAME FRAME-J).
 
 // Find next active ttdetails 
 IF vEmpID > 0 THEN DO:
     FIND ttdetails NO-LOCK
         WHERE ttdetails.EmpID = vEmpID NO-ERROR.
 END.
 
 lFirstTry = TRUE.
 REPEAT:
     IF lFirstTry THEN DO:
         IF AVAILABLE ttdetails THEN
             FIND next ttdetails NO-LOCK NO-ERROR.
         ELSE
             FIND next ttdetails NO-LOCK NO-ERROR.
         lFirstTry = FALSE.
     END.
     ELSE
         FIND next ttdetails NO-LOCK NO-ERROR.
 
     IF NOT AVAILABLE ttdetails THEN DO:
         MESSAGE "You are at the last record."
             VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
         RETURN.
     END.
 
     // Check ttadmin status 
     FIND FIRST ttadmin NO-LOCK
          WHERE ttadmin.EmpID = ttdetails.EmpID
          NO-ERROR.
 
     IF AVAILABLE ttadmin AND
        UPPER(TRIM(ttadmin.EmpStatus)) <> "INACTIVE" THEN LEAVE.
 END.
 
 // Clear all frames
 DO WITH FRAME FRAME-J:
     ASSIGN txtemployeeid:SCREEN-VALUE   = ""
            txtemployeename:SCREEN-VALUE = "".
 END.
 
 DO WITH FRAME FRAME-L:
     ASSIGN txtjoindate:SCREEN-VALUE     = ""
            txtdesignation:SCREEN-VALUE  = ""
            txtDepartment:SCREEN-VALUE   = "".
 END.
 
 DO WITH FRAME FRAME-M:
     ASSIGN // txtmonth:SCREEN-VALUE         = ""
            txtMonthdays:SCREEN-VALUE     = ""
            txtemployeedays:SCREEN-VALUE  = ""
            txtemployeeleave:SCREEN-VALUE = "".
 END.
 
 DO WITH FRAME FRAME-I:
     ASSIGN Txtbank:SCREEN-VALUE   = ""
            TxtPan:SCREEN-VALUE    = ""
            TxtUn:SCREEN-VALUE     = ""
            Txtbasic:SCREEN-VALUE  = ""
            txthouse:SCREEN-VALUE  = ""
            txtsp:SCREEN-VALUE     = ""
            txtpf:SCREEN-VALUE     = ""
            txttotal:SCREEN-VALUE  = ""
            txttx:SCREEN-VALUE     = ""
            txtd:SCREEN-VALUE      = ""
            txtgg:SCREEN-VALUE     = ""
            txtnet:SCREEN-VALUE    = "".
            //txtprovide:SCREEN-VALUE = "".
 END.
 
 //Load ttdetails into FRAME-J
 DO WITH FRAME FRAME-J:
     ASSIGN txtemployeeid:SCREEN-VALUE   = STRING(ttdetails.EmpID)
            txtemployeename:SCREEN-VALUE = ttdetails.EmpName
            txtemployeeid:SENSITIVE      = TRUE
            txtemployeename:SENSITIVE    = FALSE.
 END.
 
 // Load ttadmin into FRAME-L 
 IF AVAILABLE ttadmin THEN
     DO WITH FRAME FRAME-L:
         ASSIGN txtjoindate:SCREEN-VALUE    = STRING(ttadmin.DOJ)
                txtdesignation:SCREEN-VALUE = ttadmin.Designation
                txtDepartment:SCREEN-VALUE  = ttadmin.Department
                txtjoindate:SENSITIVE       = FALSE
                txtdesignation:SENSITIVE    = FALSE
                txtDepartment:SENSITIVE     = FALSE.
     END.
 
 // Load Employee Attendance (FRAME-M) 
 FIND FIRST ttattendance NO-LOCK
      WHERE ttattendance.EmpID = ttdetails.EmpID
        AND UPPER(TRIM(ttattendance.MonthNames)) = UPPER(TRIM(vSelectedMonth))
        AND STRING(ttattendance.YEAR) = vSelectedYear
      NO-ERROR.
 
 IF AVAILABLE ttattendance THEN
     DO WITH FRAME FRAME-M:
         ASSIGN //txtmonth:SCREEN-VALUE         = ttattendance.MonthNames
                txtMonthdays:SCREEN-VALUE     = STRING(ttattendance.MonthlyWorkingDays)
                txtemployeedays:SCREEN-VALUE  = STRING(ttattendance.EmployeeWorkingDays)
                txtemployeeleave:SCREEN-VALUE = STRING(ttattendance.TotalLeaves)
               // txtmonth:SENSITIVE           = FALSE
                txtMonthdays:SENSITIVE       = FALSE
                txtemployeedays:SENSITIVE    = FALSE
                txtemployeeleave:SENSITIVE   = FALSE.
     END.
 
 // Load Employee Salary Details (FRAME-I)
 FIND FIRST ttsalary NO-LOCK
      WHERE ttsalary.EmpID       = ttdetails.EmpID
        AND UPPER(TRIM(ttsalary.SALARYMONTH)) = UPPER(TRIM(vSelectedMonth))
        AND STRING(ttsalary.YEAR) = vSelectedYear
      NO-ERROR.
 
 IF AVAILABLE ttsalary THEN
     DO WITH FRAME FRAME-I:
         ASSIGN Txtbank:SCREEN-VALUE   = STRING(ttsalary.EemployeBankNum)
                TxtPan:SCREEN-VALUE    = ttsalary.ITPAN
                TxtUn:SCREEN-VALUE     = STRING(ttsalary.EmployeeUANNum)
                Txtbasic:SCREEN-VALUE  = STRING(ttsalary.BasicSalary)
                txthouse:SCREEN-VALUE  = STRING(ttsalary.HRA)
                txtsp:SCREEN-VALUE     = STRING(ttsalary.SpecialAllowance)
                txtpf:SCREEN-VALUE     = STRING(ttsalary.COMP-OFF-ENCASHMENT)
                txttotal:SCREEN-VALUE  = STRING(ttsalary.TotalEarings)
                txttx:SCREEN-VALUE     = STRING(ttsalary.ProfessionalTax)
                txtd:SCREEN-VALUE      = STRING(ttsalary.ProvidentFund)
                txtgg:SCREEN-VALUE     = STRING(ttsalary.TotalDeducation)
                txtnet:SCREEN-VALUE    = STRING(ttsalary.NetSalaryPaid)
                //txtprovide:SCREEN-VALUE = STRING(ttsalary.ProvidentFund)
 
                Txtbank:SENSITIVE      = FALSE
                TxtPan:SENSITIVE       = FALSE
                TxtUn:SENSITIVE        = FALSE
                Txtbasic:SENSITIVE     = FALSE
                txthouse:SENSITIVE     = FALSE
                txtsp:SENSITIVE        = FALSE
                txtpf:SENSITIVE        = FALSE
                txttx:SENSITIVE        = FALSE
                txtd:SENSITIVE         = FALSE
                txtgg:SENSITIVE        = FALSE
                txtnet:SENSITIVE       = FALSE
                txttotal:SENSITIVE     = FALSE.
               //txtprovide:SENSITIVE   = FALSE.
     END.
 
 
         END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_prev C-Win 
PROCEDURE p_prev :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


//  teamp-table not uisng code


 
 /* NEXT button: load next active employee (month + year filtered salary) */
 /*DEF VAR vEmpID         AS INTEGER   NO-UNDO.
 DEF VAR vSelectedMonth AS CHARACTER NO-UNDO.
 DEF VAR vSelectedYear  AS CHARACTER NO-UNDO.
 DEF VAR lFirstTry      AS LOGICAL   NO-UNDO.  */
 
 // EMPLOYEE SELECT MONTH AND YESR
/*  vSelectedMonth = TRIM(TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J).                        */
/*  IF vSelectedMonth = "" THEN DO:                                                              */
/*      MESSAGE "Please select a month first."                                                   */
/*          VIEW-AS ALERT-BOX ERROR BUTTONS OK.                                                  */
/*      RETURN.                                                                                  */
/*  END.                                                                                         */
/*                                                                                               */
/*  vSelectedYear = TRIM(TXTYEAR:SCREEN-VALUE IN FRAME FRAME-J).                                 */
/*  IF vSelectedYear = "" THEN DO:                                                               */
/*      MESSAGE "Please select a year first."                                                    */
/*          VIEW-AS ALERT-BOX ERROR BUTTONS OK.                                                  */
/*      RETURN.                                                                                  */
/*  END.                                                                                         */
/*  // UISNG EMPLOYEE ID                                                                         */
/*                                                                                               */
/*  vEmpID = INTEGER(txtemployeeid:SCREEN-VALUE IN FRAME FRAME-J).                               */
/*                                                                                               */
/*  // Find next active EmployeeDetails                                                          */
/*  IF vEmpID > 0 THEN DO:                                                                       */
/*      FIND EmployeeDetails NO-LOCK                                                             */
/*          WHERE EmployeeDetails.EmpID = vEmpID NO-ERROR.                                       */
/*  END.                                                                                         */
/*                                                                                               */
/*  lFirstTry = TRUE.                                                                            */
/*  REPEAT:                                                                                      */
/*      IF lFirstTry THEN DO:                                                                    */
/*          IF AVAILABLE EmployeeDetails THEN                                                    */
/*              FIND PREV EmployeeDetails NO-LOCK NO-ERROR.                                      */
/*          ELSE                                                                                 */
/*              FIND PREV EmployeeDetails NO-LOCK NO-ERROR.                                      */
/*          lFirstTry = FALSE.                                                                   */
/*      END.                                                                                     */
/*      ELSE                                                                                     */
/*          FIND PREV EmployeeDetails NO-LOCK NO-ERROR.                                          */
/*                                                                                               */
/*      IF NOT AVAILABLE EmployeeDetails THEN DO:                                                */
/*          MESSAGE "You are at the last record."                                                */
/*              VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.                                        */
/*          RETURN.                                                                              */
/*      END.                                                                                     */
/*                                                                                               */
/*      // Check EmployeeMaster status                                                           */
/*      FIND FIRST EmployeeMaster NO-LOCK                                                        */
/*           WHERE EmployeeMaster.EmpID = EmployeeDetails.EmpID                                  */
/*           NO-ERROR.                                                                           */
/*                                                                                               */
/*      IF AVAILABLE EmployeeMaster AND                                                          */
/*         UPPER(TRIM(EmployeeMaster.EmpStatus)) <> "INACTIVE" THEN LEAVE.                       */
/*  END.                                                                                         */
/*                                                                                               */
/*  // Clear all frames                                                                          */
/*  DO WITH FRAME FRAME-J:                                                                       */
/*      ASSIGN txtemployeeid:SCREEN-VALUE   = ""                                                 */
/*             txtemployeename:SCREEN-VALUE = "".                                                */
/*  END.                                                                                         */
/*                                                                                               */
/*  DO WITH FRAME FRAME-L:                                                                       */
/*      ASSIGN txtjoindate:SCREEN-VALUE     = ""                                                 */
/*             txtdesignation:SCREEN-VALUE  = ""                                                 */
/*             txtDepartment:SCREEN-VALUE   = "".                                                */
/*  END.                                                                                         */
/*                                                                                               */
/*  DO WITH FRAME FRAME-M:                                                                       */
/*      ASSIGN // txtmonth:SCREEN-VALUE         = ""                                             */
/*             txtMonthdays:SCREEN-VALUE     = ""                                                */
/*             txtemployeedays:SCREEN-VALUE  = ""                                                */
/*             txtemployeeleave:SCREEN-VALUE = "".                                               */
/*  END.                                                                                         */
/*                                                                                               */
/*  DO WITH FRAME FRAME-I:                                                                       */
/*      ASSIGN Txtbank:SCREEN-VALUE   = ""                                                       */
/*             TxtPan:SCREEN-VALUE    = ""                                                       */
/*             TxtUn:SCREEN-VALUE     = ""                                                       */
/*             Txtbasic:SCREEN-VALUE  = ""                                                       */
/*             txthouse:SCREEN-VALUE  = ""                                                       */
/*             txtsp:SCREEN-VALUE     = ""                                                       */
/*             txtpf:SCREEN-VALUE     = ""                                                       */
/*             txttotal:SCREEN-VALUE  = ""                                                       */
/*             txttx:SCREEN-VALUE     = ""                                                       */
/*             txtd:SCREEN-VALUE      = ""                                                       */
/*             txtgg:SCREEN-VALUE     = ""                                                       */
/*             txtnet:SCREEN-VALUE    = "".                                                      */
/*             //txtprovide:SCREEN-VALUE = "".                                                   */
/*  END.                                                                                         */
/*                                                                                               */
/*  //Load EmployeeDetails into FRAME-J                                                          */
/*  DO WITH FRAME FRAME-J:                                                                       */
/*      ASSIGN txtemployeeid:SCREEN-VALUE   = STRING(EmployeeDetails.EmpID)                      */
/*             txtemployeename:SCREEN-VALUE = EmployeeDetails.EmpName                            */
/*             txtemployeeid:SENSITIVE      = TRUE                                               */
/*             txtemployeename:SENSITIVE    = FALSE.                                             */
/*  END.                                                                                         */
/*                                                                                               */
/*  // Load EmployeeMaster into FRAME-L                                                          */
/*  IF AVAILABLE EmployeeMaster THEN                                                             */

/*          ASSIGN txtjoindate:SCREEN-VALUE    = STRING(EmployeeMaster.DOJ)                      */
/*                 txtdesignation:SCREEN-VALUE = EmployeeMaster.Designation                      */

/*                 txtjoindate:SENSITIVE       = FALSE                                           */

/*                 txtDepartment:SENSITIVE     = FALSE.                                          */



/*  FIND FIRST EMPLOYEEATTENADCE NO-LOCK                                                         */

/*         AND UPPER(TRIM(EMPLOYEEATTENADCE.MonthNames)) = UPPER(TRIM(vSelectedMonth))           */
/*         AND STRING(EMPLOYEEATTENADCE.YEAR) = vSelectedYear                                    */



/*      DO WITH FRAME FRAME-M:                                                                   */

/*                 txtMonthdays:SCREEN-VALUE     = STRING(EMPLOYEEATTENADCE.MonthlyWorkingDays)  */
/*                 txtemployeedays:SCREEN-VALUE  = STRING(EMPLOYEEATTENADCE.EmployeeWorkingDays) */
/*                 txtemployeeleave:SCREEN-VALUE = STRING(EMPLOYEEATTENADCE.TotalLeaves)         */
/*                // txtmonth:SENSITIVE           = FALSE                                        */

/*                 txtemployeedays:SENSITIVE    = FALSE                                          */



/*  // Load Employee Salary Details (FRAME-I)                                                    */

/*       WHERE EmployeeSalarysDetails.EmpID       = EmployeeDetails.EmpID                        */
/*         AND UPPER(TRIM(EmployeeSalarysDetails.SALARYMONTH)) = UPPER(TRIM(vSelectedMonth))     */

/*       NO-ERROR.                                                                               */



/*          ASSIGN Txtbank:SCREEN-VALUE   = STRING(EmployeeSalarysDetails.EemployeBankNum)       */
/*                 TxtPan:SCREEN-VALUE    = EmployeeSalarysDetails.ITPAN                         */
/*                 TxtUn:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.EmployeeUANNum)        */
/*                 Txtbasic:SCREEN-VALUE  = STRING(EmployeeSalarysDetails.BasicSalary)           */

/*                 txtsp:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.SpecialAllowance)      */
/*                 txtpf:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.COMP-OFF-ENCASHMENT)   */
/*                 txttotal:SCREEN-VALUE  = STRING(EmployeeSalarysDetails.TotalEarings)          */
/*                 txttx:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.ProfessionalTax)       */
/*                 txtd:SCREEN-VALUE      = STRING(EmployeeSalarysDetails.ProvidentFund)         */
/*                 txtgg:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.TotalDeducation)       */

/*                 //txtprovide:SCREEN-VALUE = STRING(EmployeeSalarysDetails.ProvidentFund)      */

/*                 Txtbank:SENSITIVE      = FALSE                                                */

/*                 TxtUn:SENSITIVE        = FALSE                                                */

/*                 txthouse:SENSITIVE     = FALSE                                                */

/*                 txtpf:SENSITIVE        = FALSE                                                */


/*                 txtgg:SENSITIVE        = FALSE                                                */

/*                 txttotal:SENSITIVE     = FALSE.                                               */



/*          END.   */


//--------------------------------------------------------------------------------

 //------------------- teamp-table using code        
         
   vSelectedMonth = TRIM(TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J).
 IF vSelectedMonth = "" THEN DO:
     MESSAGE "Please select a month first."
         VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN.
 END.
 
 vSelectedYear = TRIM(TXTYEAR:SCREEN-VALUE IN FRAME FRAME-J).
 IF vSelectedYear = "" THEN DO:
     MESSAGE "Please select a year first."
         VIEW-AS ALERT-BOX ERROR BUTTONS OK.
     RETURN.
 END.
 // UISNG EMPLOYEE ID 
 
 vEmpID = INTEGER(txtemployeeid:SCREEN-VALUE IN FRAME FRAME-J).
 
 // Find next active ttdetails 
 IF vEmpID > 0 THEN DO:
     FIND ttdetails NO-LOCK
         WHERE ttdetails.EmpID = vEmpID NO-ERROR.
 END.
 
 lFirstTry = TRUE.
 REPEAT:
     IF lFirstTry THEN DO:
         IF AVAILABLE ttdetails THEN
             FIND PREV ttdetails NO-LOCK NO-ERROR.
         ELSE
             FIND PREV ttdetails NO-LOCK NO-ERROR.
         lFirstTry = FALSE.
     END.
     ELSE
         FIND PREV ttdetails NO-LOCK NO-ERROR.
 
     IF NOT AVAILABLE ttdetails THEN DO:
         MESSAGE "You are at the first record."
             VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
         RETURN.
     END.
 
     // Check ttadmin status 
     FIND FIRST ttadmin NO-LOCK
          WHERE ttadmin.EmpID = ttdetails.EmpID
          NO-ERROR.
 
     IF AVAILABLE ttadmin AND
        UPPER(TRIM(ttadmin.EmpStatus)) <> "INACTIVE" THEN LEAVE.
 END.
 
 // Clear all frames
 DO WITH FRAME FRAME-J:
     ASSIGN txtemployeeid:SCREEN-VALUE   = ""
            txtemployeename:SCREEN-VALUE = "".
 END.
 
 DO WITH FRAME FRAME-L:
     ASSIGN txtjoindate:SCREEN-VALUE     = ""
            txtdesignation:SCREEN-VALUE  = ""
            txtDepartment:SCREEN-VALUE   = "".
 END.
 
 DO WITH FRAME FRAME-M:
     ASSIGN // txtmonth:SCREEN-VALUE         = ""
            txtMonthdays:SCREEN-VALUE     = ""
            txtemployeedays:SCREEN-VALUE  = ""
            txtemployeeleave:SCREEN-VALUE = "".
 END.
 
 DO WITH FRAME FRAME-I:
     ASSIGN Txtbank:SCREEN-VALUE   = ""
            TxtPan:SCREEN-VALUE    = ""
            TxtUn:SCREEN-VALUE     = ""
            Txtbasic:SCREEN-VALUE  = ""
            txthouse:SCREEN-VALUE  = ""
            txtsp:SCREEN-VALUE     = ""
            txtpf:SCREEN-VALUE     = ""
            txttotal:SCREEN-VALUE  = ""
            txttx:SCREEN-VALUE     = ""
            txtd:SCREEN-VALUE      = ""
            txtgg:SCREEN-VALUE     = ""
            txtnet:SCREEN-VALUE    = "".
            //txtprovide:SCREEN-VALUE = "".
 END.
 
 //Load ttdetails into FRAME-J
 DO WITH FRAME FRAME-J:
     ASSIGN txtemployeeid:SCREEN-VALUE   = STRING(ttdetails.EmpID)
            txtemployeename:SCREEN-VALUE = ttdetails.EmpName
            txtemployeeid:SENSITIVE      = TRUE
            txtemployeename:SENSITIVE    = FALSE.
 END.
 
 // Load ttadmin into FRAME-L 
 IF AVAILABLE ttadmin THEN
     DO WITH FRAME FRAME-L:
         ASSIGN txtjoindate:SCREEN-VALUE    = STRING(ttadmin.DOJ)
                txtdesignation:SCREEN-VALUE = ttadmin.Designation
                txtDepartment:SCREEN-VALUE  = ttadmin.Department
                txtjoindate:SENSITIVE       = FALSE
                txtdesignation:SENSITIVE    = FALSE
                txtDepartment:SENSITIVE     = FALSE.
     END.
 
 // Load Employee Attendance (FRAME-M) 
 FIND FIRST ttattendance NO-LOCK
      WHERE ttattendance.EmpID = ttdetails.EmpID
        AND UPPER(TRIM(ttattendance.MonthNames)) = UPPER(TRIM(vSelectedMonth))
        AND STRING(ttattendance.YEAR) = vSelectedYear
      NO-ERROR.
 
 IF AVAILABLE ttattendance THEN
     DO WITH FRAME FRAME-M:
         ASSIGN //txtmonth:SCREEN-VALUE         = ttattendance.MonthNames
                txtMonthdays:SCREEN-VALUE     = STRING(ttattendance.MonthlyWorkingDays)
                txtemployeedays:SCREEN-VALUE  = STRING(ttattendance.EmployeeWorkingDays)
                txtemployeeleave:SCREEN-VALUE = STRING(ttattendance.TotalLeaves)
               // txtmonth:SENSITIVE           = FALSE
                txtMonthdays:SENSITIVE       = FALSE
                txtemployeedays:SENSITIVE    = FALSE
                txtemployeeleave:SENSITIVE   = FALSE.
     END.
 
 // Load Employee Salary Details (FRAME-I)
 FIND FIRST ttsalary NO-LOCK
      WHERE ttsalary.EmpID       = ttdetails.EmpID
        AND UPPER(TRIM(ttsalary.SALARYMONTH)) = UPPER(TRIM(vSelectedMonth))
        AND STRING(ttsalary.YEAR) = vSelectedYear
      NO-ERROR.
 
 IF AVAILABLE ttsalary THEN
     DO WITH FRAME FRAME-I:
         ASSIGN Txtbank:SCREEN-VALUE   = STRING(ttsalary.EemployeBankNum)
                TxtPan:SCREEN-VALUE    = ttsalary.ITPAN
                TxtUn:SCREEN-VALUE     = STRING(ttsalary.EmployeeUANNum)
                Txtbasic:SCREEN-VALUE  = STRING(ttsalary.BasicSalary)
                txthouse:SCREEN-VALUE  = STRING(ttsalary.HRA)
                txtsp:SCREEN-VALUE     = STRING(ttsalary.SpecialAllowance)
                txtpf:SCREEN-VALUE     = STRING(ttsalary.COMP-OFF-ENCASHMENT)
                txttotal:SCREEN-VALUE  = STRING(ttsalary.TotalEarings)
                txttx:SCREEN-VALUE     = STRING(ttsalary.ProfessionalTax)
                txtd:SCREEN-VALUE      = STRING(ttsalary.ProvidentFund)
                txtgg:SCREEN-VALUE     = STRING(ttsalary.TotalDeducation)
                txtnet:SCREEN-VALUE    = STRING(ttsalary.NetSalaryPaid)
                //txtprovide:SCREEN-VALUE = STRING(ttsalary.ProvidentFund)
 
                Txtbank:SENSITIVE      = FALSE
                TxtPan:SENSITIVE       = FALSE
                TxtUn:SENSITIVE        = FALSE
                Txtbasic:SENSITIVE     = FALSE
                txthouse:SENSITIVE     = FALSE
                txtsp:SENSITIVE        = FALSE
                txtpf:SENSITIVE        = FALSE
                txttx:SENSITIVE        = FALSE
                txtd:SENSITIVE         = FALSE
                txtgg:SENSITIVE        = FALSE
                txtnet:SENSITIVE       = FALSE
                txttotal:SENSITIVE     = FALSE.
               //txtprovide:SENSITIVE   = FALSE.
     END.
 

         END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_SEARCH C-Win 
PROCEDURE P_SEARCH :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/


// not uisng teamp-table --

/* /* --------------------------                                                            */
/*    SEARCH button: find employee by ID + Month                                            */
/*    -------------------------- */                                                         */
/* /*DEF VAR vEmpID         AS INTEGER   NO-UNDO.                                           */
/* DEF VAR vSelectedMonth AS CHARACTER NO-UNDO.  */                                         */
/*                                                                                          */
/* /* --- Get selected month from UI --- */                                                 */
/* vSelectedMonth = TRIM(TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J).                    */
/* IF vSelectedMonth = "" THEN DO:                                                          */
/*     MESSAGE "Please select a month first."                                               */
/*         VIEW-AS ALERT-BOX ERROR BUTTONS OK.                                              */
/*     RETURN.                                                                              */
/* END.                                                                                     */
/*                                                                                          */
/* /* --- Get Employee ID from entry field --- */                                           */
/* vEmpID = INTEGER(txtemployeeid:SCREEN-VALUE IN FRAME FRAME-J).                           */
/* IF vEmpID = 0 THEN DO:                                                                   */
/*     MESSAGE "Please enter a valid Employee ID."                                          */
/*         VIEW-AS ALERT-BOX ERROR BUTTONS OK.                                              */
/*     RETURN.                                                                              */
/* END.                                                                                     */
/*                                                                                          */
/* /* --- Find EmployeeDetails by ID --- */                                                 */
/* FIND EmployeeDetails NO-LOCK                                                             */
/*      WHERE EmployeeDetails.EmpID = vEmpID NO-ERROR.                                      */
/*                                                                                          */
/* IF NOT AVAILABLE EmployeeDetails THEN DO:                                                */
/*     MESSAGE "Employee ID " vEmpID " not found."                                          */
/*         VIEW-AS ALERT-BOX ERROR BUTTONS OK.                                              */
/*     RETURN.                                                                              */
/* END.                                                                                     */
/*                                                                                          */
/* /* --- Check EmployeeMaster (must not be INACTIVE) --- */                                */
/* FIND FIRST EmployeeMaster NO-LOCK                                                        */
/*      WHERE EmployeeMaster.EmpID = EmployeeDetails.EmpID NO-ERROR.                        */
/*                                                                                          */
/* IF NOT AVAILABLE EmployeeMaster                                                          */
/*    OR UPPER(TRIM(EmployeeMaster.EmpStatus)) = "INACTIVE" THEN DO:                        */
/*     MESSAGE "Employee ID " vEmpID " is not active."                                      */
/*         VIEW-AS ALERT-BOX ERROR BUTTONS OK.                                              */
/*     RETURN.                                                                              */
/* END.                                                                                     */
/*                                                                                          */
/* /* --------------------------------------------------------------------------            */
/*    1) Clear Frames                                                                       */
/*    -------------------------------------------------------------------------- */         */
/* DO WITH FRAME FRAME-J:                                                                   */
/*     ASSIGN txtemployeeid:SCREEN-VALUE   = ""                                             */
/*            txtemployeename:SCREEN-VALUE = "".                                            */
/* END.                                                                                     */
/*                                                                                          */
/* DO WITH FRAME FRAME-L:                                                                   */
/*     ASSIGN txtjoindate:SCREEN-VALUE     = ""                                             */
/*            txtdesignation:SCREEN-VALUE  = ""                                             */
/*            txtDepartment:SCREEN-VALUE   = "".                                            */
/* END.                                                                                     */
/*                                                                                          */
/* DO WITH FRAME FRAME-M:                                                                   */
/*     ASSIGN //txtmonth:SCREEN-VALUE        = ""                                           */
/*            txtMonthdays:SCREEN-VALUE    = ""                                             */
/*            txtemployeedays:SCREEN-VALUE = ""                                             */
/*            txtemployeeleave:SCREEN-VALUE= "".                                            */
/* END.                                                                                     */
/*                                                                                          */
/* DO WITH FRAME FRAME-I:                                                                   */
/*     ASSIGN Txtbank:SCREEN-VALUE   = ""                                                   */
/*            TxtPan:SCREEN-VALUE    = ""                                                   */
/*            TxtUn:SCREEN-VALUE     = ""                                                   */
/*            Txtbasic:SCREEN-VALUE  = ""                                                   */
/*            txthouse:SCREEN-VALUE  = ""                                                   */
/*            txtsp:SCREEN-VALUE     = ""                                                   */
/*            txtpf:SCREEN-VALUE     = ""                                                   */
/*            txttotal:SCREEN-VALUE  = ""                                                   */
/*            txttx:SCREEN-VALUE     = ""                                                   */
/*            txtd:SCREEN-VALUE      = ""                                                   */
/*            txtgg:SCREEN-VALUE     = ""                                                   */
/*            txtnet:SCREEN-VALUE    = "".                                                  */
/* END.                                                                                     */
/*                                                                                          */
/* /* --------------------------------------------------------------------------            */
/*    2) Load EmployeeDetails (FRAME-J)                                                     */
/*    -------------------------------------------------------------------------- */         */
/* DO WITH FRAME FRAME-J:                                                                   */
/*     ASSIGN txtemployeeid:SCREEN-VALUE   = STRING(EmployeeDetails.EmpID)                  */
/*            txtemployeename:SCREEN-VALUE = EmployeeDetails.EmpName                        */
/*            txtemployeeid:SENSITIVE      = TRUE                                           */
/*            txtemployeename:SENSITIVE    = FALSE.                                         */
/* END.                                                                                     */
/*                                                                                          */
/* /* --------------------------------------------------------------------------            */
/*    3) Load EmployeeMaster (FRAME-L)                                                      */
/*    -------------------------------------------------------------------------- */         */
/* IF AVAILABLE EmployeeMaster THEN                                                         */
/* DO WITH FRAME FRAME-L:                                                                   */
/*     ASSIGN txtjoindate:SCREEN-VALUE    = STRING(EmployeeMaster.DOJ)                      */
/*            txtdesignation:SCREEN-VALUE = EmployeeMaster.Designation                      */
/*            txtDepartment:SCREEN-VALUE  = EmployeeMaster.Department                       */
/*                                                                                          */
/*            txtjoindate:SENSITIVE       = FALSE                                           */
/*            txtdesignation:SENSITIVE    = FALSE                                           */
/*            txtDepartment:SENSITIVE     = FALSE.                                          */
/* END.                                                                                     */
/*                                                                                          */
/* /* --------------------------------------------------------------------------            */
/*    4) Load Employee Attendance (FRAME-M) filtered by month                               */
/*    -------------------------------------------------------------------------- */         */
/* FIND FIRST EMPLOYEEATTENADCE NO-LOCK                                                     */
/*      WHERE EMPLOYEEATTENADCE.EmpID = EmployeeDetails.EmpID                               */
/*        AND UPPER(TRIM(EMPLOYEEATTENADCE.MonthNames)) = UPPER(TRIM(vSelectedMonth))       */



/* DO WITH FRAME FRAME-M:                                                                   */

/*            txtMonthdays:SCREEN-VALUE     = STRING(EMPLOYEEATTENADCE.MonthlyWorkingDays)  */
/*            txtemployeedays:SCREEN-VALUE  = STRING(EMPLOYEEATTENADCE.EmployeeWorkingDays) */
/*            txtemployeeleave:SCREEN-VALUE = STRING(EMPLOYEEATTENADCE.TotalLeaves)         */

/*            //txtmonth:SENSITIVE            = FALSE                                       */

/*            txtemployeedays:SENSITIVE     = FALSE                                         */



/* /* --------------------------------------------------------------------------            */
/*    5) Load Employee Salary Details (FRAME-I) filtered by SALARYMONTH                     */
/*    -------------------------------------------------------------------------- */         */

/*      WHERE EmployeeSalarysDetails.EmpID = EmployeeDetails.EmpID                          */
/*        AND UPPER(TRIM(EmployeeSalarysDetails.SALARYMONTH)) = UPPER(TRIM(vSelectedMonth)) */




/*     ASSIGN Txtbank:SCREEN-VALUE   = STRING(EmployeeSalarysDetails.EemployeBankNum)       */
/*            TxtPan:SCREEN-VALUE    = STRING(EmployeeSalarysDetails.ITPAN)                 */
/*            TxtUn:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.EmployeeUANNum)        */
/*            Txtbasic:SCREEN-VALUE  = STRING(EmployeeSalarysDetails.BasicSalary)           */

/*            txtsp:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.SpecialAllowance)      */
/*            txtpf:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.COMP-OFF-ENCASHMENT)   */
/*            txttotal:SCREEN-VALUE  = STRING(EmployeeSalarysDetails.TotalEarings)          */
/*            txttx:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.ProfessionalTax)       */
/*            txtd:SCREEN-VALUE      = STRING(EmployeeSalarysDetails.ProvidentFund)         */
/*            txtgg:SCREEN-VALUE     = STRING(EmployeeSalarysDetails.TotalDeducation)       */
/*            txtnet:SCREEN-VALUE    = STRING(EmployeeSalarysDetails.NetSalaryPaid)         */



/*            TxtUn:SENSITIVE        = FALSE                                                */

/*            txthouse:SENSITIVE     = FALSE                                                */

/*            txtpf:SENSITIVE        = FALSE                                                */


/*            txtgg:SENSITIVE        = FALSE                                                */

/*            txttotal:SENSITIVE     = FALSE.                                               */




// ------------------------------------teamp-table uisng code

/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

/* --------------------------
   SEARCH button: find employee by ID + Month
   -------------------------- */
/*DEF VAR vEmpID         AS INTEGER   NO-UNDO.
DEF VAR vSelectedMonth AS CHARACTER NO-UNDO.  */

/* --- Get selected month from UI --- */
vSelectedMonth = TRIM(TXTSALARYMONTHS:SCREEN-VALUE IN FRAME FRAME-J).
IF vSelectedMonth = "" THEN DO:
    MESSAGE "Please select a month first."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.

/* --- Get Employee ID from entry field --- */
vEmpID = INTEGER(txtemployeeid:SCREEN-VALUE IN FRAME FRAME-J).
IF vEmpID = 0 THEN DO:
    MESSAGE "Please enter a valid Employee ID."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.

/* --- Find ttdetails by ID --- */
FIND ttdetails NO-LOCK
     WHERE ttdetails.EmpID = vEmpID NO-ERROR.

IF NOT AVAILABLE ttdetails THEN DO:
    MESSAGE "Employee ID " vEmpID " not found."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.

/* --- Check ttadmin (must not be INACTIVE) --- */
FIND FIRST ttadmin NO-LOCK
     WHERE ttadmin.EmpID = ttdetails.EmpID NO-ERROR.

IF NOT AVAILABLE ttadmin 
   OR UPPER(TRIM(ttadmin.EmpStatus)) = "INACTIVE" THEN DO:
    MESSAGE "Employee ID " vEmpID " is not active."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.

/* --------------------------------------------------------------------------
   1) Clear Frames
   -------------------------------------------------------------------------- */
DO WITH FRAME FRAME-J:
    ASSIGN txtemployeeid:SCREEN-VALUE   = ""
           txtemployeename:SCREEN-VALUE = "".
END.

DO WITH FRAME FRAME-L:
    ASSIGN txtjoindate:SCREEN-VALUE     = ""
           txtdesignation:SCREEN-VALUE  = ""
           txtDepartment:SCREEN-VALUE   = "".
END.

DO WITH FRAME FRAME-M:
    ASSIGN //txtmonth:SCREEN-VALUE        = ""
           txtMonthdays:SCREEN-VALUE    = ""
           txtemployeedays:SCREEN-VALUE = ""
           txtemployeeleave:SCREEN-VALUE= "".
END.

DO WITH FRAME FRAME-I:
    ASSIGN Txtbank:SCREEN-VALUE   = ""
           TxtPan:SCREEN-VALUE    = ""
           TxtUn:SCREEN-VALUE     = ""
           Txtbasic:SCREEN-VALUE  = ""
           txthouse:SCREEN-VALUE  = ""
           txtsp:SCREEN-VALUE     = ""
           txtpf:SCREEN-VALUE     = ""
           txttotal:SCREEN-VALUE  = ""
           txttx:SCREEN-VALUE     = ""
           txtd:SCREEN-VALUE      = ""
           txtgg:SCREEN-VALUE     = ""
           txtnet:SCREEN-VALUE    = "".
END.

/* --------------------------------------------------------------------------
   2) Load ttdetails (FRAME-J)
   -------------------------------------------------------------------------- */
DO WITH FRAME FRAME-J:
    ASSIGN txtemployeeid:SCREEN-VALUE   = STRING(ttdetails.EmpID)
           txtemployeename:SCREEN-VALUE = ttdetails.EmpName
           txtemployeeid:SENSITIVE      = TRUE
           txtemployeename:SENSITIVE    = FALSE.
END.

/* --------------------------------------------------------------------------
   3) Load ttadmin (FRAME-L)
   -------------------------------------------------------------------------- */
IF AVAILABLE ttadmin THEN
DO WITH FRAME FRAME-L:
    ASSIGN txtjoindate:SCREEN-VALUE    = STRING(ttadmin.DOJ)
           txtdesignation:SCREEN-VALUE = ttadmin.Designation
           txtDepartment:SCREEN-VALUE  = ttadmin.Department

           txtjoindate:SENSITIVE       = FALSE
           txtdesignation:SENSITIVE    = FALSE
           txtDepartment:SENSITIVE     = FALSE.
END.

/* --------------------------------------------------------------------------
   4) Load Employee Attendance (FRAME-M) filtered by month
   -------------------------------------------------------------------------- */
FIND FIRST ttattendance NO-LOCK
     WHERE ttattendance.EmpID = ttdetails.EmpID
       AND UPPER(TRIM(ttattendance.MonthNames)) = UPPER(TRIM(vSelectedMonth))
     NO-ERROR.

IF AVAILABLE ttattendance THEN
DO WITH FRAME FRAME-M:
    ASSIGN //txtmonth:SCREEN-VALUE         = ttattendance.MonthNames
           txtMonthdays:SCREEN-VALUE     = STRING(ttattendance.MonthlyWorkingDays)
           txtemployeedays:SCREEN-VALUE  = STRING(ttattendance.EmployeeWorkingDays)
           txtemployeeleave:SCREEN-VALUE = STRING(ttattendance.TotalLeaves)

           //txtmonth:SENSITIVE            = FALSE
           txtMonthdays:SENSITIVE        = FALSE
           txtemployeedays:SENSITIVE     = FALSE
           txtemployeeleave:SENSITIVE    = FALSE.
END.

/* --------------------------------------------------------------------------
   5) Load Employee Salary Details (FRAME-I) filtered by SALARYMONTH
   -------------------------------------------------------------------------- */
FIND FIRST ttsalary NO-LOCK
     WHERE ttsalary.EmpID = ttdetails.EmpID
       AND UPPER(TRIM(ttsalary.SALARYMONTH)) = UPPER(TRIM(vSelectedMonth))
     NO-ERROR.

IF AVAILABLE ttsalary THEN
DO WITH FRAME FRAME-I:
    ASSIGN Txtbank:SCREEN-VALUE   = STRING(ttsalary.EemployeBankNum)
           TxtPan:SCREEN-VALUE    = STRING(ttsalary.ITPAN)
           TxtUn:SCREEN-VALUE     = STRING(ttsalary.EmployeeUANNum)
           Txtbasic:SCREEN-VALUE  = STRING(ttsalary.BasicSalary)
           txthouse:SCREEN-VALUE  = STRING(ttsalary.HRA)
           txtsp:SCREEN-VALUE     = STRING(ttsalary.SpecialAllowance)
           txtpf:SCREEN-VALUE     = STRING(ttsalary.COMP-OFF-ENCASHMENT)
           txttotal:SCREEN-VALUE  = STRING(ttsalary.TotalEarings)
           txttx:SCREEN-VALUE     = STRING(ttsalary.ProfessionalTax)
           txtd:SCREEN-VALUE      = STRING(ttsalary.ProvidentFund)
           txtgg:SCREEN-VALUE     = STRING(ttsalary.TotalDeducation)
           txtnet:SCREEN-VALUE    = STRING(ttsalary.NetSalaryPaid)

           Txtbank:SENSITIVE      = FALSE
           TxtPan:SENSITIVE       = FALSE
           TxtUn:SENSITIVE        = FALSE
           Txtbasic:SENSITIVE     = FALSE
           txthouse:SENSITIVE     = FALSE
           txtsp:SENSITIVE        = FALSE
           txtpf:SENSITIVE        = FALSE
           txttx:SENSITIVE        = FALSE
           txtd:SENSITIVE         = FALSE
           txtgg:SENSITIVE        = FALSE
           txtnet:SENSITIVE       = FALSE
           txttotal:SENSITIVE     = FALSE.
END.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

