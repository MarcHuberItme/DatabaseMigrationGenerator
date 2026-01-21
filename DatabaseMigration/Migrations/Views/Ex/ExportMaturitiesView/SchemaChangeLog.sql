--liquibase formatted sql

--changeset system:create-alter-view-ExportMaturitiesView context:any labels:c-any,o-view,ot-schema,on-ExportMaturitiesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportMaturitiesView
CREATE OR ALTER VIEW dbo.ExportMaturitiesView AS
SELECT TOP 100 PERCENT 'maturities_maturityType' = '1'
        , PAC.SyncValidTo AS maturities_maturityDate
        , PB.ConsultantTeamName AS maturities_consultantTeam
        , 'maturities_tandemConsultantFinancing' =  ISNULL(STUFF((
                                                    SELECT  '|' + ASS.UserGroupName
                                                    FROM    PtConsultantTeamAssign ASS
                                                    JOIN    PtConsultantTeamRole ROL on ROL.ConsultantTeamRoleNo = ASS.ConsultantTeamRoleNo
                                                                AND ROL.ConsultantTeamRoleNo IN (1, 2, 3, 4)
                                                    WHERE   ASS.PartnerId = PB.Id
                                                    AND     ASS.HdVersionNo < 999999999
                                                    FOR XML PATH ('')), 1 , 1, ''), NULL)
        , 'maturities_tandemConsultantInvestment' = ISNULL(STUFF((
                                                    SELECT  '|' + ASS.UserGroupName
                                                    FROM    PtConsultantTeamAssign ASS
                                                    JOIN    PtConsultantTeamRole ROL on ROL.ConsultantTeamRoleNo = ASS.ConsultantTeamRoleNo
                                                                AND ROL.ConsultantTeamRoleNo IN (5, 6)
                                                    WHERE   ASS.PartnerId = PB.Id
                                                    AND     ASS.HdVersionNo < 999999999
                                                    FOR XML PATH ('')), 1 , 1, ''), NULL)
        , PB.Id as maturities_partner_id
        , PDV.PtDescription as maturities_partner_description
        , PF.Id AS maturities_portfolio_id
        , PF.PortfolioNo AS maturities_portfolio_portfolioNo_numeric
        , PF.PortfolioNoEdited AS maturities_portfolio_portfolioNo_formatted
        , PF.PortfolioNoText AS maturities_portfolio_portfolioNo_textForSort
        , PF.PortfolioTypeNo AS maturities_portfolio_typeNo
        , 'maturities_generalState' = '1'
        , 'maturities_financing_maturitiesid' = PAC.Id
        , 'maturities_financing_stateNo' = '1'
        , PAB.Id AS maturities_financing_account_id
        , PAB.AccountNo AS maturities_financing_account_accountNo_numeric
        , PAB.AccountNoEdited AS maturities_financing_account_accountNo_formatted
        , PAB.AccountNoText AS maturities_financing_account_accountNo_textForSort
        , PAB.ConformAccountNoIBAN AS maturities_financing_account_accountNo_iban
        , PRI.ProductNo AS maturities_financing_account_productType
        , REF.Currency AS maturities_financing_account_currency
        , PAC.Id AS maturities_financing_tranches_id
        --, PAC.PrivateComponentId as maturities_financing_tranches_privateComponentId
        , PAC.SyncValue as maturities_financing_tranches_value
        , PAC.SyncValidFrom AS maturities_financing_tranches_validFrom
        , PAC.SyncValidTo AS maturities_financing_tranches_validTo
        , 'maturities_financing_account_isInFinancingPortfolio' =
                CASE    WHEN    hasF.Name = 'Mortgage Portfolios'
                        THEN    'true'
                        ELSE    'false'
                END
        , GETUTCDATE() AS lastSyncDate
FROM    PtBase PB
JOIN    PtDescriptionView PDV on PDV.Id = PB.Id
JOIN    PTPortfolio PF on PF.PartnerId = PB.Id
            AND PF.TerminationDate IS NULL
JOIN    PtAccountBase PAB ON PAB.PortfolioId = PF.Id
            AND PAB.TerminationDate IS NULL
JOIN    PrReference REF ON REF.AccountId = PAB.Id
JOIN    PrPrivate PRI ON PRI.ProductId = REF.ProductId
JOIN    AsGroupMember AGM ON AGM.TargetRowId = PRI.Id
JOIN    AsGroup AG ON AG.Id = AGM.GroupId
JOIN    AsGroupLabel AGL ON AGL.GroupId = AG.Id
            AND AGL.Name = 'Mortgage Products'
JOIN    PtAccountComponent PAC ON PAC.AccountBaseId = PAB.Id
            AND PAC.HdVersionNo < 999999999
                    AND PAC.SyncValidTo > DATEADD(DAY, 1, DATEADD(Month, -3, GETDATE()))
                    AND    PAC.SyncValidTo < DATEADD(DAY, 1, DATEADD(YEAR, 15, GETDATE()))
JOIN    PtAccountCompValue PACV ON  PACV.AccountComponentId = PAC.Id
JOIN    PrPrivateCompType PPCT on PPCT.Id = PAC.PrivateCompTypeId
            AND PPCT.CompTypeNo NOT IN (14, 15)
LEFT JOIN (
            SELECT  PFT.PortfolioTypeNo, AGL.Name
            FROM    PtPortfolioType PFT
            JOIN    AsGroupMember AGM on AGM.TargetRowId = PFT.Id
                        AND AGM.HdVersionNo < 999999999
            JOIN    AsGroup AG on AG.Id = AGM.GroupId
                        AND AG.HdVersionNo < 999999999
            JOIN    AsGroupLabel AGL on AGL.GroupId = AG.Id
                        AND AGL.HdVersionNo < 999999999
            WHERE   PFT.HdVersionNo < 999999999
            AND       AGL.Name = 'Mortgage Portfolios'
            ) hasF on hasF.PortfolioTypeNo = PF.PortfolioTypeNo
WHERE   PB.TerminationDate IS NULL
AND     (PACV.Value = 0 AND (PACV.ValidFrom = PAC.SyncValidTo))
AND     PB.ConsultantTeamName NOT IN ('557', '52') --keine Neonkunden | 52 = Buchhaltung
AND     PB.ServiceLevelNo NOT IN (10, 15) --10 technischer Grund | 15 VDF Institution
ORDER   BY PAB.AccountNo
