--liquibase formatted sql

--changeset system:create-alter-procedure-GetWithdrawalAmount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetWithdrawalAmount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetWithdrawalAmount
CREATE OR ALTER PROCEDURE dbo.GetWithdrawalAmount
   @PositionId uniqueidentifier,
   @SelDate datetime,
   @GetRsOutput bit,
   @WithdrawAmount money OUTPUT,
   @NoticeAmount money OUTPUT
AS  

DECLARE @TargetDate datetime
DECLARE @CurPos varchar(3)
DECLARE @AccountId As uniqueidentifier
DECLARE @CalendarMonths smallint
DECLARE @NoticeCount smallint 
DECLARE @WithdrawCommRelevant bit
DECLARE @BookWithdrawComm bit

SELECT  @WithDrawAmount=PWR.WithdrawAmount, @CalendarMonths = PWR.WithdrawalPeriodInMonths, @CurPos = Re.Currency, @AccountId = Re.AccountId,
        @WithdrawCommRelevant = P.WithdrawCommRelevant, @BookWithdrawComm = P.BookWithdrawComm
FROM	PtPosition PO
	JOIN PrReference RE ON PO.ProdReferenceId = RE.Id
	JOIN PrPrivate P ON RE.ProductId = P.ProductId
    JOIN PrPrivateWithdrawRules PWR ON P.ProductNo = PWR.ProductNo 
	   AND PWR.Id =	(SELECT TOP 1 Id FROM PrPrivateWithdrawRules R
		             WHERE R.ProductNo = P.ProductNo
                        AND   R.HdVersionNo < 999999999
		                AND   R.ValidFrom <= @SelDate
		             ORDER BY R.ValidFrom DESC
                    )	
WHERE	PO.Id = @PositionId


IF (@WithdrawCommRelevant = 1)
BEGIN
	-- Prüfe, ob Kündigungen vorhanden
	SELECT @NoticeAmount = SUM(IsNull(AN.NoticeAmount, 999999999)), @NoticeCount = COUNT(*)
		FROM PtAccountNotice AN 
		WHERE AN.AccountBaseId = @AccountId
			AND AN.TargetDate > DATEADD(day,-30,@SelDate) 
			AND AN.TargetDate <= DATEADD(day,30,@SelDate)
			AND AN.HdVersionNo < 999999999 
END

-- Für LCR: falls Produkt nicht NKK relevant ist, dieser nicht verbucht wird oder keine Rückzugsbeschränkung definiert ist: 
-- -> gazer Betrag ist auf Sicht 	(@WithdrawAmount = HighValue)
IF (@WithdrawCommRelevant = 0 OR @BookWithdrawComm = 0 OR @WithdrawAmount IS NULL) 
    SET @WithdrawAmount = 10000000000.00


-- Return recordset, if required
IF (@GetRsOutput=1)
	SELECT @WithdrawAmount As WithdrawAmount, @NoticeAmount As NoticeAmount, @NoticeCount AS NoticeCount
