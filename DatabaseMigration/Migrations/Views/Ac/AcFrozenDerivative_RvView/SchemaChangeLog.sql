--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenDerivative_RvView context:any labels:c-any,o-view,ot-schema,on-AcFrozenDerivative_RvView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenDerivative_RvView
CREATE OR ALTER VIEW dbo.AcFrozenDerivative_RvView AS
SELECT ReportDate, 
	PartnerId, 
	SUM(CASE WHEN ReplacementValue >= 0 THEN ReplacementValue ELSE 0 END) AS PosReplacementValue,
	SUM(CASE WHEN ReplacementValue < 0 THEN ReplacementValue ELSE 0 END) AS NegReplacementValue,
	SUM(ReplacementValue) AS NetPosReplacementValue, 
	0 AS NetNegReplacementValue,
	SUM(CASE WHEN DateTo IS NULL OR ContractKey IS NULL OR ReplacementValue IS NULL THEN 1 ELSE 0 END) AS IncompleteCount,
	DateTo, DateFrom
	FROM AcFrozenDerivative 
	WHERE WithCloseOutNetting = 1 
	GROUP BY ReportDate, PartnerId, DateTo, DateFrom
	HAVING SUM(ReplacementValue) >= 0

	UNION ALL

	SELECT ReportDate, 
	PartnerId, 
	SUM(CASE WHEN ReplacementValue >= 0 THEN ReplacementValue ELSE 0 END) AS PosReplacementValue,
	SUM(CASE WHEN ReplacementValue < 0 THEN ReplacementValue ELSE 0 END) AS NegReplacementValue,
	0, 
	SUM(ReplacementValue) AS NetNegReplacementValue,
	SUM(CASE WHEN DateTo IS NULL OR ContractKey IS NULL OR ReplacementValue IS NULL THEN 1 ELSE 0 END) AS IncompleteCount,
	DateTo, DateFrom
	FROM AcFrozenDerivative 
	WHERE WithCloseOutNetting = 1 
	GROUP BY ReportDate, PartnerId, DateTo, DateFrom
	HAVING SUM(ReplacementValue) < 0

	UNION ALL

	SELECT ReportDate, 
	PartnerId, 
	SUM(CASE WHEN ReplacementValue > 0 THEN ReplacementValue ELSE 0 END) AS PosReplacementValue, 
	SUM(CASE WHEN ReplacementValue < 0 THEN ReplacementValue ELSE 0 END) AS NegReplacementValue,
	SUM(CASE WHEN ReplacementValue > 0 THEN ReplacementValue ELSE 0 END) AS NetPosReplacementValue, 
	SUM(CASE WHEN ReplacementValue < 0 THEN ReplacementValue ELSE 0 END) AS NetNegReplacementValue,
	SUM(CASE WHEN DateTo IS NULL OR ContractKey IS NULL OR ReplacementValue IS NULL THEN 1 ELSE 0 END) AS IncompleteCount,
	DateTo, DateFrom
	FROM AcFrozenDerivative 
	WHERE WithCloseOutNetting = 0
	GROUP BY ReportDate, PartnerId, DateTo, DateFrom
