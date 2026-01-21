--liquibase formatted sql

--changeset system:create-alter-function-GetOtherCounterParty context:any labels:c-any,o-function,ot-schema,on-GetOtherCounterParty,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetOtherCounterParty
CREATE OR ALTER FUNCTION dbo.GetOtherCounterParty
(
@PortfolioId uniqueidentifier 
)
RETURNS @OtherCounterPartyInfo TABLE(
	PortfolioId uniqueidentifier,
	OtherCounterpartyIDType char(1),
	OtherCounterPartyID varchar(50)
) AS
BEGIN
	DECLARE @OtherCounterpartyIDType char(1)
	DECLARE @OtherCounterPartyID varchar(50)

SELECT	TOP 1
	--PtBase.PartnerNo, PtBase.DateOfBirth, PtLegalStatus.IsLegalEntity, PtNationality.CountryCode, PtIdentification.ReferenceNo, 
	--PtIdentificationExternal.IdentificationCode, PtBase.Id PartnerId, M10.PartnerId M10PartnerId, M20.PartnerId M20PartnerId
	--RelationTypeNo = ISNULL(M20.RelationTypeNo,ISNULL(M10.RelationTypeNo,0))
	@OtherCounterpartyIDType = CASE
          		WHEN PtIdentificationExternal.IdentificationCode IS NOT NULL AND PtLegalStatus.IsLegalEntity  = 1
			THEN ISNULL(IEType.CounterpartyIDType,'I')
		ELSE 'I' END
	,@OtherCounterPartyID = CASE
          		WHEN PtIdentificationExternal.IdentificationCode IS NOT NULL AND PtLegalStatus.IsLegalEntity  = 1
			THEN PtIdentificationExternal.IdentificationCode
	          	WHEN PtIdentification.ReferenceNo IS NOT NULL AND PtLegalStatus.IsLegalEntity  = 1
			THEN PtIdentification.ReferenceNo
		ELSE PtNationality.CountryCode + '-' + CONVERT(CHAR(8),ISNULL(PtBase.DateOfBirth,'19000101'),112) + '-' + CONVERT(CHAR(9),PtBase.PartnerNo) END
FROM PtPortfolio
	LEFT OUTER JOIN PtRelationMaster M10 ON M10.PartnerId = PtPortfolio.PartnerId AND M10.RelationTypeNo = 10 AND M10.HdVersionNo BETWEEN 1 AND 999999998
	LEFT OUTER JOIN PtRelationSlave SM10 ON SM10.MasterId = M10.Id AND SM10.RelationRoleNo = 6 AND SM10.HdVersionNo BETWEEN 1 AND 999999998
	LEFT OUTER JOIN PtRelationMaster M20 ON M20.PartnerId = PtPortfolio.PartnerId AND M20.RelationTypeNo = 20 AND M20.HdVersionNo BETWEEN 1 AND 999999998
	LEFT OUTER JOIN PtRelationSlave SM20 ON SM20.MasterId = M20.Id AND SM20.RelationRoleNo = 17 AND SM20.HdVersionNo BETWEEN 1 AND 999999998
	JOIN PtBase ON PtBase.Id = ISNULL(SM20.PartnerId, ISNULL(SM10.PartnerId, PtPortfolio.PartnerId))
	JOIN PtLegalStatus ON PtLegalStatus.LegalStatusNo = PtBase.LegalStatusNo AND PtLegalStatus.HdVersionNo BETWEEN 1 AND 999999998
	LEFT JOIN PtNationality ON PtNationality.PartnerId = PtBase.Id AND PtNationality.CountryCode = (SELECT TOP 1 ptn.CountryCode FROM PtNationality ptn
		WHERE ptn.PartnerId = PtBase.Id
		AND   ptn.HdVersionNo BETWEEN 1 AND 999999998
		ORDER BY ptn.CountryCode ASC)
	LEFT OUTER JOIN PtIdentification ON PtIdentification.PartnerId = PtBase.Id AND PtIdentification.Id = (SELECT TOP 1 ide.Id FROM PtIdentification ide
                	WHERE ide.PartnerId = PtBase.Id AND ide.IdentificationType = '{EEFEF51F-C9F4-4B4F-8929-6F5D31477E5E}'	--Bestätigung HR Eintrag
	                AND   ide.HdVersionNo BETWEEN 1 AND 999999998
		AND   ide.ReferenceNo LIKE 'CHE-%' 
		ORDER BY ide.DateOfIssue DESC)
	LEFT OUTER JOIN PtIdentificationExternal ON PtIdentificationExternal.PartnerId = PtBase.Id
                                AND PtIdentificationExternal.HdVersionNo BETWEEN 1 AND 999999998 
		AND PtIdentificationExternal.IdentificationType = (SELECT TOP 1 IE.IdentificationType FROM PtIdentificationExternal IE
	                JOIN PtIdentificationExternalType IET ON IE.IdentificationType = IET.IdExtType
                	WHERE IE.PartnerId = PtBase.Id 
		AND   IE.HdVersionNo BETWEEN 1 AND 999999998 
		ORDER BY IET.Priority)
	LEFT JOIN PtIdentificationExternalType IEType ON PtIdentificationExternal.IdentificationType = IEType.IdExtType 
WHERE PtPortfolio.Id = @PortfolioId
ORDER BY ISNULL(M20.RelationTypeNo,ISNULL(M10.RelationTypeNo,0)) DESC, PtBase.PartnerNo, PtNationality.CountryCode ASC


INSERT INTO @OtherCounterPartyInfo(PortfolioId, OtherCounterpartyIDType, OtherCounterPartyID)
	VALUES(@PortfolioId, @OtherCounterpartyIDType, @OtherCounterPartyID)
RETURN

END
