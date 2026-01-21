--liquibase formatted sql

--changeset system:create-alter-procedure-FetchPendingCamt053Data context:any labels:c-any,o-stored-procedure,ot-schema,on-FetchPendingCamt053Data,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FetchPendingCamt053Data
CREATE OR ALTER PROCEDURE dbo.FetchPendingCamt053Data
@Camt053FileId UniqueIdentifier, 
@AccountId UniqueIdentifier
As
insert into IfCamtStatementDeliveryAssoc
(
HdCreator,
HdChangeUser,
HdVersionNo,
CamtStatementDeliveryId,
CamtEntryDeliveryId
)
select SUSER_SNAME(), SUSER_SNAME(), 1, @Camt053FileId as Camt053FileId, D.Id From IfCamtEntryDelivery as D
Left Outer Join IfCamtStatementDeliveryAssoc as F On D.Id = F.CamtEntryDeliveryId
LEFT OUTER JOIN IfCamtStatementDelivery csd ON csd.Id = D.StatementId
LEFT OUTER JOIN PtAccountBase pab on pab.AccountNoIbanElect = csd.Iban
where pab.Id = @AccountId And F.CamtEntryDeliveryId is Null AND D.TransDate > DATEADD(year, -1, GETDATE()) And D.HdVersionNo < 999999999

SELECT MAX(ced.TransDate) AS MaxDate, MIN(ced.TransDate) AS MinDate
FROM IfCamtEntryDelivery ced
INNER JOIN IfCamtStatementDeliveryAssoc csda ON csda.CamtEntryDeliveryId = ced.Id
WHERE csda.[CamtStatementDeliveryId] = @Camt053FileId
