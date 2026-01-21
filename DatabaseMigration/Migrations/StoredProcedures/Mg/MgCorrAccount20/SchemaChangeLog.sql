--liquibase formatted sql

--changeset system:create-alter-procedure-MgCorrAccount20 context:any labels:c-any,o-stored-procedure,ot-schema,on-MgCorrAccount20,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MgCorrAccount20
CREATE OR ALTER PROCEDURE dbo.MgCorrAccount20

	@CorrAccountId uniqueidentifier

AS

SELECT
	Id, AccountId, DeliveryRuleNo, DetourGroup, MgVrxKey, MgKOEDAK, AddressTypeNo, PartnerNo, 
	SUM(CorrItem1) AS Item1, 
	SUM(CorrItem2) + SUM(DefaultCorrItem) AS Item2, 
	SUM(CorrItem3) + SUM(DefaultCorrItem) AS Item3, 
	SUM(CorrItem4) AS Item4, 
	SUM(CorrItem5) AS Item5, 
	SUM(CorrItem6) + SUM(DefaultCorrItem) AS Item6, 
	SUM(CorrItem7) + SUM(DefaultCorrItem) AS Item7

FROM(
SELECT
C.Id, C.AccountId, C.DeliveryRuleNo,  C.DetourGroup, C.MgVrxKey, C.MgKOEDAK, A.AddressTypeNo, Pt.PartnerNo,
ISNULL(I1.CopyNumber,0) AS CorrItem1,
ISNULL(I2.CopyNumber,0) AS CorrItem2,
ISNULL(I3.CopyNumber,0) AS CorrItem3,
ISNULL(I4.CopyNumber,0)  AS CorrItem4,
ISNULL(I5.CopyNumber,0)  AS CorrItem5,
ISNULL(I6.CopyNumber,0) AS CorrItem6,
ISNULL(I7.CopyNumber,0) AS CorrItem7,
ISNULL(I.CopyNumber,0) DefaultCorrItem
FROM PtCorrAccount AS C
LEFT OUTER JOIN PtAddress AS A  ON C.AddressId = A.Id
LEFT OUTER JOIN PtBase AS Pt ON A.PartnerId = Pt.Id
LEFT OUTER JOIN PtCorrAccountItemGroup AS I  ON C.Id = I.CorrAccountId AND I.CorrItemGroupNo = 1 AND (I.HdVersionNo BETWEEN 1 AND 999999998)
LEFT OUTER JOIN PtCorrAccountItemGroup AS I1 ON C.Id = I1.CorrAccountId AND I1.CorrItemGroupNo = (2001) AND (I1.HdVersionNo BETWEEN 1 AND 999999998)
LEFT OUTER JOIN PtCorrAccountItemGroup AS I2 ON C.Id = I2.CorrAccountId AND I2.CorrItemGroupNo = (2002) AND (I2.HdVersionNo BETWEEN 1 AND 999999998)
LEFT OUTER JOIN PtCorrAccountItemGroup AS I3 ON C.Id = I3.CorrAccountId AND I3.CorrItemGroupNo = (2003) AND (I3.HdVersionNo BETWEEN 1 AND 999999998)
LEFT OUTER JOIN PtCorrAccountItemGroup AS I4 ON C.Id = I4.CorrAccountId AND I4.CorrItemGroupNo = (2004) AND (I4.HdVersionNo BETWEEN 1 AND 999999998)
LEFT OUTER JOIN PtCorrAccountItemGroup AS I5 ON C.Id = I5.CorrAccountId AND I5.CorrItemGroupNo = (2005) AND (I5.HdVersionNo BETWEEN 1 AND 999999998)
LEFT OUTER JOIN PtCorrAccountItemGroup AS I6 ON C.Id = I6.CorrAccountId AND I6.CorrItemGroupNo = (2006) AND (I6.HdVersionNo BETWEEN 1 AND 999999998)
LEFT OUTER JOIN PtCorrAccountItemGroup AS I7 ON C.Id = I7.CorrAccountId AND I7.CorrItemGroupNo = (2007) AND (I7.HdVersionNo BETWEEN 1 AND 999999998)
WHERE C.Id = @CorrAccountId AND C.HdVersionNo BETWEEN 1 AND 999999998
) AS Cor

GROUP BY Id, AccountId, DeliveryRuleNo, DetourGroup, MgVrxKey, MgKOEDAK, AddressTypeNo, PartnerNo, CorrItem1, CorrItem2, CorrItem3, CorrItem4, CorrItem5, CorrItem6, CorrItem7
