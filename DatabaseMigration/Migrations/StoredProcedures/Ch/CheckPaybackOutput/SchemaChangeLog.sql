--liquibase formatted sql

--changeset system:create-alter-procedure-CheckPaybackOutput context:any labels:c-any,o-stored-procedure,ot-schema,on-CheckPaybackOutput,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CheckPaybackOutput
CREATE OR ALTER PROCEDURE dbo.CheckPaybackOutput

@InvoiceTypeNo smallint

AS

SELECT COUNT(*) NotProcessedCount 
FROM PtAccountDebitControlCorr AS Corr
INNER JOIN PtAccountDebitControl AS Dc ON Corr.DebitControlId = Dc.Id
WHERE Dc.InvoiceType = @InvoiceTypeNo
AND Dc.RelatedTableName = 'PtAccountPayback'
AND Dc.CompletionDate IS NULL
AND Dc.HdVersionNo BETWEEN 1 AND 999999998
AND Corr.HdVersionNo BETWEEN 1 AND 999999998
AND Corr.PrintDate IS NULL
