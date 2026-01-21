--liquibase formatted sql

--changeset system:create-alter-procedure-CheckIfOrderRequestAlreadyExistsInMsgStore context:any labels:c-any,o-stored-procedure,ot-schema,on-CheckIfOrderRequestAlreadyExistsInMsgStore,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CheckIfOrderRequestAlreadyExistsInMsgStore
CREATE OR ALTER PROCEDURE dbo.CheckIfOrderRequestAlreadyExistsInMsgStore
@OrderKeyTrader AS nvarchar(100),
@OrderKeyPartner AS nvarchar(100),
@MessageSourceId AS uniqueidentifier

AS

IF (@OrderKeyTrader IS NOT NULL) OR (LEN(@OrderKeyTrader) > 0)
  BEGIN
    SELECT Top(1) Count(Id) AS Count FROM MsGoiOutTraderMsg
    WHERE MessageType = 'OrderRequest'
    AND OrderKeyPartner = @OrderKeyPartner
    AND MessageSourceId = @MessageSourceId
    AND OrderKeyTrader = @OrderKeyTrader
  END
ELSE
  BEGIN
    SELECT Top(1) Count(Id) AS Count FROM MsGoiOutTraderMsg
    WHERE MessageType = 'OrderRequest'
    AND OrderKeyPartner = @OrderKeyPartner
    AND MessageSourceId = @MessageSourceId
END

