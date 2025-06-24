CREATE TRIGGER dbo.trgViewByDepartment_InsteadOfDelete
ON dbo.ViewByDepartment
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    -- Show what is being "deleted"
    SELECT 'ViewByDepartment' AS Source, * FROM deleted;
    -- Delete from underlying table
    DECLARE @EmployeeNumber INT, @DateOfTransaction SMALLDATETIME, @Amount SMALLMONEY;
    SELECT @EmployeeNumber = EmployeeNumber,
           @DateOfTransaction = DateOfTransaction,
           @Amount = TotalAmount
    FROM deleted;
    DELETE FROM tblTransaction
    WHERE EmployeeNumber = @EmployeeNumber
      AND DateOfTransaction = @DateOfTransaction
      AND Amount = @Amount;
END;
GO