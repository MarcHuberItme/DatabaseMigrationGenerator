--liquibase formatted sql

--changeset system:create-alter-procedure-GetPendingBalance context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPendingBalance,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPendingBalance
CREATE OR ALTER PROCEDURE dbo.GetPendingBalance
@PtPositionId UniqueIdentifier
As
DECLARE @curSumCredits money
DECLARE @curSumDebits money
DECLARE @curPositionBalance money
Select @curPositionBalance=ISNULL(BookletBalance,0) from PtPosition
Where Id = @PtPositionId  and HdVersionNo Between 1 and 999999998
