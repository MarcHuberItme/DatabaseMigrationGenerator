--liquibase formatted sql

--changeset system:create-alter-procedure-GetAgrPFMRegistrationInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAgrPFMRegistrationInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAgrPFMRegistrationInfo
CREATE OR ALTER PROCEDURE dbo.GetAgrPFMRegistrationInfo
@AppName varchar(50),
@agrNo as varchar(10)
As
declare @PFMMandateId as varchar(20)
declare @PFMSequenceNo int
declare @PFMAGBacceptedByCustomer datetime


select @PFMMandateId = PFMMandateId from SwMtSettings Where AppName =@AppName and HdVersionNo between 1 and 999999998
Select  @PFMSequenceNo = PFMSequenceNo,@PFMAGBacceptedByCustomer = PFMAGBacceptedByCustomer from PtAgrEbanking
Where  MgVTNo = @agrNo and HdVersionNo between 1 and 999999998

select isnull(@PFMSequenceNo,0) as  PFMSequenceNo, @PFMAGBacceptedByCustomer as PFMAGBacceptedByCustomer, @PFMMandateId as PFMMandateId
