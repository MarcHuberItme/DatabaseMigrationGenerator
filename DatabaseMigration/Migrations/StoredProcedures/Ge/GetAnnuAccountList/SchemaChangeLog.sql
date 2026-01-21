--liquibase formatted sql

--changeset system:create-alter-procedure-GetAnnuAccountList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAnnuAccountList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAnnuAccountList
CREATE OR ALTER PROCEDURE dbo.GetAnnuAccountList
@dtmSelectionDate as datetime
AS
SELECT P.AccountBaseId AS AccountId, P.AccountNo, COUNT(*) AS NumberOfPaybacks 
FROM PtAccountAnnuityView AS P 
WHERE P.NextSelectionDate <= @dtmSelectionDate	
GROUP BY P.AccountNo, P.AccountBaseId
ORDER BY AccountNo ASC
