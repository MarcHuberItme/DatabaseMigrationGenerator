--liquibase formatted sql

--changeset system:create-alter-view-PtMLPeriodicCheckView context:any labels:c-any,o-view,ot-schema,on-PtMLPeriodicCheckView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtMLPeriodicCheckView
CREATE OR ALTER VIEW dbo.PtMLPeriodicCheckView AS
SELECT  PCO.PartnerId
        ,PC.EndDate
        ,PC.ChannelNo
        ,PCST.Text
        ,PCST.URL
FROM PtMLPeriodicCheck PC
        INNER JOIN PtMLPeriodicCheckOverview PCO ON PCO.ID = PC.PeriodicCheckOverviewId
        INNER JOIN PtMLPeriodicCheckState PCS ON PCS.StateNo = PC.StateNo
                        AND PCS.OpenIssueStatusNo = 5
        INNER JOIN PtAddress PAD ON PAD.PartnerId = PCO.PartnerId
        INNER JOIN PtMLPeriodicCheckStateText PCST ON PCST.ChannelNo = PC.ChannelNo
                    AND PCST.CheckStateNo = PC.StateNo
                    AND PCST.LanguageNo = PAD.PreferredLanguageNo
WHERE PC.HdVersionNo BETWEEN 1 AND 999999998
        AND GETDATE() BETWEEN PCST.ValidFrom AND PCST.ValidTo
        AND PCO.HdVersionNo BETWEEN 1 AND 999999998
        AND PCS.HdVersionNo BETWEEN 1 AND 999999998
        AND PAD.HdVersionNo BETWEEN 1 AND 999999998
        AND PCST.HdVersionNo BETWEEN 1 AND 999999998
