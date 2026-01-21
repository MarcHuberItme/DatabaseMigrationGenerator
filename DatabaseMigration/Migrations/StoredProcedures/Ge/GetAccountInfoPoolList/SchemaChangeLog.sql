--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountInfoPoolList context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountInfoPoolList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountInfoPoolList
CREATE OR ALTER PROCEDURE dbo.GetAccountInfoPoolList
@AccountId uniqueidentifier,
@LanguageNo tinyint 

AS

SELECT Tx2.TextShort AS KeyValue, Tx.TextShort AS InfoPoolType, RemarkDate, Remark, SortKey
FROM PtInfoPoolAccountView AS Ipp 
LEFT OUTER JOIN AsText AS Tx ON Ipp.InfoPoolType = Tx.MasterId AND Tx.LanguageNo = @LanguageNo
LEFT OUTER JOIN MdTable AS Md ON Ipp.TableName = Md.TableName
LEFT OUTER JOIN AsText AS Tx2 ON Md.Id = Tx2.MasterId AND Tx2.LanguageNo = @LanguageNo
WHERE Ipp.AccountId = @AccountId AND Ipp.HdVersionNo BETWEEN 1 AND 999999998
ORDER BY SortKey DESC
