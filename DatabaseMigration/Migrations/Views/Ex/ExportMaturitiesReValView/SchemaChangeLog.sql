--liquibase formatted sql

--changeset system:create-alter-view-ExportMaturitiesReValView context:any labels:c-any,o-view,ot-schema,on-ExportMaturitiesReValView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportMaturitiesReValView
CREATE OR ALTER VIEW dbo.ExportMaturitiesReValView AS
SELECT      'maturities_maturityType' = '2'
            , DATEADD(YEAR, 10, A.ValuationDate) AS maturities_maturityDate
            , A.OwnerId AS maturities_partner_id
            , A.PtDescription AS maturities_partner_description
            , 'maturities_generalState' = '1'
            , A.ValutationId AS  'maturities_revaluation_maturitiesid'
            , 'maturities_revaluation_stateNo' = '1'
            , A.ValuationDate AS 'maturities_revaluation_object_valuationDate'
            , A.GBNo AS 'maturities_revaluation_object_gbNo'
            , A.Street AS 'maturities_revaluation_object_street'
            , A.HouseNo AS 'maturities_revaluation_object_houseNo'
            , A.Zip AS 'maturities_revaluation_object_zip'
            , A.Town AS 'maturities_revaluation_object_town'
            , A.PtDescription AS 'maturities_revaluation_object_owner'
            , A.PropertyTypeNo AS 'maturities_revaluation_object_ownershipType'
            , A.Number AS 'maturities_revaluation_object_ownershipQuota'
            , A.UnitTypeNo AS 'maturities_revaluation_object_ownershipQuotaRatio'
            , A.SChuldner_Id AS 'maturities_revaluation_object_debtor_id'
            , A.Schuldner_Description AS 'maturities_revaluation_object_debtor_description'
            , GETUTCDATE() AS lastSyncDate
  
FROM        (
            SELECT      REL.PartnerNo
                        , REL.PartnerId as OwnerId
                        --, PB.PartnerNo
                        --, PB.PartnerNoEdited
                        --, PB.PartnerNoText
                        , PDV.PtDescription
                        , REL.PropertyTypeNo
                        , REL.Number
                        , REL.UnitTypeNo
                        , REL.ValidTo
                        , PREM.GBNo
                        , PREM.Street
                        , PREM.HouseNo
                        , PREM.Zip
                        , PREM.Town
                        , MAX(VAL.ValuationDate) AS ValuationDate
                        , PB2.Id AS SChuldner_Id
                        , PDV2.PtDescription AS SChuldner_Description
                        , VAL.Id AS VAlutationId
            FROM        ReValuation VAL
            JOIN        RePremises PREM on PREM.Id = VAL.PremisesId
            JOIN        ReBase RB on RB.ID = PREM.ReBaseId
                            AND RB.TerminationDate IS NULL
            JOIN        ReOwnerView REL ON REL.ReBaseId = RB.Id
            JOIN        PtBase PB ON PB.Id = REL.PartnerId
            JOIN        PtDescriptionView PDV on PDV.Id = PB.Id
            JOIN        ReObligPremisesRelation PREMREL on PREMREL.PremisesId = PREM.Id
            JOIN        CoBase CB ON CB.ObligationId = PREMREL.ObligationId
                            AND CB.Inactflag = 0
            JOIN        CoBaseass CBA ON CBA.CollateralId = CB.Id
            JOIN        PtAccountBase PAB ON PAB.Id = CBA.AccountId
            JOIN        PtPortfolio PF on PF.Id = PAB.PortfolioId
            JOIN        PtBase PB2 ON PB2.Id = PF.PartnerId
            JOIN        PtDescriptionView PDV2 ON PDV2.Id = PB2.Id
            WHERE       VAL.HdVersionNo BETWEEN 1 and 999999998
            AND         VAL.ValuationDate IS NOT NULL
            AND         VAL.ValuationStatusCode = 3 --nur freigebene Schätzungen
            AND         (REL.ValidTo IS NULL OR REL.ValidTo > GETDATE())
            GROUP BY    REL.PartnerNo, REL.PartnerId, PDV.PtDescription, REL.PropertyTypeNo, REL.NUmber, REL.UnitTypeNo, REL.ValidTo, PREM.GBNo, PREM.Street, PREM.HouseNo, PREM.Zip, PREM.Town, PB2.Id, PDV2.PtDescription, VAL.Id
            HAVING      MAX(VAL.ValuationDate) < DATEADD(YEAR, -10, GETDATE())
            ) A  
