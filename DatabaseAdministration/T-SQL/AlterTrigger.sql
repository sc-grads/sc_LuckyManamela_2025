ALTER TRIGGER dbo.trgTransaction_After
ON dbo.tblTransaction
AFTER UPDATE
AS
BEGIN
    SET NOCOUNT ON;
    IF UPDATE(DateOfTransaction)
    BEGIN
        SELECT 'Inserted' AS Source, * FROM inserted;
        SELECT 'Deleted' AS Source, * FROM deleted;
    END;
END;
GO