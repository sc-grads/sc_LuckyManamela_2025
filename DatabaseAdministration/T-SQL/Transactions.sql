DECLARE @EmployeeNumber INT, @DateOfTransaction SMALLDATETIME, @Amount SMALLMONEY;
SELECT @EmployeeNumber = EmployeeNumber,
       @DateOfTransaction = DateOfTransaction,
       @Amount = TotalAmount
FROM deleted;
DELETE FROM tblTransaction
WHERE EmployeeNumber = @EmployeeNumber
  AND DateOfTransaction = @DateOfTransaction
  AND Amount = @Amount;