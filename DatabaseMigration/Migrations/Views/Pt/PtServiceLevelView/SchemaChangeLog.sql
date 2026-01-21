--liquibase formatted sql

--changeset system:create-alter-view-PtServiceLevelView context:any labels:c-any,o-view,ot-schema,on-PtServiceLevelView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtServiceLevelView
CREATE OR ALTER VIEW dbo.PtServiceLevelView AS
SELECT 
PtServiceLevel.Id,
AsText.TextShort,
PtServiceLevel.ServiceLevelNo,
AsText.LanguageNo,
PtServiceLevel.ForLegalPartner,
PtServiceLevel.ForNaturalPartner,
PtServiceLevel.ForAiA,
PtServiceLevel.ForAML,
PtServiceLevel.ForAnonymous,
PtServiceLevel.ForMarriedCouple
 FROM PtServiceLevel
 INNER JOIN AsText ON PtServiceLevel.Id=AsText.MasterId
 AND PtServiceLevel.HdVersionNo<999999999
