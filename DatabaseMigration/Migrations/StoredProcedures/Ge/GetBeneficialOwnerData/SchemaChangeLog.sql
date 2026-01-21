--liquibase formatted sql

--changeset system:create-alter-procedure-GetBeneficialOwnerData context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBeneficialOwnerData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBeneficialOwnerData
CREATE OR ALTER PROCEDURE dbo.GetBeneficialOwnerData
@PortfolioId UNIQUEIDENTIFIER

As

SELECT PtBase.PartnerNo, PtBase.DateOfBirth, PtLegalStatus.IsLegalEntity, PtNationality.CountryCode, i.ReferenceNo,
PtIdentificationExternal.IdentificationType, PtIdentificationExternal.IdentificationCode, PtBase.Id PartnerId,
M10.PartnerId M10PartnerId, M20.PartnerId M20PartnerId, PtLegalStatus.BeneficialOwnerCode, PtPortfolio.PortfolioTypeNo, PT.Id as PortfolioTypeId
FROM PtPortfolio
JOIN PtPortfolioType PT on PT.PortfolioTypeNo = PtPortfolio.PortfolioTypeNo and PT.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtRelationMaster M10 on M10.PartnerId = PtPortfolio.PartnerId and M10.RelationTypeNo = 10 and M10.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtRelationSlave SM10 on SM10.MasterId = M10.Id and SM10.RelationRoleNo = 6 and SM10.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtRelationMaster M20 on M20.PartnerId = PtPortfolio.PartnerId and M20.RelationTypeNo = 20 and M20.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtRelationSlave SM20 on SM20.MasterId = M20.Id and SM20.RelationRoleNo = 17 and SM20.HdVersionNo between 1 and 999999998
JOIN PtBase on PtBase.id = isnull(SM20.PartnerId, isnull(SM10.PartnerId, PtPortfolio.PartnerId))
JOIN PtNationality on PtNationality.PartnerId = PtBase.Id
and PtNationality.HdVersionNo between 1 and 999999998
JOIN PtLegalStatus on PtLegalStatus.LegalStatusNo = PtBase.LegalStatusNo
and PtLegalStatus.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN PtIdentificationExternal on PtIdentificationExternal.PartnerId = PtBase.Id
    AND PtIdentificationExternal.IdentificationType = (SELECT TOP 1 IE.IdentificationType FROM PtIdentificationExternal IE
    JOIN PtIdentificationExternalType IET ON IE.IdentificationType = IET.IdExtType
    Where IE.PartnerId = PtBase.Id AND  IE.HdVersionNo BETWEEN 1 AND 999999998 ORDER BY IET.Priority)
LEFT OUTER JOIN PtIdentification i on i.PartnerId = PtBase.Id AND i.Id = (SELECT TOP 1 ide.Id FROM PtIdentification ide
    Where ide.PartnerId = PtBase.Id AND ide.IdentificationType ='{EEFEF51F-C9F4-4B4F-8929-6F5D31477E5E}'
    AND ide.HdVersionNo < 999999999 AND ide.ReferenceNo LIKE 'CHE-%' ORDER BY ide.DateOfIssue DESC)
WHERE PtPortfolio.Id = @PortfolioId
ORDER BY PtBase.PartnerNo,PtNationality.CountryCode

