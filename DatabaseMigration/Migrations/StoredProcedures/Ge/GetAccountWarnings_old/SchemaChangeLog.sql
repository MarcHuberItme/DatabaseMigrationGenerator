--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountWarnings_old context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountWarnings_old,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountWarnings_old
CREATE OR ALTER PROCEDURE dbo.GetAccountWarnings_old

@AccountId uniqueidentifier,
@PortfolioId uniqueidentifier,
@PartnerId uniqueidentifier

AS 

SELECT 
	0 AS LineNumber, Id, ParentTableName, IsWarning, BlockDate, BlockIssuer, BlockReason, BlockComment 
FROM PtBlocking 
WHERE ParentId IN (@AccountId, @PortfolioId, @PartnerId) 
	AND (ReleaseDate IS NULL OR ReleaseDate > GETDATE() ) 
	AND HdVersionNo BETWEEN 1 AND 999999998 

UNION ALL 

SELECT 	LineNumber, Id, 'MgXS40' AS ParentTableName, 1 AS IsWarning, HdChangeDate AS BlockDate, 
	HdChangeUser AS BlockIssuer,  NULL AS BlockReason, Remark AS BlockComment 
FROM MgXS40 
WHERE AccountId = @AccountId
AND HdVersionNo BETWEEN 1 AND 999999998 
AND EXISTS (	SELECT * FROM MgXS40 WHERE AccountId = @AccountId 
		AND HdVersionNo BETWEEN 1 AND 999999998
		AND (	Remark like '%betreib%' or remark like '%quick%' or remark like '%zahlungs%'
			or remark like '%ueberz%' or remark like '%berz%' or remark like '%zv%' or remark like '%vollm%')
		)
ORDER BY LineNumber, IsWarning ASC, BlockDate DESC, BlockReason
