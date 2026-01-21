--liquibase formatted sql

--changeset system:create-alter-procedure-GetAgrSecAsBeneficiary context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAgrSecAsBeneficiary,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAgrSecAsBeneficiary
CREATE OR ALTER PROCEDURE dbo.GetAgrSecAsBeneficiary
@PartnerId uniqueidentifier,
@LanguageNo tinyint

AS

SELECT Pt.PartnerNo, Pt.PtDescription, Tx.TextShort AS AgrTypeText, Acc.AccountNoEdited AS ExclusiveAccount, Sec.ReferenceNo, Sec.Description, V.VersionNo, V.BeginDate, V.ExpirationDate, V.PrintDate, V.SignDate,PartnerIdBeneficiary, Sec.PartnerId AS PartnerIdSource
FROM PtAgrSecurity AS Sec
INNER JOIN PtDescriptionView AS Pt ON Sec.PartnerId = Pt.Id
INNER JOIN AsSecurityAgrType AS Sat ON Sec.AgrTypeNo = Sat.AgrTypeNo
LEFT OUTER JOIN PtAgrSecurityVersion AS V ON Sec.Id = V.AgrSecurityId AND (V.ExpirationDate IS NULL OR V.ExpirationDate <= GETDATE()) AND V.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN AsText AS Tx ON Sat.Id = Tx.MasterId AND Tx.LanguageNo = @LanguageNo
LEFT OUTER JOIN PtAccountBase AS Acc ON Sec.ExclusiveAccountId = Acc.Id
WHERE ReplacedDate IS NULL AND Sec.PartnerIdBeneficiary = @PartnerId
AND Sec.HdVersionNo BETWEEN 1 AND 999999998
ORDER BY Pt.PartnerNo, Tx.TextShort, Sec.ReferenceNo, V.VersionNo
