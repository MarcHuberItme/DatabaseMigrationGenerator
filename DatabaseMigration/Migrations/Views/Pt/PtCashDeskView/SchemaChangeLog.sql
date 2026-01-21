--liquibase formatted sql

--changeset system:create-alter-view-PtCashDeskView context:any labels:c-any,o-view,ot-schema,on-PtCashDeskView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCashDeskView
CREATE OR ALTER VIEW dbo.PtCashDeskView AS
SELECT TOP 100 PERCENT
    pab.Id , pab.HdPendingChanges , pab.HdPendingSubChanges , pab.HdVersionNo , pab.AccountNo ,
    pab.PrivacyLockId , pab.AccountNoEdited , pab.AccountNoIbanForm , pab.FormerAccountNo ,
    pab.CustomerReference ,  pab.OpeningDate , pab.TerminationDate , pab.PortfolioId ,
    prr.ProductId , prr.Currency , ptb.Id AS PartnerId , ptb.PartnerNo , ptb.PartnerNoEdited ,
    ptb.FirstName , ptb.MiddleName , ptb.Name , ptb.NameCont , ptb.DateOfBirth ,
    ptb.ConsultantTeamName , pta.AddrSupplement , pta.Street , pta.HouseNo , 
    pta.Zip , pta.Town , pta.CountryCode
FROM PtAccountBase pab 
	INNER JOIN PrReference prr ON pab.Id = prr.AccountId
	INNER JOIN PtPortfolio ppo ON pab.PortfolioId = ppo.Id
	INNER JOIN PtBase ptb ON ppo.PartnerId = ptb.Id
	LEFT OUTER JOIN PtAddress pta ON ptb.Id = pta.PartnerId AND pta.AddressTypeNo = 11

