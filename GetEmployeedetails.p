
{GetLoginDetail.i}
/* Parameters */
DEFINE INPUT  PARAMETER ipUser     AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipPassword AS CHARACTER NO-UNDO.
DEFINE OUTPUT PARAMETER opRes      AS CHARACTER NO-UNDO.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttadmin.

/* Clear previous records */
EMPTY TEMP-TABLE ttadmin.

/* Try to find matching admin login */
FIND FIRST ADMINLOGINS NO-LOCK
     WHERE UPPER(TRIM(ADMINLOGINS.USERNAME)) = UPPER(TRIM(ipUser))
       AND TRIM(ADMINLOGINS.PASSWORD) = TRIM(ipPassword)
     NO-ERROR.

/* If found, copy it into ttadmin */
IF AVAILABLE ADMINLOGINS THEN DO:
    CREATE ttadmin.
    BUFFER-COPY ADMINLOGINS TO ttadmin.
    ASSIGN opRes = "OK".
END.
ELSE DO:
    ASSIGN opRes = "Error".
END.
