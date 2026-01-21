--liquibase formatted sql

--changeset system:create-alter-function-DataExport_BuildName context:any labels:c-any,o-function,ot-schema,on-DataExport_BuildName,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function DataExport_BuildName
CREATE OR ALTER FUNCTION dbo.DataExport_BuildName
(@Name As nvarchar(40),
 @MaidenName As nvarchar(25),
 @ChangeNameOrder bit)
RETURNS nvarchar(70)
AS
BEGIN
   DECLARE @NameSeparator char(1)
   DECLARE @ResultName nvarchar(70)

   IF @ChangeNameOrder = 1
       Set @NameSeparator = ' '
   ELSE
       Set @NameSeparator = '-'

  
   IF @MaidenName IS NOT NULL
      SET @ResultName = @Name + @NameSeparator + @MaidenName
   ELSE
      SET @ResultName = @Name

   RETURN @ResultName
END
