ALTER TRIGGER dbo.trgTransaction_After
ON dbo.tblTransaction
AFTER INSERT, UPDATE, DELETE
AS
BEGIN
    SET NOCOUNT ON;
    SELECT @@NESTLEVEL AS NestLevel;
    IF @@NESTLEVEL = 1
    BEGIN
        SELECT 'Table_Insert' AS Source, * FROM inserted;
        SELECT 'Table_Delete' AS Source, * FROM deleted;
    END;
END;
GO