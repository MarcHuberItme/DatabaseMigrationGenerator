--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenCustomerAcSpecProv context:any labels:c-any,o-view,ot-schema,on-AcFrozenCustomerAcSpecProv,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenCustomerAcSpecProv
CREATE OR ALTER VIEW dbo.AcFrozenCustomerAcSpecProv AS
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
      ,AccountDesc + '_EinzelWB' As AccountDesc
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
WHERE DefaultRiskSpecialAmountBaCu <> 0
