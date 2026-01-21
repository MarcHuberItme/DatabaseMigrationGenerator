--liquibase formatted sql

--changeset system:create-alter-procedure-GetVSBRelevantProducts context:any labels:c-any,o-stored-procedure,ot-schema,on-GetVSBRelevantProducts,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetVSBRelevantProducts
CREATE OR ALTER PROCEDURE dbo.GetVSBRelevantProducts
@PartnerId uniqueidentifier, 
@BlockReasonId uniqueidentifier

AS

-- Check Kontoprodukte
SELECT	ac.Id, ac.AccountNo, pr.ProductNo
FROM	PtAccountBase ac
     	JOIN PtPortfolio po  ON ac.PortfolioId = po.Id        
   	JOIN PrReference ref ON ac.Id          = ref.AccountId 
	JOIN PrPrivate pr    ON ref.ProductId  = pr.ProductId
WHERE   po.PartnerId = @PartnerId 
AND	ac.TerminationDate IS NULL
AND	pr.IsVsbRelevant = 1
AND	NOT Exists (
		SELECT	* from PtBlocking b
		WHERE	b.PartnerId = po.PartnerId
		AND	b.ParentTableName = 'PtAccountBase'
		AND	b.ParentId = ac.Id
		AND	b.BlockReason = @BlockReasonId
		AND	b.ReleaseDate IS NULL
		)

UNION ALL		

-- Check Portfolio-Produkte
SELECT	po.Id, po.PortfolioNo AS AccountNo, po.PortfolioTypeNo AS ProductNo
FROM	PtPortfolio po
   	JOIN PtPortfolioType pot ON po.PortfolioTypeNo = pot.PortfolioTypeNo 
WHERE	po.PartnerId = @PartnerId
AND	po.TerminationDate IS NULL 
AND	pot.IsVsbRelevant = 1
AND	NOT Exists (
		SELECT	* from PtBlocking b
		WHERE	b.PartnerId = po.PartnerId
		AND	b.ParentTableName = 'PtPortfolio'
		AND	b.ParentId = po.Id
		AND	b.BlockReason = @BlockReasonId
		AND	b.ReleaseDate IS NULL
		)

