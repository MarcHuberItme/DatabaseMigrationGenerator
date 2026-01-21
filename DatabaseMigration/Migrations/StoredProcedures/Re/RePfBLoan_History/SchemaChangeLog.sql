--liquibase formatted sql

--changeset system:create-alter-procedure-RePfBLoan_History context:any labels:c-any,o-stored-procedure,ot-schema,on-RePfBLoan_History,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RePfBLoan_History
CREATE OR ALTER PROCEDURE dbo.RePfBLoan_History
AS

SET NOCOUNT ON

INSERT INTO RePfBLoanHistory ( HdVersionNo , HdCreator , HdChangeUser 
      , SumLoans , DateHistory  
	) SELECT 1 , 'HBL_NT\finstarbg', 'HBL_NT\finstarbg'
         , (SELECT SUM(ptp.ValueProductCurrency) AS AllocationSum   
	FROM PtPosition ptp
	INNER JOIN PrReference prr ON ptp.ProdReferenceId = prr.Id AND prr.Currency = 'CHF' 
		AND prr.HdVersionNo BETWEEN 1 AND 999999998
	INNER JOIN PtAccountBase ptab ON prr.AccountId = ptab.Id AND ptab.TerminationDate IS NULL 
		AND ptab.HdVersionNo BETWEEN 1 AND 999999998
	INNER JOIN PrPrivate prp ON prr.ProductId = prp.ProductId AND prp.ProductNo = 1062 
		AND prp.HdVersionNo BETWEEN 1 AND 999999998
	WHERE ptp.HdVersionNo BETWEEN 1 AND 999999998) 
           AS SumLoans , CONVERT(CHAR(10) , GETDATE() , 112) AS DateHistory 

SET NOCOUNT OFF
