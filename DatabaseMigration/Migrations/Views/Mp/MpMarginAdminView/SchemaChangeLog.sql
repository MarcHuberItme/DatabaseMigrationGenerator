--liquibase formatted sql

--changeset system:create-alter-view-MpMarginAdminView context:any labels:c-any,o-view,ot-schema,on-MpMarginAdminView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MpMarginAdminView
CREATE OR ALTER VIEW dbo.MpMarginAdminView AS
SELECT MpMargin.Id, 
MpMargin.HdCreateDate, 
MpMargin.HdCreator, 
MpMargin.HdChangeDate, 
MpMargin.HdChangeUser, 
MpMargin.HdEditStamp, 
MpMargin.HdVersionNo,
MpMargin.HdProcessId,
MpMargin.HdStatusFlag,
MpMargin.HdNoUpdateFlag,
MpMargin.HdPendingChanges,
MpMargin.HdPendingSubChanges,
MpMargin.HdTriggerControl,
PtPortfolio.PartnerId,
MpMargin.PortfolioTypeNo,
MpMargin.PortfolioId,PtPortfolio.PortfolioNo,
PtDescriptionView.PtDescription,
MpMargin.StaffRebate,
MpMargin.Symbol,
MpMargin.SourceCurrency,
MpMargin.TargetCurrency,
Case when MpMargin.Symbol is not null THEN  MpMargin.Symbol
WHEN MpMargin.SourceCurrency is not null and MpMargin.TargetCurrency is not null THEN MpMargin.SourceCurrency + ' -> ' + MpMargin.TargetCurrency
ELSE NULL
END as CurrencyInfo, 
MpMargin.CurveId,
MpMargin.Margin,
MpMargin.ValueType,
IsNull(MpCurve.Curvelabel,CONVERT(varchar,Margin)+' '+MpMargin.ValueType) MarginInfo
FROM MpMargin
left outer join MpCurve on MpMargin.CurveId = MpCurve.Id
left outer join PtPortfolio on MpMargin.PortfolioId = PtPortfolio.Id
left outer join PtDescriptionView on PtDescriptionView.Id = PtPortfolio.PartnerId
