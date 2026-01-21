--liquibase formatted sql

--changeset system:create-alter-procedure-VaRefValAccruedInterestWithId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaRefValAccruedInterestWithId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaRefValAccruedInterestWithId
CREATE OR ALTER PROCEDURE dbo.VaRefValAccruedInterestWithId
--StoreProcedure: VaRefValAccruedInterestWithId
@RunId Uniqueidentifier
AS

/*
Declare @RunId  AS Uniqueidentifier
Set @RunID = '1F05C722-EA17-47B4-9DC4-D729CEDE733E'
*/
Declare @ValuationDate as smalldateTime
Set @ValuationDate = (Select ValuationDate From VaRun Where Id = @RunId);

With TmpPublicCf (TmpId, TmpPublicId, TmpRefId, TmpEarningPerBeginDate, TmpDueDate, TmpAmount, TmpDayCountConvNo ) AS
	(
	Select PCF.Id, PCF.PublicId, ProdReferenceId, PCF.EarningPerBeginDate, PCF.DueDate, PCF.Amount, PCF.DayCountConvNo
	From PrPublicCf PCF
	Inner Join PrPublicCashflowStatus PCFS on  PCFS.CashflowStatusNo = PCF.CashflowStatusNo
	Where  PCF.DueDate >@ValuationDate
	And PCFS.CalcAccruedInterest = 1 
	And PCF.PaymentFuncNo = 17 
	AND PCF.EarningPerBeginDate < @ValuationDate
    AND PCF.HdVersionNo Between 1 AND 999999998
	)
Select 
	(Select Top 1 PH.InstrumentStatusNo From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <=@ValuationDate Order by FromDate DESC) as InstrumentStatusNo
,   P.SecurityType as SecurityType
,   P.NominalCurrency
,   P.TimeUnitNo
,   P.NumberTimeUnit
,   isnull(P.FactorDoubleCurrencyBond,0) as FactorDoubleCurrencyBond
,   P.SpecialInterestCurrency 
,   TmpEarningPerBeginDate AS EarningPerBeginDate
,   TmpDueDate AS DueDate
,   TmpAmount AS Amount
,	P.ActualInterest
,   P.DayCountConvNo
,	TmpDayCountConvNo as DayCountConvNoCF
,	P.InstrumentTypeNo
,	(Select top 1 isnull(Count(BCF2.Id),0) 
		From PrPublicCf BCF2
		Inner Join PrPublicCashflowStatus PCFS on  BCF2.CashflowStatusNo = PCFS.CashflowStatusNo
		Where BCF2.DueDate >  @ValuationDate 
		And PCFS.CalcAccruedInterest = 1 
		And BCF2.PaymentFuncNo = 17 
		And BCF2.HdVersionNo Between 1 AND 999999998
		And PCFS.HdVersionNo Between 1 AND 999999998
		And BCF2.ProdReferenceId = REF.Id
		Group by ProdReferenceId)  AS CountByRef
,	(Select top 1 isnull(Count(BCF2.Id),0) 
		From PrPublicCf BCF2
		Inner Join PrPublicCashflowStatus PCFS on  BCF2.CashflowStatusNo = PCFS.CashflowStatusNo
		Where BCF2.DueDate >  @ValuationDate
		And PCFS.CalcAccruedInterest = 1 
		And BCF2.PaymentFuncNo = 17 
		And BCF2.HdVersionNo Between 1 AND 999999998
		And PCFS.HdVersionNo Between 1 AND 999999998
		And BCF2.PublicID = P.Id
		Group by ProdReferenceId)  AS CountByPub
,    P.RefTypeNo  
,    RV.AccruedInterestPrCu
,    REF.Id
from VaRefVal RV
	Left Outer Join prPublicPrice PP on PP.ID = RV.PublicPriceId
	Inner Join PrReference REF on RV.ProdReferenceId = REF.Id
	Inner Join PrPublic P on P.ProductId = REF.ProductId
	Inner Join  TmpPublicCf on (TmpPublicId = P.Id And not P.RefTypeNo in(3,4)) OR (TmpRefId = REF.Id AND P.RefTypeNo in(3,4))

Where TmpPublicCf.TmpId = (Select TOP 1 TmpId From TmpPublicCf Where (TmpPublicId = P.Id And not P.RefTypeNo in(3,4)) OR (TmpRefId = REF.Id AND P.RefTypeNo in(3,4)) Order by TmpDueDate ASC)
	AND P.InstrumentTypeNo in (1,8,11,12,98)
	AND RV.ValRunId =  @RunId
	AND (PP.IsFlat <> 1 OR PP.IsFlat is Null)
	AND (TmpDueDate > @ValuationDate)
Order by Ref.id
