--liquibase formatted sql

--changeset system:create-alter-procedure-MgCorrPortfolio context:any labels:c-any,o-stored-procedure,ot-schema,on-MgCorrPortfolio,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MgCorrPortfolio
CREATE OR ALTER PROCEDURE dbo.MgCorrPortfolio

	@CorrPortfolioId uniqueidentifier

AS 

SELECT 	Id, PortfolioId, DeliveryRuleNo, DetourGroup, MgVrxKey, AddressTypeNo, 
	PartnerNo, SUM(CorrItem1) AS Item1, 
	SUM(CorrItem2) AS Item2, 
	SUM(CorrItem3) AS Item3, 
	SUM(CorrItem4) AS Item4, 
	SUM(CorrItem5) AS Item5, 
	SUM(CorrItem6) AS Item6, 
	SUM(CorrItem7) AS Item7

FROM(

	SELECT 	C.Id, 
			C.PortfolioId, C.DeliveryRuleNo,  C.DetourGroup, C.MgVrxKey, A.AddressTypeNo, Pt.PartnerNo,
			ISNULL(I1.CopyNumber,0) AS CorrItem1,
			ISNULL(I.CopyNumber,0) + ISNULL(I2.CopyNumber,0) AS CorrItem2,
			ISNULL(I.CopyNumber,0) + ISNULL(I3.CopyNumber,0) AS CorrItem3,
 			ISNULL(I.CopyNumber,0) + ISNULL(I4.CopyNumber,0) AS CorrItem4,
			ISNULL(I.CopyNumber,0) + ISNULL(I5.CopyNumber,0) AS CorrItem5,
			ISNULL(I.CopyNumber,0) + ISNULL(I6.CopyNumber,0) AS CorrItem6,
			ISNULL(I.CopyNumber,0) + ISNULL(I7.CopyNumber,0) AS CorrItem7

	FROM PtCorrPortfolio AS C
	LEFT OUTER JOIN PtAddress 		AS A  ON C.AddressId = A.Id
	LEFT OUTER JOIN PtBase 			AS Pt ON A.PartnerId = Pt.Id
	LEFT OUTER JOIN PtCorrPortfolioItemGroup 	AS I  ON C.Id = I.CorrPortfolioId AND I.CorrItemGroupNo = 1 AND (I.HdVersionNo BETWEEN 1 AND 999999998)
	LEFT OUTER JOIN PtCorrPortfolioItemGroup 	AS I1 ON C.Id = I1.CorrPortfolioId AND I1.CorrItemGroupNo = 5001 AND (I1.HdVersionNo BETWEEN 1 AND 999999998)
	LEFT OUTER JOIN PtCorrPortfolioItemGroup 	AS I2 ON C.Id = I2.CorrPortfolioId AND I2.CorrItemGroupNo = 5002 AND (I2.HdVersionNo BETWEEN 1 AND 999999998)
	LEFT OUTER JOIN PtCorrPortfolioItemGroup 	AS I3 ON C.Id = I3.CorrPortfolioId AND I3.CorrItemGroupNo = 5003 AND (I3.HdVersionNo BETWEEN 1 AND 999999998)
	LEFT OUTER JOIN PtCorrPortfolioItemGroup 	AS I4 ON C.Id = I4.CorrPortfolioId AND I4.CorrItemGroupNo = 5004 AND (I4.HdVersionNo BETWEEN 1 AND 999999998)
	LEFT OUTER JOIN PtCorrPortfolioItemGroup 	AS I5 ON C.Id = I5.CorrPortfolioId AND I5.CorrItemGroupNo = 5005 AND (I5.HdVersionNo BETWEEN 1 AND 999999998)
	LEFT OUTER JOIN PtCorrPortfolioItemGroup 	AS I6 ON C.Id = I6.CorrPortfolioId AND I6.CorrItemGroupNo = 5006 AND (I6.HdVersionNo BETWEEN 1 AND 999999998)
	LEFT OUTER JOIN PtCorrPortfolioItemGroup 	AS I7 ON C.Id = I7.CorrPortfolioId AND I7.CorrItemGroupNo = 5007 AND (I7.HdVersionNo BETWEEN 1 AND 999999998)

	WHERE C.HdVersionNo BETWEEN 1 AND 999999998
) AS Cor

WHERE 	Id = @CorrPortfolioId

GROUP BY Id, PortfolioId, DeliveryRuleNo, DetourGroup, MgVrxKey, AddressTypeNo, PartnerNo, CorrItem1, CorrItem2, CorrItem3, CorrItem4, CorrItem5, CorrItem6, CorrItem7

