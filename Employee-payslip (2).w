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
DEFINE VARIABLE vSelectedYear      AS CHAR   NO-UNDO.
DEFINE VARIABLE vSelectedMonth     AS CHARACTER NO-UNDO.
DEFINE VARIABLE vTXTFile           AS CHARACTER NO-UNDO.
DEFINE VARIABLE vToday             AS CHARACTER NO-UNDO.
DEFINE VARIABLE cPaymentStatus     AS CHARACTER NO-UNDO.
DEFINE VARIABLE vEmpName           AS CHARACTER NO-UNDO.
DEFINE VARIABLE vMonthlyDays       AS INTEGER   NO-UNDO.
DEFINE VARIABLE vEmpWorkingDays    AS INTEGER   NO-UNDO.
DEFINE VARIABLE vTotalEarnings     AS DECIMAL   NO-UNDO.
DEFINE VARIABLE vTotalDeducation   AS DECIMAL   NO-UNDO.
DEFINE VARIABLE vLOPAmount         AS DECIMAL   NO-UNDO.
DEFINE VARIABLE vNetSalary         AS DECIMAL   NO-UNDO.
DEFINE VARIABLE iCount             AS INTEGER   NO-UNDO.
DEFINE VARIABLE vTotalMonthPay     AS DECIMAL   NO-UNDO.
DEFINE VARIABLE activeEmpCount     AS INTEGER   NO-UNDO.
DEFINE VARIABLE vProvidentFund     AS DECIMAL   NO-UNDO.
DEFINE VARIABLE vProfessionalTax   AS DECIMAL   NO-UNDO.
DEFINE VARIABLE opRes AS CHARACTER NO-UNDO.

/* Bank Transfer Details */
DEFINE VARIABLE vPaymentMode AS CHARACTER NO-UNDO INIT "Bank Transfer".
DEFINE VARIABLE vBankName    AS CHARACTER NO-UNDO INIT "Axis Bank".
DEFINE VARIABLE vUTRNo       AS CHARACTER NO-UNDO.
DEFINE VARIABLE vPayDate     AS DATE      NO-UNDO.

DEFINE TEMP-TABLE ttadmin       LIKE EmployeeMaster.
DEFINE TEMP-TABLE ttdetails     LIKE EmployeeDetails.
DEFINE TEMP-TABLE ttattendance  LIKE EMPLOYEEATTENADCE.
DEFINE TEMP-TABLE ttsalary      LIKE EmployeeSalarysDetails.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frpayslip

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-56 RECT-72 RECT-73 RECT-74 IMAGE-94 ~
RECT-75 IMAGE-96 IMAGE-97 txtback cbMonth cbYear TXTGENERATE BTSBANK ~
txtviewpayslip btnemail 
&Scoped-Define DISPLAYED-OBJECTS cbMonth cbYear 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VARIABLE C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnemail 
     LABEL "EMAIL" 
     SIZE 40 BY 1.19
     FONT 6.

DEFINE BUTTON BTSBANK 
     LABEL "BANKING RELATED REPORTS" 
     SIZE 40 BY 1.14
     FONT 6.

DEFINE BUTTON txtback 
     LABEL "BACK" 
     SIZE 15 BY 1.14
     BGCOLOR 11 FONT 6.

DEFINE BUTTON TXTGENERATE 
     LABEL "GENERATE PAYROLL" 
     SIZE 41 BY 1.14
     FONT 6.

DEFINE BUTTON txtviewpayslip 
     LABEL "VIEW PAYSLIP'S" 
     SIZE 40 BY 1.19
     FONT 6.

DEFINE VARIABLE cbMonth AS CHARACTER FORMAT "X(256)":U 
     LABEL "SALARY MONTH" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","January","February","March","April","May","June","July","August","September","October","November","December" 
     DROP-DOWN-LIST
     SIZE 18 BY 1
     FGCOLOR 15 FONT 6 NO-UNDO.

DEFINE VARIABLE cbYear AS CHARACTER FORMAT "X(256)":U 
     LABEL "YEAR" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","2025","2026","2027","2028","2029" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     FONT 6 NO-UNDO.

DEFINE IMAGE IMAGE-94
     FILENAME "C:/Users/sriharsha.c/Downloads/gemini_generated_image_egdnr5egdnr5egdn.png":U
     STRETCH-TO-FIT
     SIZE 70 BY 27.29.

DEFINE IMAGE IMAGE-96
     FILENAME "C:/Users/sriharsha.c/Downloads/payslip2.png":U
     STRETCH-TO-FIT
     SIZE 70 BY 12.62.

DEFINE IMAGE IMAGE-97
     FILENAME "C:/Users/sriharsha.c/Downloads/gemini_generated_image_llf3hnllf3hnllf3.png":U
     STRETCH-TO-FIT
     SIZE 17.4 BY 2.38.

DEFINE RECTANGLE RECT-56
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 73 BY 27.62
     BGCOLOR 0 FGCOLOR 7 .

DEFINE RECTANGLE RECT-72
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 71 BY 1.67.

DEFINE RECTANGLE RECT-73
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 71 BY 1.67.

DEFINE RECTANGLE RECT-74
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 71 BY 1.67.

DEFINE RECTANGLE RECT-75
     EDGE-PIXELS 2 GRAPHIC-EDGE  NO-FILL   
     SIZE 71 BY 1.91.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frpayslip
     txtback AT ROW 1.29 COL 1.8 WIDGET-ID 10
     cbMonth AT ROW 10.57 COL 121.2 COLON-ALIGNED WIDGET-ID 6
     cbYear AT ROW 10.62 COL 80.8 COLON-ALIGNED WIDGET-ID 38
     TXTGENERATE AT ROW 13.38 COL 86 WIDGET-ID 8
     BTSBANK AT ROW 15.24 COL 87 WIDGET-ID 36
     txtviewpayslip AT ROW 17.14 COL 87 WIDGET-ID 34
     btnemail AT ROW 19.1 COL 87 WIDGET-ID 56
     "ATOMATIC-- PAYROLL--GENERATION" VIEW-AS TEXT
          SIZE 44 BY .62 AT ROW 15.38 COL 21.8 WIDGET-ID 52
          BGCOLOR 0 FGCOLOR 7 
     "ONE-CLICK REPORTS GENERATION" VIEW-AS TEXT
          SIZE 41.6 BY .62 AT ROW 19.05 COL 6.4 WIDGET-ID 50
          BGCOLOR 0 FGCOLOR 7 
     "SECURED DATA AND PRIVACY" VIEW-AS TEXT
          SIZE 39 BY .62 AT ROW 25.62 COL 24.2 WIDGET-ID 48
          BGCOLOR 0 FGCOLOR 7 
     RECT-56 AT ROW 1 COL 71 WIDGET-ID 32
     RECT-72 AT ROW 13.14 COL 72 WIDGET-ID 40
     RECT-73 AT ROW 15.05 COL 72 WIDGET-ID 42
     RECT-74 AT ROW 16.91 COL 72 WIDGET-ID 44
     IMAGE-94 AT ROW 1 COL 1 WIDGET-ID 46
     RECT-75 AT ROW 18.81 COL 72 WIDGET-ID 58
     IMAGE-96 AT ROW 1 COL 1 WIDGET-ID 62
     IMAGE-97 AT ROW 24.81 COL 6 WIDGET-ID 64
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1
         SIZE 145 BY 27.67
         BGCOLOR 0 FGCOLOR 7  WIDGET-ID 100.


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
         TITLE              = "EMPLOYEE PLAYSLIP-VIEW"
         HEIGHT             = 27.38
         WIDTH              = 143.2
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
/* SETTINGS FOR FRAME frpayslip
   FRAME-NAME                                                           */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* EMPLOYEE PLAYSLIP-VIEW */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* EMPLOYEE PLAYSLIP-VIEW */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnemail
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnemail C-Win
ON CHOOSE OF btnemail IN FRAME frpayslip /* EMAIL */
DO:
  RUN p_email.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTSBANK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTSBANK C-Win
ON CHOOSE OF BTSBANK IN FRAME frpayslip /* BANKING RELATED REPORTS */
DO:
  RUN P_BANK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME txtback
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL txtback C-Win
ON CHOOSE OF txtback IN FRAME frpayslip /* BACK */
DO:
  APPLY "CLOSE" TO THIS-PROCEDURE.   
  RUN  DASH1-BOARD.W.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME TXTGENERATE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL TXTGENERATE C-Win
ON CHOOSE OF TXTGENERATE IN FRAME frpayslip /* GENERATE PAYROLL */
DO:
  RUN p_generate.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME txtviewpayslip
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL txtviewpayslip C-Win
ON CHOOSE OF txtviewpayslip IN FRAME frpayslip /* VIEW PAYSLIP'S */
DO:
  APPLY "close" TO THIS-PROCEDURE.
  RUN Pay_roll.w.
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
  
  RUN  GetEmployeePayslip.p (
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
      WITH FRAME frpayslip IN WINDOW C-Win.
  ENABLE RECT-56 RECT-72 RECT-73 RECT-74 IMAGE-94 RECT-75 IMAGE-96 IMAGE-97 
         txtback cbMonth cbYear TXTGENERATE BTSBANK txtviewpayslip btnemail 
      WITH FRAME frpayslip IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frpayslip}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_BANK C-Win 
PROCEDURE P_BANK :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
vSelectedMonth = TRIM(UPPER(cbMonth:SCREEN-VALUE IN FRAME {&FRAME-NAME})).
IF vSelectedMonth = "" OR vSelectedMonth = ? THEN DO:
    MESSAGE "Please select month." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.
 
// selected year from UI 
vSelectedYear = TRIM(cbYear:SCREEN-VALUE IN FRAME {&FRAME-NAME}).
IF vSelectedYear = "" OR vSelectedYear = ? THEN DO:
    MESSAGE "Please select year." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.
 
// Prepare TXT file path 
vTXTFile = "C:\Main_Project\PAYROLL\Bank_reports\BankReport_" 
         + REPLACE(vSelectedMonth, " ", "_") + "_" + vSelectedYear + ".txt".
 
// Today's date for footer 
vToday = STRING(DAY(TODAY), "99") + "-"
       + CAPS(ENTRY(MONTH(TODAY),
       "JANUARY,FEBRUARY,MARCH,APRIL,MAY,JUNE,JULY,AUGUST,SEPTEMBER,OCTOBER,NOVEMBER,DECEMBER")) 
       + "-" + STRING(YEAR(TODAY)).
 
//Calculate Payment Date (salary paid on 4th of next month) 
DEFINE VARIABLE iMonthNum AS INTEGER NO-UNDO.
iMonthNum = LOOKUP(vSelectedMonth, "JANUARY,FEBRUARY,MARCH,APRIL,MAY,JUNE,JULY,AUGUST,SEPTEMBER,OCTOBER,NOVEMBER,DECEMBER").
vPayDate = DATE(4, iMonthNum + 1, INTEGER(vSelectedYear)).
IF iMonthNum = 12 THEN // December -> next year January 
    vPayDate = DATE(4, 1, INTEGER(vSelectedYear) + 1).
 
//  If 4th is holiday (Sat/Sun), shift to previous working day 
IF WEEKDAY(vPayDate) = 1 THEN // Sunday 
    vPayDate = vPayDate - 2.
ELSE IF WEEKDAY(vPayDate) = 7 THEN // Saturday 
    vPayDate = vPayDate - 1.
 
// Open TXT file 
OUTPUT TO VALUE(vTXTFile).
 
// Header 
PUT UNFORMATTED 
    FILL(" ", 25) + "                BANK SALARY REPORT - " 
    + vSelectedMonth + "-" + vSelectedYear SKIP
    FILL("-", 145) SKIP
    "Employee Id    EmployeeName                   BankAccount        IFSC                   NetSalaryPaid      PaymentStatus              UTRNO" SKIP
    FILL("-", 145) SKIP.
 
// Initialize counters 
iCount = 0.
vTotalMonthPay = 0.
 
// Loop Active employees with salary + attendance for selected month & year 
FOR EACH ttadmin NO-LOCK 
    WHERE ttadmin.EmpStatus = "ACTIVE",
    EACH ttsalary NO-LOCK 
    WHERE ttsalary.EmpId = ttadmin.EmpId
      AND CAPS(ttsalary.SalaryMonth) = vSelectedMonth
      AND STRING(ttsalary.Year) = vSelectedYear,
    EACH ttattendance NO-LOCK 
    WHERE ttattendance.EmpId = ttadmin.EmpId
      AND CAPS(ttattendance.MonthNames) = vSelectedMonth
      AND STRING(ttattendance.Year) = vSelectedYear,
    EACH ttdetails NO-LOCK 
    WHERE ttdetails.EmpId = ttadmin.EmpId:
 
 
    /* Payment status */
DEFINE VARIABLE vIFSC   AS CHARACTER NO-UNDO.
DEFINE VARIABLE vChar1  AS INTEGER   NO-UNDO.
 
vIFSC = TRIM(ttsalary.EmployeeIFCCode).
 
/* Default = Not Paid */
cPaymentStatus = "Not Paid".
 
IF vIFSC <> ? AND vIFSC <> "" THEN DO:
    vChar1 = ASC(UPPER(SUBSTRING(vIFSC, 1, 1))).
 
    /* If first char is A-Z only then allow Paid */
    IF vChar1 >= 65 AND vChar1 <= 90 THEN DO:
        IF ttsalary.NetSalaryPaid > 0 THEN
            cPaymentStatus = "Paid".
    END.
END.
    /* Generate unique UTR per employee */
    DEFINE VARIABLE vUTRNo AS CHARACTER NO-UNDO.
    vUTRNo = "AXIS" + vSelectedYear + STRING(iMonthNum,"99") + STRING(ttsalary.EmpId,"9999").
DEFINE VARIABLE vIFSCStart   AS CHARACTER NO-UNDO. /* optional, can remove */
DEFINE VARIABLE vIFSCEnd     AS CHARACTER NO-UNDO. /* optional, can remove */
DEFINE VARIABLE vMaskedIFSC  AS CHARACTER NO-UNDO.
DEFINE VARIABLE vLength      AS INTEGER   NO-UNDO.
 
vIFSC = ttsalary.EmployeeIFCCode.
vLength = LENGTH(vIFSC).
 
IF vLength > 6 THEN
    vMaskedIFSC = SUBSTRING(vIFSC, 1, 3) + FILL("*", vLength - 6) + SUBSTRING(vIFSC, vLength - 2, 3).
ELSE
    vMaskedIFSC = vIFSC. /* if length <= 6, do not mask */
 

    /* Mask UTR */
    DEFINE VARIABLE vUTRStart AS CHARACTER NO-UNDO.
    DEFINE VARIABLE vUTREnd   AS CHARACTER NO-UNDO.
    DEFINE VARIABLE vMaskedUTR AS CHARACTER NO-UNDO.
    vUTREnd   = SUBSTRING(vUTRNo, LENGTH(vUTRNo) - 3, 4).
    vUTRStart = FILL("*", LENGTH(vUTRNo) - 4).
    vMaskedUTR = vUTRStart + vUTREnd.
    /* ----------------- Masking End ----------------- */
    /* Report line */
    PUT UNFORMATTED
        STRING(ttsalary.EmpId) + "            "
        + STRING(ttdetails.EmpName,"x(30)") + " "
        + STRING(ttsalary.EemployeBankNum,"x(15)") + " "
        + STRING(vMaskedIFSC,"x(20)") + " "
        + FILL(" ",1)
        + STRING(ttsalary.NetSalaryPaid, "->>>,>>>,>>9.99") + "            "
        + STRING(cPaymentStatus, "x(12)") + "         " 
        + vMaskedUTR SKIP.
    // Totals 
    iCount = iCount + 1.
    vTotalMonthPay = vTotalMonthPay + ttsalary.NetSalaryPaid.
END.
 
// Footer 
PUT UNFORMATTED 
    FILL("-", 145) SKIP
    "Total Employees in report: " + STRING(iCount) SKIP
    "Total Salary for " + vSelectedMonth + "-" + vSelectedYear + ": " 
     + STRING(vTotalMonthPay, "->>,>>9.99") SKIP
    "Payment Mode : " + vPaymentMode SKIP
    "Bank Name    : " + vBankName SKIP
    "Payment Date On: " + vToday SKIP.
   // "Payment Date : " + STRING(vPayDate,"99-XXX-9999") SKIP.
 
OUTPUT CLOSE.
 
IF iCount = 0 THEN DO:
    OS-DELETE VALUE(vTXTFile).
    MESSAGE "No salary records for " vSelectedMonth + "-" + vSelectedYear
        VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END.
ELSE
    MESSAGE "Bank payment file generated: " vTXTFile
        VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_email C-Win 
PROCEDURE p_email :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE cFrom        AS CHARACTER NO-UNDO INIT "sriharshabobbi52@gmail.com".
DEFINE VARIABLE cPassword    AS CHARACTER NO-UNDO INIT "dsbw yiau dlkj bqfo".  /* Gmail App Password */
DEFINE VARIABLE cCC          AS CHARACTER NO-UNDO.
DEFINE VARIABLE cBCC         AS CHARACTER NO-UNDO.
DEFINE VARIABLE cBody        AS CHARACTER NO-UNDO.
DEFINE VARIABLE cSubject     AS CHARACTER NO-UNDO.
DEFINE VARIABLE cFilePath    AS CHARACTER NO-UNDO.
DEFINE VARIABLE vSelectedMonth AS CHARACTER NO-UNDO.
DEFINE VARIABLE vSelectedYear  AS INTEGER   NO-UNDO.
DEFINE VARIABLE vToday         AS CHARACTER NO-UNDO.
DEFINE VARIABLE vEmpName       AS CHARACTER NO-UNDO.
DEFINE VARIABLE vEmpMail       AS CHARACTER NO-UNDO.
DEFINE VARIABLE vMonthlyDays   AS INTEGER   NO-UNDO.
DEFINE VARIABLE vEmpWorkingDays AS INTEGER  NO-UNDO.
DEFINE VARIABLE vTotalEarnings   AS DECIMAL NO-UNDO.
DEFINE VARIABLE vTotalDeducation AS DECIMAL NO-UNDO.
DEFINE VARIABLE vLOPAmount       AS DECIMAL NO-UNDO.
DEFINE VARIABLE vNetSalary       AS DECIMAL NO-UNDO.
DEFINE VARIABLE vBodyText        AS LONGCHAR NO-UNDO.
DEFINE VARIABLE cLine            AS CHARACTER NO-UNDO.
DEFINE VARIABLE i                AS INTEGER   NO-UNDO.
DEFINE VARIABLE vCount           AS INTEGER   NO-UNDO INITIAL 0.

/* .NET mail objects */
DEFINE VARIABLE oClient  AS System.Net.Mail.SmtpClient        NO-UNDO.
DEFINE VARIABLE oMessage AS System.Net.Mail.MailMessage       NO-UNDO.
DEFINE VARIABLE oAttach  AS System.Net.Mail.Attachment        NO-UNDO.
DEFINE VARIABLE oCred    AS System.Net.NetworkCredential      NO-UNDO.
DEFINE VARIABLE fromAddr AS System.Net.Mail.MailAddress       NO-UNDO.
DEFINE VARIABLE toAddr   AS System.Net.Mail.MailAddress       NO-UNDO.

/* Get month and year from screen */
ASSIGN
    vSelectedMonth = TRIM(UPPER(cbMonth:SCREEN-VALUE IN FRAME {&FRAME-NAME}))
    vSelectedYear  = INTEGER(cbYear:SCREEN-VALUE IN FRAME {&FRAME-NAME}).

IF vSelectedMonth = "" OR vSelectedMonth = ? THEN DO:
    MESSAGE "Please select month name." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

IF vSelectedYear = ? OR vSelectedYear = 0 THEN DO:
    MESSAGE "Please select year." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* Configure Gmail Client */
ASSIGN
    oCred               = NEW System.Net.NetworkCredential(cFrom, cPassword)
    oClient             = NEW System.Net.Mail.SmtpClient("smtp.gmail.com", 587)
    oClient:EnableSsl   = TRUE
    oClient:UseDefaultCredentials = FALSE
    oClient:Credentials = oCred
    fromAddr            = NEW System.Net.Mail.MailAddress(cFrom).

/* Get current date string */
ASSIGN
    vToday = STRING(DAY(TODAY),"99") + "-"
           + CAPS(ENTRY(MONTH(TODAY),"JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC"))
           + "-" + STRING(YEAR(TODAY)).

/* Iterate through active employees */
FOR EACH EmployeeDetails NO-LOCK,
    EACH EmployeeMaster NO-LOCK
        WHERE EmployeeMaster.EmpID = EmployeeDetails.EmpID
          AND EmployeeMaster.EmpStatus = "ACTIVE":

    ASSIGN
        vEmpName         = EmployeeDetails.EmpName
        vEmpMail         = TRIM(EmployeeDetails.EMail)
        vMonthlyDays     = 0
        vEmpWorkingDays  = 0
        vTotalEarnings   = 0
        vTotalDeducation = 0
        vLOPAmount       = 0
        vNetSalary       = 0
        vBodyText        = "".

    FIND EmployeeSalarysDetails NO-LOCK
         WHERE EmployeeSalarysDetails.EmpID = EmployeeDetails.EmpID
           AND CAPS(EmployeeSalarysDetails.SALARYMONTH) = CAPS(vSelectedMonth)
         NO-ERROR.

    FIND EMPLOYEEATTENADCE NO-LOCK
         WHERE EMPLOYEEATTENADCE.EmpID = EmployeeDetails.EmpID
           AND CAPS(EMPLOYEEATTENADCE.MonthNames) = CAPS(vSelectedMonth)
         NO-ERROR.

    IF AVAILABLE EmployeeSalarysDetails AND AVAILABLE EMPLOYEEATTENADCE THEN DO:
        ASSIGN
            vMonthlyDays     = EMPLOYEEATTENADCE.MonthlyWorkingDays
            vEmpWorkingDays  = EMPLOYEEATTENADCE.EmployeeWorkingDays
            vTotalEarnings   = EmployeeSalarysDetails.TotalEarings
            vTotalDeducation = EmployeeSalarysDetails.TotalDeducation
            vLOPAmount       = (vMonthlyDays - vEmpWorkingDays) * (vTotalEarnings / vMonthlyDays)
            vNetSalary       = vTotalEarnings - vLOPAmount - vTotalDeducation.
        IF vNetSalary < 0 THEN vNetSalary = 0.
    END.

    /* Build separator line */
    ASSIGN cLine = "".
    DO i = 1 TO 50:
        cLine = cLine + "-".
    END.

    /* Build payslip body */
    IF vTotalEarnings = 0 THEN
        vBodyText =
            "*** PAY SLIP REPORT - " + vSelectedMonth + " " + STRING(vSelectedYear) + " ***" + CHR(10)
            + "Generated on: " + vToday + CHR(10)
            + cLine + CHR(10)
            + "Employee ID   : " + STRING(EmployeeDetails.EmpID) + CHR(10)
            + "Employee Name : " + vEmpName + CHR(10)
            + "Designation   : " + EmployeeMaster.Designation + CHR(10)
            + "Department    : " + EmployeeMaster.Department + CHR(10)
            + cLine + CHR(10)
            + "Payslip not available for this month." + CHR(10).
    ELSE
        vBodyText =
            "*** PAY SLIP REPORT - " + vSelectedMonth + " " + STRING(vSelectedYear) + " ***" + CHR(10)
            + "Generated on: " + vToday + CHR(10)
            + cLine + CHR(10)
            + "Employee ID   : " + STRING(EmployeeDetails.EmpID) + CHR(10)
            + "Employee Name : " + vEmpName + CHR(10)
            + "Designation   : " + EmployeeMaster.Designation + CHR(10)
            + "Department    : " + EmployeeMaster.Department + CHR(10)
            + cLine + CHR(10)
            + "Total Working Days      : " + STRING(vMonthlyDays) + CHR(10)
            + "Employee Working Days   : " + STRING(vEmpWorkingDays) + CHR(10)
            + "Employee Leaves         : " + STRING(vMonthlyDays - vEmpWorkingDays) + CHR(10)
            + cLine + CHR(10)
            + "Basic Salary     : " + STRING(EmployeeSalarysDetails.BasicSalary,"->>,>>>,>>9") + CHR(10)
            + "HRA              : " + STRING(EmployeeSalarysDetails.HRA,"->>,>>>,>>9") + CHR(10)
            + "Special Allowance: " + STRING(EmployeeSalarysDetails.SpecialAllowance,"->>,>>>,>>9") + CHR(10)
            + "Total Earnings   : " + STRING(vTotalEarnings,"->>,>>>,>>9") + CHR(10)
            + "Deductions       : " + STRING(vTotalDeducation,"->>,>>>,>>9") + CHR(10)
            + "LOP Amount       : " + STRING(vLOPAmount,"->>,>>>,>>9") + CHR(10)
            + "Net Salary       : " + STRING(vNetSalary,"->>,>>>,>>9") + CHR(10)
            + cLine + CHR(10).

    /* Save payslip file */
    ASSIGN cFilePath = "C:\Temp\Payslip_" + STRING(EmployeeDetails.EmpID) + "_" 
                     + CAPS(vSelectedMonth) + "_" + STRING(vSelectedYear) + ".txt".
    COPY-LOB FROM vBodyText TO FILE cFilePath.

    /* Send mail only if email available */
    IF vEmpMail <> "" THEN DO:
        ASSIGN
            toAddr     = NEW System.Net.Mail.MailAddress(vEmpMail)
            oMessage   = NEW System.Net.Mail.MailMessage(fromAddr, toAddr)
            cSubject   = SUBSTITUTE("Pay Slip - &1 &2", vSelectedMonth, STRING(vSelectedYear))
            cBody      = "Dear " + vEmpName + "," + CHR(10)
                       + "Please find attached your payslip for " + vSelectedMonth + " " + STRING(vSelectedYear) + "." + CHR(10) + CHR(10)
                       + "Regards," + CHR(10) + "Payroll Team.".

        ASSIGN
            oMessage:Subject = cSubject
            oMessage:Body    = cBody.

        IF TRIM(cCC) <> "" THEN oMessage:CC:Add(cCC).
        IF TRIM(cBCC) <> "" THEN oMessage:Bcc:Add(cBCC).

        IF SEARCH(cFilePath) <> ? THEN DO:
            oAttach = NEW System.Net.Mail.Attachment(cFilePath).
            oMessage:Attachments:Add(oAttach).
        END.

        oClient:Send(oMessage).
        vCount = vCount + 1.  /* ? count successfully sent emails */

        /* Remove per-email popup */
        DELETE OBJECT oAttach  NO-ERROR.
        DELETE OBJECT oMessage NO-ERROR.
        DELETE OBJECT toAddr   NO-ERROR.
    END.
END.

/* Cleanup */
DELETE OBJECT oClient  NO-ERROR.
DELETE OBJECT oCred    NO-ERROR.
DELETE OBJECT fromAddr NO-ERROR.

/* ? Final single message */
IF vCount > 0 THEN
    MESSAGE SUBSTITUTE("Payslips sent successfully for &1 employees.", vCount)
        VIEW-AS ALERT-BOX INFORMATION.
ELSE
    MESSAGE "No payslips were sent (no active employees with valid emails)."
        VIEW-AS ALERT-BOX INFO.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_generate C-Win 
PROCEDURE P_generate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
//DEFINE VARIABLE vLOPAmount      AS DECIMAL NO-UNDO.
 
DEFINE VARIABLE vSelectedMonth AS CHARACTER NO-UNDO.
DEFINE VARIABLE vSelectedYear  AS INTEGER   NO-UNDO.

/* Get selected month and year */
ASSIGN
    vSelectedMonth = TRIM(UPPER(cbMonth:SCREEN-VALUE IN FRAME {&FRAME-NAME}))
    vSelectedYear  = INTEGER(cbYear:SCREEN-VALUE IN FRAME {&FRAME-NAME}).

/* Validate month and year */
IF vSelectedMonth = "" OR vSelectedMonth = ? THEN DO:
    MESSAGE "Please select month name."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.

IF vSelectedYear = ? OR vSelectedYear = 0 THEN DO:
    MESSAGE "Please select year."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.

 
 
// Set output file path & today's date
 
vTXTFile = "C:\Main_Project\PAYROLL\Monthly_reports\NetSalaryReport_" 
           + REPLACE(vSelectedMonth, " ", "_") + "_" 
           + STRING(vSelectedYear) + ".txt".
 
vToday = STRING(DAY(TODAY), "99") + "-" +
         CAPS(ENTRY(MONTH(TODAY), "JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC")) +
         "-" + STRING(YEAR(TODAY)).
 
 
//Payment Status
 
cPaymentStatus = "BANK TRANSFER".
 
 
// inactive employees' salary = 0
 
FOR EACH ttadmin NO-LOCK WHERE ttadmin.EmpStatus <> "ACTIVE":
    FIND ttsalary EXCLUSIVE-LOCK
        WHERE ttsalary.EmpID = ttadmin.EmpID
          AND UPPER(ttsalary.SALARYMONTH) = vSelectedMonth
          AND ttsalary.YEAR = STRING(vSelectedYear)
        NO-ERROR.
    IF AVAILABLE ttsalary THEN
        ASSIGN ttsalary.NetSalary        = 0
               ttsalary.ProvidentFund    = 0
               ttsalary.ProfessionalTax  = 0
               /* ttsalary.LOPAmount     = 0 */
               ttsalary.TotalDeducation  = 0.
END.
 
 
// Count active employees
 
DEFINE VARIABLE activeEmpCount AS INTEGER NO-UNDO.
activeEmpCount = 0.
FOR EACH ttadmin NO-LOCK WHERE ttadmin.EmpStatus = "ACTIVE":
    activeEmpCount = activeEmpCount + 1.
END.
MESSAGE "Active Employee Count: " + STRING(activeEmpCount)
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
 
// Open TXT file
 
OUTPUT TO VALUE(vTXTFile).
 
PUT UNFORMATTED
    FILL(" ", 25) + "                Pay Slip Report - " 
    + vSelectedMonth + " " + STRING(vSelectedYear) SKIP
    FILL("-", 175) SKIP
    "Employee ID    Employee Name           TotalWorkingDays       WorkingDays     TotalEarnings     TotalDeduction             LOPAmount           NetSalary        PaymentMode" SKIP
    FILL("-", 175) SKIP.
 
 
iCount = 0.
vTotalMonthPay = 0.
 
FOR EACH ttadmin  WHERE ttadmin.EmpStatus = "ACTIVE":
 
   FIND ttsalary 
        WHERE ttsalary.EmpID              = ttadmin.EmpID
          AND UPPER(ttsalary.SALARYMONTH) = vSelectedMonth
          AND ttsalary.YEAR               = STRING(vSelectedYear)
        NO-ERROR.
 
   FIND ttattendance 
        WHERE ttattendance.EmpID             = ttadmin.EmpID
          AND UPPER(ttattendance.MonthNames) = vSelectedMonth
          AND ttattendance.YEAR              = STRING(vSelectedYear)
        NO-ERROR.
 
   FIND ttdetails 
        WHERE ttdetails.EmpID = ttadmin.EmpID
        NO-ERROR.
 
   IF NOT AVAILABLE ttsalary
       OR NOT AVAILABLE ttattendance
       OR NOT AVAILABLE ttdetails THEN NEXT.
 
    // Skip if any record missing
IF NOT AVAILABLE ttsalary
   OR NOT AVAILABLE ttattendance
   OR NOT AVAILABLE ttdetails THEN NEXT.
 
 
    ASSIGN
        vMonthlyDays      = ttattendance.MonthlyWorkingDays
        vEmpWorkingDays   = ttattendance.EmployeeWorkingDays
        vTotalEarnings    = ttsalary.TotalEarings
        vEmpName          = ttdetails.EmpName.
 
    IF vMonthlyDays = 0 THEN NEXT.
 
// Compute PF, PT, LOP
    vProvidentFund    = vTotalEarnings * 0.12.
    vProfessionalTax  = vTotalEarnings * 0.004.
    vLOPAmount        = (vMonthlyDays - vEmpWorkingDays) * (vTotalEarnings / vMonthlyDays).
    vTotalDeducation   = vProvidentFund + vProfessionalTax + vLOPAmount.
    vNetSalary        = vTotalEarnings - vTotalDeducation .
    IF vNetSalary < 0 THEN vNetSalary = 0.
 
// Update Salary Table 
    DO TRANSACTION:
        FIND ttsalary EXCLUSIVE-LOCK
            WHERE ttsalary.EmpID              = ttadmin.EmpID
              AND UPPER(ttsalary.SALARYMONTH) = vSelectedMonth
              AND ttsalary.YEAR               = STRING(vSelectedYear)
            NO-ERROR.
        IF AVAILABLE ttsalary THEN
            ASSIGN ttsalary.NetSalary         = vNetSalary
                   ttsalary.ProvidentFund     = vProvidentFund
                   ttsalary.ProfessionalTax   = vProfessionalTax
                   ttsalary.lossofpay       = vLOPAmount
                   ttsalary.TotalDeducation   = vTotalDeducation.
    END.
     DO TRANSACTION:
        FIND EmployeeSalarysDetails EXCLUSIVE-LOCK
            WHERE EmployeeSalarysDetails.EmpID              = ttadmin.EmpID
              AND UPPER(EmployeeSalarysDetails.SALARYMONTH) = vSelectedMonth
              AND ttsalary.YEAR                             = STRING(vSelectedYear)
            NO-ERROR.
        IF AVAILABLE EmployeeSalarysDetails THEN
            ASSIGN EmployeeSalarysDetails.NetSalary        = vNetSalary
                   EmployeeSalarysDetails.ProvidentFund    = vProvidentFund
                   EmployeeSalarysDetails.ProfessionalTax  = vProfessionalTax
                   EmployeeSalarysDetails.lossofpay        = vLOPAmount
                   EmployeeSalarysDetails.TotalDeducation  = vTotalDeducation.
    END.
 
// Totals & print 
    vTotalMonthPay = vTotalMonthPay + vNetSalary.
 
// Print row 
    PUT UNFORMATTED
        STRING(ttadmin.EmpID, "999") + "            "
        + vEmpName + FILL(" ", 30 - LENGTH(vEmpName))
        + STRING(vMonthlyDays, "99") + "                  "
        + STRING(vEmpWorkingDays, "99") + "            "
        + STRING(vTotalEarnings, "->>,>>9.99") + "         "
        + STRING(vTotalDeducation, "->>,>>9.99") + "         "   
        + STRING(vLOPAmount, "->>,>>>,>>9.99") + "           "
        + STRING(vNetSalary, "->>,>>9.99") + "       "
        + cPaymentStatus SKIP.
 
    iCount = iCount + 1.
END.
 
 
//close file
 
PUT UNFORMATTED
    FILL("-", 175) SKIP
    "Total Employees in report: " + STRING(iCount) SKIP
    "Total NetSalary for " + vSelectedMonth + ": " + STRING(vTotalMonthPay, "->>,>>9.99") SKIP
    "Report Generated on: " + vToday SKIP.
 
OUTPUT CLOSE.
 
MESSAGE "Pay Slip TXT file generated: " + vTXTFile
    VIEW-AS ALERT-BOX INFORMATION BUTTONS OK.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

