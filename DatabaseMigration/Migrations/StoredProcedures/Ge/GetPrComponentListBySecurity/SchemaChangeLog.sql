--liquibase formatted sql

--changeset system:create-alter-procedure-GetPrComponentListBySecurity context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPrComponentListBySecurity,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPrComponentListBySecurity
CREATE OR ALTER PROCEDURE dbo.GetPrComponentListBySecurity

@PrivateCurrRegionId as uniqueidentifier,
@IsFixedDuration as bit,
@IsDebit as bit,
@LanguageNo as tinyint,
@SecurityLevelNo as tinyint

AS

SELECT P.*,T.TextShort, C.MgCoverageNo, C.MgDeckartNo 
FROM PrPrivateComponent AS P
JOIN PrPrivateCompType C ON P.PrivateCompTypeId = C.Id 
LEFT OUTER JOIN AsText AS T ON C.Id = T.MasterId 
WHERE P.PrivateCurrRegionId = @PrivateCurrRegionId
AND P.IsFixed = 0 
AND (P.DateLimit = GetDate() OR P.DateLimit IS NULL)
AND (P.HdVersionNo BETWEEN 1 AND 999999998 )
AND T.LanguageNo = @LanguageNo
AND C.IsFixedDuration = @IsFixedDuration
AND C.SecurityLevelNo = @SecurityLevelNo
AND C.IsDebit = @IsDebit
ORDER BY T.TextShort
