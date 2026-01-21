--liquibase formatted sql

--changeset system:create-alter-procedure-IbAuth_GetSecureListData context:any labels:c-any,o-stored-procedure,ot-schema,on-IbAuth_GetSecureListData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IbAuth_GetSecureListData
CREATE OR ALTER PROCEDURE dbo.IbAuth_GetSecureListData
@AgrNo varchar(10)
AS
SELECT PASL.Password, PASL.PasswordSHA2, PASL.Id AS SecureListId, PASL.PasswordSetByCustomer, PASL.CurrentListPosition, PASL.WrongPasswordCounter, PASL.WrongListCodeCounter, PASL.CurrentList, PASL.NewList, AEB.ExpirationDate, AEB.Id AS AgrEbankingId, PASL.IsMatrixList, PASL.IsSecureListEnabled, PASL.IsMobileCodeEnabled, PASL.WrongMobileCodeCounter, PASL.UnusedMobileCodeCounter, PASL.IsAstAllowed, PASL.AstUserId, PASL.AstRejectCounter
FROM PtAgrSecureList PASL
INNER JOIN PtAgrEbanking AS AEB ON AEB.MgVTNo = @AgrNo AND AEB.HdVersionNo BETWEEN 1 AND 999999998
WHERE PASL.HdVersionNo BETWEEN 1 AND 999999998 AND PASL.PrevEBankingNo = @AgrNo
