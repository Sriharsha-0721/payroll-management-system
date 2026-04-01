/*                                                                    */
/* {GetLoginDetail.i}                                                 */
/* /* Parameters */                                                   */
/* DEFINE INPUT-OUTPUT PARAMETER            TABLE FOR ttadmin.        */
/* DEFINE INPUT        PARAMETER ipUser     AS CHARACTER NO-UNDO.     */
/* DEFINE INPUT        PARAMETER ipPassword AS CHARACTER NO-UNDO.     */
/* DEFINE OUTPUT       PARAMETER opRes      AS CHARACTER NO-UNDO.     */
/*                                                                    */
/* /* Clear previous records */                                       */
/* EMPTY TEMP-TABLE ttadmin.                                          */
/*                                                                    */
/* /* Check credentials */                                            */
/* FIND FIRST ADMINLOGINS NO-LOCK                                     */
/*      WHERE UPPER(TRIM(ADMINLOGINS.USERNAME)) = UPPER(TRIM(ipUser)) */
/*        AND TRIM(ADMINLOGINS.PASSWORD) = TRIM(ipPassword)           */
/*      NO-ERROR.                                                     */
/*                                                                    */
/* /* Copy into temp-table */                                         */
/* IF AVAILABLE ADMINLOGINS THEN DO:                                  */
/*     CREATE ttadmin.                                                */
/*     BUFFER-COPY ADMINLOGINS TO ttadmin.                            */
/*     opRes = "OK".                                                  */
/* END.                                                               */
/* ELSE DO:                                                           */
/*     opRes = "Error".                                               */
/* END.                                                               */
/* --- GetAdminLogin.p (Modified to read CSV for login) --- */

{GetLoginDetail.i} /* Define ttadmin (output temp-table) */

/* --- Internal Temp-Table to load CSV data for checking --- */
DEFINE TEMP-TABLE ttAdminLoginCheck NO-UNDO
    FIELD AdminID  AS INTEGER
    FIELD USERNAME AS CHARACTER
    FIELD PASSWORD AS CHARACTER.

/* Parameters - Must match the CALL in the UI procedure */
DEFINE INPUT  PARAMETER ipUser     AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipPassword AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER opRes      AS CHARACTER NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttadmin.

/* Local variables for CSV processing and Counting */
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cFields AS CHARACTER NO-UNDO.
DEFINE VARIABLE iRecordCount AS INTEGER NO-UNDO. /* New variable for counting */

/* Clear previous records */
EMPTY TEMP-TABLE ttadmin.
EMPTY TEMP-TABLE ttAdminLoginCheck.

/* --- STEP 1: Load Admin Logins from CSV file --- */

INPUT FROM "C:\Main_Project\PAYROLL\Payroll_csv's\userlogin_details.csv".

REPEAT:
    IMPORT UNFORMATTED cLine.
    IF cLine BEGINS "ADMINID" THEN NEXT. /* Skip header row */
    
    cFields = cLine.
    
    /* Ensure sufficient fields exist to avoid runtime errors on empty lines or malformed rows */
    IF NUM-ENTRIES(cFields, ",") >= 3 THEN DO:
        CREATE ttAdminLoginCheck.
        ASSIGN
            ttAdminLoginCheck.AdminID   = INTEGER(ENTRY(1, cFields, ",")) 
            ttAdminLoginCheck.USERNAME  = TRIM(REPLACE(ENTRY(2, cFields, ","), """", "")) 
            ttAdminLoginCheck.PASSWORD  = TRIM(REPLACE(ENTRY(3, cFields, ","), """", "")). 
    END.
END.
INPUT CLOSE.

/* --- NEW: Debugging Check for Loaded Records --- */
ASSIGN iRecordCount = 0.
FOR EACH ttAdminLoginCheck NO-LOCK:
    iRecordCount = iRecordCount + 1.
END.
MESSAGE "Number of records loaded from CSV:" SKIP iRecordCount VIEW-AS ALERT-BOX.

/* --- STEP 2: Try to find matching login in the temporary CSV data --- */

FIND FIRST ttAdminLoginCheck NO-LOCK
     WHERE UPPER(TRIM(ttAdminLoginCheck.USERNAME)) = UPPER(TRIM(ipUser))
       AND TRIM(ttAdminLoginCheck.PASSWORD) = TRIM(ipPassword)
     NO-ERROR.

/* --- STEP 3: Handle result --- */
IF AVAILABLE ttAdminLoginCheck THEN DO:
    /* Copy the matching record to the output temp-table ttadmin */
    CREATE ttadmin.
    ASSIGN
        ttadmin.AdminID  = ttAdminLoginCheck.AdminID
        ttadmin.USERNAME = ttAdminLoginCheck.USERNAME
        ttadmin.PASSWORD = ttAdminLoginCheck.PASSWORD.
        
    ASSIGN opRes = "OK".
END.
ELSE DO:
    ASSIGN opRes = "Error".
END.
