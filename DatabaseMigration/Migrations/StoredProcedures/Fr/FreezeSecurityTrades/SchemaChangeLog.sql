--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeSecurityTrades context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeSecurityTrades,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeSecurityTrades
CREATE OR ALTER PROCEDURE dbo.FreezeSecurityTrades
@ReportDate datetime

AS

UPDATE AcFrozenSecurityBalance SET QuarterlyBuyCHF = QT.CreditAmountCV * QT.Rate , QuarterlySellCHF = QT.DebitAmountCV * QT.Rate

FROM AcFrozenSecurityBalance bal
JOIN (

SELECT AV.*, CASE WHEN CvCurrency = 'CHF' THEN 1 ELSE r.Rate END As Rate FROM 

(SELECT Isnull(a.PositionId, v.PositionId) As PositionId, IsNull(a.CreditCvCurrency, v.DebitCvCurrency) As CvCurrency, a.CreditAmountCV, v.DebitAmountCV from 

(SELECT sb.PositionId, tm.CreditCvCurrency, sum(creditAmountCv) As CreditAmountCV
FROM AcFrozenSecurityBalance sb 
	Join PtTransItem ti on ti.PositionId = sb.PositionId 
	Left outer Join PtTransMessage tm on tm.Id = ti.MessageId

WHERE sb.ReportDate = @ReportDate
    AND ti.TransDate <= @ReportDate
	AND ti.TransDate > DATEADD(month, -3, @ReportDate)
	and ti.CreditQuantity <> 0

AND ti.TextNo in( 120, 121)

GROUP BY sb.PositionId, tm.CreditCvCurrency) As A

FULL JOIN

(
SELECT sb.PositionId, tm.DebitCvCurrency,  sum(tm.DebitAmountCv) As DebitAmountCV
FROM AcFrozenSecurityBalance sb 
	Join PtTransItem ti on ti.PositionId = sb.PositionId 
	Left outer Join PtTransMessage tm on tm.Id = ti.MessageId

WHERE sb.ReportDate = @ReportDate
    AND ti.TransDate <= @ReportDate
	AND ti.TransDate > DATEADD(month, -3, @ReportDate)
	and ti.DebitQuantity <> 0

AND ti.TextNo in (130,124, 147)

GROUP BY sb.PositionId, tm.DebitCvCurrency
) As V

 on a.PositionId = v.PositionId and a.CreditCvCurrency = v.DebitCvCurrency
) AS AV

LEFT OUTER JOIN  CyRateRecent r on r.CySymbolOriginate = AV.CvCurrency AND  CySymbolTarget = 'CHF' and RateType = 203 and ValidFrom <= @ReportDate and  ValidTo > @ReportDate
) As QT ON QT.PositionId = bal.PositionId

WHERE bal.ReportDate = @ReportDate




