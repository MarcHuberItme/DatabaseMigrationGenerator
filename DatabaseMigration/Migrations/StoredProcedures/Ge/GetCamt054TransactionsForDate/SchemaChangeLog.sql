--liquibase formatted sql

--changeset system:create-alter-procedure-GetCamt054TransactionsForDate context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCamt054TransactionsForDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCamt054TransactionsForDate
CREATE OR ALTER PROCEDURE dbo.GetCamt054TransactionsForDate
(@AccountNo AS DECIMAL,
@Date AS DATETIME,
@EsrParticipantNo AS VARCHAR(16))
AS

DECLARE @PositionId AS uniqueidentifier
select @PositionId = p.Id
from PtPosition p
inner join PrReference r on r.Id = p.ProdReferenceId
inner join PtAccountBase pab on pab.Id = r.AccountId
where pab.AccountNo = @AccountNo

select ti.*
from PtTransItem ti
INNER JOIN PtTransMessage tm ON tm.id = ti.MessageId
	AND (ti.MessageId IS NOT NULL)
	AND (tm.CreditAccountNo = @AccountNo)
INNER JOIN PtTransaction t ON t.Id = tm.TransactionId
INNER JOIN PtTransType tt ON tt.TransTypeNo = t.TransTypeNo
	AND tt.IsPaymentAdviceType = 1
where ti.PositionId = (@PositionId)
and ti.HdVersionNo between 1 and 999999998
and tm.HdVersionNo between 1 and 999999998
and t.HdVersionNo between 1 and 999999998
and tt.HdVersionNo between 1 and 999999998
and (
		(tm.CreditEsrReference IS NOT NULL)
		and (t.UpdateStatus = 1)
		and (ti.CreditAmount > 0)
		and (
			(tm.CreditPCNo = (@EsrParticipantNo))
			or (tm.CreditMessageType LIKE 'ESR%')
			or (tm.CreditMessageType = 'QrIban')
			or (tm.CreditMessageType = 'CSTPMT')
			or (tm.CreditMessageType = 'IPCPMT_IP')
			or (
				(tm.CreditMessageType = 'A15')
				and (tm.CreditMessageStandard = 'Internal')
				)
			or (
				(tm.CreditMessageType = 'TYPE5')
				and (tm.CreditMessageStandard = 'Internal')
				)
			)
		)
and ti.TransDate = @Date
and tm.CreditAccountNo = @AccountNo
