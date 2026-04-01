                                                                                                
{Getemployeedefinetable.i}
                                                                                                  
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttadmin.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttdetails.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttattendance.
DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttsalary.
DEFINE OUTPUT PARAMETER opRes AS CHARACTER NO-UNDO.
                                                                                                 
/* --- Local variables for CSV parsing --- */                                                    
DEFINE VARIABLE cLine   AS CHARACTER NO-UNDO.
DEFINE VARIABLE cFields AS CHARACTER NO-UNDO.
DEFINE VARIABLE sDate   AS CHARACTER NO-UNDO.
DEFINE VARIABLE iYear   AS INTEGER   NO-UNDO.
DEFINE VARIABLE iMonth  AS INTEGER   NO-UNDO.
DEFINE VARIABLE iDay    AS INTEGER   NO-UNDO.

/* --- Clear previous data in temp-tables --- */
EMPTY TEMP-TABLE ttadmin.
EMPTY TEMP-TABLE ttdetails.
EMPTY TEMP-TABLE ttattendance.
//EMPTY TEMP-TABLE ttsalary.

// Import EmployeeMaster.csv into ttadmin

FUNCTION SafeEntry RETURNS CHARACTER
    (INPUT pPos AS INTEGER, INPUT pList AS CHARACTER):

    IF NUM-ENTRIES(pList, ",") >= pPos THEN
        RETURN ENTRY(pPos, pList, ",").
    ELSE
        RETURN "".
END FUNCTION.

INPUT FROM "C:\Main_Project\PAYROLL\Payroll_csv's\employyee-master.csv".
REPEAT:
    IMPORT UNFORMATTED cLine.
    IF cLine BEGINS "EmpID" THEN NEXT.
    cFields = cLine.

    CREATE ttadmin.
    ASSIGN
        ttadmin.EmpID       = INTEGER(ENTRY(1,cFields,","))
        ttadmin.FirstName   = ENTRY(2,cFields,",")
        ttadmin.LastName    = ENTRY(3,cFields,",")
        ttadmin.Department  = ENTRY(4,cFields,",")
        ttadmin.Designation = ENTRY(5,cFields,",")
        ttadmin.EmpStatus   = ENTRY(7,cFields,",").

   // Parse DOJ safely
    sDate = ENTRY(6,cFields,",").
    IF sDate <> "" AND NUM-ENTRIES(sDate,"-") = 3 THEN DO:
        iMonth = INTEGER(ENTRY(1,sDate,"-")) NO-ERROR.
        iDay   = INTEGER(ENTRY(2,sDate,"-")) NO-ERROR.
        iYear  = INTEGER(ENTRY(3,sDate,"-")) NO-ERROR.
        IF iYear < 100 THEN
            iYear = IF iYear >= 50 THEN 1900 + iYear ELSE 2000 + iYear.
        IF iYear > 0 AND iMonth >= 1 AND iMonth <= 12 AND iDay >= 1 AND iDay <= 31 THEN
            ttadmin.DOJ = DATE(iMonth,iDay,iYear).
    END.
END.
INPUT CLOSE.

// Import employee-details.csv into ttdetails

INPUT FROM "C:\Main_Project\PAYROLL\Payroll_csv's\employee-details.csv".
REPEAT:
    IMPORT UNFORMATTED cLine.
    IF cLine BEGINS "EmpID" THEN NEXT.
    cFields = cLine.

    CREATE ttdetails.
    ASSIGN
        ttdetails.EmpID   = INTEGER(ENTRY(1,cFields,","))
        ttdetails.EmpName = ENTRY(2,cFields,",")
        ttdetails.Gender  = ENTRY(3,cFields,",")
        ttdetails.Phone   = ENTRY(5,cFields,",")
        ttdetails.Email   = ENTRY(6,cFields,",")
        ttdetails.Address = ENTRY(7,cFields,",").

   //Parse DOB
    sDate = ENTRY(4,cFields,",").
    IF sDate <> "" AND (NUM-ENTRIES(sDate,"-") = 3 OR NUM-ENTRIES(sDate,"/") = 3) THEN DO:
        DEFINE VARIABLE sep AS CHARACTER NO-UNDO.
        sep = IF NUM-ENTRIES(sDate,"-") = 3 THEN "-" ELSE "/".
        iMonth = INTEGER(ENTRY(1,sDate,sep)) NO-ERROR.
        iDay   = INTEGER(ENTRY(2,sDate,sep)) NO-ERROR.
        iYear  = INTEGER(ENTRY(3,sDate,sep)) NO-ERROR.
        IF iYear < 100 THEN
            iYear = IF iYear >= 50 THEN 1900 + iYear ELSE 2000 + iYear.
        IF iYear > 0 AND iMonth >= 1 AND iMonth <= 12 AND iDay >= 1 AND iDay <= 31 THEN
            ttdetails.DOB = DATE(iMonth,iDay,iYear).
    END.
END.
INPUT CLOSE.

// Import employee-attenadce.csv into ttattendance

INPUT FROM "C:\Main_Project\PAYROLL\Payroll_csv's\employee-attenadce.csv".
REPEAT:
    IMPORT UNFORMATTED cLine.
    IF cLine BEGINS "EMPID" THEN NEXT.
    cFields = cLine.

    CREATE ttattendance.
    ASSIGN
        ttattendance.EMPID                      = INTEGER(ENTRY(1,cFields,","))
        ttattendance.MonthNames                 = ENTRY(2,cFields,",")
        ttattendance.YEAR                       = STRING(ENTRY(3,cFields,","))
        ttattendance.MonthlyWorkingDays         = INTEGER(ENTRY(4,cFields,","))
        ttattendance.EmployeeWorkingDays        = INTEGER(ENTRY(5,cFields,","))
        ttattendance.MonthlyWorkingHours        = INTEGER(ENTRY(6,cFields,","))
        ttattendance.EmployeeMonthlyWorkingHours= INTEGER(ENTRY(7,cFields,","))
        ttattendance.OfficeDailyWorkingHours    = INTEGER(ENTRY(8,cFields,","))
        ttattendance.TotalLeaves                = INTEGER(ENTRY(9,cFields,","))
        ttattendance.LeaveType                  = ENTRY(10,cFields,",")
        ttattendance.ApprovedBy                 = ENTRY(11,cFields,",").
END.
INPUT CLOSE.


//  Step 4: Import employee-salarys.csv into ttsalary
/*                                                                          */
/* INPUT FROM "C:\Main_Project\PAYROLL\Payroll_csv's\employee-salarys.csv". */
/* REPEAT:                                                                  */
/*     IMPORT UNFORMATTED cLine.                                            */
/*     IF cLine BEGINS "EmpId" THEN NEXT.                                   */
/*     cFields = cLine.                                                     */
/*                                                                          */
/*     CREATE ttsalary.                                                     */
/*     ASSIGN                                                               */
/*         ttsalary.EmpId             = INTEGER(ENTRY(1,cFields,","))       */
/*         ttsalary.SalaryMonth       = ENTRY(2,cFields,",")                */
/*         ttsalary.YEAR              = STRING(ENTRY(3,cFields,","))        */
/*         ttsalary.BasicSalary       = DECIMAL(ENTRY(4,cFields,","))       */
/*         ttsalary.HRA               = DECIMAL(ENTRY(5,cFields,","))       */
/*         ttsalary.SpecialAllowance  = DECIMAL(ENTRY(6,cFields,","))       */
/*         ttsalary.COMP-OFF-ENCASHMENT = DECIMAL(ENTRY(7,cFields,","))     */
/*         ttsalary.TotalEarings      = DECIMAL(ENTRY(8,cFields,","))       */
/*         ttsalary.ProvidentFund     = DECIMAL(ENTRY(9,cFields,","))       */
/*         ttsalary.ProfessionalTax   = DECIMAL(ENTRY(11,cFields,","))      */
/*         ttsalary.NetSalaryPaid     = DECIMAL(ENTRY(13,cFields,","))      */
/*         ttsalary.EemployeBankNum   = ENTRY(14,cFields,",")               */
/*         ttsalary.EmployeeIFCCode   = ENTRY(15,cFields,",")               */
/*         ttsalary.EmployeeUANNum    = ENTRY(16,cFields,",")               */
/*         ttsalary.ITPAN             = ENTRY(17,cFields,",")               */
/*         ttsalary.GrossSalary       = DECIMAL(ENTRY(18,cFields,",")).     */
/* END.                                                                     */
/* INPUT CLOSE.                                                             */
/* Load employee-salarys.csv */
INPUT FROM "C:\Main_Project\PAYROLL\Payroll_csv's\employee-salarys.csv".

REPEAT:
    IMPORT UNFORMATTED cLine.
    IF cLine BEGINS "EmpId" THEN NEXT.

    /* CLEAN LINE */
    cFields = TRIM(REPLACE(cLine,CHR(13),"")).
    cFields = TRIM(REPLACE(cFields,CHR(10),"")).

    /* SKIP broken or empty lines */
    IF cFields = "" OR NUM-ENTRIES(cFields) < 10 THEN NEXT.

    CREATE ttsalary.

    ASSIGN
        ttsalary.EmpId               = INTEGER(ENTRY(1,cFields))
        ttsalary.SalaryMonth         = TRIM(ENTRY(2,cFields))
        ttsalary.YEAR                = TRIM(ENTRY(3,cFields))

        ttsalary.BasicSalary         = DECIMAL(ENTRY(4,cFields))
        ttsalary.HRA                 = DECIMAL(ENTRY(5,cFields))
        ttsalary.SpecialAllowance    = DECIMAL(ENTRY(6,cFields))
        ttsalary.COMP-OFF-ENCASHMENT = DECIMAL(ENTRY(7,cFields))
        ttsalary.TotalEarings        = DECIMAL(ENTRY(8,cFields))

        ttsalary.ProvidentFund       = DECIMAL(ENTRY(9,cFields))
        /* PFContribution is ignored – not in table */

        ttsalary.ProfessionalTax     = DECIMAL(ENTRY(11,cFields))
        ttsalary.TotalDeducation     = DECIMAL(ENTRY(12,cFields))
        ttsalary.NetSalaryPaid       = DECIMAL(ENTRY(13,cFields))

        ttsalary.EemployeBankNum     = ENTRY(14,cFields)
        ttsalary.EmployeeIFCCode     = ENTRY(15,cFields)
        ttsalary.EmployeeUANNum      = ENTRY(16,cFields)
        ttsalary.ITPAN               = ENTRY(17,cFields)
        ttsalary.GrossSalary         = DECIMAL(ENTRY(18,cFields)).
END.

INPUT CLOSE.


  // Final message


  // EmployeeMaster
             FOR EACH employeemaster:
                 DELETE employeemaster.
             END.


             FOR EACH employeedetails:
                 DELETE employeedetails.
             END.

             FOR EACH EMPLOYEEATTENADCE:
                 DELETE EMPLOYEEATTENADCE.
             END.

             FOR EACH EmployeeSalarysDetails:
                 DELETE EmployeeSalarysDetails .
             END.


FOR EACH ttadmin NO-LOCK:
    CREATE EmployeeMaster.
    ASSIGN
        EmployeeMaster.EmpID       = ttadmin.EmpID
        EmployeeMaster.FirstName   = ttadmin.FirstName
        EmployeeMaster.LastName    = ttadmin.LastName
        EmployeeMaster.Department  = ttadmin.Department
        EmployeeMaster.Designation = ttadmin.Designation
        EmployeeMaster.DOJ         = ttadmin.DOJ
        EmployeeMaster.EmpStatus   = ttadmin.EmpStatus.
END.

// EmployeeDetails
FOR EACH ttdetails NO-LOCK:
    CREATE EmployeeDetails.
    ASSIGN
        EmployeeDetails.EmpID   = ttdetails.EmpID
        EmployeeDetails.EmpName = ttdetails.EmpName
        EmployeeDetails.Gender  = ttdetails.Gender
        EmployeeDetails.DOB     = ttdetails.DOB
        EmployeeDetails.Phone   = ttdetails.Phone
        EmployeeDetails.Email   = ttdetails.Email
        EmployeeDetails.Address = ttdetails.Address.
END.

// EMPLOYEEATTENADCE
FOR EACH ttattendance NO-LOCK:
    CREATE EMPLOYEEATTENADCE.
    ASSIGN
        EMPLOYEEATTENADCE.EMPID                       = ttattendance.EMPID
        EMPLOYEEATTENADCE.MonthNames                  = ttattendance.MonthNames
        EMPLOYEEATTENADCE.YEAR                        = ttattendance.YEAR
        EMPLOYEEATTENADCE.MonthlyWorkingDays          = ttattendance.MonthlyWorkingDays
        EMPLOYEEATTENADCE.EmployeeWorkingDays         = ttattendance.EmployeeWorkingDays
        EMPLOYEEATTENADCE.MonthlyWorkingHours         = ttattendance.MonthlyWorkingHours
        EMPLOYEEATTENADCE.EmployeeMonthlyWorkingHours = ttattendance.EmployeeMonthlyWorkingHours
        EMPLOYEEATTENADCE.OfficeDailyWorkingHours     = ttattendance.OfficeDailyWorkingHours
        EMPLOYEEATTENADCE.TotalLeaves                 = ttattendance.TotalLeaves
        EMPLOYEEATTENADCE.LeaveType                   = ttattendance.LeaveType
        EMPLOYEEATTENADCE.ApprovedBy                  = ttattendance.ApprovedBy.
END.



FOR EACH ttsalary NO-LOCK:
    CREATE EmployeeSalarysDetails.
    ASSIGN
        EmployeeSalarysDetails.EmpId             = ttsalary.EmpId
        EmployeeSalarysDetails.SalaryMonth       = ttsalary.SalaryMonth
        EmployeeSalarysDetails.YEAR              = ttsalary.YEAR
        EmployeeSalarysDetails.BasicSalary       = ttsalary.BasicSalary
        EmployeeSalarysDetails.HRA               = ttsalary.HRA
        EmployeeSalarysDetails.SpecialAllowance  = ttsalary.SpecialAllowance
        EmployeeSalarysDetails.Comp-Off-Encashment = ttsalary.Comp-Off-Encashment
        EmployeeSalarysDetails.TotalEarings     = ttsalary.TotalEarings
        EmployeeSalarysDetails.ProvidentFund     = ttsalary.ProvidentFund
        EmployeeSalarysDetails.ProfessionalTax   = ttsalary.ProfessionalTax
        EmployeeSalarysDetails.NetSalaryPaid     = ttsalary.NetSalaryPaid
        EmployeeSalarysDetails.EemployeBankNum   = ttsalary.EemployeBankNum
        EmployeeSalarysDetails.EmployeeIFCCode   = ttsalary.EmployeeIFCCode
        EmployeeSalarysDetails.EmployeeUANNum    = ttsalary.EmployeeUANNum
        EmployeeSalarysDetails.ITPAN             = ttsalary.ITPAN
        EmployeeSalarysDetails.GrossSalary       = ttsalary.GrossSalary.
END.

