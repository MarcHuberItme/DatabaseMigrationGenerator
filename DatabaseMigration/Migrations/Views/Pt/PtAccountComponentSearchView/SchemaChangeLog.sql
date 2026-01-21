--liquibase formatted sql

--changeset system:create-alter-view-PtAccountComponentSearchView context:any labels:c-any,o-view,ot-schema,on-PtAccountComponentSearchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountComponentSearchView
CREATE OR ALTER VIEW dbo.PtAccountComponentSearchView AS
select
AC.Id as AccountComponentId,
AB.Id as AccountId,
AB.AccountNo as AccountNo,
P.Id as PortfolioId,
P.PortfolioNo as PortfolioNo,
PB.Id as PartnerId,
PB.PartnerNo as PartnerNo,
AC.HdVersionNo,
AC.ContractBaseId,
AC.PrivateComponentId,
AC.PrivateCompTypeId,
AC.PriorityOfInterestCalculation,
AC.PriorityOfPayback,
AC.PriorityOfLegalReporting,
AC.IsOldComponent,
AC.Duration,
AC.DurationTypeId,
AC.PrivateCompCharacteristicNo,
AC.Remark,
AC.SyncValue,
AC.SyncValidFrom,
AC.SyncValidTo
from PtAccountComponent AC
join PtAccountBase AB on AC.AccountBaseId = AB.Id and AB.HdVersionNo < 999999999
join PtPortfolio P on AB.PortfolioId = P.Id and P.HdVersionNo < 999999999
join PtBase PB on P.PartnerId = PB.Id and PB.HdVersionNo < 999999999
where 
	AC.HdVersionNo < 999999999
