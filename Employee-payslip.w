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
DEFINE TEMP-TABLE ttattendance  LIKE EmployeeAttenadce.
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
&Scoped-Define ENABLED-OBJECTS IMAGE-103 IMAGE-107 IMAGE-109 txtback cbYear ~
cbMonth TXTGENERATE BTSBANK txtviewpayslip btnemail 
&Scoped-Define DISPLAYED-OBJECTS cbYear cbMonth 

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
     SIZE 59 BY 1.71
     FONT 6.

DEFINE BUTTON BTSBANK 
     LABEL "BANKING RELATED REPORTS" 
     SIZE 59 BY 1.86
     FONT 6.

DEFINE BUTTON txtback 
     LABEL "BACK" 
     SIZE 15 BY 1.14
     BGCOLOR 11 FONT 6.

DEFINE BUTTON TXTGENERATE 
     LABEL "GENERATE PAYROLL" 
     SIZE 59 BY 1.67
     FONT 6.

DEFINE BUTTON txtviewpayslip 
     LABEL "VIEW PAYSLIP'S" 
     SIZE 59 BY 1.81
     FONT 6.

DEFINE VARIABLE cbMonth AS CHARACTER FORMAT "X(256)":U 
     LABEL "MONTH" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","January","February","March","April","May","June","July","August","September","October","November","December" 
     DROP-DOWN-LIST
     SIZE 18 BY 1
     BGCOLOR 4 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE cbYear AS CHARACTER FORMAT "X(256)":U 
     LABEL "YEAR" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","2024","2025","2026","2027","2028","2029" 
     DROP-DOWN-LIST
     SIZE 20 BY 1
     BGCOLOR 4 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE IMAGE IMAGE-103
     FILENAME "C:/Users/sriharsha.c/Downloads/payslip_final.png":U
     STRETCH-TO-FIT
     SIZE 164 BY 24.29.

DEFINE IMAGE IMAGE-107
     FILENAME "C:/Users/sriharsha.c/OneDrive - iSpace/Pictures/Screenshots/screenshot 2025-11-07 014951.png":U
     STRETCH-TO-FIT
     SIZE 74 BY 12.62.

DEFINE IMAGE IMAGE-109
     FILENAME "C:/Users/sriharsha.c/Downloads/logo_final.png":U
     STRETCH-TO-FIT
     SIZE 61 BY 3.81.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frpayslip
     txtback AT ROW 1.95 COL 3 WIDGET-ID 10
     cbYear AT ROW 8.48 COL 96 COLON-ALIGNED WIDGET-ID 38
     cbMonth AT ROW 8.48 COL 137 COLON-ALIGNED WIDGET-ID 6
     TXTGENERATE AT ROW 10.67 COL 94 WIDGET-ID 8
     BTSBANK AT ROW 13.19 COL 94 WIDGET-ID 36
     txtviewpayslip AT ROW 16.1 COL 94 WIDGET-ID 34
     btnemail AT ROW 19.05 COL 94 WIDGET-ID 56
     IMAGE-103 AT ROW 1 COL 1 WIDGET-ID 76
     IMAGE-107 AT ROW 9.33 COL 86 WIDGET-ID 80
     IMAGE-109 AT ROW 2.43 COL 55 WIDGET-ID 82
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1
         SIZE 231 BY 25.48
         BGCOLOR 1 FGCOLOR 4 FONT 6 WIDGET-ID 100.


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
         HEIGHT             = 24.29
         WIDTH              = 163.8
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
  RUN p_BANK(INPUT cbMonth:SCREEN-VALUE IN FRAME frpayslip,
             INPUT INTEGER(cbYear:SCREEN-VALUE IN FRAME frpayslip)
            ).
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
  RUN p_generate(INPUT cbMonth:SCREEN-VALUE,
                 INPUT INTEGER(cbYear:SCREEN-VALUE)
                 ).
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
  
  RUN PAYROLL\Procedures\EmployeeAllTables.p (
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
  DISPLAY cbYear cbMonth 
      WITH FRAME frpayslip IN WINDOW C-Win.
  ENABLE IMAGE-103 IMAGE-107 IMAGE-109 txtback cbYear cbMonth TXTGENERATE 
         BTSBANK txtviewpayslip btnemail 
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
/* === INPUT PARAMETERS === */
DEFINE INPUT PARAMETER ipMonth AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER ipYear  AS INTEGER   NO-UNDO.
/* === Load salary data (same SP used by Payslip Generator) === */
RUN spGeneratePayslipData.p
(
    INPUT ipMonth,
    INPUT STRING(ipYear),
    OUTPUT TABLE ttadmin,
    OUTPUT TABLE ttdetails,
    OUTPUT TABLE ttattendance,
    OUTPUT TABLE ttsalary
).

/* Variables */
DEFINE VARIABLE vTXTFile        AS CHARACTER NO-UNDO.
DEFINE VARIABLE vFolder         AS CHARACTER NO-UNDO.
DEFINE VARIABLE vToday          AS CHARACTER NO-UNDO.
DEFINE VARIABLE vPayDate        AS DATE      NO-UNDO.
DEFINE VARIABLE vMaskedIFSC     AS CHARACTER NO-UNDO.
DEFINE VARIABLE vMaskedUTR      AS CHARACTER NO-UNDO.
DEFINE VARIABLE vIFSC           AS CHARACTER NO-UNDO.
DEFINE VARIABLE vUTRNo          AS CHARACTER NO-UNDO.
DEFINE VARIABLE vName           AS CHARACTER NO-UNDO.
DEFINE VARIABLE vTotalMonthPay  AS DECIMAL   NO-UNDO.
DEFINE VARIABLE iCount          AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMonthNum       AS INTEGER   NO-UNDO.
DEFINE VARIABLE vLength         AS INTEGER   NO-UNDO.
DEFINE VARIABLE cPaymentStatus  AS CHARACTER NO-UNDO.


/* VALIDATION */
 IF ipMonth = "" OR ipMonth = ? THEN DO:
    MESSAGE "Please Select Month and Year to generate payslip." VIEW-AS ALERT-BOX ERROR.
    RETURN.
 END.

 IF ipMonth ="" THEN DO:
  MESSAGE "Please Select Month" VIEW-AS ALERT-BOX ERROR.
  RETURN.
 END.

 IF ipYear = 0 THEN DO:
    MESSAGE "Please select Year." VIEW-AS ALERT-BOX ERROR.
    RETURN.
 END.
 
 //If the bank related info already exists 

DEFINE VARIABLE lChoice AS LOGICAL NO-UNDO.

/* Count salary rows for selected month/year */
FOR EACH EmployeeSalarysDetails NO-LOCK
    WHERE UPPER(TRIM(EmployeeSalarysDetails.SalaryMonth)) = UPPER(TRIM(ipMonth))
      AND TRIM(EmployeeSalarysDetails.Year) = STRING(ipYear):

    iCount = iCount + 1.
END.

/* Ask user if month already generated */
IF iCount > 0 THEN DO:
    MESSAGE SUBSTITUTE(
        "Bank Reports for &1 &2 is already generated." + CHR(10) +
        "Do you want to regenerate?",
        ipMonth, STRING(ipYear)
        )
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        UPDATE lChoice.

    IF NOT lChoice THEN RETURN.
END.


/* Output folder */
ASSIGN
    vFolder  = "C:\Main_Project\PAYROLL\Bank_reports"
    vTXTFile = vFolder + "\BankReport_" + REPLACE(ipMonth," ","_") 
               + "_" + STRING(ipYear) + ".txt".

OS-CREATE-DIR VALUE(vFolder) NO-ERROR.

/* Date */
vToday = STRING(DAY(TODAY),"99") + "-"
       + CAPS(ENTRY(MONTH(TODAY),
         "JANUARY,FEBRUARY,MARCH,APRIL,MAY,JUNE,JULY,AUGUST,SEPTEMBER,OCTOBER,NOVEMBER,DECEMBER"))
       + "-" + STRING(YEAR(TODAY)).

iMonthNum = LOOKUP(ipMonth,
    "JANUARY,FEBRUARY,MARCH,APRIL,MAY,JUNE,JULY,AUGUST,SEPTEMBER,OCTOBER,NOVEMBER,DECEMBER").

vPayDate = DATE(4, iMonthNum + 1, ipYear).
IF iMonthNum = 12 THEN vPayDate = DATE(4, 1, ipYear + 1).
IF WEEKDAY(vPayDate) = 1 THEN vPayDate = vPayDate - 2.
IF WEEKDAY(vPayDate) = 7 THEN vPayDate = vPayDate - 1.

/* Start TXT Output */
OUTPUT TO VALUE(vTXTFile) NO-ECHO NO-MAP.

/* HEADER */
PUT UNFORMATTED
" ================================================================================================================================= " SKIP
"                                             MONTHLY BANK TRANSFER REPORT                                                         " SKIP
"                                                  " + ipMonth + " " + STRING(ipYear) + "                                                 " SKIP
" ================================================================================================================================= " SKIP SKIP.

/* TABLE HEADER */
PUT UNFORMATTED
"| EmpID | Employee Name               | Bank Account No      | IFSC Code     | Net Salary      | Payment Status  |     UTR NO     |" SKIP
"|-------|-----------------------------|----------------------|---------------|-----------------|-----------------|----------------|" SKIP.

/* MAIN LOOP */
FOR EACH ttadmin WHERE CAPS(ttadmin.EmpStatus) = "ACTIVE",
    EACH ttsalary WHERE ttsalary.EmpID = ttadmin.EmpID
                   AND CAPS(ttsalary.SalaryMonth) = CAPS(ipMonth)
                   AND STRING(ttsalary.Year) = STRING(ipYear),
    EACH ttdetails WHERE ttdetails.EmpID = ttadmin.EmpID:

    /* Counters >>> IMPORTANT <<< */
    iCount = iCount + 1.
    vTotalMonthPay = vTotalMonthPay + ttsalary.NetSalaryPaid.

    /* Clean Name */
    vName = ttdetails.EmpName.
    IF LENGTH(vName) > 28 THEN vName = SUBSTRING(vName,1,28).

    /* IFSC Mask */
    vIFSC = TRIM(ttsalary.EmployeeIFCCode).
    vLength = LENGTH(vIFSC).
    IF vLength > 6 THEN
        vMaskedIFSC = SUBSTRING(vIFSC,1,3) + FILL("*", vLength - 6) + SUBSTRING(vIFSC,vLength - 2,3).
    ELSE
        vMaskedIFSC = vIFSC.

    /* Status */
    cPaymentStatus = IF ttsalary.NetSalaryPaid > 0 THEN "PAID" ELSE "NOT PAID".

    /* UTR */
    vUTRNo = "AXIS" + STRING(ipYear) + STRING(iMonthNum,"99") + STRING(ttsalary.EmpId,"9999").
    vMaskedUTR = FILL("*", LENGTH(vUTRNo) - 4) + SUBSTRING(vUTRNo, LENGTH(vUTRNo) - 3,4).

    /* Write Row */
    PUT UNFORMATTED
        "| " + STRING(ttadmin.EmpID,"999") + "   | "
        + STRING(vName,"x(28)") + "| "
        + STRING(ttsalary.EemployeBankNum,"x(21)") + "| "
        + STRING(vMaskedIFSC,"x(13)") + " | "
        + STRING(ttsalary.NetSalaryPaid,"->>>,>>>,>>9.99") + " | "
        + STRING(cPaymentStatus,"x(13)") + "   | "
        + STRING(vMaskedUTR,"x(14)") + " |"
        SKIP.

END.

/* FOOTER */
PUT UNFORMATTED SKIP
" ================================================================================================================================= " SKIP
"  Total Employees Processed : " + STRING(iCount) SKIP
"  Total Net Salary Transfer : " + STRING(vTotalMonthPay) SKIP
"  Payment Mode              : NEFT" SKIP
"  Bank Name                 : AXIS BANK" SKIP
"  Payment Date              : " + STRING(vPayDate) SKIP
" ================================================================================================================================= " SKIP.

OUTPUT CLOSE.

/* DONE */
MESSAGE "Bank TXT generated successfully:" SKIP vTXTFile
        VIEW-AS ALERT-BOX INFO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_email C-Win 
PROCEDURE p_email :
/*------------------------------------------------------------------------------
  Purpose :
  Inputs  :
------------------------------------------------------------------------------*/
/* -------------------------------
   Variable Definitions
-------------------------------- */
DEFINE VARIABLE cFrom            AS CHARACTER NO-UNDO INIT "sriharshabobbi52@gmail.com".
DEFINE VARIABLE cPassword        AS CHARACTER NO-UNDO INIT "dsbw yiau dlkj bqfo". /* Gmail App Password */
DEFINE VARIABLE cBody            AS CHARACTER NO-UNDO.
DEFINE VARIABLE cSubject         AS CHARACTER NO-UNDO.
DEFINE VARIABLE cFilePath        AS CHARACTER NO-UNDO.
DEFINE VARIABLE vSelectedMonth   AS CHARACTER NO-UNDO.
DEFINE VARIABLE vSelectedYear    AS INTEGER   NO-UNDO.
DEFINE VARIABLE vToday           AS CHARACTER NO-UNDO.
DEFINE VARIABLE vMonthlyDays     AS INTEGER   NO-UNDO.
DEFINE VARIABLE vEmpWorkingDays  AS INTEGER   NO-UNDO.
DEFINE VARIABLE vTotalEarnings   AS DECIMAL   NO-UNDO.
DEFINE VARIABLE vTotalDeducation AS DECIMAL   NO-UNDO.
DEFINE VARIABLE vLOPAmount       AS DECIMAL   NO-UNDO.
DEFINE VARIABLE vNetSalary       AS DECIMAL   NO-UNDO.
DEFINE VARIABLE vBodyText        AS LONGCHAR  NO-UNDO.
DEFINE VARIABLE cLine            AS CHARACTER NO-UNDO.
DEFINE VARIABLE vEmpMail         AS CHARACTER NO-UNDO.
DEFINE VARIABLE vEmpName         AS CHARACTER NO-UNDO.
DEFINE VARIABLE i                AS INTEGER   NO-UNDO.
DEFINE VARIABLE vCount           AS INTEGER   NO-UNDO INITIAL 0.

/* .NET mail objects */
DEFINE VARIABLE oClient  AS System.Net.Mail.SmtpClient        NO-UNDO.
DEFINE VARIABLE oMessage AS System.Net.Mail.MailMessage       NO-UNDO.
DEFINE VARIABLE oAttach  AS System.Net.Mail.Attachment        NO-UNDO.
DEFINE VARIABLE oCred    AS System.Net.NetworkCredential      NO-UNDO.
DEFINE VARIABLE fromAddr AS System.Net.Mail.MailAddress       NO-UNDO.
DEFINE VARIABLE toAddr   AS System.Net.Mail.MailAddress       NO-UNDO.


/* Get month & year */
ASSIGN
    vSelectedMonth = TRIM(UPPER(cbMonth:SCREEN-VALUE IN FRAME {&FRAME-NAME}))
    vSelectedYear  = INTEGER(cbYear:SCREEN-VALUE IN FRAME {&FRAME-NAME}).

IF vSelectedMonth = "" OR vSelectedMonth = ? THEN DO:
    MESSAGE "Please select month." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

IF vSelectedYear = 0 THEN DO:
    MESSAGE "Please select year." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* ----------------------------------------------
   FIX: Load TT data before sending emails
---------------------------------------------- */
RUN spGeneratePayslipData.p (
    INPUT vSelectedMonth,
    INPUT vSelectedYear,
    OUTPUT TABLE ttadmin,
    OUTPUT TABLE ttdetails,
    OUTPUT TABLE ttattendance,
    OUTPUT TABLE ttsalary
).



/* -------------------------------
   Gmail SMTP Configuration
-------------------------------- */
ASSIGN
    oCred               = NEW System.Net.NetworkCredential(cFrom, cPassword)
    oClient             = NEW System.Net.Mail.SmtpClient("smtp.gmail.com", 587)
    oClient:EnableSsl   = TRUE
    oClient:UseDefaultCredentials = FALSE
    oClient:Credentials = oCred
    fromAddr            = NEW System.Net.Mail.MailAddress(cFrom).


/* -------------------------------
   Date for Payslip Footer
-------------------------------- */
vToday = STRING(DAY(TODAY),"99") + "-"
       + CAPS(ENTRY(MONTH(TODAY),"JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC"))
       + "-" + STRING(YEAR(TODAY)).


/* --------------------------------------
   LOOP ACTIVE EMPLOYEES ONLY
--------------------------------------- */
FOR EACH ttadmin NO-LOCK
    WHERE CAPS(ttadmin.EmpStatus) = "ACTIVE",

    EACH ttdetails NO-LOCK
        WHERE ttdetails.EmpID = ttadmin.EmpID:

    /* Get email & name */
    ASSIGN
        vEmpMail = TRIM(ttdetails.Email)
        vEmpName = ttdetails.EmpName.

    /* Skip if no email */
    IF vEmpMail = "" THEN NEXT.


    /* -------------------------------
       Load salary & attendance from TT
    -------------------------------- */
    FIND FIRST ttsalary NO-LOCK
        WHERE ttsalary.EmpID = ttadmin.EmpID
          AND CAPS(ttsalary.SalaryMonth) = CAPS(vSelectedMonth)
          AND INTEGER(ttsalary.Year) = vSelectedYear
        NO-ERROR.

    FIND FIRST ttattendance NO-LOCK
        WHERE ttattendance.EmpID = ttadmin.EmpID
          AND CAPS(ttattendance.MonthNames) = CAPS(vSelectedMonth)
        NO-ERROR.

    IF NOT AVAILABLE ttsalary OR NOT AVAILABLE ttattendance THEN NEXT.


    /* Assign computed values */
    ASSIGN
        vMonthlyDays     = ttattendance.MonthlyWorkingDays
        vEmpWorkingDays  = ttattendance.EmployeeWorkingDays
        vTotalEarnings   = ttsalary.TotalEarings
        vTotalDeducation = ttsalary.TotalDeducation
        vLOPAmount       = ttsalary.lossOfPay
        vNetSalary       = ttsalary.NetSalaryPaid.

    IF vNetSalary < 0 THEN vNetSalary = 0.


    /* -------------------------------
       BUILD PAYSLIP BODY (TXT FORMAT)
    -------------------------------- */
    cLine = FILL("-", 60).

    vBodyText = ""
        + "                   *** COMPANY PAY SLIP ***" + CHR(10)
        + SUBSTITUTE("                     &1 &2", vSelectedMonth, STRING(vSelectedYear)) + CHR(10)
        + cLine + CHR(10)
        + SUBSTITUTE("Employee ID        : &1", STRING(ttadmin.EmpID)) + CHR(10)
        + SUBSTITUTE("Employee Name      : &1", vEmpName) + CHR(10)
        + SUBSTITUTE("Designation        : &1", ttadmin.Designation) + CHR(10)
        + SUBSTITUTE("Department         : &1", ttadmin.Department) + CHR(10)
        + SUBSTITUTE("Bank A/C Number    : &1", ttsalary.EemployeBankNum) + CHR(10)
        + SUBSTITUTE("IFSC Code          : &1", ttsalary.EmployeeIFCCode) + CHR(10)
        + cLine + CHR(10)
        + SUBSTITUTE("Total Working Days : &1", STRING(vMonthlyDays)) + CHR(10)
        + SUBSTITUTE("Days Worked        : &1", STRING(vEmpWorkingDays)) + CHR(10)
        + SUBSTITUTE("Leave Days         : &1", STRING(vMonthlyDays - vEmpWorkingDays)) + CHR(10)
        + cLine + CHR(10)
        + "        EARNINGS" + CHR(10)
        + SUBSTITUTE("Basic Salary       : &1", STRING(ttsalary.BasicSalary,"->>,>>>,>>9.99")) + CHR(10)
        + SUBSTITUTE("HRA                : &1", STRING(ttsalary.HRA,"->>,>>>,>>9.99")) + CHR(10)
        + SUBSTITUTE("Special Allowance  : &1", STRING(ttsalary.SpecialAllowance,"->>,>>>,>>9.99")) + CHR(10)
        + SUBSTITUTE("Total Earnings     : &1", STRING(vTotalEarnings,"->>,>>>,>>9.99")) + CHR(10)
        + cLine + CHR(10)
        + "        DEDUCTIONS" + CHR(10)
        + SUBSTITUTE("PF Contribution    : &1", STRING(ttsalary.ProvidentFund,"->>,>>>,>>9.99")) + CHR(10)
        + SUBSTITUTE("Professional Tax   : &1", STRING(ttsalary.ProfessionalTax,"->>,>>>,>>9.99")) + CHR(10)
        + SUBSTITUTE("Loss of Pay (LOP)  : &1", STRING(vLOPAmount,"->>,>>>,>>9.99")) + CHR(10)
        + SUBSTITUTE("Total Deductions   : &1", STRING(vTotalDeducation,"->>,>>>,>>9.99")) + CHR(10)
        + cLine + CHR(10)
        + SUBSTITUTE("NET SALARY PAYABLE : &1", STRING(vNetSalary,"->>,>>>,>>9.99")) + CHR(10)
        + cLine + CHR(10)
        + SUBSTITUTE("Payslip Generated On : &1", vToday) + CHR(10)
        + "This is a system-generated payslip and does not require signature." + CHR(10).


    /* -------------------------------
       Save Payslip TXT File
    -------------------------------- */
    cFilePath = "C:\Temp\Payslip_"
              + STRING(ttadmin.EmpID) + "_"
              + CAPS(vSelectedMonth) + "_"
              + STRING(vSelectedYear) + ".txt".

    COPY-LOB FROM vBodyText TO FILE cFilePath.


    /* -------------------------------
       SEND EMAIL
    -------------------------------- */
    ASSIGN
        toAddr     = NEW System.Net.Mail.MailAddress(vEmpMail)
        oMessage   = NEW System.Net.Mail.MailMessage(fromAddr, toAddr)
        cSubject   = SUBSTITUTE("Pay Slip - &1 &2", vSelectedMonth, STRING(vSelectedYear))
        cBody      = SUBSTITUTE("Dear &1,", vEmpName)
                     + CHR(10) + "Please find attached your payslip."
                     + CHR(10) + "Regards," + CHR(10) + "Payroll Team.".

    ASSIGN
        oMessage:Subject = cSubject
        oMessage:Body    = cBody.

    /* Attach payslip */
    IF SEARCH(cFilePath) <> ? THEN DO:
        oAttach = NEW System.Net.Mail.Attachment(cFilePath).
        oMessage:Attachments:Add(oAttach).
    END.

    oClient:Send(oMessage).
    vCount = vCount + 1.

    DELETE OBJECT oAttach NO-ERROR.
    DELETE OBJECT oMessage NO-ERROR.
    DELETE OBJECT toAddr   NO-ERROR.

END. /* FOR EACH employee */


/* -------------------------------
   Cleanup
-------------------------------- */
DELETE OBJECT oClient  NO-ERROR.
DELETE OBJECT oCred    NO-ERROR.
DELETE OBJECT fromAddr NO-ERROR.


/* -------------------------------
   Final Message
-------------------------------- */
IF vCount > 0 THEN
    MESSAGE SUBSTITUTE("Payslips sent successfully for &1 employees.", vCount)
        VIEW-AS ALERT-BOX INFO.
ELSE
    MESSAGE "No payslips were sent (no valid email IDs found)."
        VIEW-AS ALERT-BOX INFO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE P_generate C-Win 
PROCEDURE P_generate :
/*------------------------------------------------------------------------------
  Purpose :
  Inputs  :
------------------------------------------------------------------------------*/
/* -------------------------------------------------------------
   INPUT
   ------------------------------------------------------------- */
DEFINE INPUT PARAMETER ipMonth AS CHARACTER NO-UNDO.
DEFINE INPUT PARAMETER ipYear  AS INTEGER   NO-UNDO.


/* -------------------------------------------------------------
   LOCAL VARIABLES
   ------------------------------------------------------------- */
DEFINE VARIABLE vTXTFile     AS CHARACTER NO-UNDO.
DEFINE VARIABLE vFolder      AS CHARACTER NO-UNDO.
DEFINE VARIABLE vToday       AS CHARACTER NO-UNDO.
DEFINE VARIABLE vTotalNet    AS DECIMAL   NO-UNDO.
DEFINE VARIABLE vName        AS CHARACTER NO-UNDO.
DEFINE VARIABLE vCount       AS INTEGER   NO-UNDO.

/* -------------------------------------------------------------
   VALIDATION
   ------------------------------------------------------------- */
IF TRIM(ipMonth) = "" OR ipMonth = ? THEN DO:
    MESSAGE "Please select Month." VIEW-AS ALERT-BOX ERROR. 
    RETURN.
END.

IF ipYear = 0 THEN DO:
    MESSAGE "Please select Year." VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* -------------------------------------------------------------
   CHECK IF PAYSLIP ALREADY EXISTS
   ------------------------------------------------------------- */
DEFINE VARIABLE vMonth AS CHARACTER NO-UNDO.
DEFINE VARIABLE vYear  AS CHARACTER NO-UNDO.
DEFINE VARIABLE iCount AS INTEGER   NO-UNDO.
DEFINE VARIABLE lChoice AS LOGICAL NO-UNDO.

ASSIGN
    vMonth = CAPS(TRIM(ipMonth))
    vYear  = TRIM(STRING(ipYear)).

iCount = 0.

/* Check DB for existing payslip */
FOR EACH EmployeeSalarysDetails NO-LOCK
    WHERE CAPS(TRIM(EmployeeSalarysDetails.SalaryMonth)) = vMonth
      AND TRIM(EmployeeSalarysDetails.Year) = vYear:

    iCount = iCount + 1.
END.

/* If exists, ask user */
IF iCount > 0 THEN DO:

    MESSAGE SUBSTITUTE(
        "Payslip for &1 &2 already exists." + CHR(10) +
        "Do you want to regenerate?",
        vMonth, vYear
        )
        VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO
        UPDATE lChoice.

    IF NOT lChoice THEN DO:
        RETURN. /* Stop only if NO */
    END.
END.


/* -------------------------------------------------------------
   LOAD PERSISTED PAYROLL DATA FROM SP
   ------------------------------------------------------------- */
RUN spGeneratePayslipData.p (INPUT  ipMonth,
                             INPUT  ipYear,
                             OUTPUT TABLE ttadmin,
                             OUTPUT TABLE ttdetails,
                             OUTPUT TABLE ttattendance,
                             OUTPUT TABLE ttsalary
                             ).

/* -------------------------------------------------------------
   PREPARE OUTPUT FILE
   ------------------------------------------------------------- */
   

ASSIGN
    vFolder = "C:\Main_Project\PAYROLL\Monthly_reports"
    vTXTFile = vFolder + "\NetSalaryReport_" +
               REPLACE(ipMonth," ","_") + "_" +
               STRING(ipYear) + ".txt".

OS-CREATE-DIR VALUE(vFolder) NO-ERROR.

ASSIGN
    vToday = STRING(DAY(TODAY),"99") + "-" +
             CAPS(ENTRY(MONTH(TODAY),
             "JAN,FEB,MAR,APR,MAY,JUN,JUL,AUG,SEP,OCT,NOV,DEC")) + "-" +
             STRING(YEAR(TODAY))
    vTotalNet = 0
    vCount = 0.

/* -------------------------------------------------------------
   WRITE REPORT
   ------------------------------------------------------------- */
OUTPUT TO VALUE(vTXTFile) NO-ECHO NO-MAP.

/* HEADER */
PUT UNFORMATTED
" ================================================================================================================================ " SKIP
"                                           MONTHLY NET SALARY REPORT                                                           " SKIP
"                                               " + ipMonth + " " + STRING(ipYear) + "                                                  " SKIP
" ================================================================================================================================ " SKIP SKIP.

/* COLUMN TITLES */
PUT UNFORMATTED
"| EmpID | Employee Name               | TotDays | WorkDays | TotalEarnings | TotalDeductions | LOP Amount     | Net Salary      |" SKIP
"|-------|-----------------------------|---------|----------|---------------|-----------------|----------------|-----------------|" SKIP.

/* MAIN LOOP — DATA COMES ONLY FROM TEMP TABLES */
FOR EACH ttadmin NO-LOCK
    WHERE UPPER(TRIM(ttadmin.EmpStatus)) = "ACTIVE":

    FIND FIRST ttdetails    WHERE ttdetails.EmpID = ttadmin.EmpID NO-LOCK NO-ERROR.
    FIND FIRST ttattendance WHERE ttattendance.EmpID = ttadmin.EmpID NO-LOCK NO-ERROR.
    FIND FIRST ttsalary     WHERE ttsalary.EmpID = ttadmin.EmpID NO-LOCK NO-ERROR.

    IF NOT AVAILABLE ttdetails OR NOT AVAILABLE ttattendance OR NOT AVAILABLE ttsalary THEN NEXT.

    vCount = vCount + 1.
    vName = ttdetails.EmpName.
    IF LENGTH(vName) > 28 THEN vName = SUBSTRING(vName,1,28).

    IF ttsalary.NetSalaryPaid = ? THEN ttsalary.NetSalaryPaid = 0.

    vTotalNet = vTotalNet + ttsalary.NetSalaryPaid.

    PUT UNFORMATTED
        "| "
        + STRING(ttadmin.EmpID,"999") + "   | "
        + STRING(vName,"x(28)")       + "| "
        + STRING(ttattendance.MonthlyWorkingDays,"99") + "      | "
        + STRING(ttattendance.EmployeeWorkingDays,"99") + "       | "
        + STRING(ttsalary.TotalEarings,"->>,>>9.99")            + "    | "
        + STRING(ttsalary.TotalDeducation,"->>,>>9.99")         + "      | "
        + STRING(ttsalary.lossOfPay,"->>,>>9.99")               + "     | "
        + STRING(ttsalary.NetSalaryPaid,"->>,>>9.99")           + "      |"
        SKIP.
END.

/* FOOTER */
PUT UNFORMATTED SKIP
" ================================================================================================================================ " SKIP
"  Total Employees Processed : " + STRING(vCount) SKIP
"  Total Net Salary Payout   : " + STRING(vTotalNet) SKIP
"  Report Generated On       : " + vToday SKIP
" ================================================================================================================================ " SKIP.

OUTPUT CLOSE.

/* MESSAGE */
MESSAGE "Payslip TXT Report generated successfully:" SKIP vTXTFile
    VIEW-AS ALERT-BOX INFO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

