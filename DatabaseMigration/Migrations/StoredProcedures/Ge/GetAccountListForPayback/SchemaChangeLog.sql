--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountListForPayback context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountListForPayback,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountListForPayback
CREATE OR ALTER PROCEDURE dbo.GetAccountListForPayback
@dtmMatureDate as datetime
AS
SELECT P.AccountBaseId AS AccountId, P.AccountNo, COUNT(*) AS NumberOfPaybacks 
FROM PtAccountPayBackView AS P 
WHERE P.NextSelectionDate <= @dtmMatureDate	
GROUP BY P.AccountNo, P.AccountBaseId
ORDER BY AccountNo ASC
