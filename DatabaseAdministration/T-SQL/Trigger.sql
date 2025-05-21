ALTER TRIGGER dbo.trgViewByDepartment_InsteadOfDelete
ON dbo.ViewByDepartment
INSTEAD OF DELETE
AS
BEGIN
    SET NOCOUNT ON;
    DELETE t
    FROM tblTransaction t
    INNER JOIN deleted d
    ON t.EmployeeNumber = d.EmployeeNumber
    AND t.DateOfTransaction = d.DateOfTransaction
    AND t.Amount = d.TotalAmount;
END;
GO