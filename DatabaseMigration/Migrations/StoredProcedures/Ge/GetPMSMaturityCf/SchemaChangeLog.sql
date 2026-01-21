--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSMaturityCf context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSMaturityCf,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSMaturityCf
CREATE OR ALTER PROCEDURE dbo.GetPMSMaturityCf
@PublicId UniqueIdentifier

As

Select  * from PrPublicCf
Where PublicId =@PublicId
and PaymentFuncNo in (1,18)
and DueDate = 
(Select max(DueDate) from PrPublicCf
Where PublicId =@PublicId
and PaymentFuncNo in (1,18)
and HdVersionNo between 1 and 999999998
)
order by PaymentFuncNo
