--liquibase formatted sql

--changeset system:create-alter-view-PtFxContractPartnerListView context:any labels:c-any,o-view,ot-schema,on-PtFxContractPartnerListView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtFxContractPartnerListView
CREATE OR ALTER VIEW dbo.PtFxContractPartnerListView AS
SELECT C.HdVersionNo,
       C.Id                AS ContractId,
       C.ContractNo        AS ContractNo,
       C.ExternalRemark,
       C.InternalRemark,

       C.Amount            AS ContractualAmnt,
       C.AgentId,
       C.DeTourGroup,
       C.Status            AS StatusNo,
       C.FxTransId         AS TransactionId,
       C.Currency,
       CASE
           WHEN Cp.IsFxBuyer = 1 THEN 'BUY'
           ELSE 'SELL'
           END             AS Side,
       C.FxBuyCurrency     AS BuyCurrency,
       C.FxSellCurrency    AS SellCurrency,
       C.OrderDate,
       C.DateFrom,
       C.DateTo,
       C.HdChangeDate      AS HdContractChangeDateTime,

       C.ContractType      AS ContractTypeNo,
       C.BranchNo,
       PartnerPortfolio.Id AS PartnerPortfolioId,
       Partner.Id          AS PartnerId,
       Partner.PartnerNo   as PartnerNo,
       Cp.PartnerDescription,

       Cp.ConversionRate,
       Cp.MarketRate

FROM PtContract C
         JOIN
     PtContractPartner Cp
     ON Cp.ContractId = C.Id
         LEFT JOIN
     PtPortfolio PartnerPortfolio
     ON PartnerPortfolio.Id = Cp.PortfolioId
         JOIN
     PtBase Partner
     ON Partner.Id = PartnerPortfolio.PartnerId
WHERE C.ContractType IN (50, 51, 52, 53) 
