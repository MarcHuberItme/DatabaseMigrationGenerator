--liquibase formatted sql

--changeset system:create-alter-view-PtPositionValuationView context:any labels:c-any,o-view,ot-schema,on-PtPositionValuationView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionValuationView
CREATE OR ALTER VIEW dbo.PtPositionValuationView AS
SELECT Pos.ID,
    Pos.HdCreateDate, 
    Pos.HdCreator, 
    Pos.HdChangeDate, 
    Pos.HdChangeUser,
    Pos.HdEditStamp, 
    Pos.HdVersionNo, 
    Pos.HdProcessId, 
    Pos.HdStatusFlag, 
    Pos.HdNoUpdateFlag, 
    Pos.HdPendingChanges, 
    Pos.HdPendingSubChanges, 
    Pos.HdTriggerControl, 
    Pos.Quantity As ActualQuantity,
    Pos.MaturityInfoTypeNo,
    vp.ValRunID As VaRunId,
    por.PartnerID, 
    Pos.PortfolioId,
    por.PortfolioNo,
    por.PortfolioNoEdited, 
    V.Id As PosQuantId,
    IsNull(V.Quantity,0) As ValQuantity, 
    V.CollateralRate*(IsNull(V.MarketValueCHF, 0.0)) As CollateralValueCHF, 
    V.ValuationCurrency, 
    V.PriceCurrency, 
    V.MarketValuePrCu, 
    V.MarketValueVaCu, 
    V.MarketValueCHF,
    V.AccruedInterestPrCu, 
    V.AccruedInterestVaCu, 
    V.AccruedInterestCHF, 
    V.Rate,
    V.QuoteAcCu,
    V.RatePrCuVaCu, 
    V.RatePrCuCHF,
    V.PriceDate,
    V.PriceQuoteType,
    RMV.PublicID, 
    RMV.InstrumentTypeNo, 
    RMV.ISINNo,
    RMV.ShortName As Description, 
    RMV.NominalCurrency,
    RMV.DueDate, 
    RMV.LanguageNo,
    G.GroupNo As LocGroupNo,
    IsNull(Convert(varchar,RMV.InterestRate) + ' % ', '')
        + IsNull(Convert(varchar,RMV.MaturityDate,104) + ' ', '')
        + IsNull(RMV.SpecialKey + ' ','')
        + IsNull(Convert(varchar,OBJ.ObjectSeqNo), '')
        + IsNull(Convert(varchar,OBL.ObjectSeqNo), '')
        + IsNull(Convert(varchar,INS.ObjectSeqNo), '') As ReferenceData,
    Case When Par.Value Is Null Then 0 Else 1 End As IsOwnBond,
    V.MarketValueVaCu + V.AccruedInterestVaCu As TotalValueVaCu,
    V.MarketValueCHF + V.AccruedInterestCHF As TotalValueCHF,
    CASE V.PriceQuoteType
         WHEN 2 THEN '%nv'
         WHEN 4 THEN '%'
         WHEN 5 THEN '% f'
         WHEN 6 THEN '%nv'
         ELSE V.PriceCurrency
    END As DisplayPriceCurrency, 
    RMV.LongName,
    OBJ.ObjectSeqNo as ObjectObjectSeqNo,
    OBL.ObjectSeqNo as ObligationObjectSeqNo,
    INS.ObjectSeqNo as InsuranceObjectSeqNo,
    PT.HasPerformanceCalculation 
FROM PtPosition Pos
    JOIN PtPortfolio por on pos.PortfolioId = por.Id
    JOIN PtPortfolioType PT on por.PortfolioTypeNo = PT.PortfolioTypeNo
    JOIN PrLocGroup G On Pos.ProdLocGroupID=G.ID
    JOIN PrReferenceMaturityView RMV on RMV.Id = Pos.ProdReferenceId
    LEFT OUTER JOIN PrObject OBJ on OBJ.Id = RMV.ObjectId 
    LEFT OUTER JOIN ReObligation OBL on OBL.Id = RMV.ObligationId 
    LEFT OUTER JOIN PrInsurancePolice INS on INS.Id = RMV.InsurancePoliceId  
    LEFT OUTER JOIN AsParameter Par On RMV.IssuerID=Par.Value And RMV.SecurityType='2' And Par.Name='PartnerIDOwn'
    LEFT OUTER JOIN VaPortfolio vp on por.Id = vp.PortfolioId
    LEFT OUTER JOIN VaPublicView V on V.PositionId = Pos.Id AND V.VaRunId = vp.ValRunId
