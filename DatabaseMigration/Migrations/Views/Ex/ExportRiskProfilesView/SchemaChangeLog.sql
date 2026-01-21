--liquibase formatted sql

--changeset system:create-alter-view-ExportRiskProfilesView context:any labels:c-any,o-view,ot-schema,on-ExportRiskProfilesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportRiskProfilesView
CREATE OR ALTER VIEW dbo.ExportRiskProfilesView AS
SELECT TOP 100 PERCENT     PB.Id AS riskProfile_partner_id
            , PB.PartnerNo AS riskProfile_partner_no_numeric
            , PB.PartnerNoEdited AS riskProfile_partner_no_formatted
            , PB.PartnerNoText AS riskProfile_partner_no_textForSort
            , PDV.PtDescription AS riskProfile_partner_description
            , IRP.Id AS riskProfile_id
            , IRP.ValidFrom AS riskProfile_validFrom
            , IRP.DateOfCompletion AS riskProfile_completionDate
            , IRP.FIDLEGClassNo AS riskProfile_fidlegClassNo
            , IRP.OptingInOut AS riskProfile_customerType
            , IRP.RiskKeyCalculatedTypeNo AS riskProfile_riskClass_calculated
            , IRP.RiskKeyManualTypeNo AS riskProfile_riskClass_manual
            , IRP.RecProductCategoryNo AS riskProfile_productClass_calculated
            , IRP.ManProductCategoryNo AS riskProfile_productClass_manual
            , IRP.InvestmentTypeNo AS riskProfile_investment_type
            , IRP.InvestmentAmount AS riskProfile_investment_amount
            , IRP.InvestmentAmountCurr AS riskProfile_investment_currency
            , IRP.InvestmentHorizon AS riskProfile_investment_duration
            , KE1.Experience AS riskProfile_moneyMarket_experience
            , KE1.Knowledge AS riskProfile_moneyMarket_knowledge
            , KE1.Information AS riskProfile_moneyMarket_information
            , KE2.Experience AS riskProfile_bonds_experience
            , KE2.Knowledge AS riskProfile_bonds_knowledge
            , KE2.Information AS riskProfile_bonds_information
            , KE3.Experience AS riskProfile_shares_experience
            , KE3.Knowledge AS riskProfile_shares_knowledge
            , KE3.Information AS riskProfile_shares_information
            , KE4.Experience AS riskProfile_realEstate_experience
            , KE4.Knowledge AS riskProfile_realEstate_knowledge
            , KE4.Information AS riskProfile_realEstate_information
            , KE5.Experience AS riskProfile_structuredProducts_experience
            , KE5.Knowledge AS riskProfile_structuredProducts_knowledge
            , KE5.Information AS riskProfile_structuredProducts_information
            , KE6.Experience AS riskProfile_metals_experience
            , KE6.Knowledge AS riskProfile_metals_knowledge
            , KE6.Information AS riskProfile_metals_information
            , KE8.Experience AS riskProfile_others_experience
            , KE8.Knowledge AS riskProfile_others_knowledge
            , KE8.Information AS riskProfile_others_information
            , GETUTCDATE() as lastSyncDate
FROM        PtBase PB
JOIN        PtDescriptionView PDV ON PDV.Id = PB.Id
JOIN        PtInvestmentRiskProfile IRP ON IRP.PartnerId = PB.Id
                AND IRP.HdVersionNo BETWEEN 1 AND 999999998
                AND IRP.IsInactiv = 0
LEFT JOIN   PtInvestmentKE KE1 ON KE1.InvestmentRiskProfileID = IRP.Id AND KE1.AssetClassNumber = 1
LEFT JOIN   PtInvestmentKE KE2 ON KE2.InvestmentRiskProfileID = IRP.Id AND KE2.AssetClassNumber = 2
LEFT JOIN   PtInvestmentKE KE3 ON KE3.InvestmentRiskProfileID = IRP.Id AND KE3.AssetClassNumber = 3
LEFT JOIN   PtInvestmentKE KE4 ON KE4.InvestmentRiskProfileID = IRP.Id AND KE4.AssetClassNumber = 4
LEFT JOIN   PtInvestmentKE KE5 ON KE5.InvestmentRiskProfileID = IRP.Id AND KE5.AssetClassNumber = 5
LEFT JOIN   PtInvestmentKE KE6 ON KE6.InvestmentRiskProfileID = IRP.Id AND KE6.AssetClassNumber = 6
LEFT JOIN   PtInvestmentKE KE8 ON KE8.InvestmentRiskProfileID = IRP.Id AND KE8.AssetClassNumber = 8
WHERE       PB.TerminationDate IS NULL
ORDER BY    PB.PartnerNo
