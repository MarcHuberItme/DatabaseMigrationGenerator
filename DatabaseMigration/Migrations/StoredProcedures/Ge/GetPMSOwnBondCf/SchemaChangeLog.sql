--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSOwnBondCf context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSOwnBondCf,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSOwnBondCf
CREATE OR ALTER PROCEDURE dbo.GetPMSOwnBondCf
@ReferenceId UniqueIdentifier, @PortfolioId UniqueIdentifier
As
Select PtOwnBond.EmissionDate, PrReference.MaturityDate, ProcessDate,PrPublicCF.* from PrReference
inner join PtPosition on  PrReference.Id = PtPosition.ProdReferenceId and PtPosition.PortfolioId = @PortfolioId 
inner join PtPositionDetail on  PtPosition.Id = PtPositionDetail.PositionId
inner join PtOwnBond on PrReference.Id = PtOwnBond.PrReferenceId
inner join PtOwnBondCf on PtOwnBond.Id = PtOwnBondCf.OwnBondId and PtOwnBondCf.HdVersionNo between 1 and 999999998
inner join PrPublicCF on PtOwnBondCf.PublicCfId = PrPublicCf.Id and PaymentFuncNo = 17 and PrPublicCF.HdVersionNo between 1 and 999999998
Where PrReference.Id = @ReferenceId
and PtPositionDetail.TitleNo = PtOWnBond.titleNo
Order by DueDate

