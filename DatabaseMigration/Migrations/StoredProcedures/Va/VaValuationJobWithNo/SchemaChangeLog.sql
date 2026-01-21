--liquibase formatted sql

--changeset system:create-alter-procedure-VaValuationJobWithNo context:any labels:c-any,o-stored-procedure,ot-schema,on-VaValuationJobWithNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaValuationJobWithNo
CREATE OR ALTER PROCEDURE dbo.VaValuationJobWithNo
--StoreProcdeure: VaValuationJobWithNo
@StatusNo smallint 
AS

Select ValuationStatusNo, Job, SQL From VaValuationStatus
Where ValuationStatusNo = @StatusNo
