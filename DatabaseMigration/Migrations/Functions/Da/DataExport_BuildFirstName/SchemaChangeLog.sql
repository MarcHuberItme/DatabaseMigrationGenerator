--liquibase formatted sql

--changeset system:create-alter-function-DataExport_BuildFirstName context:any labels:c-any,o-function,ot-schema,on-DataExport_BuildFirstName,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function DataExport_BuildFirstName
CREATE OR ALTER FUNCTION dbo.DataExport_BuildFirstName
(@FirstName As nvarchar(25),
 @MiddleName As nvarchar(25),
 @UseMiddleName bit)
RETURNS nvarchar(60)
AS
BEGIN
   DECLARE @NameSeparator char(1)
   DECLARE @ResultFirstName nvarchar(60)
  
   IF @UseMiddleName = 1 AND @MiddleName IS NOT NULL
      SET @ResultFirstName = @FirstName + ' ' + @MiddleName
   ELSE
      SET @ResultFirstName = @FirstName

   RETURN @ResultFirstName
END
