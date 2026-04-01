                                         */
/* Temp-table definition */
DEFINE TEMP-TABLE ttadmin LIKE EmployeeMaster.

/* Parameters */
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttadmin.
DEFINE OUTPUT PARAMETER opRes AS CHARACTER NO-UNDO.

/* Clear previous records */
EMPTY TEMP-TABLE ttadmin.

/* Try to find matching admin login */
FOR EACH EmployeeMaster NO-LOCK:  /* <-- Added colon here */
    /* If found, copy it into ttadmin */
    CREATE ttadmin.
    BUFFER-COPY EmployeeMaster TO ttadmin.
    ASSIGN opRes = "OK".
END.


