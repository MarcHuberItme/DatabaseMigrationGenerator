--liquibase formatted sql

--changeset system:create-alter-view-ExportMaturitiesInvestmentView context:any labels:c-any,o-view,ot-schema,on-ExportMaturitiesInvestmentView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportMaturitiesInvestmentView
CREATE OR ALTER VIEW dbo.ExportMaturitiesInvestmentView AS
SELECT DISTINCT 'maturities_maturityType' = '3'
            , PB.Id AS maturities_investment_partner_id
            , PB.PartnerNo AS maturities_investment_partner_no_numeric
            , PB.PartnerNoEdited AS maturities_investment_partner_no_formatted
            , PB.PartnerNoText AS maturities_investment_partner_no_textForSort
            , PDV.PtDescription AS maturities_investment_partner_description
            , PF.PortfolioNo AS maturities_investment_portfolio_no_numeric
            , PF.PortfolioNoEdited AS maturities_investment_portfolio_no_formatted
            , PF.PortfolioNoText AS maturities_investment_portfolio_no_textForSort
            , PF.CustomerReference AS maturities_investment_portfolio_customerReference
            , PF.PortfolioTypeNo AS maturities_investment_portfolio_type
            , REF.Currency AS maturities_investment_instrument_currency
            , POS.Id AS maturities_investment_positionId
            , PUBDV.Id AS maturities_investment_instrument_id
            , PUBDV.IsinNo AS maturities_investment_instrument_isinNo
            , PUBDV.VdfInstrumentSymbol AS maturities_investment_instrument_no
            , PUBDV.PublicDescription AS maturities_investment_instrument_description
            , PUBDV.InstrumentTypeNo AS maturities_investment_instrument_typeNo
            , PUBDV.SecurityType AS maturities_investment_instrument_SecType
            , PUBDV.IssuerId AS maturities_investment_instrument_issuer_id
            , 'maturities_investment_instrument_maturityDate' = CASE
                        WHEN    PUBDV.InstrumentTypeNo = 5  --Bezugsrecht
                        THEN    CF.PlannedEndDate          
                        WHEN    PUBDV.RefTypeNo = 6         --Versicherung
                        THEN    INS.MaturityDate
                        WHEN    (PUBDV.Issuerid = '{A0B962C6-2FCC-4490-AE31-598220EF6D08}' AND PUBDV.InstrumentTypeNo = 8) --KO Hypi
                        THEN    REF.MaturityDate
                        ELSE    CF.DueDate
                    END
            , POS.Quantity AS maturities_investment_instrument_quantity
            , GETUTCDATE() AS lastSyncDate
FROM        PtPosition POS
JOIN        PtPortfolio PF ON PF.Id = POS.PortfolioId
                AND PF.PortfolioTypeNo NOT IN (5020, 5050)
JOIN        PtBase PB ON PB.Id = PF.PartnerId
JOIN        PtDescriptionView PDV ON PDV.Id = PB.Id
JOIN        PrReference REF ON REF.Id = POS.ProdReferenceId
JOIN        PrPublicDescriptionView PUBDV ON PUBDV.ProductId = REF.ProductId
                AND PUBDV.LanguageNo = 2
LEFT JOIN   (SELECT     PublicId, ProdReferenceId, Max(DueDate) AS DueDate, Max(PlannedEndDate) AS PlannedEndDate
            FROM        PrPublicCf
            WHERE       HdVersionNo < 999999999
            AND         PaymentFuncNo IN (1, 18)
            AND         CashFlowStatusNo IN (1, 13)
            AND         (PlannedEndDate  IS NULL OR PlannedEndDate > GETDATE())
            AND         (DueDate IS NULL OR DueDate > GETDATE())
            GROUP BY    PublicId, ProdReferenceId) AS CF ON CF.PublicId = PUBDV.Id
LEFT JOIN   PrInsurancePolice INS on INS.Id = REF.InsurancePoliceId
WHERE       POS.Quantity <> 0
AND         PUBDV.InstrumentTypeNo <> 201 --Schuldbriefe
AND         (INS.MaturityDate IS NULL OR INS.MaturityDate > GETDATE())
AND         (REF.MaturityDate  IS NULL OR REF.MaturityDate > GETDATE())
