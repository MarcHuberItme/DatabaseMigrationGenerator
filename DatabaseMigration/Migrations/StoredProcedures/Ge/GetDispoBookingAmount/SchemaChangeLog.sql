--liquibase formatted sql

--changeset system:create-alter-procedure-GetDispoBookingAmount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetDispoBookingAmount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetDispoBookingAmount
CREATE OR ALTER PROCEDURE dbo.GetDispoBookingAmount
@PositionId  uniqueidentifier,
@TotalDispoBookingAmount money OUTPUT

AS

SELECT @TotalDispoBookingAmount = ISNULL(Sum(PtDispoBooking.SettlementAmount),0) 
FROM  
   PtDispoBooking
WHERE  
  PtDispoBooking.Status = 1
  and PtDispoBooking.PositionId = @PositionId
  and PtDispoBooking.HdVersionNo between 1 and 999999998
