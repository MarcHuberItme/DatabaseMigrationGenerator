--liquibase formatted sql

--changeset system:create-alter-function-PosQuantityValueDate context:any labels:c-any,o-function,ot-schema,on-PosQuantityValueDate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function PosQuantityValueDate
CREATE OR ALTER FUNCTION dbo.PosQuantityValueDate
(
@PositionId uniqueidentifier,
@PerDate DateTime
)
RETURNS MONEY
AS BEGIN
RETURN (
SELECT		POS.Quantity + ISNULL(SUM(PTI.DebitQuantity),0) - ISNULL(SUM(PTI.CreditQuantity), 0)
                                                       - ISNULL(SUM(PTI_2.DebitQuantity),0) + ISNULL(SUM(PTI_2.CreditQuantity), 0)
FROM		PtPosition POS
LEFT OUTER JOIN	PtTransItem PTI ON PTI.PositionId = POS.Id  
				AND PTI.ValueDate > @PerDate
                                                                AND PTI.DetailCounter >= 1 
                                                                AND PTI.HdVersionNo < 999999999
LEFT OUTER JOIN	PtTransItem PTI_2 ON PTI_2.PositionId = POS.Id  
				AND PTI_2.ValueDate <= @PerDate
                                                                AND PTI_2.DetailCounter = 0 
                                                                AND PTI_2.HdVersionNo < 999999999
WHERE 		POS.Id = @PositionId
GROUP BY 	POS.Id, POS.Quantity)
END
