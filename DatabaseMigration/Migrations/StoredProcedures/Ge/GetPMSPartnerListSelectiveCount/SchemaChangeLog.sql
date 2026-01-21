--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPartnerListSelectiveCount context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPartnerListSelectiveCount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPartnerListSelectiveCount
CREATE OR ALTER PROCEDURE dbo.GetPMSPartnerListSelectiveCount
 @LastRunDate DateTime, @LastRunId UniqueIdentifier, @PartnerNoOwn decimal (11,0)
AS
exec GetPMSPartnerListSelective   @LastRunDate , @LastRunId,  9999999, @PartnerNoOwn 
Select @@ROWCOUNT as CountRows
