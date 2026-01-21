--liquibase formatted sql

--changeset system:create-alter-view-PtCheckResultLatestView context:any labels:c-any,o-view,ot-schema,on-PtCheckResultLatestView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCheckResultLatestView
CREATE OR ALTER VIEW dbo.PtCheckResultLatestView AS
SELECT cr.* FROM
   (SELECT ProfileId, CheckTypeNo, Max(MatchDate) LatestDate 
       FROM PtCheckResult
       GROUP BY ProfileId, CheckTypeNo) LatestMatch
   JOIN PtCheckResult cr ON cr.ProfileId = LatestMatch.ProfileId 
       AND cr.CheckTypeNo = LatestMatch.CheckTypeNo 
       AND LatestMatch.LatestDate = cr.MatchDate
