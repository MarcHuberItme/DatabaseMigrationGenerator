--liquibase formatted sql

--changeset system:create-alter-procedure-GetFireManualRecordsTotals context:any labels:c-any,o-stored-procedure,ot-schema,on-GetFireManualRecordsTotals,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetFireManualRecordsTotals
CREATE OR ALTER PROCEDURE dbo.GetFireManualRecordsTotals
@ReportId uniqueidentifier, 
@LanguageNo tinyint

AS

SELECT @ReportId AS FireReportId, Acc.AccountNo, Tx.TextShort AS Description, ISNULL(Rec.NoOfRecords,0) AS NoOfRecords, ISNULL(Rec.TotalAmount,0) AS TotalAmount, 
Map.MappingTypeNo, 
CASE WHEN LEFT(Map.FireAccountNo, 1) = 2 THEN Balance.BalanceValue
ELSE -Balance.BalanceValue
END AS BalanceValue
FROM AcFireMapping AS Map 
INNER JOIN AcFireAccount AS Acc ON Map.FireAccountNo = Acc.AccountNo
INNER JOIN AcFireReport AS Rep ON Rep.Id = @ReportId
LEFT OUTER JOIN AsText AS Tx ON Acc.Id = Tx.MasterId AND Tx.LanguageNo = @LanguageNo
LEFT OUTER JOIN (
		SELECT Rec.C001, SUM(Rec.C041) AS TotalAmount, COUNT(*) AS NoOfRecords
		FROM AcFireRecord AS Rec 
		INNER JOIN AcFireMapping AS Map ON Map.FireAccountNo = Rec.C001
		WHERE Rec.FireReportId = @ReportId 
		AND Map.MappingTypeNo = 90
		AND Rec.HdVersionNo BETWEEN 1 AND 999999998
		AND Rec.Label = 'MANUAL VALUE'
		GROUP BY Rec.C001) AS Rec ON Map.FireAccountNo = Rec.C001
LEFT OUTER JOIN (
		SELECT Map.FireAccountNo, SUM(ValueHoCu) AS BalanceValue 
		FROM AcFrozenAccount
		INNER JOIN AcBalanceStructure AS BS ON AcFrozenAccount.AccountNo = BS.BalanceAccountNo 
                                       AND BS.BalanceSheetTypeNo = 20
		INNER JOIN AcFireMapping AS Map ON Map.FireAccountNo = BS.FireAccountNo AND Map.MappingTypeNo = 10
		INNER JOIN AcFireReport AS Rep ON Rep.Id = @ReportId AND Rep.ReportDate = AcFrozenAccount.ReportDate
		GROUP BY Map.FireAccountNo
		) AS Balance ON Map.FireAccountNO = Balance.FireAccountNo
WHERE Map.MappingTypeNo = 90
AND Map.HdVersionNo BETWEEN 1 AND 999999998
ORDER BY Acc.AccountNo

