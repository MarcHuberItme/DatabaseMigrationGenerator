--liquibase formatted sql

--changeset system:create-alter-procedure-GetPositionDetailCfInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPositionDetailCfInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPositionDetailCfInfo
CREATE OR ALTER PROCEDURE dbo.GetPositionDetailCfInfo

@OwnBondCfId uniqueidentifier,
@PositionId uniqueidentifier

AS

SELECT 
Cf.Id as OwnBondCfId, 
Cf.DueDate, 
Cf.ProcessDate,  
Cf.PaymentDate, 
PosD.Id AS PosDetailId, 
PosD.PositionId,
PosD.TitleNo, 
PosD.Quantity,
Ob.ConversionStatusNo, 
Ob.Amount AS EmissionValue,
PrCf.Amount,
PrCf.PaymentFuncNo,
Pos.ProdReferenceId, 
Pos.ProdLocGroupId,
Pos.PortfolioId,
Ref.Currency
FROM PtOwnBondCf AS Cf
INNER JOIN PtOwnBond AS Ob ON Ob.Id = Cf.OwnBondId
INNER JOIN PrPublicCf AS PrCf ON Cf.PublicCfId = PrCf.Id
INNER JOIN PtPositionDetail AS PosD ON Ob.TitleNo = PosD.TitleNo
INNER JOIN PtPosition AS Pos ON PosD.PositionId = Pos.Id
INNER JOIN PtPortfolio AS Pf ON Pos.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref ON Ref.Id = Ob.PrReferenceId
WHERE Cf.Id = @OwnBondCfId
AND PosD.PositionId = @PositionId

