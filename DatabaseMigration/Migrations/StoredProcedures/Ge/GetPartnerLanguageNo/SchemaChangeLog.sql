--liquibase formatted sql

--changeset system:create-alter-procedure-GetPartnerLanguageNo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPartnerLanguageNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPartnerLanguageNo
CREATE OR ALTER PROCEDURE dbo.GetPartnerLanguageNo
@PartnerId uniqueidentifier
AS

SELECT ISNULL(CorrespondenceLanguageNo, ISNULL(SubstituteLanguageNo, (
				SELECT Value
				FROM AsParameterView
				WHERE GroupName = 'System'
					AND ParameterName = 'DefaultLanguage'
				)))
FROM PtAddress
WHERE PartnerId = @PartnerId 
	AND AddressTypeNo = 11
	AND HdVersionNo BETWEEN 1
		AND 999999998


