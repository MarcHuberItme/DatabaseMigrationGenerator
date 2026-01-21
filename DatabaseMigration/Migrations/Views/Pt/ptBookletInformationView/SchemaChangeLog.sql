--liquibase formatted sql

--changeset system:create-alter-view-ptBookletInformationView context:any labels:c-any,o-view,ot-schema,on-ptBookletInformationView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ptBookletInformationView
CREATE OR ALTER VIEW dbo.ptBookletInformationView AS
Select 	dbo.PrReference.Id, 
	dbo.PrReference.HdProcessId,
	dbo.PrReference.HdVersionNo, 
	dbo.PrReference.HdCreateDate,
	dbo.PrReference.HdCreator,
	dbo.PrReference.HdChangeDate,
	dbo.PrReference.HdChangeUser,
	dbo.PrReference.HdStatusFlag, 
	dbo.PrReference.HdNoUpdateFlag, 
	dbo.PrReference.HdTriggerControl, 
	dbo.PrReference.HdPendingChanges, 
	dbo.PrReference.HdPendingSubChanges, 
	dbo.PrReference.HdEditStamp,
	dbo.PrReference.Currency,
	dbo.PtPosition.Id as PositionId,
	dbo.PtAccountBase.PortfolioId,  
	dbo.PtPosition.ProdReferenceId, 
	dbo.PtPosition.ProdLocGroupId, 
	dbo.PtPosition.Quantity, 
	dbo.PtPosition.ValueProductCurrency, 
	dbo.PtPosition.ValueCustomerCurrency, 
	dbo.PtPosition.ValueBasicCurrency, 
	dbo.PtPosition.ValueBasicCurrencyCollateral, 
	dbo.PtPosition.NostroTypeId, 
	dbo.PtPosition.BookletPrintDate, 
	dbo.PtPosition.BookletPage, 
	dbo.PtPosition.BookletLine, 
	dbo.PtPosition.BookletBalance, 
	dbo.PtPosition.Agent, 
	dbo.PtAddress.AdviceAdrLine,
	dbo.PtAddress.Street,
	dbo.PtAddress.HouseNo,
	dbo.PtAddress.Zip,
	dbo.PtAddress.Town,
	dbo.PtBase.DateOfBirth,
	dbo.PtBase.YearOfBirth,
	dbo.PtAccountBase.AccountNo,  
	dbo.PtBase.PartnerNo,
	dbo.PtBase.FirstName,
	dbo.PtBase.Name,
                dbo.PtAccountBase.AccountNoEdited,
                dbo.PtAccountBase.CustomerReference

FROM  PrReference
INNER JOIN PtAccountBase On   PrReference.Accountid = PtAccountBase.Id
INNER JOIN PtPortfolio On PtAccountBase.PortfolioId = PtPortfolio.Id
INNER JOIN PtBase On PtPortfolio.PartnerId = PtBase.Id
LEFT OUTER JOIN PtAddress ON PtBase.Id = PtAddress.PartnerId and PtAddress.AddressTypeNo = 11
LEFT Outer JOIN PtPosition ON dbo.PtPosition.ProdReferenceId = PrReference.Id
