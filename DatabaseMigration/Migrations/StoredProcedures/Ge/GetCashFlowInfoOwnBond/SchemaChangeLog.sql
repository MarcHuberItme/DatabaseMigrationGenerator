--liquibase formatted sql

--changeset system:create-alter-procedure-GetCashFlowInfoOwnBond context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCashFlowInfoOwnBond,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCashFlowInfoOwnBond
CREATE OR ALTER PROCEDURE dbo.GetCashFlowInfoOwnBond
@TitleNo int,
@DueDate datetime,
@PaymentFuncNo int

AS

SELECT
Cf.Id as OwnBondCfId, 
Cf.DueDate, 
Cf.ProcessDate,  
Cf.PaymentDate, 
PosD.Id AS PosDetailId, 
PosD.TitleNo, 
PosD.Quantity,
PosD.PositionId,
Ob.ConversionStatusNo, 
Ob.Amount AS EmissionValue,
Ob.Period,
PrCf.Amount,
PrCf.PaymentFuncNo,
PrCf.PublicId,
Pos.ProdReferenceId, 
Pos.ProdLocGroupId,
Pos.PortfolioId,
Pos.Id AS PositionId,
Ref.Currency
FROM PtOwnBondCf AS Cf
INNER JOIN PtOwnBond AS Ob ON Ob.Id = Cf.OwnBondId
INNER JOIN PtPositionDetail AS PosD ON Ob.TitleNo = PosD.TitleNo
INNER JOIN PrPublicCf AS PrCf ON Cf.PublicCfId = PrCf.Id
INNER JOIN PtPosition AS Pos ON PosD.PositionId = Pos.Id
INNER JOIN PtPortfolio AS Pf ON Pos.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.Id = Ob.PrReferenceId
WHERE PosD.TitleNo = @TitleNo
AND Cf.DueDate = @DueDate
AND PrCf.PaymentFuncNo = @PaymentFuncNo
AND Cf.HdVersionNo BETWEEN 1 AND 999999998
AND Cf.Invalidated = 0
ORDER BY Cf.PaymentDate DESC, PosD.Quantity DESC, PosD.HdCreateDate DESC

