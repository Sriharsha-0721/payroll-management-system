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



DEFINE TEMP-TABLE ttAdmin LIKE EmployeeMaster.
DEFINE TEMP-TABLE ttDetails LIKE EmployeeDetails.
DEFINE TEMP-TABLE ttAttendance LIKE EMPLOYEEATTENADCE.
DEFINE TEMP-TABLE ttSalary LIKE EmployeeSalarysDetails.

/* Query for browse */
DEFINE VARIABLE opRes AS CHARACTER NO-UNDO.

/* Local Variable Definitions ---                                       */

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-PREPROCESSOR-BLOCK 

/* ********************  Preprocessor Definitions  ******************** */

&Scoped-define PROCEDURE-TYPE Window
&Scoped-define DB-AWARE no

/* Name of first Frame and/or Browse and/or first Query                 */
&Scoped-define FRAME-NAME DEFAULT-FRAME
&Scoped-define BROWSE-NAME brwInactive

/* Internal Tables (found by Frame, Query & Browse Queries)             */
&Scoped-define INTERNAL-TABLES ttDetails ttAdmin

/* Definitions for BROWSE brwInactive                                   */
&Scoped-define FIELDS-IN-QUERY-brwInactive ttAdmin.EmpID ttDetails.EmpName ttAdmin.Department ttAdmin.Designation ttAdmin.EmpStatus   
&Scoped-define ENABLED-FIELDS-IN-QUERY-brwInactive   
&Scoped-define SELF-NAME brwInactive
&Scoped-define QUERY-STRING-brwInactive FOR     EACH ttDetails NO-LOCK, ~
           EACH ttAdmin  NO-LOCK         WHERE ttAdmin.EmpID = ttDetails.EmpID           AND (ttAdmin.EmpStatus = "Inactive"                OR ttAdmin.EmpStatus = "InActive")     BY ttDetails.EmpID
&Scoped-define OPEN-QUERY-brwInactive OPEN QUERY brwInactive FOR     EACH ttDetails NO-LOCK, ~
           EACH ttAdmin  NO-LOCK         WHERE ttAdmin.EmpID = ttDetails.EmpID           AND (ttAdmin.EmpStatus = "Inactive"                OR ttAdmin.EmpStatus = "InActive")     BY ttDetails.EmpID.
&Scoped-define TABLES-IN-QUERY-brwInactive ttDetails ttAdmin
&Scoped-define FIRST-TABLE-IN-QUERY-brwInactive ttDetails
&Scoped-define SECOND-TABLE-IN-QUERY-brwInactive ttAdmin


/* Definitions for FRAME DEFAULT-FRAME                                  */
&Scoped-define OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME ~
    ~{&OPEN-QUERY-brwInactive}

/* Standard List Definitions                                            */
&Scoped-Define ENABLED-OBJECTS RECT-76 btnBack brwInactive 

/* Custom List Definitions                                              */
/* List-1,List-2,List-3,List-4,List-5,List-6                            */

/* _UIB-PREPROCESSOR-BLOCK-END */
&ANALYZE-RESUME



/* ***********************  Control Definitions  ********************** */

/* Define the widget handle for the window                              */
DEFINE VARIABLE C-Win AS WIDGET-HANDLE NO-UNDO.

/* Definitions of the field level widgets                               */
DEFINE BUTTON btnBack 
     LABEL "BACK" 
     SIZE 15 BY 1.

DEFINE RECTANGLE RECT-76
     EDGE-PIXELS 2 GRAPHIC-EDGE    
     SIZE 150 BY 1.43
     BGCOLOR 7 .

/* Query definitions                                                    */
&ANALYZE-SUSPEND
DEFINE QUERY brwInactive FOR 
      ttDetails, 
      ttAdmin SCROLLING.
&ANALYZE-RESUME

/* Browse definitions                                                   */
DEFINE BROWSE brwInactive
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _DISPLAY-FIELDS brwInactive C-Win _FREEFORM
  QUERY brwInactive DISPLAY
      ttAdmin.EmpID
ttDetails.EmpName
ttAdmin.Department
ttAdmin.Designation
ttAdmin.EmpStatus
/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME
    WITH NO-ROW-MARKERS SEPARATORS SIZE 150 BY 16.67
         BGCOLOR 15  FIT-LAST-COLUMN.


/* ************************  Frame Definitions  *********************** */

DEFINE FRAME DEFAULT-FRAME
     btnBack AT ROW 1.19 COL 135 WIDGET-ID 2
     brwInactive AT ROW 2.43 COL 2 WIDGET-ID 200
     "INACTIVE EMPLOYEE LIST" VIEW-AS TEXT
          SIZE 43 BY .95 AT ROW 1.24 COL 51.2 WIDGET-ID 4
          BGCOLOR 7 FONT 6
     RECT-76 AT ROW 1 COL 2 WIDGET-ID 6
    WITH 1 DOWN NO-BOX KEEP-TAB-ORDER OVERLAY 
         SIDE-LABELS NO-UNDERLINE THREE-D 
         AT COLUMN 1 ROW 1
         SIZE 151.6 BY 18.19
         BGCOLOR 3  WIDGET-ID 100.


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
         TITLE              = "InactiveEmployees"
         HEIGHT             = 18.19
         WIDTH              = 151.6
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
                                                                        */
/* BROWSE-TAB brwInactive btnBack DEFAULT-FRAME */
IF SESSION:DISPLAY-TYPE = "GUI":U AND VALID-HANDLE(C-Win)
THEN C-Win:HIDDEN = no.

/* _RUN-TIME-ATTRIBUTES-END */
&ANALYZE-RESUME


/* Setting information for Queries and Browse Widgets fields            */

&ANALYZE-SUSPEND _QUERY-BLOCK BROWSE brwInactive
/* Query rebuild information for BROWSE brwInactive
     _START_FREEFORM
OPEN QUERY brwInactive FOR
    EACH ttDetails NO-LOCK,
    EACH ttAdmin  NO-LOCK
        WHERE ttAdmin.EmpID = ttDetails.EmpID
          AND (ttAdmin.EmpStatus = "Inactive"
               OR ttAdmin.EmpStatus = "InActive")
    BY ttDetails.EmpID.
     _END_FREEFORM
     _Query            is OPENED
*/  /* BROWSE brwInactive */
&ANALYZE-RESUME

 



/* ************************  Control Triggers  ************************ */

&Scoped-define SELF-NAME C-Win
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON END-ERROR OF C-Win /* InactiveEmployees */
OR ENDKEY OF {&WINDOW-NAME} ANYWHERE DO:
  /* This case occurs when the user presses the "Esc" key.
     In a persistently run window, just ignore this.  If we did not, the
     application would exit. */
  IF THIS-PROCEDURE:PERSISTENT THEN RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL C-Win C-Win
ON WINDOW-CLOSE OF C-Win /* InactiveEmployees */
DO:
  /* This event will close the window and terminate the procedure.  */
  APPLY "CLOSE":U TO THIS-PROCEDURE.
  RETURN NO-APPLY.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define SELF-NAME btnBack
&ANALYZE-SUSPEND _UIB-CODE-BLOCK _CONTROL btnBack C-Win
ON CHOOSE OF btnBack IN FRAME DEFAULT-FRAME /* BACK */
DO:
  APPLY "close" TO THIS-PROCEDURE.
  RUN PAYROLL/employee_details.w.
END.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME


&Scoped-define BROWSE-NAME brwInactive
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


/* Load inactive employees */
RUN p_LoadInactive.

/* Open browse now */
/* Load fresh data from database + CSV */
RUN PAYROLL/Procedures/EmployeeAllTables.p (
    INPUT-OUTPUT TABLE ttAdmin,
    INPUT-OUTPUT TABLE ttDetails,
    INPUT-OUTPUT TABLE ttAttendance,
    INPUT-OUTPUT TABLE ttSalary,
    OUTPUT opRes
).

OPEN QUERY brwInactive FOR
    EACH ttDetails NO-LOCK,
    EACH ttAdmin  NO-LOCK 
        WHERE ttAdmin.EmpID = ttDetails.EmpID
          AND (ttAdmin.EmpStatus = "Inactive"
               OR ttAdmin.EmpStatus = "InActive")
    BY ttDetails.EmpID.


/* Display first employee if available */
RUN p_ShowFirstEmployee.

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
  ENABLE RECT-76 btnBack brwInactive 
      WITH FRAME DEFAULT-FRAME IN WINDOW C-Win.
  {&OPEN-BROWSERS-IN-QUERY-DEFAULT-FRAME}
  VIEW C-Win.
END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_LoadInactive C-Win 
PROCEDURE p_LoadInactive :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/
    EMPTY TEMP-TABLE ttAdmin.
    EMPTY TEMP-TABLE ttDetails.

    /* Load EmployeeMaster */
    FOR EACH EmployeeMaster 
        WHERE UPPER(EmployeeMaster.EmpStatus) = "INACTIVE"
        NO-LOCK:

        CREATE ttAdmin.
        BUFFER-COPY EmployeeMaster TO ttAdmin.
    END.

    /* Load only matching employee details */
    FOR EACH EmployeeDetails NO-LOCK:
        FIND ttAdmin WHERE ttAdmin.EmpID = EmployeeDetails.EmpID NO-ERROR.
        IF AVAILABLE ttAdmin THEN DO:
            CREATE ttDetails.
            BUFFER-COPY EmployeeDetails TO ttDetails.
        END.
    END.

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

&ANALYZE-SUSPEND _UIB-CODE-BLOCK _PROCEDURE p_ShowFirstEmployee C-Win 
PROCEDURE p_ShowFirstEmployee :
/*------------------------------------------------------------------------------
  Purpose:     
  Parameters:  <none>
  Notes:       
------------------------------------------------------------------------------*/

END PROCEDURE.

/* _UIB-CODE-BLOCK-END */
&ANALYZE-RESUME

