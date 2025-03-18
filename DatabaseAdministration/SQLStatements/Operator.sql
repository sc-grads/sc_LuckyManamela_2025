-- Create an operator 'DBAOperator' with an email address
EXEC msdb.dbo.sp_add_operator
    @name = 'DBAOperator',
    @email_address = 'Lucky.manamela@sambeconsulting.com';
GO
