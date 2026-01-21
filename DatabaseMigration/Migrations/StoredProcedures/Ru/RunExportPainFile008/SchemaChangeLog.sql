--liquibase formatted sql

--changeset system:create-alter-procedure-RunExportPainFile008 context:any labels:c-any,o-stored-procedure,ot-schema,on-RunExportPainFile008,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RunExportPainFile008
CREATE OR ALTER PROCEDURE dbo.RunExportPainFile008
@DebugMode BIT = 0,
@BeginDate DATETIME,
@DueDatePlusDays INT = 5
AS
BEGIN

-- 1st Get all record IDs from all invoices, that have the due date of payment in five days. Needed to generate LSV 008 Pain files.
DECLARE @RecordIds TABLE (Id uniqueidentifier)
INSERT @RecordIds(Id)
SELECT
adc.Id
FROM
PtAccountDebitControl adc 
INNER JOIN PtBase AS base ON base.Id = adc.PartnerId
INNER JOIN PtAddress AS adr ON adr.PartnerId = base.Id AND adr.AddressTypeNo = 11 -- Just address type number 11
INNER JOIN PtExternalAccountMap AS eam ON eam.FinstarAccountId = adc.DebitAccountId AND eam.HdVersionNo BETWEEN 1 AND 999999998 -- Because Avobis is not a bank, we need the IBAN number from this mapping table, and not direct from PtAccountBase
INNER JOIN PrReference AS ref ON ref.AccountId = adc.DebitAccountId
INNER JOIN PrPrivate AS prvt ON prvt.ProductId = ref.ProductId
INNER JOIN PtExternalBillConfig AS ebc ON ebc.ProductNo = prvt.ProductNo -- PtExternalBillConfig must be configured with Product Number
INNER JOIN PtAccountDirectDebiting AS dd ON dd.Identification = ebc.LsvId AND dd.AccountId = adc.DebitAccountId AND dd.HdVersionNo BETWEEN 1 AND 999999998 -- PtExternalBillConfig must be configured with LSV-ID
WHERE 
(adc.InvoiceDueDate <= DATEADD(DAY, @DueDatePlusDays, GETDATE())) -- All invoices with due date in the next 5 days
AND (adc.InvoiceDueDate >= @BeginDate) -- But only these ones, that are newer than the parameter BeginDate
AND (adc.LsvExportDateTime IS NULL) -- And just these ones, that aren't already exported, by an older run of this Stored Procedure (because LsvExportDateTime will be set, immediate after this SELECT)
AND (adc.InitialAmount > 0); -- And just these ones, that have an amount (because, there exists with 0.00 amount)


-- 2nd Replacement of the first digits of ESR ReferenceNo is necessary for Avobis Refinanzierer Banks
-- Just works with ESR reference numbers with 27 digits, and no spaces or other characters are allowed.
-- After this run the 'Modulo 10 recursive calculation' to build the new checksum (the last digit of 27 ESR reference number)
UPDATE PtAccountDebitControl  
SET ReferenceNo = 
CASE
	WHEN LEN(adc.ReferenceNo) = 27 THEN
		CASE
			WHEN ebc.LsvId = 'KFH1W' THEN dbo.GetEsrRefNoWithCorrectChecksum('995595' + SUBSTRING(adc.ReferenceNo, 7, 21))
			WHEN ebc.LsvId = 'KFH2W' THEN dbo.GetEsrRefNoWithCorrectChecksum('381100' + SUBSTRING(adc.ReferenceNo, 7, 21))
			WHEN ebc.LsvId = 'BEP1W' THEN dbo.GetEsrRefNoWithCorrectChecksum('988832' + SUBSTRING(adc.ReferenceNo, 7, 21))
			WHEN ebc.LsvId = 'IST2I' AND ebc.ProductNo IN(3450, 3460, 3480) THEN dbo.GetEsrRefNoWithCorrectChecksum('952015' + SUBSTRING(adc.ReferenceNo, 7, 21))
			WHEN ebc.LsvId = 'IST2I' AND ebc.ProductNo IN(3360) THEN dbo.GetEsrRefNoWithCorrectChecksum('951645' + SUBSTRING(adc.ReferenceNo, 7, 21))
			WHEN ebc.LsvId = 'IST2I' AND ebc.ProductNo IN(3361) THEN dbo.GetEsrRefNoWithCorrectChecksum('951758' + SUBSTRING(adc.ReferenceNo, 7, 21))
			WHEN ebc.LsvId = 'AJW1W' THEN dbo.GetEsrRefNoWithCorrectChecksum('981329' + SUBSTRING(adc.ReferenceNo, 7, 21))
			WHEN ebc.LsvId = 'JAP1W' THEN dbo.GetEsrRefNoWithCorrectChecksum('905442' + SUBSTRING(adc.ReferenceNo, 7, 21))
			ELSE adc.ReferenceNo
		END
	ELSE adc.ReferenceNo
END
FROM PtAccountDebitControl AS adc
INNER JOIN @RecordIds ids ON ids.Id = adc.Id
INNER JOIN PrReference AS ref ON ref.AccountId = adc.DebitAccountId
INNER JOIN PrPrivate AS prvt ON prvt.ProductId = ref.ProductId
INNER JOIN PtExternalBillConfig AS ebc ON ebc.ProductNo = prvt.ProductNo
WHERE ebc.LsvId IS NOT NULL AND ebc.ProductNo IS NOT NULL;


-- 3rd Result of the stored procedure, to generate a LSV pain 008 file in JCS job.
SELECT
adc.Id, adc.ReferenceNo, adc.InvoiceCurrency, adc.InitialAmount, adc.InvoiceDueDate,
adr.NameLine AS DebtorNameLine,
ebc.MandateName AS CreditorName, ebc.EsrParticipantNo, ebc.LsvId,
ebc.Iban AS CreditorIban, eam.ExternalIban AS DebtorIban,
adr.Zip AS ZipDebtor,   adr.Town AS TownDebtor,   adr.Street AS StreetDebtor,   adr.HouseNo AS HouseNoDebtor,   adr.CountryCode AS CountryCodeDebtor,
ebc.Zip AS ZipCreditor, ebc.Town AS TownCreditor, ebc.Street AS StreetCreditor, ebc.HouseNo AS HouseNoCreditor, ebc.CountryCode AS CountryCodeCreditor
FROM
PtAccountDebitControl adc
INNER JOIN @RecordIds ids ON ids.Id = adc.Id
INNER JOIN PtBase AS base ON base.Id = adc.PartnerId
INNER JOIN PtAddress AS adr ON adr.PartnerId = base.Id AND adr.AddressTypeNo = 11
INNER JOIN PtExternalAccountMap AS eam ON eam.FinstarAccountId = adc.DebitAccountId
INNER JOIN PrReference AS ref ON ref.AccountId = adc.DebitAccountId
INNER JOIN PrPrivate AS prvt ON prvt.ProductId = ref.ProductId
INNER JOIN PtExternalBillConfig AS ebc ON ebc.ProductNo = prvt.ProductNo
INNER JOIN PtAccountDirectDebiting AS dd ON dd.Identification = ebc.LsvId AND dd.AccountId = adc.DebitAccountId
ORDER BY
adc.Id, adc.PartnerId, adc.InvoiceDueDate;

-- 4th Set the LsvExportDateTime to the current timestamp, to avoid to be generated a second time.
UPDATE PtAccountDebitControl 
SET 
LsvExportDateTime = GETDATE() 
FROM
PtAccountDebitControl adc
INNER JOIN @RecordIds ids ON ids.Id = adc.Id;

END;
