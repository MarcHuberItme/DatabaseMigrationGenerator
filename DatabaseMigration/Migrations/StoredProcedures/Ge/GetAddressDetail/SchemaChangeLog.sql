--liquibase formatted sql

--changeset system:create-alter-procedure-GetAddressDetail context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAddressDetail,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAddressDetail
CREATE OR ALTER PROCEDURE dbo.GetAddressDetail
   @AddressId varchar(38)
As
   SELECT a.AddressTypeNo, 
        a.CorrespondenceLanguageNo,
        a.CountryCode,
        a.Zip,
        a.FullAddress,
        a.AttentionOfLineNo,
        a.Undeliverable, 
        a.FormalAddress, 
        e.EmailAddress, 
        b.PartnerNo,
        b.Id As PartnerId,
        b.FirstClassMail
   FROM PtAddress a 
      JOIN PtBase b ON a.PartnerId = b.Id
      LEFT OUTER JOIN PtEmailAddress e ON a.EmailAddressId = e.Id and e.HdVersionNo BETWEEN 1 AND 999999998
   WHERE a.Id = @AddressId
      AND a.HdVersionNo BETWEEN 1 AND 999999998
