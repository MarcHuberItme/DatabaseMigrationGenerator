--liquibase formatted sql

--changeset system:create-alter-procedure-GetStaffRebateInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetStaffRebateInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetStaffRebateInfo
CREATE OR ALTER PROCEDURE dbo.GetStaffRebateInfo
@PartnerId  uniqueidentifier,
@ApplicableDate  datetime,
@RsOutput  bit,
@HasStaffRebate bit OUTPUT
As
DECLARE @intCount as int

Select @intCount=count(*) from PtUserBase
Where 
PtUserBase.PartnerId = @PartnerId
and PtUserBase.HasStaffRebate = 1
and isNull(PtUserBase.AdmissionDate,'19000101') <= @ApplicableDate and IsNull(PtUserBase.LeavingDate,'99991231 23:59:59.997') >= @ApplicableDate

if(@intCount>0)
set @HasStaffRebate=1
else
set @HasStaffRebate=0


if(@RsOutput=1)
	select @HasStaffRebate as HasStaffRebate



