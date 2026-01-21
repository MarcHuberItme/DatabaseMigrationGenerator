--liquibase formatted sql

--changeset system:create-alter-procedure-GetBookingsFrontDesk context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBookingsFrontDesk,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBookingsFrontDesk
CREATE OR ALTER PROCEDURE dbo.GetBookingsFrontDesk
(@MessageId  as uniqueidentifier,
@LanguageNo as int)

AS

(
SELECT  AccountNo =
	Case 
		when PrPrivate.Productno = 1027 then '*********'
		else convert(varchar,PAB.AccountNo)
	End,
	PR.Currency,
	PAB.CustomerReference,
	PTI.TransDate, 	
	PTI.ValueDate, 	
	PTI.CreditAmount, 
	PTI.DebitAmount, 	
                PTIT.TextNo, 
	TE.TextShort, 
	PTI.TransText, 
	PTI.TransId, 
                PTI.TransDateTime, 
	PTI.Id, 
	PTI.MessageId

FROM    PtTransItem AS PTI

INNER JOIN PtPosition AS PP ON PTI.PositionId = PP.Id
INNER JOIN PrReference AS PR ON PP.ProdReferenceId = PR.Id
Inner JOIN PrPrivate   ON PR.ProductId = PrPrivate.ProductId
INNER JOIN PtAccountBase AS PAB ON PR.AccountId = PAB.Id
INNER JOIN PtTransItemText AS PTIT on PTI.TextNo = PTIT.TextNo
INNER JOIN AsText AS TE On PTIT.Id = TE.MasterId AND TE.LanguageNo = @LanguageNo

WHERE     PTI.DetailCounter IN (0, 1) AND PTI.MessageId = @MessageId 
      AND     PTI.HdVersionNo between 1 and 999999998


UNION ALL 

SELECT  AccountNo =
	Case 
		when PrPrivate.Productno = 1027 then '*********'
		else convert(varchar,PAB.AccountNo)
	End, 
	PR.Currency,
	PAB.CustomerReference,
	PTI.TransDate, 	
	PTI.ValueDate, 	
	PTID.CreditAmount, 
	PTID.DebitAmount, 
	PTIT.TextNo, 
	TE.TextShort, 
	PTID.TransText, 
	PTID.TransactionId AS TransId, 
	PTI.TransDateTime, 
                PTID.Id,
	PTI.MessageId

FROM    PtTransItem AS PTI

INNER JOIN dbo.PtTransItemDetail AS PTID ON PTI.Id = PTID.TransItemId
INNER JOIN PtPosition AS PP ON PTI.PositionId = PP.Id
INNER JOIN PrReference AS PR ON PP.ProdReferenceId = PR.Id
Inner JOIN PrPrivate   ON PR.ProductId = PrPrivate.ProductId
INNER JOIN PtAccountBase AS PAB ON PR.AccountId = PAB.Id
INNER JOIN PtTransItemText AS PTIT on PTI.TextNo = PTIT.TextNo
INNER JOIN AsText AS TE On PTIT.Id = TE.MasterId AND TE.LanguageNo = @LanguageNo

WHERE   PTI.DetailCounter >= 2 AND PTI.MessageId =@MessageId 
      AND   PTI.HdVersionNo between 1 and 999999998

)
