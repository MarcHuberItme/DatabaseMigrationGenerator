--liquibase formatted sql

--changeset system:create-alter-view-PtAgrEbankingView context:any labels:c-any,o-view,ot-schema,on-PtAgrEbankingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrEbankingView
CREATE OR ALTER VIEW dbo.PtAgrEbankingView AS
SELECT TOP 100 PERCENT
E.Id,
E.HdPendingChanges,
E.HdPendingSubChanges,
E.HdVersionNo,
E.PartnerId,
E.ContactPersonId,
E.SeqNo,
P.PartnerNoEdited + ' ' + IsNull(C.FirstName + ' ','') + IsNull(C.Name + ' - ','')  + A.ReportAdrline AS Description
FROM PtAgrEbanking AS E
INNER JOIN PtBase AS P ON E.PartnerId = P.Id
INNER JOIN PtAddress AS A ON E.PartnerId = A.PartnerId AND A.AddressTypeNo = 11
LEFT OUTER JOIN PtContactPerson AS C ON E.ContactPersonId = C.Id


