--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSMinEarningBeingDateCf context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSMinEarningBeingDateCf,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSMinEarningBeingDateCf
CREATE OR ALTER PROCEDURE dbo.GetPMSMinEarningBeingDateCf
@PublicId UniqueIdentifier, @ProdReferenceId UniqueIdentifier
As
Select min (EarningPerBeginDate)
from PrReference 
inner join PrPublicCF on PublicId = @PublicId
and ProdReferenceId = PrReference.Id
Where PrReference.ID = @ProdReferenceId
and PaymentFuncNo = 17

