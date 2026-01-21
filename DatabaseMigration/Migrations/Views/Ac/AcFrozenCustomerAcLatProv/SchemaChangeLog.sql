--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenCustomerAcLatProv context:any labels:c-any,o-view,ot-schema,on-AcFrozenCustomerAcLatProv,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenCustomerAcLatProv
CREATE OR ALTER VIEW dbo.AcFrozenCustomerAcLatProv AS
SELECT TOP 100 percent Id
      ,AccountGroupNo
      ,AccountId
      ,AccountNo
      ,AccountNoText
      ,CharacteristicNo
      ,ClosingPeriodRuleNo
      ,ConsCreditMonitorId
      ,Currency
      ,DueValuePrCu
      ,DueValuePrCuAdjustment
      ,FreezeStatus
      ,IsDueRelevant
      ,IsMoneyMarket
      ,MgOBJEKT
      ,MgOBJPLZ
      ,MgSITZ
      ,NotAssignedDueValue
      ,NotAssignedValue
      ,OperationTypeNo
      ,PartnerId
      ,PositionId
      ,ProductNo
      ,PrReferenceId
      ,ReportDate
      ,AccountDesc + '_LatWB' As AccountDesc
      ,ValueSign
      ,DateFrom
      ,ExpirationDate
      ,InterestRate
      ,AmountType
      ,ValueHoCu
      ,ValuePrCu
      ,CodeC510
      ,PartnerNo
      ,FiscalDomicileCountry
      ,Nationality
      ,Employees
      ,LargeExpGroupNo
      ,Canton
      ,InterestRateType
      ,CreditLimitsHoCu
      ,RealEstateCanton
      ,Noga2008
      ,SecurityLevelNo
      ,MgCoverageNo
      ,MgDeckartNo
      ,CovCode
      ,FiduciaryCountry
      ,CompTypeNo
      ,IsRepo
      ,SpecProvision
      ,IsImpaired
      ,IsOverdue
      ,PledgePortfolioNo
      ,PledgeKey
      ,CustomerRefPaymentDate
      ,MinimumCapitalViolated
      ,MinimumAmortisationViolated
      ,MaxEffWithdrawAmountHoCu
      ,SexStatusNo
      ,MortgageExpirationDate
      ,LoanExpirationDate
      ,Location
      ,RelationshipMonths
      ,LongTermLoan
      ,AmountOfProducts
      ,CollClean
      ,DefaultRiskAmount
      ,DefaultRiskAmountBasicCurrency
      ,DefaultRiskSpecialAmountBaCu
      ,DefaultRiskAccrualsAmountBaCu
      ,DefaultRiskInterestAmountBaCu
  FROM AcFrozenCustomerAccountView
WHERE DefaultRiskAmountBasicCurrency <> 0

and productNo not in (1050, 1054, 1056, 1065)
