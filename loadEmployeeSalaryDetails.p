/*=========================================================
  File : loadEmployeeSalaryDetails.p
  Purpose : Load Employee Salary Details for browse display
  Author  : Payroll System Project
=========================================================*/
{ttEmployeeSalaryDetails.i}

/* ---------- Parameters ---------- */
DEFINE INPUT  PARAMETER ipEmpID             AS INTEGER   NO-UNDO.
DEFINE INPUT  PARAMETER ipBankNum           AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipIFCCode           AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipUANNum            AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipITPAN             AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipStatus            AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipMonth             AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipYear              AS CHARACTER NO-UNDO.
DEFINE INPUT  PARAMETER ipBasicSalary       AS DECIMAL   NO-UNDO.
DEFINE INPUT  PARAMETER ipCompOffEncashment AS DECIMAL   NO-UNDO.
DEFINE INPUT  PARAMETER ipHRA               AS DECIMAL   NO-UNDO.
DEFINE INPUT  PARAMETER ipSpecialAllowance  AS DECIMAL   NO-UNDO.

DEFINE INPUT-OUTPUT PARAMETER TABLE FOR ttEmployeeSalaryDetails.

/* ---------- Clear temp-table ---------- */
EMPTY TEMP-TABLE ttEmployeeSalaryDetails.

/* ---------- Load data with filters ---------- */
FOR EACH EmployeeSalarysDetails NO-LOCK
    WHERE (ipEmpID   = 0  OR EmployeeSalarysDetails.EmpID              = ipEmpID)
      AND (ipBankNum = "" OR EmployeeSalarysDetails.EemployeBankNum    = ipBankNum)
      AND (ipIFCCode = "" OR EmployeeSalarysDetails.EmployeeIFCCode    = ipIFCCode)
      AND (ipUANNum  = "" OR EmployeeSalarysDetails.EmployeeUANNum     = ipUANNum)
      AND (ipITPAN   = "" OR EmployeeSalarysDetails.ITPAN              = ipITPAN)
      AND (ipMonth   = "" OR CAPS(EmployeeSalarysDetails.SalaryMonth)  = CAPS(ipMonth))
      AND (ipYear    = "" OR STRING(EmployeeSalarysDetails.Year)       = ipYear):

    CREATE ttEmployeeSalaryDetails.
    ASSIGN
        /* Primary Salary Structure */
        ttEmployeeSalaryDetails.EmpID              = EmployeeSalarysDetails.EmpID
        ttEmployeeSalaryDetails.SalaryMonth        = EmployeeSalarysDetails.SalaryMonth
        ttEmployeeSalaryDetails.Year               = EmployeeSalarysDetails.Year
        ttEmployeeSalaryDetails.BasicSalary        = EmployeeSalarysDetails.BasicSalary
        ttEmployeeSalaryDetails.HRA                = EmployeeSalarysDetails.HRA
        ttEmployeeSalaryDetails.SpecialAllowance   = EmployeeSalarysDetails.SpecialAllowance
        ttEmployeeSalaryDetails.COMP-OFF-ENCASHMENT
                                                    = EmployeeSalarysDetails.COMP-OFF-ENCASHMENT

        /* Correct Total Earnings field */
        ttEmployeeSalaryDetails.TotalEarings       = EmployeeSalarysDetails.TotalEarings

        /* Deductions */
        ttEmployeeSalaryDetails.ProvidentFund      = EmployeeSalarysDetails.ProvidentFund
        ttEmployeeSalaryDetails.ProfessionalTax    = EmployeeSalarysDetails.ProfessionalTax
        //ttEmployeeSalaryDetails.lossofpay          = EmployeeSalarysDetails.lossofpay
        ttEmployeeSalaryDetails.TotalDeducation    = EmployeeSalarysDetails.TotalDeducation

        /* Correct Net Salary field after generation */
        ttEmployeeSalaryDetails.NetSalaryPaid = EmployeeSalarysDetails.NetSalaryPaid

        /* Bank / Account info */
        ttEmployeeSalaryDetails.EemployeBankNum    = EmployeeSalarysDetails.EemployeBankNum
        ttEmployeeSalaryDetails.EmployeeIFCCode    = EmployeeSalarysDetails.EmployeeIFCCode
        ttEmployeeSalaryDetails.EmployeeUANNum     = EmployeeSalarysDetails.EmployeeUANNum
        ttEmployeeSalaryDetails.ITPAN              = EmployeeSalarysDetails.ITPAN.
END.

/* ========== End of File ========== */
