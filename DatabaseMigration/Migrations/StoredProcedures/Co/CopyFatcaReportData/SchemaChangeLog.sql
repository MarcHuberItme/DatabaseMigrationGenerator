--liquibase formatted sql

--changeset system:create-alter-procedure-CopyFatcaReportData context:any labels:c-any,o-stored-procedure,ot-schema,on-CopyFatcaReportData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CopyFatcaReportData
CREATE OR ALTER PROCEDURE dbo.CopyFatcaReportData
AS
DECLARE @taxReportId UNIQUEIDENTIFIER;
DECLARE @refTaxReportId UNIQUEIDENTIFIER;
DECLARE @taxProgramNo INT;

SET @taxProgramNo = 840

SELECT @taxReportId = Id, @refTaxReportId = RefTaxReportId
FROM AiTaxReport
WHERE TaxProgramNo = @taxProgramNo
AND ReportStatusNo = 1
AND ReportTypeNo IN(2,3,4)
AND HdVersionNo BETWEEN 1 AND 999999998;

-- Get all accounts with status 4 or which belong to a partner with status 4
INSERT INTO AiTaxReportAccount (HdCreator, HdChangeUser, HdVersionNo, TaxReportId, AccountNo, AccountHolder, RefTaxReportAccountId, Currency, Balance, StatusNo)
SELECT SUSER_NAME(), SUSER_NAME(), 1, @taxReportId, AccountNo, AccountHolder, Id, Currency, Balance, 1 
FROM AiTaxReportAccount tra
WHERE TaxReportId = @refTaxReportId
AND (StatusNo = 4
OR EXISTS(SELECT Id 
			FROM AiTaxReportPartner trp 
			WHERE trp.Id = tra.AccountHolder 
			AND TaxReportId = @refTaxReportId AND StatusNo = 4
			AND trp.HdVersionNo BETWEEN 1 AND 999999998))
AND tra.HdVersionNo BETWEEN 1 AND 999999998;

-- Get all partners with status 4 or which belong to an account with status 4 or which are substantial owners of an account with status 4 
INSERT INTO AiTaxReportPartner (HdCreator, HdChangeUser, HdVersionNo, TaxReportId, PartnerTypeNo, PartnerId, PartnerNoEdited, FiscalCountries, Tin, Title, Name, FirstName, MiddleName, NameCont, AddrZip, AddrTown, AddrStreet, AddrHouseNo, AddrPOBox, AddrCountryCode, AddrState, AddrFull, Nationalities, DateOfBirth, StatusNo, AcctHolderTypeNo, RefTaxReportPartnerId)
SELECT SUSER_NAME(), SUSER_NAME(), 1, @taxReportId, PartnerTypeNo, PartnerId, PartnerNoEdited, FiscalCountries, Tin, Title, Name, FirstName, MiddleName, NameCont, AddrZip, AddrTown, AddrStreet, AddrHouseNo, AddrPOBox, AddrCountryCode, AddrState, AddrFull, Nationalities, DateOfBirth, 1, AcctHolderTypeNo, Id
FROM AiTaxReportPartner trp
WHERE TaxReportId = @refTaxReportId
AND (StatusNo = 4
OR EXISTS(SELECT Id 
			FROM AiTaxReportAccount tra 
			WHERE trp.RefTaxReportPartnerId = tra.AccountHolder 
			AND TaxReportId = @refTaxReportId AND StatusNo = 4
			AND tra.HdVersionNo BETWEEN 1 AND 999999998)
OR EXISTS(SELECT tra.Id 
			FROM AiTaxReportAccount tra
			INNER JOIN AiTaxReportSubstantialOwner trso ON tra.RefTaxReportAccountId = trso.TaxReportAccountId AND tra.TaxReportId = @taxReportId AND trso.HdVersionNo BETWEEN 1 AND 999999998
			INNER JOIN AiTaxReportPartner trp2 ON trso.TaxReportPartnerId = trp2.Id AND trp2.HdVersionNo BETWEEN 1 AND 999999998
			WHERE trp2.PartnerId = trp.PartnerId
			AND tra.HdVersionNo BETWEEN 1 AND 999999998)
)
AND trp.HdVersionNo BETWEEN 1 AND 999999998;

-- Get report payments for selected accounts
INSERT INTO AiTaxReportPayment (HdCreator, HdChangeUser, HdVersionNo, TaxReportAccountId, PaymentTypeNo, Currency, Amount, StatusNo)
SELECT SUSER_NAME(), SUSER_NAME(), 1, tra.Id, trp.PaymentTypeNo, trp.Currency, trp.Amount, trp.StatusNo
FROM AiTaxReportPayment trp
INNER JOIN AiTaxReportAccount tra ON tra.RefTaxReportAccountId = trp.TaxReportAccountId AND tra.HdVersionNo BETWEEN 1 AND 999999998
WHERE tra.TaxReportId = @taxReportId
AND trp.HdVersionNo BETWEEN 1 AND 999999998;

-- Get substantial owners for selected accounts
INSERT INTO AiTaxReportSubstantialOwner (HdCreator, HdChangeUser, HdVersionNo, TaxReportAccountId, TaxReportPartnerId, StatusNo)
SELECT SUSER_NAME(), SUSER_NAME(), 1, tra.Id, trp.Id, trso.StatusNo
FROM AiTaxReportSubstantialOwner trso
INNER JOIN AiTaxReportAccount tra ON tra.RefTaxReportAccountId = trso.TaxReportAccountId AND tra.TaxReportId = @taxReportId AND tra.HdVersionNo BETWEEN 1 AND 999999998
INNER JOIN AiTaxReportPartner trp ON trp.RefTaxReportPartnerId = trso.TaxReportPartnerId AND trp.TaxReportId = @taxReportId AND trp.HdVersionNo BETWEEN 1 AND 999999998
WHERE trso.HdVersionNo BETWEEN 1 AND 999999998

UPDATE AiTaxReport SET ReportStatusNo = 2 WHERE Id = @taxReportId



