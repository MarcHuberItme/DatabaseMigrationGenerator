--liquibase formatted sql

--changeset system:create-alter-view-ExportEbDetailsViews context:any labels:c-any,o-view,ot-schema,on-ExportEbDetailsViews,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportEbDetailsViews
CREATE OR ALTER VIEW dbo.ExportEbDetailsViews AS
SELECT TOP 100 PERCENT A.AccessorId AS ebanking_accessor_partnerId,
        A.Accessor AS ebanking_accessor_noFormatted,
        'ebanking_accessor_type' =  CASE    WHEN A.AccessorId = A.AccessedPartnerId AND A.contactPersonId IS NULL
                                    THEN 'own'
                                    WHEN A.AccessorId = A.AccessedPartnerId AND A.contactPersonId IS NOT NULL
                                    THEN 'contactPerson'
                                    ELSE 'other'
                            END,
        A.contractId AS ebanking_accessor_contract_id,
        A.contractNo AS ebanking_accessor_contract_no,
        A.ExpirationDate AS ebanking_accessor_contract_validTo,
        A.contactPersonId AS ebanking_accessor_contactPerson_id,
        A.ContactPerson AS ebanking_accessor_contactPerson_name,
      
        A.AccessedPartnerId AS ebanking_accessed_partner_id,
        A.AccessedPartner AS ebanking_accessed_partner_noFormatted,
      
        'ebanking_accessedObject_type' =        CASE    WHEN A.PortfolioId IS NULL
                                                        THEN 'Account'
                                                        ELSE 'Portfolio'
                                                END,
        'ebanking_accessedObject_id' =          CASE    WHEN A.PortfolioId IS NULL
                                                        THEN A.AccountId
                                                        ELSE A.PortfolioId
                                                END,
        'ebanking_accessedObject_noFormatted' = CASE    WHEN A.PortfolioNoEdited IS NULL
                                                        THEN A.AccountNoEdited
                                                        ELSE A.PortfolioNoEdited
                                                END,
   
     
        A.ValidFrom AS ebanking_accessedObject_accessRights_validFrom,
        A.ValidTo AS ebanking_accessedObject_accessRights_validTo,
        A.InternetbankingAllowed AS ebanking_accessedObject_accessRights_ebankingAllowed,
        A.DefaultForPayment AS ebanking_accessedObject_accessRights_mainAccount,
        A.QueryRestriction AS ebanking_accessedObject_accessRights_queryRestriction,
        A.QueryDetailRestriction AS ebanking_accessedObject_accessRights_queryDetailRestriction,
        A.BalanceRestriction AS ebanking_accessedObject_accessRights_balanceRestriction,
        A.OrderRestriction AS ebanking_accessedObject_accessRights_orderRestriction,
        A.PerformanceChartRestriction AS ebanking_accessedObject_accessRights_performanceChartRestriction,
        A.SalaryPaymentRestriction AS ebanking_accessedObject_accessRights_salaryRestriction,
      
        A.PaymentVisumNo AS ebanking_accessedObject_visa_paymentVisaNo,
        A.StandingOrderVisumNo AS ebanking_accessedObject_visa_recurringPaymentsVisaNo,
        A.DTAVisumNo AS ebanking_accessedObject_visa_dtaVisaNo,
 
        GETUTCDATE() AS 'lastSyncDate'
   
FROM    (
    
        -- AccessedObject (PORTFOLIO)
   
        SELECT      PBAccessor.Id As AccessorId,
                    PBAccessor.PartnerNoEdited AS Accessor,
  
                    PB.Id AS AccessedPartnerId,
                    PB.PartnerNoEdited AS AccessedPartner,
                    PPF.PortfolioNoEdited AS AccessedObject,
   
                    PPF.Id AS PortfolioId,
                    PPF.PortfolioNoEdited AS PortfolioNoEdited,
   
                    NULL AS AccountId,
                    NULL AS AccountNoEdited,
   
                    PAEB.ExpirationDate AS ExpirationDate,
                    PAEBD.ValidFrom AS ValidFrom,
                    PAEBD.ValidTo AS ValidTo,
                    PAEBD.InternetbankingAllowed,
                    PAEBD.DefaultForPayment AS DefaultForPayment,
   
                    PAEBD.QueryRestriction AS QueryRestriction,
                    PAEBD.QueryDetailRestriction AS QueryDetailRestriction,
                    PAEBD.BalanceRestriction AS BalanceRestriction,
                    PAEBD.OrderRestriction AS OrderRestriction,
                    PAEBD.PerformanceChartRestriction AS PerformanceChartRestriction,
                    PAEBD.SalaryPaymentRestriction AS SalaryPaymentRestriction,
   
                    PAEBD.PaymentVisumNo AS PaymentVisumNo,
                    PAEBD.StandingOrderVisumNo AS StandingOrderVisumNo,
                    PAEBD.DTAVisumNo AS DTAVisumNo,
   
                    PAEB.Id AS contractId,
                    PAEB.MgVTNo AS contractNo,
                    PCP.Id AS contactPersonId,
                    'ContactPerson' = PCP.Name + ' ' + PCP.FirstName,
                    NULL AS ContactPersonTown
        FROM        PtAgrEBankingDetail PAEBD
        JOIN        PtPortfolio PPF ON PPF.Id=PAEBD.PortfolioId
        JOIN        PtBase PB ON PB.Id=PPF.PartnerId
        JOIN        PtAgrEBanking PAEB ON PAEB.Id=PAEBD.AgrEBankingId
                        AND PAEB.ExpirationDate > GETDATE()
        JOIN        PtBase PBAccessor ON PBAccessor.Id = PAEB.PartnerId
        LEFT JOIN   PtContactPerson PCP ON PCP.Id = PAEB.ContactPersonId
        WHERE       PAEBD.ValidTo > GETDATE()
                    AND PPF.HdVersionNo BETWEEN 1 AND 999999998
                    AND PAEBD.HdVersionNo BETWEEN 1 AND 999999998
   
        UNION ALL
   
        -- AccessedObject (ACCOUNT)
   
        SELECT      PBAccessor.Id As AccessorId,
                    PBAccessor.PartnerNoEdited AS Accessor,
      
                    PB.Id AS AccessedPartnerId,
                    PB.PartnerNoEdited AS AccessedPartner,
                    PAB.AccountNoEdited AS AccessedObject,
   
                    NULL AS PortfolioId,
                    NULL AS PortfolioNoEdited,
   
                    PAB.Id AS AccountId,
                    PAB.AccountNoEdited AS AccountNoEdited,
   
                    PAEB.ExpirationDate AS ExpirationDate,
                    PAEBD.ValidFrom AS ValidFrom,
                    PAEBD.ValidTo AS ValidTo,
                    PAEBD.InternetbankingAllowed AS InternetbankingAllowed,
                    PAEBD.DefaultForPayment AS DefaultForPayment,
   
                    PAEBD.QueryRestriction AS QueryRestriction,
                    PAEBD.QueryDetailRestriction AS QueryDetailRestriction,
                    PAEBD.BalanceRestriction AS BalanceRestriction,
                    PAEBD.OrderRestriction AS OrderRestriction,
                    PAEBD.PerformanceChartRestriction AS PerformanceChartRestriction,
                    PAEBD.SalaryPaymentRestriction AS SalaryPaymentRestriction,
   
                    PAEBD.PaymentVisumNo AS PaymentVisumNo,
                    PAEBD.StandingOrderVisumNo AS StandingOrderVisumNo,
                    PAEBD.DTAVisumNo AS DTAVisumNo,
   
                    PAEB.Id AS contractId,
                    PAEB.MgVTNo AS contractNo,
                    PCP.Id AS contactPersonId,
                    'ContactPerson' = PCP.Name + ' ' + PCP.FirstName,
                    NULL AS ContactPersonTown
        FROM        PtAgrEBankingDetail PAEBD
        JOIN        PtAccountBase PAB ON PAB.Id=PAEBD.AccountId
        JOIN        PtPortfolio PPAccount ON PPAccount.Id=PAB.PortfolioId
        JOIN        PtBase PB ON PB.Id=PPAccount.PartnerId
        JOIN        PtAgrEBanking PAEB ON PAEB.Id=PAEBD.AgrEBankingId
                        AND PAEB.ExpirationDate > GETDATE()
        JOIN        PtBase PBAccessor ON PBAccessor.Id = PAEB.PartnerId
        LEFT JOIN   PtContactPerson PCP ON PCP.Id = PAEB.ContactPersonId
        WHERE       PAEBD.ValidTo > GETDATE()      
        AND         PPAccount.HdVersionNo BETWEEN 1 AND 999999998
        AND         PAEBD.HdVersionNo BETWEEN 1 AND 999999998
   
        ) A
   
ORDER BY A.Accessor, A.contractNo, A.AccessedObject
