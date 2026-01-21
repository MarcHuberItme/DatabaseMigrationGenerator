--liquibase formatted sql

--changeset system:create-alter-procedure-CopyFireMapping context:any labels:c-any,o-stored-procedure,ot-schema,on-CopyFireMapping,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CopyFireMapping
CREATE OR ALTER PROCEDURE dbo.CopyFireMapping
  @OldAccountNo int,
  @MappingTypeNo int,
  @NewFireAccountNo int
AS

Declare @OldMappingId uniqueidentifier
Declare @NewMappingId uniqueidentifier
Set @NewMappingId = NEWID()

Select @OldMappingId = Id 
FROM AcFireMapping
WHERE FireAccountNo = @OldAccountNo
   and MappingTypeNo = @MappingTypeNo
   and HdVersionNo < 999999999


INSERT INTO AcFireMapping
SELECT @NewMappingId As Id,
	 GetDate() As HdCreatdDate,
	 'HBL_NT\psk' As HdCreator,
	 GetDate() As HdChangeDate,
	 'HBL_NT\psk' As HdChangeUser,
	 NEWID() As HdEditStamp,
	 1 As HdVersionNo,
	 null As HdProcessId,
	 null As HdStatusFlag,
	 null As HdNoUpdateFlag,
	 0 As HdPendingChanges,
	 0 As HdPendingSubChanges,
	 1 As HdTriggerControl,
	 @NewFireAccountNo As FireAccountNo,
	 MappingTypeNo,
	 DepositTypeNo,
	 SuppressFireExport,
	 null As FireAccountNoOld
FROM AcFireMapping
WHERE Id = @OldMappingId
   and HdVersionNo < 999999999


Insert into AcFireMappingAccField
select NEWID() As Id,
	 GetDate() As HdCreatdDate,
	 'HBL_NT\psk' As HdCreator,
	 GetDate() As HdChangeDate,
	 'HBL_NT\psk' As HdChangeUser,
	 NEWID() As HdEditStamp,
	 1 As HdVersionNo,
	 null As HdProcessId,
	 null As HdStatusFlag,
	 null As HdNoUpdateFlag,
	 0 As HdPendingChanges,
	 0 As HdPendingSubChanges,
	 1 As HdTriggerControl,
	 @NewMappingId As FireMappingId,
	 FireFieldName,
	 ConversionTypeNo,
	 SourceFieldName,
	 DefaultValue,
	 CodeTablename,
	 DynamicConversionId,
	 ValueSign,
	 ValueMandatory,
	 CodeFieldName,
	 CodeSelFilter
	 from AcFireMappingAccField
where FireMappingId = @OldMappingId
   and HdVersionNo < 999999999
