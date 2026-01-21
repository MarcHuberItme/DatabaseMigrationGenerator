--liquibase formatted sql

--changeset system:create-alter-view-PtBaseQueryBirthday context:any labels:c-any,o-view,ot-schema,on-PtBaseQueryBirthday,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtBaseQueryBirthday
CREATE OR ALTER VIEW dbo.PtBaseQueryBirthday AS
SELECT     TOP 100 PERCENT
PtBase.Id,
PtBase.HdCreateDate,
PtBase.HdCreator,
PtBase.HdChangeDate,
PtBase.HdChangeUser,
PtBase.HdEditStamp,
PtBase.HdVersionNo,
PtBase.HdProcessId,
PtBase.HdStatusFlag,
PtBase.HdNoUpdateFlag,
PtBase.HdPendingChanges,
PtBase.HdPendingSubChanges,
PtBase.HdTriggerControl,
dbo.PtBase.PartnerNoEdited, dbo.PtBase.FirstName, dbo.PtBase.Name, YEAR(GETDATE()) - dbo.PtBase.YearOfBirth AS [Jubilaeum], 
                      dbo.PtBase.DateOfBirth, dbo.PtBase.ConsultantTeamName
FROM         dbo.PtBase LEFT OUTER JOIN
                      dbo.MgA02 ON dbo.PtBase.MgSACHB = dbo.MgA02.MigValue
WHERE     (dbo.PtBase.TerminationDate IS NULL) AND (dbo.PtBase.YearOfBirth <> 0) AND (YEAR(GETDATE()+1) - dbo.PtBase.YearOfBirth >= 60) AND 
                      (dbo.PtBase.SexStatusNo = 1 OR
                      dbo.PtBase.SexStatusNo = 2) AND (dbo.PtBase.YearOfBirth IS NOT NULL) AND ((YEAR(GETDATE()+1) - dbo.PtBase.YearOfBirth) / 5 * 5 = YEAR(GETDATE()+1)
                       - dbo.PtBase.YearOfBirth)
ORDER BY dbo.PtBase.MgSACHB
