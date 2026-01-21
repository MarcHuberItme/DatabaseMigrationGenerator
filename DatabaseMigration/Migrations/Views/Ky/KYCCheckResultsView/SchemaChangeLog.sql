--liquibase formatted sql

--changeset system:create-alter-view-KYCCheckResultsView context:any labels:c-any,o-view,ot-schema,on-KYCCheckResultsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view KYCCheckResultsView
CREATE OR ALTER VIEW dbo.KYCCheckResultsView AS
SELECT PartnerNoEdited, [Name], FirstName, NameCont, PtBase.ID as PartnerId, PtCheckResult.ID as Id 
FROM PtCheckResult
INNER JOIN PtProfile ON PtCheckResult.ProfileId = PtProfile.Id
INNER JOIN PtBase ON PtProfile.PartnerId = PtBase.Id

