--liquibase formatted sql

--changeset system:create-alter-procedure-HasCredit2Active context:any labels:c-any,o-stored-procedure,ot-schema,on-HasCredit2Active,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure HasCredit2Active
CREATE OR ALTER PROCEDURE dbo.HasCredit2Active
AS
DECLARE @HasCredit2Active bit
DECLARE @ParameterValue nvarchar(500)

Set @HasCredit2Active = 0

SELECT @ParameterValue = AsParameter.Value
FROM AsParameter
INNER JOIN AsParameterGroup ON AsParameter.ParamGroupId = AsParameterGroup.Id
WHERE (AsParameterGroup.GroupName = 'Credit') AND (AsParameter.Name = 'HasCredit2Active')

IF @ParameterValue IS NOT NULL AND @ParameterValue = '1'
	Set @HasCredit2Active = 1

RETURN @HasCredit2Active

