--liquibase formatted sql

--changeset system:create-alter-procedure-GetBookingDays context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBookingDays,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBookingDays
CREATE OR ALTER PROCEDURE dbo.GetBookingDays
(@PositionId  as uniqueidentifier,
 @TransDateBegin  as datetime,
 @TransDateEnd  as datetime
)
AS
SELECT COUNT(DISTINCT TransDate) As BookingDays
FROM PtTransItem 
WHERE PositionId = @PositionId
   AND TransDate > @TransDateBegin
   AND TransDate <= @TransDateEnd
   AND (HdVersionNo BETWEEN 1 AND 999999998)
   AND IsInactive = 0
   AND IsClosingItem = 0
