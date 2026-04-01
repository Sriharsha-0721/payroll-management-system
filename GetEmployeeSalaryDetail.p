
{GetEmployeeSalaryDeatails.i}
// Parameters

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttadmin.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttdetail.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttsalary.

DEFINE OUTPUT PARAMETER opRes AS CHARACTER NO-UNDO.

// Clear previous records

EMPTY TEMP-TABLE ttadmin.
EMPTY TEMP-TABLE ttdetail.
EMPTY TEMP-TABLE ttsalary.


// Load EmployeeMaster into ttadmin
FOR EACH EmployeeMaster NO-LOCK:
    CREATE ttadmin.
    BUFFER-COPY EmployeeMaster TO ttadmin.
END.

// Load EmployeeDetails into ttdetails
FOR EACH EmployeeDetails NO-LOCK:
    CREATE ttdetail.
    BUFFER-COPY EmployeeDetails TO ttdetail.
END.


// Load EmployeeSalarysDetails into ttsalary
FOR EACH EmployeeSalarysDetails NO-LOCK:
    CREATE ttsalary.
    BUFFER-COPY EmployeeSalarysDetails TO ttsalary.
END.

// Return result flag
ASSIGN opRes = "OK".




































