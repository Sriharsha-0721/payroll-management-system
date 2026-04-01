
/* === Include Shared Temp-Table Definitions === */
{GetEmployeePaySlipDetails.i}
// Parameters 
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttadmin.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttdetails.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttattendance.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttsalary.
DEFINE OUTPUT PARAMETER opRes AS CHARACTER NO-UNDO.

// Clear temp-tables (optional) 

EMPTY TEMP-TABLE ttadmin.
EMPTY TEMP-TABLE ttdetails.
EMPTY TEMP-TABLE ttattendance.
EMPTY TEMP-TABLE ttsalary.


// Load EmployeeMaster into ttadmin 
FOR EACH EmployeeMaster NO-LOCK:
    CREATE ttadmin.
    BUFFER-COPY EmployeeMaster TO ttadmin.
    ASSIGN opRes = "OK".
END.

// Load EmployeeDetails into ttdetails 
FOR EACH EmployeeDetails NO-LOCK:
    CREATE ttdetails.
    BUFFER-COPY EmployeeDetails TO ttdetails.
END.

//Load EmployeeAttenadce into ttattendance 
FOR EACH EmployeeAttenadce NO-LOCK:
    CREATE ttattendance.
    BUFFER-COPY EmployeeAttenadce TO ttattendance.
END.

// Load EmployeeSalarysDetails into ttsalary 
FOR EACH EmployeeSalarysDetails NO-LOCK:
    CREATE ttsalary.
    BUFFER-COPY EmployeeSalarysDetails TO ttsalary.
END.
