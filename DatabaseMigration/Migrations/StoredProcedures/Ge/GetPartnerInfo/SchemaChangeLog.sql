--liquibase formatted sql

--changeset system:create-alter-procedure-GetPartnerInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPartnerInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPartnerInfo
CREATE OR ALTER PROCEDURE dbo.GetPartnerInfo

@PartnerId UniqueIdentifier

AS

DECLARE @IsPledged Bit

SELECT @IsPledged =
	CASE
	WHEN
		COUNT(Position.HdVersionNo) > 0 THEN 1
	ELSE 0
	END
FROM PtAgrSecurityPosition AS Position
INNER JOIN PtAgrSecurityVersion AS Version ON Position.SecurityVersionId = Version.Id
INNER JOIN PtAgrSecurity AS Agr ON Version.AgrSecurityId = Agr.Id
WHERE 
Position.PartnerId IN (

	SELECT @PartnerId  AS PartnerId

	UNION ALL

	SELECT Master.PartnerId
	FROM PtRelationMaster AS Master 
	INNER JOIN PtRelationSlave AS Slave ON Master.Id = Slave.MasterId
	WHERE Slave.PartnerId = @PartnerId 
	AND Master.RelationTypeNo = 10 
	AND Slave.RelationRoleNo = 7
	AND Slave.HdVersionNo BETWEEN 1 AND 999999998

	)
AND Position.HdVersionNo BETWEEN 1 AND 999999998
AND Version.PrintDate <= GETDATE() 
AND (Version.ExpirationDate > GETDATE() OR Version.ExpirationDate IS NULL)
AND Version.ReplacedDate IS NULL
AND Agr.HdVersionNo BETWEEN 1 AND 999999998

IF @IsPledged = 0
     BEGIN

     SELECT @IsPledged =
	CASE
	WHEN
		COUNT(Position.HdVersionNo) > 0 THEN 1
	ELSE 0
	END
     FROM PtAgrSecurityPosition AS Position
     INNER JOIN PtAgrSecurityVersion AS Version ON Position.SecurityVersionId = Version.Id
     INNER JOIN PtAgrSecurity AS Agr ON Version.AgrSecurityId = Agr.Id
     WHERE 
	Position.PartnerId IN (

		SELECT Master.PartnerId
		FROM PtRelationMaster AS Master 
		INNER JOIN PtRelationSlave AS Slave ON Master.Id = Slave.MasterId
		WHERE Slave.PartnerId = @PartnerId 
		AND Master.RelationTypeNo = 10 
		AND Slave.RelationRoleNo = 6
		AND Slave.HdVersionNo BETWEEN 1 AND 999999998

		)
	AND Position.InclusiveCoPartners = 1
	AND Position.HdVersionNo BETWEEN 1 AND 999999998
	AND Version.PrintDate <= GETDATE() 
	AND (Version.ExpirationDate > GETDATE() OR Version.ExpirationDate IS NULL)
	AND Version.ReplacedDate IS NULL
	AND Agr.HdVersionNo BETWEEN 1 AND 999999998

     END

SELECT 
A.FullAddress AS Address,
B.ServiceLevelNo,
P.MoneyLaunderSuspect,
P.PEPTypeNo,
B.OpeningDate,
B.TerminationDate,
B.DateOfBirth,
Count(Safe.VersionNo) AS SafeCount,
Count(Dc.InvoiceNo) AS InvoiceCount,
@IsPledged AS IsPartnerPledged
FROM PtBase AS B
INNER JOIN PtProfile AS P ON B.Id = P.PartnerId
LEFT OUTER JOIN PtAddress AS A ON B.Id = A.PartnerId
LEFT OUTER JOIN PtAgrSafeDepositBox AS Safe ON B.Id = Safe.PartnerId 
		 AND (Safe.ExpirationDate IS NULL OR Safe.ExpirationDate > GETDATE())
		 AND Safe.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtAccountDebitControl AS Dc ON B.Id = Dc.PartnerId
		AND Dc.PendingAmount > 0
		AND Dc.HdVersionNo BETWEEN 1 AND 999999998
WHERE 
B.Id = @PartnerId 
AND (A.AddressTypeNo = 11 OR A.AddressTypeNo IS NULL)
Group By A.FullAddress, B.ServiceLevelNo, P.MoneyLaunderSuspect, P.PEPTypeNo, B.OpeningDate,
B.TerminationDate, B.DateOfBirth

