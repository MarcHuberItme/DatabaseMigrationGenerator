--liquibase formatted sql

--changeset system:create-alter-view-ExportPartnersView context:any labels:c-any,o-view,ot-schema,on-ExportPartnersView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportPartnersView
CREATE OR ALTER VIEW dbo.ExportPartnersView AS
SELECT DISTINCT TOP 100 PERCENT PB.Id AS partner_id
            , PB.PartnerNo AS partner_partnerNo_numeric
            , PB.PartnerNoEdited AS partner_partnerNo_formatted
            , PB.PartnerNoText AS partner_partnerNo_textForSort
            , PB.DateOfBirth AS dateOfBirth
            , PB.DateOfDeath AS dateOfDeath
            , PB.TerminationDate AS terminationDate
            , 'partner_description' = PAD.ReportAdrLine
            , ISNULL(PB.ConsultantTeamName, 501) AS consultantTeamName
            , PB.IsAuthorised AS isAuthorized
            , 'personType' =
                CASE    WHEN PB.SexStatusNo IN (1,2)
                        THEN 'NaturalPerson'
                        WHEN PB.SexStatusNo = 5
                        THEN 'Couple'
                        WHEN (PB.SexStatusNo = 3 AND PB.LegalStatusNo IN (33, 35, 36))
                        THEN 'Couple'
                        WHEN PB.LegalStatusNo = 20
                        THEN 'CommunityOfHeirs'
                        ELSE 'LegalPerson'
                END
            , 'persons_naturalperson_gender' =
                CASE    WHEN PB.SexStatusNo = 1
                        THEN 'Female'
                        WHEN PB.SexStatusNo = 2
                        THEN 'Male'
                        ELSE NULL
                END
            , 'persons_naturalperson_legalStatus_value' =
                CASE    WHEN PB.LegalStatusNo = 1
                        THEN 'Single'
                        WHEN PB.LegalStatusNo = 2
                        THEN 'Married'
                        WHEN PB.LegalStatusNo = 4
                        THEN 'Divorced'
                        WHEN PB.LegalStatusNo IN (6, 8)
                        THEN 'LegallySeparated'
                        WHEN PB.LegalStatusNo IN (35,36)
                        THEN 'RegisteredPartnerShip'
                        WHEN PB.LegalStatusNo = 10
                        THEN 'Widowed'
                        ELSE NULL
                END
            , PB.LegalStatusNo AS legalStatus
            , 'persons_legalPerson_legalForm' = ISNULL(PB.LegalStatusNo, 99)
            , 'persons_legalPerson_nogaCode2008' = ISNULL(PB.NogaCode2008, 970000)
            , PB.DateOfVSBComplChecked AS vsb2020_complianceCheckDate
            , 'tandemConsultantTeamName' = ISNULL(STUFF((   SELECT  '|' + ASS.UserGroupName
                                                            FROM    PtConsultantTeamAssign ASS
                                                            WHERE   ASS.PartnerId = PB.Id
                                                            AND     ASS.HdVersionNo < 999999999
                                                            FOR XML PATH ('')), 1 , 1, ''), NULL)
            , 'tandemConsultantRole' = ISNULL(STUFF((       SELECT  '|' + AST.TextShort
                                                            FROM    PtConsultantTeamAssign ASS
                                                            JOIN    PtConsultantTeamRole ROL on ROL.ConsultantTeamRoleNo = ASS.ConsultantTeamRoleNo
                                                            JOIN    AsText AST on AST.MasterId = ROL.Id
                                                            WHERE   ASS.PartnerId = PB.Id
                                                            AND     ASS.HdVersionNo < 999999999
                                                            AND     ROL.HdVersionNo < 999999999
                                                            AND     AST.LanguageNo = 1
                                                            FOR XML PATH ('')), 1, 1, ''), NULL)
            , 'hasFinancing' =
                    CASE    WHEN FIN.hasFinancing = 'true'
                            THEN 'true'
                            ELSE 'false'
                    END
            , 'hasFinancingPortfolio' =
                    CASE    WHEN FIN.hasFinancingPortfolio = 'true'
                            THEN 'true'
                            ELSE 'false'
                    END
            , 'hasInvestment' =
                    CASE    WHEN INV.hasInvestment = 'true'
                            THEN 'true'
                            ELSE 'false'
                    END
            , 'hasAccounts' =
                    CASE    WHEN ACC.hasAccounts = 'true'
                            THEN 'true'
                            ELSE 'false'
                    END
            , 'hasEBanking' =
                    CASE    WHEN IB.hasEBanking = 'true'
                            THEN 'true'
                            ELSE 'false'
                    END
            , 'hasTaxService' =
                    CASE    WHEN TS.hasTaxService = 'true'
                            THEN 'true'
                            ELSE 'false'
                    END
            ,'hasWillAdmin' =
                    CASE    WHEN TS.hasWillAdmin = 'true'
                            THEN 'true'
                            ELSE 'false'
                    END
            , ISNULL(CAR.creditCard, 0) as creditCard
            , ISNULL(CAR.debitCard, 0) as debitCard
            , ISNULL(CAR.fintechCard, 0) as fintechCard
            , ISNULL(CAR.travelCash, 0) as travelCash
            , 'SafeDepositBox' =
                    CASE    WHEN TF.BOX IS NOT NULL
                            THEN 'true'
                            ELSE 'false'
                    END
            , GETUTCDATE() AS lastSyncDate
                               
FROM        PtBase PB
JOIN        PtDescriptionView PDV on PDV.Id = PB.Id
JOIN        PtAddress PAD on PAD.PartnerId = PB.Id AND PAD.AddressTypeNo = 11 AND PAD.HdVersionNo < 999999999
LEFT JOIN   (
            SELECT DISTINCT PB.Id as PartnerId
                , 'hasFinancing' = 'true'
                , 'hasFinancingPortfolio' = 'true'
            FROM            PtBase PB
            JOIN            PtPortfolio PF on PF.PartnerId = PB.Id
            JOIN            PtPortfolioType PFT on PFT.PortfolioTypeNo = PF.PortfolioTypeNo
            JOIN            AsGroupMember AGM on AGM.TargetRowId = PFT.Id
            JOIN            AsGroup AG on AG.Id = AGM.GroupId
            JOIN            AsGroupLabel AGL on AGL.GroupId = AG.Id
            WHERE           PB.TerminationDate IS NULL
            AND             PF.TerminationDate IS NULL
            AND             PFT.HdVersionNo BETWEEN 1 AND 999999998
            AND             AGL.Name = 'Mortgage Portfolios'
            ) FIN on FIN.PartnerId = PB.Id
LEFT JOIN   (
            SELECT DISTINCT PB.Id as PartnerId
                            , 'hasInvestment' = 'true'
                            , PF.PortfolioTypeNo
                            , AST.TextShort
            FROM            PtBase PB
            JOIN            PtPortfolio PF on PF.PartnerId = PB.Id
            JOIN            PtPortfolioType PFT on PFT.PortfolioTypeNo = PF.PortfolioTypeNo
            JOIN            Astext AST on AST.MasterId = PFT.Id AND AST.LanguageNo = 2
            JOIN            AsGroupMember AGM on AGM.TargetRowId = PFT.Id
            JOIN            AsGroup AG on AG.Id = AGM.GroupId
            JOIN            AsGroupLabel AGL on AGL.GroupId = AG.Id
            WHERE           PB.TerminationDate IS NULL
            AND             PF.TerminationDate IS NULL
            AND             PFT.HdVersionNo BETWEEN 1 AND 999999998
            AND             AGL.Name = 'Investment Portfolios'
            ) INV ON INV.PartnerId = PB.Id
LEFT JOIN   (
            SELECT          DISTINCT PB.Id as PartnerId
                            , 'hasAccounts' = 'true'
            FROM            PtBase PB
            JOIN            PtPortfolio PF on PF.PartnerId = PB.Id
            JOIN            PtAccountBase PAB on PAB.PortfolioId = PF.Id
            WHERE           PB.TerminationDate IS NULL
            AND             PF.TerminationDate IS NULL
            AND             PAB.TerminationDate IS NULL
            ) ACC on ACC.PartnerId = PB.Id
LEFT JOIN   (
            SELECT DISTINCT PB.Id as PartnerId
                , 'hasEBanking' = 'true'
            FROM            PtBase PB
            JOIN            PtAgrEBanking AGR on AGR.PartnerId = PB.Id
                                AND AGR.HdVersionNo BETWEEN 1 AND 999999998
            WHERE           PB.TerminationDate IS NULL
            ) IB on IB.PartnerId = PB.Id
LEFT JOIN   (
            SELECT  DISTINCT PB.Id as partnerId
                    ,'hasTaxService' =
                    CASE    WHEN Pro.TaxService = 'true'
                            THEN 'true'
                            ELSE 'false'
                    END
                    ,'hasWillAdmin' =
                    CASE    WHEN Pro.WillAdmin = 'true'
                            THEN 'true'
                            ELSE 'false'
                    END
                       
            FROM    PtBase PB
            JOIN    PtProfile PRO on PRO.PartnerId = PB.Id
            WHERE   PB.TerminationDate IS NULL
            AND     PRO.HdVersionNo < 999999999
            ) TS ON TS.partnerId = PB.Id
LEFT JOIN   (
            SELECT      A.partnerId
                        , sum(A.creditCard) as creditCard
                        , sum(A.debitCard) as debitCard
                        , sum(A.travelCash) as travelCash
                        , sum(A.finTechCard) as fintechCard
            FROM        (
                        SELECT  DISTINCT PB.Id as partnerId
                                , 'creditCard' =
                                            CASE    WHEN CB.CardType IN (5, 6, 15, 16)
                                                    THEN 1
                                                    ELSE 0
                                            END
                                , 'debitCard' =
                                            CASE    WHEN CB.CardType IN (1, 2, 20, 21, 22, 23, 24, 25, 301)
                                                    THEN 1
                                                    ELSE 0
                                            END
                                , 'travelCash' =
                                            CASE    WHEN CB.CardType IN (17)
                                                    THEN 1
                                                    ELSE 0
                                            END
                                , 'finTechCard' =
                                            CASE    WHEN CB.CardType IN (200, 201, 202, 203, 204, 205, 206, 207, 208, 209, 210, 211, 212, 213, 214, 302, 303, 304, 305, 401)
                                                    THEN 1
                                                    ELSE 0
                                            END
                        FROM    PtBase PB
                        JOIN    PtAgrCardBase CB on CB.PartnerId = PB.Id
                        JOIN    PtAgrCard CA on CA.CardId = CB.Id
                        WHERE   PB.TerminationDate IS NULL
                        AND     CB.HdVersionNo < 999999999
                        AND     CA.HdVersionNo < 999999999
                        AND     CA.CardStatus IN (0, 1, 2, 3, 5, 6, 8)
                        AND     (CB.ExpirationDate IS NULL OR CB.ExpirationDate > GETDate())
                        ) A
            GROUP BY A.partnerId
            ) CAR on CAR.partnerId = PB.Id
LEFT JOIN   (
            SELECT  PB.Id as partnerId
                    , BOX.Id as BOX
            FROM    PtBase PB
            JOIN    PtAgrSafeDepositBox BOX on BOX.PartnerId = PB.Id
            WHERE   PB.TerminationDate IS NULL
            AND     BOX.HdVersionNo < 999999999
            AND     (BOX.ExpirationDate IS NULL OR BOX.ExpirationDate > GETDate())
            ) TF on TF.partnerId = PB.Id
WHERE   PB.ConsultantTeamName NOT IN ('557', '52') --keine Neonkunden | 52 = Buchhaltung
AND     PB.ServiceLevelNo NOT IN (15) --15 VDF Institution
AND     PB.Id IS NOT NULL
ORDER   BY PB.PartnerNo
