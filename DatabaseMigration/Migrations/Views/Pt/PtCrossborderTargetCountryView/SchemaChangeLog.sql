--liquibase formatted sql

--changeset system:create-alter-view-PtCrossborderTargetCountryView context:any labels:c-any,o-view,ot-schema,on-PtCrossborderTargetCountryView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCrossborderTargetCountryView
CREATE OR ALTER VIEW dbo.PtCrossborderTargetCountryView AS
SELECT TOP 100 PERCENT
Pt.Id, Adr.CountryCode AS MainFiscalCountry, FC.CountryCode AS FiscalCountry, N.CountryCode AS Nationality, US_Status.BasketNo AS USFiscalStatus,
CASE WHEN Adr.CountryCode = 'US' OR FC.CountryCode = 'US' OR N.CountryCode = 'US' OR US_Status.BasketNo = 40 THEN 'US'
ELSE Adr.CountryCode END AS TargetCountry
FROM PtBase AS Pt
INNER JOIN PtAddress AS Adr ON Pt.Id = Adr.PartnerId AND Adr.AddressTypeNo = 11
LEFT OUTER JOIN PtFiscalCountry AS FC ON Pt.Id = FC.PartnerId AND FC.CountryCode = 'US' AND FC.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PtNationality AS N ON Pt.Id = N.PartnerId AND N.CountryCode = 'US' AND N.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN (
					SELECT DISTINCT PartnerId, BasketNo FROM PtAgrTaxRegulation 
					WHERE BasketNo = 40 AND HdVersionNo BETWEEN 1 AND 999999998 
					AND (ExpirationDate IS NULL OR ExpirationDate < GETDATE())
				) AS US_Status ON Pt.Id = US_Status.PartnerId

