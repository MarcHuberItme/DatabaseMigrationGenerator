--liquibase formatted sql

--changeset system:create-alter-procedure-PurgeOldMsFixEntries context:any labels:c-any,o-stored-procedure,ot-schema,on-PurgeOldMsFixEntries,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PurgeOldMsFixEntries
CREATE OR ALTER PROCEDURE dbo.PurgeOldMsFixEntries
@NumberOfDaysToKeep int

AS

declare @Datelimit as datetime = dateadd(d,-@NumberOfDaysToKeep,GETDATE())

delete from MsFixInMsg WHERE HdCreateDate < @Datelimit
--delete from MsFixInAck WHERE HdCreateDate < @Datelimit

delete from MsFixInTraderMsg WHERE HdCreateDate < @Datelimit
--delete from MsFixInTraderAck WHERE HdCreateDate < @Datelimit

delete from MsFixOutMsg WHERE HdCreateDate < @Datelimit
--delete from MsFixOutAck WHERE HdCreateDate < @Datelimit

delete from MsFixOutTraderMsg WHERE HdCreateDate < @Datelimit
--delete from MsFixOutTraderAck WHERE HdCreateDate < @Datelimit

delete from MsGoiOutMsg WHERE HdCreateDate < @Datelimit
--delete from MsGoiOutAck WHERE HdCreateDate < @Datelimit

delete from MsGoiOutTraderMsg WHERE HdCreateDate < @Datelimit
--delete from MsGoiOutTraderAck WHERE HdCreateDate < @Datelimit

