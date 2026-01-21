--liquibase formatted sql

--changeset system:create-alter-procedure-DataExport_LocalInformation context:any labels:c-any,o-stored-procedure,ot-schema,on-DataExport_LocalInformation,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DataExport_LocalInformation
CREATE OR ALTER PROCEDURE dbo.DataExport_LocalInformation
AS    
SELECT  p.Value As 'BankSicnr'
FROM AsParameterGroup g
   JOIN AsParameter p on p.ParamGroupId = g.Id
WHERE g.GroupName = 'System'
   AND p.Name = 'BcNo'
   AND p.HdVersionNo BETWEEN 1 AND 999999998

