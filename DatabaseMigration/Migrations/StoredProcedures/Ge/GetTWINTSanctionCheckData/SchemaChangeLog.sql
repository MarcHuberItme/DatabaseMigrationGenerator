--liquibase formatted sql

--changeset system:create-alter-procedure-GetTWINTSanctionCheckData context:any labels:c-any,o-stored-procedure,ot-schema,on-GetTWINTSanctionCheckData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetTWINTSanctionCheckData
CREATE OR ALTER PROCEDURE dbo.GetTWINTSanctionCheckData
@LanguageNo integer AS
SELECT ID, 
PeerName, PartnerName, PartnerFirstName, RequestedAmount, CustomerInformationText, Iban, AuthorizationStatusType as AuthorizationValue
FROM TwSanctionCheckView Sanctions

