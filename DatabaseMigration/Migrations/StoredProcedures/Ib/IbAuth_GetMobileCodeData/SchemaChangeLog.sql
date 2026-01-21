--liquibase formatted sql

--changeset system:create-alter-procedure-IbAuth_GetMobileCodeData context:any labels:c-any,o-stored-procedure,ot-schema,on-IbAuth_GetMobileCodeData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IbAuth_GetMobileCodeData
CREATE OR ALTER PROCEDURE dbo.IbAuth_GetMobileCodeData
@AgrNo varchar(10)
AS
SELECT
	SL.Id AS SecureListId,
	SL.PasswordSetByCustomer,
	SL.WrongMobileCodeCounter,
	SL.UnusedMobileCodeCounter,
	MD.PhoneNo,
	MCH.Id AS MobileCodeHistId,
	MCH.GenDate,
	MCH.UseDate,
	MCH.HashCode
FROM PtAgrSecureList SL
	INNER JOIN PtAgrEbanking AS AEB ON AEB.MgVTNo = @AgrNo AND AEB.HdVersionNo BETWEEN 1 AND 999999998
	LEFT OUTER JOIN PtAgrSecureListMobileDef AS MD ON MD.Id = (
		SELECT TOP 1 Id
		FROM PtAgrSecureListMobileDef AS IMD
		WHERE IMD.SecureListId = SL.Id
			AND IMD.HdVersionNo BETWEEN 1 AND 999999998 
			AND IMD.BeginDate <= getdate() AND (IMD.ExpirationDate IS NULL OR IMD.ExpirationDate > getdate())
		ORDER BY IMD.BeginDate DESC, IMD.HdCreateDate DESC
	)
	LEFT OUTER JOIN PtAgrSecureListMobileCodeHist AS MCH ON MCH.Id = (
		SELECT TOP 1 Id
		FROM PtAgrSecureListMobileCodeHist AS IMCH
		WHERE IMCH.SecureListId = SL.Id
			AND IMCH.HdVersionNo BETWEEN 1 AND 999999998 
		ORDER BY IMCH.GenDate DESC
	)
WHERE SL.HdVersionNo BETWEEN 1 AND 999999998 AND SL.PrevEBankingNo = @AgrNo
