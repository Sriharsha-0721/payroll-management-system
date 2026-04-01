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

  Author: sriharsha.ch

  Created: 

------------------------------------------------------------------------*/
/*          This .W file was created with the Progress AppBuilder.      */
/*----------------------------------------------------------------------*/


CREATE WIDGET-POOL.

/* ***************************  Definitions  ************************** */

/* Parameters Definitions ---                                           */
/* Local Variable Definitions ---                                       */
DEFINE VARIABLE vEmpID           AS INTEGER   NO-UNDO.
DEFINE VARIABLE vMonthName       AS CHARACTER NO-UNDO.
DEFINE VARIABLE vYear            AS CHARACTER NO-UNDO.
DEFINE VARIABLE iNextEmpID       AS INTEGER   NO-UNDO.
DEFINE VARIABLE vMobile          AS CHARACTER NO-UNDO.
DEFINE VARIABLE i                AS INTEGER   NO-UNDO.
DEFINE VARIABLE vAnswer          AS LOGICAL   NO-UNDO.
DEFINE VARIABLE iMonthNumber     AS INTEGER   NO-UNDO.
DEFINE VARIABLE cMonthName       AS CHARACTER NO-UNDO.
DEFINE VARIABLE cOpResult        AS CHARACTER NO-UNDO.
DEFINE VARIABLE iCurrentYear     AS INTEGER   NO-UNDO.
DEFINE VARIABLE opRes            AS CHARACTER NO-UNDO.                               
DEFINE VARIABLE iSpacePosition   AS INTEGER   NO-UNDO.
DEFINE VARIABLE cFirstNameTemp   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cLastNameTemp    AS CHARACTER NO-UNDO.
DEFINE VARIABLE lAddConfirmed    AS LOGICAL   NO-UNDO.
DEFINE VARIABLE cCSVFile         AS CHARACTER NO-UNDO INITIAL "EmployeeDetails.csv".

/*Temp-Table Definitions (local to this procedure)*/
DEFINE TEMP-TABLE ttadmin      LIKE EmployeeMaster.
DEFINE TEMP-TABLE ttdetails    LIKE EmployeeDetails.
DEFINE TEMP-TABLE ttattendance LIKE EMPLOYEEATTENADCE.
DEFINE TEMP-TABLE ttsalary     LIKE EmployeeSalarysDetails.
DEFINE TEMP-TABLE ttDetails2 NO-UNDO LIKE EmployeeDetails.

DEFINE QUERY qEmployees FOR ttdetails, ttadmin.
DEFINE VARIABLE gViewMode AS CHARACTER NO-UNDO INIT "ACTIVE".

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of designated FRAME-NAME and/or first browse and/or first query */
&Scoped-define FRAME-NAME frMain
&Scoped-define BROWSE-NAME brEmployees

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES ttDetails ttAdmin

/* Definitions for BROWSE brEmployees                                   */
&Scoped-define FIELDS-IN-QUERY-brEmployees ttDetails.EmpID ttDetails.EmpName ttDetails.Email ttDetails.Gender ttDetails.Phone ttAdmin.Department ttAdmin.Designation ttAdmin.EmpStatus   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brEmployees   
&Scoped-define SELF-NAME brEmployees
&Scoped-define QUERY-STRING-brEmployees FOR     EACH ttDetails NO-LOCK, ~
           EACH ttAdmin NO-LOCK WHERE ttAdmin.EmpID = ttDetails.EmpID     BY ttDetails.EmpID
&Scoped-define OPEN-QUERY-brEmployees OPEN QUERY brEmployees FOR     EACH ttDetails NO-LOCK, ~
           EACH ttAdmin NO-LOCK WHERE ttAdmin.EmpID = ttDetails.EmpID     BY ttDetails.EmpID.
&Scoped-define TABLES-IN-QUERY-brEmployees ttDetails ttAdmin
&Scoped-define FIRST-TABLE-IN-QUERY-brEmployees ttDetails
&Scoped-define SECOND-TABLE-IN-QUERY-brEmployees ttAdmin


/* Definitions for FRAME frMain                                         */
&Scoped-define OPEN-BROWSERS-IN-QUERY-frMain ~
    ~{&OPEN-QUERY-brEmployees}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-29 RECT-57 RECT-71 BTSBACK btssearch ~
fiEmpName fiEmail fiEmpID btsNext BTSDELETE btnInactive btsprev BTSUPDATE ~
BTSSAVE btsclear brEmployees 
&Scoped-Define DISPLAYED-OBJECTS fiEmpName fiEmail fiEmpID 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VARIABLE C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE VARIABLE fiEmpStatus AS CHARACTER FORMAT "X(26)":U 
     LABEL "Employee Status" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","Active","InActive" 
     DROP-DOWN-LIST
     SIZE 24 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiDepartment AS CHARACTER FORMAT "X(16)":U 
     LABEL "DepartMent" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiDesignation AS CHARACTER FORMAT "X(20)":U 
     LABEL "Designation" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiDOJ AS DATE FORMAT "99/99/99":U 
     LABEL "Date Of Joining" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiFirstName AS CHARACTER FORMAT "X(56)":U 
     LABEL "First Name" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiLastName AS CHARACTER FORMAT "X(56)":U 
     LABEL "Last Name" 
     VIEW-AS FILL-IN 
     SIZE 24 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE cbMonthName AS CHARACTER FORMAT "X(256)":U 
     LABEL "MONTH NAMES" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","January","February","March","April","May","June","July","August","September","October","November","December" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE cbYear AS CHARACTER FORMAT "X(256)":U 
     LABEL "YEAR" 
     VIEW-AS COMBO-BOX INNER-LINES 5
     LIST-ITEMS "","2024","2025","2026","2027","2028" 
     DROP-DOWN-LIST
     SIZE 16 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiApprovedBy AS CHARACTER FORMAT "X(26)":U 
     LABEL "Employee Leave Approved Name" 
     VIEW-AS FILL-IN 
     SIZE 29 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiEmployeeMonthlyHours AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Employee Working Hours" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiEmployeeWorkingDays AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Office Working Days" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiLeaveType AS CHARACTER FORMAT "X(26)":U 
     LABEL "Employee LeaveType" 
     VIEW-AS FILL-IN 
     SIZE 28.8 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiMonthlyWorkingDays AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Employee Monthly Workng Days" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiMonthlyWorkingHours AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Monthly Working Hours" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiOfficeDailyHours AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Employee Office Working Hours" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiTotalLeaves AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Total Leave Details" 
     VIEW-AS FILL-IN 
     SIZE 18 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiAddress AS CHARACTER FORMAT "X(76)":U 
     LABEL "Employee Address" 
     VIEW-AS FILL-IN 
     SIZE 39.8 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiDOB AS DATE FORMAT "99/99/99":U 
     LABEL "Employee DOB" 
     VIEW-AS FILL-IN 
     SIZE 33.2 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiGender AS CHARACTER FORMAT "X(26)":U 
     LABEL "Employee Gender" 
     VIEW-AS FILL-IN 
     SIZE 29.8 BY 1
     FONT 6 NO-UNDO.

DEFINE VARIABLE fiPhone AS CHARACTER FORMAT "X(10)":U 
     LABEL "Employee Phone Number" 
     VIEW-AS FILL-IN 
     SIZE 30 BY 1
     FONT 6 NO-UNDO.

DEFINE BUTTON btnInactive 
     LABEL "INACTIVE EMPLOYEE" 
     SIZE 33 BY 1.14
     BGCOLOR 11 .

DEFINE BUTTON btsadd 
     LABEL "ADD" 
     SIZE 15 BY 1.14
     BGCOLOR 11 .

DEFINE BUTTON BTSBACK 
     LABEL "BACK" 
     SIZE 15 BY 1.14
     BGCOLOR 11 .

DEFINE BUTTON btsclear AUTO-GO 
     LABEL "CLEAR" 
     SIZE 16 BY 1.14
     BGCOLOR 11 .

DEFINE BUTTON BTSDELETE 
     LABEL "DEACTIVATE" 
     SIZE 17 BY 1.14
     BGCOLOR 11 .

DEFINE BUTTON btsNext 
     LABEL ">>>" 
     SIZE 15 BY 1.14
     BGCOLOR 12 .

DEFINE BUTTON btsprev 
     LABEL "<<<" 
     SIZE 15 BY 1.14
     BGCOLOR 12 .

DEFINE BUTTON BTSSAVE 
     LABEL "SAVE" 
     SIZE 15 BY 1.14
     BGCOLOR 11 .

DEFINE BUTTON btssearch 
     LABEL "Search" 
     SIZE 18 BY 1.38
     BGCOLOR 11 .

DEFINE BUTTON BTSUPDATE 
     LABEL "UPDATE" 
     SIZE 15 BY 1.14
     BGCOLOR 11 .

DEFINE VARIABLE fiEmail AS CHARACTER FORMAT "X(56)":U 
     LABEL "Employee Mail" 
     VIEW-AS FILL-IN 
     SIZE 48 BY 1
     FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiEmpID AS INTEGER FORMAT "->,>>>,>>9":U INITIAL 0 
     LABEL "Employee ID" 
     VIEW-AS FILL-IN 
     SIZE 14 BY 1
     BGCOLOR 4 FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE VARIABLE fiEmpName AS CHARACTER FORMAT "X(56)":U 
     LABEL "Employee Name" 
     VIEW-AS FILL-IN 
     SIZE 37 BY 1
     FGCOLOR 0 FONT 6 NO-UNDO.

DEFINE RECTANGLE RECT-29
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 247 BY 3.81
     BGCOLOR 15 FGCOLOR 4 .

DEFINE RECTANGLE RECT-57
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 247 BY 1.91
     BGCOLOR 15 .

DEFINE RECTANGLE RECT-71
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 247 BY 13.38
     BGCOLOR 8 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brEmployees FOR 
      ttDetails, 
      ttAdmin SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brEmployees
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brEmployees C-Win _FREEFORM
  QUERY brEmployees DISPLAY
      ttDetails.EmpID
    ttDetails.EmpName
    ttDetails.Email
    ttDetails.Gender WIDTH 12
    ttDetails.Phone WIDTH 15
    ttAdmin.Department
    ttAdmin.Designation
    ttAdmin.EmpStatus
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-BOX NO-ROW-MARKERS SEPARATORS SIZE 247 BY 13.43
         BGCOLOR 4 FGCOLOR 0 FONT 6 ROW-HEIGHT-CHARS .86 FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME frMain
     BTSBACK AT ROW 1.29 COL 2 WIDGET-ID 40
     btssearch AT ROW 2.29 COL 217 WIDGET-ID 10
     fiEmpName AT ROW 2.67 COL 79.4 COLON-ALIGNED WIDGET-ID 4
     fiEmail AT ROW 2.67 COL 147 COLON-ALIGNED WIDGET-ID 6
     fiEmpID AT ROW 2.76 COL 21 COLON-ALIGNED WIDGET-ID 2
     btsNext AT ROW 17.91 COL 223.6 WIDGET-ID 18
     BTSDELETE AT ROW 17.95 COL 148.8 WIDGET-ID 28
     btnInactive AT ROW 17.95 COL 176.2 WIDGET-ID 48
     btsprev AT ROW 18 COL 8 WIDGET-ID 16
     btsadd AT ROW 18 COL 34 WIDGET-ID 22
     BTSUPDATE AT ROW 18 COL 62.2 WIDGET-ID 24
     BTSSAVE AT ROW 18 COL 89.6 WIDGET-ID 26
     btsclear AT ROW 18 COL 118.6 WIDGET-ID 44
     brEmployees AT ROW 19.48 COL 1 WIDGET-ID 500
     RECT-29 AT ROW 1 COL 1 WIDGET-ID 12
     RECT-57 AT ROW 17.67 COL 1 WIDGET-ID 42
     RECT-71 AT ROW 4.29 COL 1 WIDGET-ID 46
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1.67
         SIZE 262 BY 37.1
         BGCOLOR 15 FGCOLOR 0 FONT 6 WIDGET-ID 100.

DEFINE FRAME frAttendance
     cbYear AT ROW 1.24 COL 13 COLON-ALIGNED WIDGET-ID 24
     cbMonthName AT ROW 1.24 COL 53 COLON-ALIGNED WIDGET-ID 26
     fiOfficeDailyHours AT ROW 2.43 COL 42.2 COLON-ALIGNED WIDGET-ID 4
     fiEmployeeWorkingDays AT ROW 3.62 COL 42.2 COLON-ALIGNED WIDGET-ID 6
     fiMonthlyWorkingDays AT ROW 4.81 COL 42.2 COLON-ALIGNED WIDGET-ID 2
     fiMonthlyWorkingHours AT ROW 6 COL 42.2 COLON-ALIGNED WIDGET-ID 8
     fiEmployeeMonthlyHours AT ROW 7.43 COL 42.2 COLON-ALIGNED WIDGET-ID 12
     fiTotalLeaves AT ROW 8.62 COL 42.2 COLON-ALIGNED WIDGET-ID 14
     fiLeaveType AT ROW 9.81 COL 42.2 COLON-ALIGNED WIDGET-ID 18
     fiApprovedBy AT ROW 11 COL 42.4 COLON-ALIGNED WIDGET-ID 20
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 157 ROW 4.67
         SIZE 75 BY 12.43
         FONT 5
         TITLE "Attendance Overview" WIDGET-ID 400.

DEFINE FRAME frEmpDetails
     fiDOB AT ROW 3 COL 19.8 COLON-ALIGNED WIDGET-ID 2
     fiGender AT ROW 4.91 COL 23.2 COLON-ALIGNED WIDGET-ID 4
     fiAddress AT ROW 6.57 COL 24.2 COLON-ALIGNED WIDGET-ID 6
     fiPhone AT ROW 8.48 COL 32.2 COLON-ALIGNED WIDGET-ID 8
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 83 ROW 4.62
         SIZE 66 BY 12.48
         FONT 5
         TITLE "Employee Details" WIDGET-ID 300.

DEFINE FRAME frAdminDetails
     fiFirstName AT ROW 1.95 COL 26.4 COLON-ALIGNED WIDGET-ID 2
     fiLastName AT ROW 3.62 COL 26.4 COLON-ALIGNED WIDGET-ID 4
     fiDOJ AT ROW 5.29 COL 26.4 COLON-ALIGNED WIDGET-ID 6
     fiDesignation AT ROW 7.19 COL 26.4 COLON-ALIGNED WIDGET-ID 8
     fiDepartment AT ROW 8.86 COL 26.4 COLON-ALIGNED WIDGET-ID 10
     fiEmpStatus AT ROW 10.48 COL 26.4 COLON-ALIGNED WIDGET-ID 14
    WITH 1 DOWN KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 8 ROW 4.57
         SIZE 66 BY 12.52
         BGCOLOR 7 FONT 5
         TITLE "Employee Master" WIDGET-ID 200.


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
         TITLE              = "EMPLOYEE-DETAILS"
         HEIGHT             = 32.76
         WIDTH              = 247.8
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
ASSIGN FRAME frAdminDetails:FRAME = FRAME frMain:HANDLE
       FRAME frAttendance:FRAME = FRAME frMain:HANDLE
       FRAME frEmpDetails:FRAME = FRAME frMain:HANDLE.

/* SETTINGS FOR FRAME frAdminDetails
                                                                        */
/* SETTINGS FOR FRAME frAttendance
                                                                        */
/* SETTINGS FOR COMBO-BOX cbMonthName IN FRAME frAttendance
   NO-DISPLAY                                                           */
/* SETTINGS FOR FILL-IN fiApprovedBy IN FRAME frAttendance
   NO-ENABLE                                                            */
ASSIGN 
       fiApprovedBy:READ-ONLY IN FRAME frAttendance        = TRUE.

/* SETTINGS FOR FILL-IN fiEmployeeMonthlyHours IN FRAME frAttendance
   NO-ENABLE                                                            */
ASSIGN 
       fiEmployeeMonthlyHours:READ-ONLY IN FRAME frAttendance        = TRUE.

/* SETTINGS FOR FILL-IN fiEmployeeWorkingDays IN FRAME frAttendance
   NO-ENABLE                                                            */
ASSIGN 
       fiEmployeeWorkingDays:READ-ONLY IN FRAME frAttendance        = TRUE.

/* SETTINGS FOR FILL-IN fiLeaveType IN FRAME frAttendance
   NO-ENABLE                                                            */
ASSIGN 
       fiLeaveType:READ-ONLY IN FRAME frAttendance        = TRUE.

/* SETTINGS FOR FILL-IN fiMonthlyWorkingDays IN FRAME frAttendance
   NO-ENABLE                                                            */
ASSIGN 
       fiMonthlyWorkingDays:READ-ONLY IN FRAME frAttendance        = TRUE.

/* SETTINGS FOR FILL-IN fiMonthlyWorkingHours IN FRAME frAttendance
   NO-ENABLE                                                            */
ASSIGN 
       fiMonthlyWorkingHours:READ-ONLY IN FRAME frAttendance        = TRUE.

/* SETTINGS FOR FILL-IN fiOfficeDailyHours IN FRAME frAttendance
   NO-ENABLE                                                            */
ASSIGN 
       fiOfficeDailyHours:READ-ONLY IN FRAME frAttendance        = TRUE.

/* SETTINGS FOR FILL-IN fiTotalLeaves IN FRAME frAttendance
   NO-ENABLE                                                            */
ASSIGN 
       fiTotalLeaves:READ-ONLY IN FRAME frAttendance        = TRUE.

/* SETTINGS FOR FRAME frEmpDetails
                                                                        */
/* SETTINGS FOR FRAME frMain
   FRAME-NAME                                                           */
/* BROWSE-TAB brEmployees btsclear frMain */
/* SETTINGS FOR BUTTON btsadd IN FRAME frMain
   NO-ENABLE                                                            */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brEmployees
/* Query rebuild information for BROWSE brEmployees
     _START_FREEFORM
OPEN QUERY brEmployees FOR
    EACH ttDetails NO-LOCK,
    EACH ttAdmin NO-LOCK WHERE ttAdmin.EmpID = ttDetails.EmpID
    BY ttDetails.EmpID.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brEmployees */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* EMPLOYEE-DETAILS */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* EMPLOYEE-DETAILS */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME frMain
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL frMain C-Win
ON GO OF FRAME frMain
DO:
  //FIND FOR
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnInactive
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnInactive C-Win
ON CHOOSE OF btnInactive IN FRAME frMain /* INACTIVE EMPLOYEE */
DO:
   APPLY "close" TO THIS-PROCEDURE.
   RUN InactiveEmployees.w.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btsadd
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btsadd C-Win
ON CHOOSE OF btsadd IN FRAME frMain /* ADD */
DO:
  RUN p_add.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTSBACK
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTSBACK C-Win
ON CHOOSE OF BTSBACK IN FRAME frMain /* BACK */
DO:
  APPLY "close" TO THIS-PROCEDURE.
  RUN PAYROLL\DASH1-BOARD.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btsclear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btsclear C-Win
ON CHOOSE OF btsclear IN FRAME frMain /* CLEAR */
DO  :
/* WITH FRAME DEFAULT-FRAME */
    
  //RUN P_CLEAR.
  fiEmpName:CLEAR().
  fiEmail:CLEAR() .
 
  CLEAR FRAME     frAdminDetails.
  CLEAR FRAME     frEmpDetails.
  CLEAR FRAME      frAttendance.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTSDELETE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTSDELETE C-Win
ON CHOOSE OF BTSDELETE IN FRAME frMain /* DEACTIVATE */
DO:
  RUN p_deactivate.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btsNext
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btsNext C-Win
ON CHOOSE OF btsNext IN FRAME frMain /* >>> */
DO:
    RUN p_next.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btsprev
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btsprev C-Win
ON CHOOSE OF btsprev IN FRAME frMain /* <<< */
DO:
  RUN P_Prev.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTSSAVE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTSSAVE C-Win
ON CHOOSE OF BTSSAVE IN FRAME frMain /* SAVE */
DO:
 RUN p_save.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btssearch
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btssearch C-Win
ON CHOOSE OF btssearch IN FRAME frMain /* Search */
DO:
  RUN p_find.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME BTSUPDATE
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL BTSUPDATE C-Win
ON CHOOSE OF BTSUPDATE IN FRAME frMain /* UPDATE */
DO:
  RUN p_update.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frAttendance
&Scoped-define SELF-NAME cbMonthName
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbMonthName C-Win
ON VALUE-CHANGED OF cbMonthName IN FRAME frAttendance /* MONTH NAMES */
DO:
  RUN p_LoadAttendance.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME cbYear
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL cbYear C-Win
ON VALUE-CHANGED OF cbYear IN FRAME frAttendance /* YEAR */
DO:
  RUN p_LoadAttendance.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define FRAME-NAME frMain
&Scoped-define BROWSE-NAME brEmployees
&UNDEFINE SELF-NAME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CUSTOM _MAIN-BLOCK C-Win 


/* ***************************  Main Block  *************************** */
/*
  Purpose:
*/

ASSIGN CURRENT-WINDOW                 = {&WINDOW-NAME}
       THIS-PROCEDURE:CURRENT-WINDOW  = {&WINDOW-NAME}.

ON CLOSE OF THIS-PROCEDURE
    RUN disable_UI.

PAUSE 0 BEFORE-HIDE.

/* ======================= MAIN PROCESS ======================= */
MAIN-BLOCK:
DO ON ERROR    UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK
   ON END-KEY  UNDO MAIN-BLOCK, LEAVE MAIN-BLOCK:
   
    RUN enable_UI. 
    RUN PAYROLL\Procedures\EmployeeAllTables.p ( INPUT-OUTPUT TABLE ttadmin,
                                                 INPUT-OUTPUT TABLE ttdetails,
                                                 INPUT-OUTPUT TABLE ttattendance,
                                                 INPUT-OUTPUT TABLE ttsalary,
                                                 OUTPUT opRes                                          
                                                 ).                       

    /* Initialize Window Components */
    RUN p_Initialize.


    ASSIGN iMonthNumber = MONTH(TODAY)
           iCurrentYear = YEAR(TODAY).

    CASE iMonthNumber:
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

    /* Assign Default Values to Combo Boxes */
    ASSIGN cbMonthName:SCREEN-VALUE IN FRAME frAttendance = cMonthName
           cbYear:SCREEN-VALUE      IN FRAME frAttendance = STRING(iCurrentYear).

    
    IF NOT THIS-PROCEDURE:PERSISTENT THEN
        WAIT-FOR CLOSE OF THIS-PROCEDURE.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


/* **********************  Internal Procedures  *********************** */

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE ClearAttendanceFields C-Win 
PROCEDURE ClearAttendanceFields :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DO WITH FRAME frAttendance:
    ASSIGN cbMonthName:SCREEN-VALUE             = ""
           cbYear:SCREEN-VALUE                  = ""
           fiOfficeDailyHours:SCREEN-VALUE      = "0"
           fiEmployeeWorkingDays:SCREEN-VALUE   = "0"
           fiMonthlyWorkingDays:SCREEN-VALUE    = "0"
           fiMonthlyWorkingHours:SCREEN-VALUE   = "0"
           fiEmployeeMonthlyHours:SCREEN-VALUE  = "0"
           fiTotalLeaves:SCREEN-VALUE           = "0"
           fiLeaveType:SCREEN-VALUE             = ""
           fiApprovedBy:SCREEN-VALUE            = ""
           
           cbMonthName:SENSITIVE                = TRUE
           cbYear:SENSITIVE                     = TRUE
           fiOfficeDailyHours:SENSITIVE         = TRUE
           fiEmployeeWorkingDays:SENSITIVE      = TRUE
           fiMonthlyWorkingDays:SENSITIVE       = TRUE
           fiMonthlyWorkingHours:SENSITIVE      = TRUE
           fiEmployeeMonthlyHours:SENSITIVE     = TRUE
           fiTotalLeaves:SENSITIVE              = TRUE
           fiLeaveType:SENSITIVE                = TRUE
           fiApprovedBy:SENSITIVE               = TRUE.
    END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

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
  DISPLAY fiEmpName fiEmail fiEmpID 
      WITH FRAME frMain IN WINDOW C-Win.
  ENABLE RECT-29 RECT-57 RECT-71 BTSBACK btssearch fiEmpName fiEmail fiEmpID 
         btsNext BTSDELETE btnInactive btsprev BTSUPDATE BTSSAVE btsclear 
         brEmployees 
      WITH FRAME frMain IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frMain}
  DISPLAY fiFirstName fiLastName fiDOJ fiDesignation fiDepartment fiEmpStatus 
      WITH FRAME frAdminDetails IN WINDOW C-Win.
  ENABLE fiFirstName fiLastName fiDOJ fiDesignation fiDepartment fiEmpStatus 
      WITH FRAME frAdminDetails IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frAdminDetails}
  DISPLAY fiDOB fiGender fiAddress fiPhone 
      WITH FRAME frEmpDetails IN WINDOW C-Win.
  ENABLE fiDOB fiGender fiAddress fiPhone 
      WITH FRAME frEmpDetails IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frEmpDetails}
  DISPLAY cbYear fiOfficeDailyHours fiEmployeeWorkingDays fiMonthlyWorkingDays 
          fiMonthlyWorkingHours fiEmployeeMonthlyHours fiTotalLeaves fiLeaveType 
          fiApprovedBy 
      WITH FRAME frAttendance IN WINDOW C-Win.
  ENABLE cbYear cbMonthName 
      WITH FRAME frAttendance IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-frAttendance}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_add C-Win 
PROCEDURE p_add :
/*------------------------------------------------------------------------------
  Purpose:
  Parameters: 
  Notes:      
------------------------------------------------------------------------------*/
DEFINE VARIABLE lConfirm AS LOGICAL NO-UNDO.
DEFINE VARIABLE iNextEmpID AS INTEGER NO-UNDO.

MESSAGE "Do you really want to add a new employee?"
    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE lConfirm.

IF NOT lConfirm THEN RETURN.

/* Generate next Employee ID */
FIND LAST ttAdmin USE-INDEX EmpID NO-LOCK NO-ERROR.
ASSIGN iNextEmpID = IF AVAILABLE ttAdmin THEN ttAdmin.EmpID + 1 ELSE 1001.

/* === Clear and Enable all fields === */
DO WITH FRAME frMain:
    ASSIGN fiEmpID:SCREEN-VALUE   = STRING(iNextEmpID)
           fiEmpName:SCREEN-VALUE = ""
           fiEmail:SCREEN-VALUE   = ""
           fiEmpID:SENSITIVE      = FALSE
           fiEmpName:SENSITIVE    = TRUE
           fiEmail:SENSITIVE      = TRUE.
    APPLY "ENTRY" TO fiEmpName.
END.

DO WITH FRAME frEmpDetails:
    ASSIGN fiDOB:SCREEN-VALUE     = ""
           fiAddress:SCREEN-VALUE = ""
           fiPhone:SCREEN-VALUE   = ""
           fiGender:SCREEN-VALUE  = ""
           fiDOB:SENSITIVE        = TRUE
           fiGender:SENSITIVE     = TRUE
           fiAddress:SENSITIVE    = TRUE
           fiPhone:SENSITIVE      = TRUE.
END.

DO WITH FRAME frAdminDetails:
    ASSIGN fiFirstName:SCREEN-VALUE   = ""
           fiLastName:SCREEN-VALUE    = ""
           fiDOJ:SCREEN-VALUE         = ""
           fiDesignation:SCREEN-VALUE = ""
           fiDepartment:SCREEN-VALUE  = ""
           fiEmpStatus:SCREEN-VALUE   = ""
           fiFirstName:SENSITIVE      = TRUE
           fiLastName:SENSITIVE       = TRUE
           fiDOJ:SENSITIVE            = TRUE
           fiDesignation:SENSITIVE    = TRUE
           fiDepartment:SENSITIVE     = TRUE
           fiEmpStatus:SENSITIVE      = TRUE.
END.

MESSAGE "New employee initialized with ID " STRING(iNextEmpID)
    VIEW-AS ALERT-BOX INFO BUTTONS OK.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_deactivate C-Win 
PROCEDURE p_deactivate :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE iEmpID      AS INTEGER   NO-UNDO.
DEFINE VARIABLE cMessage    AS CHARACTER NO-UNDO.
DEFINE VARIABLE lConfirm    AS LOGICAL   NO-UNDO.
DEFINE VARIABLE cOTP        AS CHARACTER NO-UNDO.
DEFINE VARIABLE cUserOTP    AS CHARACTER NO-UNDO.
DEFINE VARIABLE cFrom       AS CHARACTER NO-UNDO.
DEFINE VARIABLE cPassword   AS CHARACTER NO-UNDO.
DEFINE VARIABLE oClient     AS System.Net.Mail.SmtpClient        NO-UNDO.
DEFINE VARIABLE oMessage    AS System.Net.Mail.MailMessage       NO-UNDO.
DEFINE VARIABLE oCred       AS System.Net.NetworkCredential      NO-UNDO.
DEFINE VARIABLE fromAddr    AS System.Net.Mail.MailAddress       NO-UNDO.
DEFINE VARIABLE toAddr      AS System.Net.Mail.MailAddress       NO-UNDO.

/* === Step 1: Get Employee ID === */
ASSIGN iEmpID = INTEGER(fiEmpID:SCREEN-VALUE IN FRAME frMain).

IF iEmpID = 0 THEN DO:
    MESSAGE "Please select a valid Employee record."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.

/* === Step 2: Confirm deactivation intent === */
MESSAGE 
    "You are requesting to deactivate Employee ID: " + STRING(iEmpID) + "." SKIP
    "This action will disable the employee from all payroll activities." SKIP
    "Do you want to continue?"
VIEW-AS ALERT-BOX QUESTION BUTTONS OK-CANCEL UPDATE lConfirm.

IF NOT lConfirm THEN RETURN.

/* === Step 3: Generate OTP === */
/* Generate OTP */
cOTP = STRING(RANDOM(100000,999999)).


DEFINE VARIABLE oMsg      AS System.Net.Mail.MailMessage NO-UNDO.

ASSIGN
    cFrom     = "sriharshabobbi52@gmail.com"
    cPassword = "pvnp sfep mdzt dtso".   /* App Password */

/* SMTP Setup */
oCred   = NEW System.Net.NetworkCredential(cFrom, cPassword).
oClient = NEW System.Net.Mail.SmtpClient("smtp.gmail.com", 587).

oClient:EnableSsl             = TRUE.
oClient:UseDefaultCredentials = FALSE.
oClient:Credentials           = oCred.

/* Build Email */
oMsg = NEW System.Net.Mail.MailMessage(cFrom, cFrom).
oMsg:Subject = "OTP for Employee Deactivation".
oMsg:Body    = "Your OTP is: " + cOTP + CHR(10) + "Do not share this OTP.".

/* Send Email */
oClient:Send(oMsg).

DELETE OBJECT oMsg NO-ERROR.

/* Inform the user */
MESSAGE "An OTP has been sent your registered admin email address." VIEW-AS ALERT-BOX INFO.

DELETE OBJECT toAddr   NO-ERROR.
DELETE OBJECT fromAddr NO-ERROR.

/* === Step 6: Define OTP UI === */
DEFINE VARIABLE fiOTP     AS CHARACTER NO-UNDO VIEW-AS FILL-IN SIZE 25 BY 1.
DEFINE BUTTON   btnVerify LABEL "Verify OTP" SIZE 15 BY 1.
DEFINE BUTTON   btnCancel LABEL "Cancel"     SIZE 15 BY 1.

/* OTP Frame — AppBuilder-compatible, no WIDTH/HEIGHT attributes */
DEFINE FRAME frOTP
    SKIP(1)
    fiOTP LABEL "Enter OTP:" AT ROW 2 COL 10
    SKIP(1)
    btnVerify AT ROW 4 COL 10
    btnCancel AT ROW 4 COL 30
    SKIP(1)
    WITH
        CENTERED
        TITLE "OTP Verification".
/* === Step 7: Trigger for Verify button === */
ON CHOOSE OF btnVerify IN FRAME frOTP DO:
    ASSIGN cUserOTP = fiOTP:SCREEN-VALUE IN FRAME frOTP.

    IF cUserOTP = cOTP THEN DO:
        MESSAGE "Successfully deactivated this employee."
            VIEW-AS ALERT-BOX INFO.

        /* Call your deactivate procedure */
        RUN Procedures/employee/spEmployeeDeactivate.p (
            INPUT iEmpID,
            OUTPUT cMessage,
            INPUT-OUTPUT TABLE ttAdmin
        ).

        MESSAGE cMessage VIEW-AS ALERT-BOX INFO.

        /* Reload tables and browse */
        RUN PAYROLL/Procedures/EmployeeAllTables.p (
            INPUT-OUTPUT TABLE ttAdmin,
            INPUT-OUTPUT TABLE ttDetails,
            INPUT-OUTPUT TABLE ttAttendance,
            INPUT-OUTPUT TABLE ttSalary,
            OUTPUT opRes
        ).
        RUN p_Initialize.
        OPEN QUERY brEmployees FOR
            EACH ttDetails NO-LOCK,
            EACH ttAdmin NO-LOCK 
                WHERE ttAdmin.EmpID = ttDetails.EmpID
                  AND UPPER(ttAdmin.EmpStatus) = "ACTIVE"
            BY ttDetails.EmpID.
        fiEmpStatus:SCREEN-VALUE IN FRAME frAdminDetails = "Inactive".

        HIDE FRAME frOTP.
    END.
    ELSE DO:
        MESSAGE "Invalid OTP. Deactivation canceled."
            VIEW-AS ALERT-BOX ERROR.
        HIDE FRAME frOTP.
    END.
END.

/* === Step 8: Trigger for Cancel button === */
ON CHOOSE OF btnCancel IN FRAME frOTP DO:
    MESSAGE "Deactivation canceled by admin."
        VIEW-AS ALERT-BOX INFO.
    HIDE FRAME frOTP.
END.

/* === Step 9: Show OTP frame === */

ENABLE fiOTP btnVerify btnCancel WITH FRAME frOTP.
VIEW FRAME frOTP.

/* Allow UI events for OTP pop-up */
WAIT-FOR CHOOSE OF btnVerify IN FRAME frOTP
     OR CHOOSE OF btnCancel IN FRAME frOTP.

END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_DisplayEmployee C-Win 
PROCEDURE p_DisplayEmployee :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE INPUT PARAMETER ipEmpID AS INTEGER NO-UNDO.

DEFINE VARIABLE cMonth AS CHARACTER NO-UNDO.
DEFINE VARIABLE cYear  AS CHARACTER NO-UNDO.

ASSIGN
    cMonth = TRIM(cbMonthName:SCREEN-VALUE IN FRAME frAttendance)
    cYear  = TRIM(cbYear:SCREEN-VALUE IN FRAME frAttendance).


FIND FIRST ttDetails WHERE ttDetails.EmpID = ipEmpID NO-LOCK NO-ERROR.

IF AVAILABLE ttDetails THEN DO:

    /* ---- frMain ---- */
    DO WITH FRAME frMain:
        ASSIGN
            fiEmpID:SCREEN-VALUE    = STRING(ttDetails.EmpID)
            fiEmpName:SCREEN-VALUE  = ttDetails.EmpName
            fiEmail:SCREEN-VALUE    = ttDetails.Email
            fiEmpID:SENSITIVE       = TRUE
            fiEmpName:SENSITIVE     = FALSE
            fiEmail:SENSITIVE       = FALSE.
    END.

    /* ---- frEmpDetails ---- */
    DO WITH FRAME frEmpDetails:
        ASSIGN
            fiDOB:SCREEN-VALUE     = STRING(ttDetails.DOB, "99/99/9999")
            fiGender:SCREEN-VALUE  = ttDetails.Gender
            fiAddress:SCREEN-VALUE = ttDetails.Address
            fiPhone:SCREEN-VALUE   = ttDetails.Phone
            fiDOB:SENSITIVE        = FALSE
            fiGender:SENSITIVE     = FALSE
            fiAddress:SENSITIVE    = FALSE
            fiPhone:SENSITIVE      = FALSE.
    END.
END.

FIND FIRST ttAdmin WHERE ttAdmin.EmpID = ipEmpID NO-LOCK NO-ERROR.

IF AVAILABLE ttAdmin THEN DO WITH FRAME frAdminDetails:
    ASSIGN 
        fiFirstName:SCREEN-VALUE   = ttAdmin.FirstName
        fiLastName:SCREEN-VALUE    = ttAdmin.LastName
        fiDOJ:SCREEN-VALUE         = STRING(ttAdmin.DOJ, "99/99/9999")
        fiDesignation:SCREEN-VALUE = ttAdmin.Designation
        fiDepartment:SCREEN-VALUE  = ttAdmin.Department
        fiEmpStatus:SCREEN-VALUE   = ttAdmin.EmpStatus
        fiFirstName:SENSITIVE      = FALSE
        fiLastName:SENSITIVE       = FALSE
        fiDOJ:SENSITIVE            = FALSE
        fiDesignation:SENSITIVE    = FALSE
        fiDepartment:SENSITIVE     = FALSE
        fiEmpStatus:SENSITIVE      = FALSE.
END.

FIND FIRST ttAttendance NO-LOCK
     WHERE ttAttendance.EmpID = ipEmpID
       AND (cMonth = "" OR UPPER(ttAttendance.MonthNames) = UPPER(cMonth))
       AND (cYear  = "" OR STRING(ttAttendance.Year) = cYear)
     NO-ERROR.

DO WITH FRAME frAttendance:

    IF AVAILABLE ttAttendance THEN
        ASSIGN
            cbMonthName:SCREEN-VALUE            = ttAttendance.MonthNames
            cbYear:SCREEN-VALUE                 = STRING(ttAttendance.Year)
            fiOfficeDailyHours:SCREEN-VALUE     = STRING(ttAttendance.OfficeDailyWorkingHours)
            fiEmployeeWorkingDays:SCREEN-VALUE  = STRING(ttAttendance.EmployeeWorkingDays)
            fiMonthlyWorkingDays:SCREEN-VALUE   = STRING(ttAttendance.MonthlyWorkingDays)
            fiMonthlyWorkingHours:SCREEN-VALUE  = STRING(ttAttendance.MonthlyWorkingHours)
            fiEmployeeMonthlyHours:SCREEN-VALUE = STRING(ttAttendance.EmployeeMonthlyWorkingHours)
            fiTotalLeaves:SCREEN-VALUE          = STRING(ttAttendance.TotalLeaves)
            fiLeaveType:SCREEN-VALUE            = ttAttendance.LeaveType
            fiApprovedBy:SCREEN-VALUE           = ttAttendance.ApprovedBy
            cbMonthName:SENSITIVE               = TRUE
            cbYear:SENSITIVE                    = TRUE.
            

    ELSE
        ASSIGN
            cbMonthName:SCREEN-VALUE            = ""
            cbYear:SCREEN-VALUE                 = ""
            fiOfficeDailyHours:SCREEN-VALUE     = ""
            fiEmployeeWorkingDays:SCREEN-VALUE  = ""
            fiMonthlyWorkingDays:SCREEN-VALUE   = ""
            fiMonthlyWorkingHours:SCREEN-VALUE  = ""
            fiEmployeeMonthlyHours:SCREEN-VALUE = ""
            fiTotalLeaves:SCREEN-VALUE          = ""
            fiLeaveType:SCREEN-VALUE            = "N/A"
            fiApprovedBy:SCREEN-VALUE           = "N/A"
            cbMonthName:SENSITIVE               = TRUE
            cbYear:SENSITIVE                    = TRUE.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_find C-Win 
PROCEDURE p_find :
/*------------------------------------------------------------------------------
  Purpose:   
  Notes:      
------------------------------------------------------------------------------*/
DEFINE VARIABLE opResult AS CHARACTER NO-UNDO.
DEFINE VARIABLE iEmpID   AS INTEGER   NO-UNDO.

/* Get entered Employee ID */
ASSIGN iEmpID = INTEGER(fiEmpID:SCREEN-VALUE IN FRAME frMain).

/* ------------------------------------------
   1) Build navigation list of ONLY ACTIVE employees
   ------------------------------------------ */
EMPTY TEMP-TABLE ttDetails.

FOR EACH EmployeeDetails NO-LOCK,
    EACH EmployeeMaster NO-LOCK
        WHERE EmployeeMaster.EmpID = EmployeeDetails.EmpID
          AND UPPER(EmployeeMaster.EmpStatus) = "ACTIVE"
    BY EmployeeDetails.EmpID:

    CREATE ttDetails.
    BUFFER-COPY EmployeeDetails TO ttDetails.
END.

/* ------------------------------------------
   2) Call SP — but DO NOT let it overwrite ttDetails!
   ------------------------------------------ */
EMPTY TEMP-TABLE ttDetails2.
EMPTY TEMP-TABLE ttAdmin.

RUN PAYROLL/Procedures/employee/spFindEmployeeDetails.p
(
    INPUT  iEmpID,
    OUTPUT opResult,
    OUTPUT TABLE ttDetails2,   /* SP OUTPUT ? SEPARATE TT */
    OUTPUT TABLE ttAdmin
).

/* ------------------------------------------
   3) Check if employee NOT found
   ------------------------------------------ */
IF opResult BEGINS "Error" THEN DO:
    MESSAGE "Employee ID " + STRING(iEmpID) + " not found."
        VIEW-AS ALERT-BOX ERROR.
    RUN ClearAttendanceFields.
    RETURN.
END.

/* ------------------------------------------
   4) Check if employee is INACTIVE
   ------------------------------------------ */
FIND FIRST ttAdmin WHERE ttAdmin.EmpID = iEmpID NO-LOCK NO-ERROR.

IF AVAILABLE ttAdmin THEN DO:
    IF UPPER(ttAdmin.EmpStatus) BEGINS "INACT" THEN DO:

        MESSAGE
            "Employee ID " + STRING(iEmpID) + " is INACTIVE." SKIP
            "Please check the Inactive Employee window."
            VIEW-AS ALERT-BOX WARNING.

        RUN ClearAttendanceFields.
        RETURN.   /* VERY IMPORTANT ? do NOT display employee */
    END.
END.

/* ------------------------------------------
   5) Position search EmpID inside navigation list (ttDetails)
   ------------------------------------------ */
FIND FIRST ttDetails WHERE ttDetails.EmpID = iEmpID NO-LOCK NO-ERROR.

/* ------------------------------------------
   6) Display the employee (based on ttDetails2)
   ------------------------------------------ */
RUN p_DisplayEmployee(iEmpID).
                                                                              
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_Initialize C-Win 
PROCEDURE p_Initialize :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* Clear temp-tables */
EMPTY TEMP-TABLE ttAdmin.
EMPTY TEMP-TABLE ttDetails.
EMPTY TEMP-TABLE ttAttendance.
EMPTY TEMP-TABLE ttSalary.

/* Load ONLY ACTIVE employees into ttAdmin */
FOR EACH EmployeeMaster NO-LOCK
    WHERE UPPER(EmployeeMaster.EmpStatus) = "ACTIVE":
    CREATE ttAdmin.
    BUFFER-COPY EmployeeMaster TO ttAdmin.
END.

/* Load ONLY ACTIVE employee details into ttDetails */
FOR EACH EmployeeDetails NO-LOCK:
    IF CAN-FIND(FIRST ttAdmin WHERE ttAdmin.EmpID = EmployeeDetails.EmpID) THEN DO:
        CREATE ttDetails.
        BUFFER-COPY EmployeeDetails TO ttDetails.
    END.
END.

/* Open browse shows only active employees */
OPEN QUERY brEmployees FOR
    EACH ttDetails NO-LOCK,
    EACH ttAdmin NO-LOCK WHERE ttAdmin.EmpID = ttDetails.EmpID
    BY ttDetails.EmpID.

/* Show FIRST active employee in form */
FIND FIRST ttDetails NO-LOCK NO-ERROR.
IF AVAILABLE ttDetails THEN
    RUN p_DisplayEmployee(ttDetails.EmpID).

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_LoadAttendance C-Win 
PROCEDURE p_LoadAttendance :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
DEFINE VARIABLE cMonth AS CHARACTER NO-UNDO.
DEFINE VARIABLE cYear  AS CHARACTER NO-UNDO.

ASSIGN 
    cMonth = TRIM(cbMonthName:SCREEN-VALUE IN FRAME frAttendance)
    cYear  = TRIM(cbYear:SCREEN-VALUE  IN FRAME frAttendance).

IF cMonth = "" OR cYear = "" THEN RETURN.

/* Call SP */
RUN PAYROLL/Procedures/employee/spLoadAttendance.p ( INPUT cMonth,
                                                     INPUT INTEGER(cYear),
                                                     OUTPUT TABLE ttattendance
                                                     ).

/* Load first attendance row */
FIND FIRST ttattendance NO-LOCK NO-ERROR.

IF AVAILABLE ttattendance THEN DO WITH FRAME frAttendance:

    ASSIGN
        fiOfficeDailyHours:SCREEN-VALUE      = STRING(ttattendance.OfficeDailyWorkingHours)
        fiEmployeeWorkingDays:SCREEN-VALUE   = STRING(ttattendance.EmployeeWorkingDays)
        fiMonthlyWorkingDays:SCREEN-VALUE    = STRING(ttattendance.MonthlyWorkingDays)
        fiMonthlyWorkingHours:SCREEN-VALUE   = STRING(ttattendance.MonthlyWorkingHours)
        fiEmployeeMonthlyHours:SCREEN-VALUE  = STRING(ttattendance.EmployeeMonthlyWorkingHours)
        fiTotalLeaves:SCREEN-VALUE           = STRING(ttattendance.TotalLeaves)
        fiLeaveType:SCREEN-VALUE             = ttattendance.LeaveType
        fiApprovedBy:SCREEN-VALUE            = ttattendance.ApprovedBy.
END.
ELSE DO:
 ASSIGN fiOfficeDailyHours:SCREEN-VALUE      = "0"
        fiEmployeeWorkingDays:SCREEN-VALUE   = "0"
        fiMonthlyWorkingDays:SCREEN-VALUE    = "0"
        fiMonthlyWorkingHours:SCREEN-VALUE   = "0"
        fiEmployeeMonthlyHours:SCREEN-VALUE  = "0"
        fiTotalLeaves:SCREEN-VALUE           = "0"
        fiLeaveType:SCREEN-VALUE             = "N/A"
        fiApprovedBy:SCREEN-VALUE            = "N/A". 
END.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_next C-Win 
PROCEDURE p_next :
/*------------------------------------------------------------------------------
  Purpose:
  Parameters: 
  Notes:      
------------------------------------------------------------------------------*/
FIND NEXT ttAdmin 
    WHERE UPPER(TRIM(ttAdmin.EmpStatus)) = "ACTIVE"
    NO-LOCK NO-ERROR.

IF NOT AVAILABLE ttAdmin THEN DO:
    MESSAGE "This is the last active employee." VIEW-AS ALERT-BOX INFO.
    RETURN.
END.

RUN p_DisplayEmployee(ttAdmin.EmpID).
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_prev C-Win 
PROCEDURE p_prev :
/*------------------------------------------------------------------------------
  Purpose:   
  Parameters:
  Notes:      
------------------------------------------------------------------------------*/
FIND PREV ttAdmin 
    WHERE UPPER(TRIM(ttAdmin.EmpStatus)) = "ACTIVE"
    NO-LOCK NO-ERROR.

IF NOT AVAILABLE ttAdmin THEN DO:
    MESSAGE "This is the first active employee." VIEW-AS ALERT-BOX INFO.
    RETURN.
END.

RUN p_DisplayEmployee(ttAdmin.EmpID).
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
{EmployeeSave.i}   

DEFINE VARIABLE lConfirm AS LOGICAL   NO-UNDO.
DEFINE VARIABLE opResult AS CHARACTER NO-UNDO.

/* Confirm Save */
MESSAGE "Do you want to save or update this employee record?"
    VIEW-AS ALERT-BOX QUESTION BUTTONS YES-NO UPDATE lConfirm.

IF NOT lConfirm THEN RETURN.

/* Collect values from UI */
ASSIGN
    iEmpID        = INTEGER(fiEmpID:SCREEN-VALUE       IN FRAME frMain)
    cEmpName      = fiEmpName:SCREEN-VALUE             IN FRAME frMain
    cEmail        = fiEmail:SCREEN-VALUE               IN FRAME frMain
    cDOB          = fiDOB:SCREEN-VALUE                 IN FRAME frEmpDetails
    cPhone        = fiPhone:SCREEN-VALUE               IN FRAME frEmpDetails
    cGender       = fiGender:SCREEN-VALUE              IN FRAME frEmpDetails
    cAddress      = fiAddress:SCREEN-VALUE             IN FRAME frEmpDetails
    cFirstName    = fiFirstName:SCREEN-VALUE           IN FRAME frAdminDetails
    cLastName     = fiLastName:SCREEN-VALUE            IN FRAME frAdminDetails
    cDOJ          = fiDOJ:SCREEN-VALUE                 IN FRAME frAdminDetails
    cDesignation  = fiDesignation:SCREEN-VALUE         IN FRAME frAdminDetails
    cDepartment   = fiDepartment:SCREEN-VALUE          IN FRAME frAdminDetails
    cEmpStatus    = fiEmpStatus:SCREEN-VALUE           IN FRAME frAdminDetails.

/* Save / Update via SP */
RUN PAYROLL\Procedures\employee\spEmployeeManager.p(
    INPUT "SAVE",
    INPUT iEmpID,
    INPUT cEmpName,
    INPUT cGender,
    INPUT cDOB,
    INPUT cPhone,
    INPUT cEmail,
    INPUT cAddress,
    INPUT cFirstName,
    INPUT cLastName,
    INPUT cDepartment,
    INPUT cDesignation,
    INPUT cDOJ,
    INPUT cEmpStatus,
    OUTPUT opResult
).

/* Error Handling */
IF opResult BEGINS "Error" THEN DO:
    MESSAGE opResult VIEW-AS ALERT-BOX ERROR.
    RETURN.
END.

/* Reload TT Tables */
RUN PAYROLL\Procedures\EmployeeAllTables.p (
    INPUT-OUTPUT TABLE ttadmin,
    INPUT-OUTPUT TABLE ttdetails,
    INPUT-OUTPUT TABLE ttattendance,
    INPUT-OUTPUT TABLE ttsalary,
    OUTPUT opRes
) NO-ERROR.

/* Refresh UI */
RUN p_initialize.

/* Lock fields again after saving */
DO WITH FRAME frMain:
    fiEmpID:SENSITIVE   = TRUE.
    fiEmpName:SENSITIVE = FALSE.
    fiEmail:SENSITIVE   = FALSE.
END.

DO WITH FRAME frEmpDetails:
    fiDOB:SENSITIVE     = FALSE.
    fiGender:SENSITIVE  = FALSE.
    fiAddress:SENSITIVE = FALSE.
    fiPhone:SENSITIVE   = FALSE.
END.

DO WITH FRAME frAdminDetails:
    fiFirstName:SENSITIVE   = FALSE.
    fiLastName:SENSITIVE    = FALSE.
    fiDOJ:SENSITIVE         = FALSE.
    fiDesignation:SENSITIVE = FALSE.
    fiDepartment:SENSITIVE  = FALSE.
    fiEmpStatus:SENSITIVE   = FALSE.
END.

MESSAGE "Employee saved successfully!"
    VIEW-AS ALERT-BOX INFO.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_update C-Win 
PROCEDURE p_update :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
/* local var */
DEFINE VARIABLE iEmployeeID AS INTEGER NO-UNDO.
/* get employee id */
iEmployeeID = INTEGER(fiEmpID:SCREEN-VALUE IN FRAME frMain).

IF iEmployeeID = 0 THEN DO:
    MESSAGE "Please find or select an employee record before editing."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.

/* find & lock employee details */
FIND ttdetails WHERE ttdetails.EmpID = iEmployeeID EXCLUSIVE-LOCK NO-ERROR.
IF NOT AVAILABLE ttdetails THEN DO:
    MESSAGE "Employee ID " iEmployeeID " not found for editing."
        VIEW-AS ALERT-BOX ERROR BUTTONS OK.
    RETURN.
END.

/* populate main frame */
DO WITH FRAME frMain:
    ASSIGN fiEmpID:SCREEN-VALUE   = STRING(ttdetails.EmpID)
           fiEmpName:SCREEN-VALUE = ttdetails.EmpName
           fiEmail:SCREEN-VALUE   = ttdetails.Email
           fiEmpID:SENSITIVE      = FALSE
           fiEmpName:SENSITIVE    = TRUE
           fiEmail:SENSITIVE      = TRUE.
END.

/* populate personal info */
DO WITH FRAME frEmpDetails:
    ASSIGN fiDOB:SCREEN-VALUE     = STRING(ttdetails.DOB, "99/99/9999")
           fiGender:SCREEN-VALUE  = ttdetails.Gender
           fiAddress:SCREEN-VALUE = ttdetails.Address
           fiPhone:SCREEN-VALUE   = ttdetails.Phone

           fiDOB:SENSITIVE        = TRUE
           fiGender:SENSITIVE     = TRUE
           fiAddress:SENSITIVE    = TRUE
           fiPhone:SENSITIVE      = TRUE.
END.

/* find & lock admin */
FIND ttAdmin WHERE ttAdmin.EmpID = iEmployeeID EXCLUSIVE-LOCK NO-ERROR.
IF AVAILABLE ttAdmin THEN DO WITH FRAME frAdminDetails:
    ASSIGN fiFirstName:SCREEN-VALUE   = ttAdmin.FirstName
           fiLastName:SCREEN-VALUE    = ttAdmin.LastName
           fiDOJ:SCREEN-VALUE         = STRING(ttAdmin.DOJ, "99/99/9999")
           fiDesignation:SCREEN-VALUE = ttAdmin.Designation
           fiDepartment:SCREEN-VALUE  = ttAdmin.Department
           fiEmpStatus:SCREEN-VALUE   = ttAdmin.EmpStatus

           fiFirstName:SENSITIVE      = TRUE
           fiLastName:SENSITIVE       = TRUE
           fiDOJ:SENSITIVE            = TRUE
           fiDesignation:SENSITIVE    = TRUE
           fiDepartment:SENSITIVE     = TRUE
           fiEmpStatus:SENSITIVE      = TRUE.
END.
ELSE DO:
    MESSAGE "Warning: Admin details not found. Creating a new Admin record upon save."
        VIEW-AS ALERT-BOX WARNING BUTTONS OK.
END.

/* find & lock attendance */
FIND ttattendance WHERE ttattendance.EmpID = iEmployeeID EXCLUSIVE-LOCK NO-ERROR.

DO WITH FRAME frAttendance:
    ENABLE ALL.

    IF AVAILABLE ttattendance THEN DO:
        ASSIGN cbMonthName:SCREEN-VALUE             = ttattendance.MonthNames
               cbYear:SCREEN-VALUE                  = STRING(ttattendance.Year)
               fiOfficeDailyHours:SCREEN-VALUE      = STRING(ttattendance.OfficeDailyWorkingHours)
               fiEmployeeWorkingDays:SCREEN-VALUE   = STRING(ttattendance.EmployeeWorkingDays)
               fiMonthlyWorkingDays:SCREEN-VALUE    = STRING(ttattendance.MonthlyWorkingDays)
               fiMonthlyWorkingHours:SCREEN-VALUE   = STRING(ttattendance.MonthlyWorkingHours)
               fiEmployeeMonthlyHours:SCREEN-VALUE  = STRING(ttattendance.EmployeeMonthlyWorkingHours)
               fiTotalLeaves:SCREEN-VALUE           = STRING(ttattendance.TotalLeaves)
               fiLeaveType:SCREEN-VALUE             = ttattendance.LeaveType
               fiApprovedBy:SCREEN-VALUE            = ttattendance.ApprovedBy
               cbMonthName:SENSITIVE                = TRUE
               cbYear:SENSITIVE                     = TRUE
               fiOfficeDailyHours:SENSITIVE         = FALSE
               fiEmployeeWorkingDays:SENSITIVE      = FALSE
               fiMonthlyWorkingDays:SENSITIVE       = FALSE
               fiMonthlyWorkingHours:SENSITIVE      = FALSE
               fiEmployeeMonthlyHours:SENSITIVE     = FALSE
               fiTotalLeaves:SENSITIVE              = FALSE
               fiLeaveType:SENSITIVE                = FALSE
               fiApprovedBy:SENSITIVE               = FALSE.
    END.
    ELSE DO:
        RUN ClearAttendanceFields.
    END.
END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

