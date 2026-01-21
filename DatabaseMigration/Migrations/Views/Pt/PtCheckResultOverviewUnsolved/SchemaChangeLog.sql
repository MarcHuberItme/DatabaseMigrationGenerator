--liquibase formatted sql

--changeset system:create-alter-view-PtCheckResultOverviewUnsolved context:any labels:c-any,o-view,ot-schema,on-PtCheckResultOverviewUnsolved,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCheckResultOverviewUnsolved
CREATE OR ALTER VIEW dbo.PtCheckResultOverviewUnsolved AS
SELECT cr.Id As Id, 
               cr.HdPendingChanges, 
               cr.HdPendingSubChanges, 
               cr.HdVersionNo,
               b.Id As PartnerId, 
               b.Partnerno, b.Name + IsNull(b.NameCont,'') + ' ' + IsNull(b.FirstName,'') As PartnerName,
               p.PoliticalExposedPerson, 
               cr.MatchCategoryNo, 
               cr.Score, 
               cr.MatchDate, 
               cr.ProcessId, 
               cr.BankVerificationResultNo, 
               cr.VerificationUser
FROM
	(
		SELECT crS.*
			FROM
			(
				SELECT DISTINCT ProfileId
					FROM PtCheckResult
			) crG
			CROSS APPLY
			(
				SELECT TOP 1 *
					FROM PtCheckResult crF
					WHERE crF.ProfileId = crG.ProfileId
					AND (crF.BankVerificationResultNo IS NULL OR crF.BankVerificationResultNo = 0)
				ORDER BY crF.MatchDate DESC
			) crS
	) cr 
   JOIN PtProfile p on cr.ProfileId = p.Id
   JOIN Ptbase b on p.partnerId = b.id
