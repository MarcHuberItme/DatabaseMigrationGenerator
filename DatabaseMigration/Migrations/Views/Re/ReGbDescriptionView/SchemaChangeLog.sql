--liquibase formatted sql

--changeset system:create-alter-view-ReGbDescriptionView context:any labels:c-any,o-view,ot-schema,on-ReGbDescriptionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReGbDescriptionView
CREATE OR ALTER VIEW dbo.ReGbDescriptionView AS
SELECT TOP 100 PERCENT
                RP.Id, 
                RP.HdPendingChanges,
                RP.HdVersionNo,
                RP.HdPendingSubChanges,
                RP.ReBaseId,
                RP.PremisesType,
                ISNULL(RP.GBRegisterType, 'GB') + ': ' + ISNULL(RP.GBNo, 0)  + ' ' + ISNULL(RP.GBNoAdd, 0) + ' ' + ISNULL(RP.GBPlanNo, 0) 
                 AS GbDescription,
                 RP.Street,
                 RP.HouseNo,
                 RB.Zip,
                 RB.Town,
                 RP.GBNo,
                 RP.GBNoAdd,
                 RP.GBPlanNo
FROM      RePremises RP, ReBase RB
WHERE  RP.ReBaseId = RB.Id
