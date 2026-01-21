--liquibase formatted sql

--changeset system:create-alter-view-PtAccountPriceDevTypeView context:any labels:c-any,o-view,ot-schema,on-PtAccountPriceDevTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountPriceDevTypeView
CREATE OR ALTER VIEW dbo.PtAccountPriceDevTypeView AS
SELECT 
PtAccountPriceDevType.Id,
AsText.TextShort,
PtAccountPriceDevType.DeviationReasonType,
PtAccountPriceDevType.ForFixedDurationComp,
PtAccountPriceDevType.ForVariableDurationComp,
AsText.LanguageNo
FROM PtAccountPriceDevType
LEFT JOIN AsText ON PtAccountPriceDevType.Id = AsText.MasterId
