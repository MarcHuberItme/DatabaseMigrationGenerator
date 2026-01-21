--liquibase formatted sql

--changeset system:create-alter-view-AiTaxDescriptionView context:any labels:c-any,o-view,ot-schema,on-AiTaxDescriptionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AiTaxDescriptionView
CREATE OR ALTER VIEW dbo.AiTaxDescriptionView AS
SELECT TOP 100 PERCENT
    A.Id, 
    A.HdPendingChanges,
    A.HdPendingSubChanges, 
    A.HdVersionNo,
    A.PartnerNoEdited,
    A.FirstName,
    A.MiddleName,
    A.Name,
    A.NameCont,
    A.DateOfBirth,
    A.AddrPOBox,
    A.AddrStreet,
    A.AddrHouseNo,
    A.AddrZip, 
    A.AddrTown, 
    A.AddrCountryCode,
    A.PartnerNoEdited + ' ' + IsNull(AD.ReportAdrLine,IsNull(A.Name + ' ','') + IsNull(A.FirstName,'') + ' ' + IsNull(A.AddrTown,''))  PtDescription,
    A.TaxReportId,
    R.ReportingPeriod
FROM AiTaxReportPartner A
    JOIN AiTaxReport R ON A.TaxReportId = R.Id
    LEFT OUTER JOIN PtAddress AD ON A.PartnerId = AD.PartnerId AND AD.AddressTypeNo = 11 

