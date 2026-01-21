--liquibase formatted sql

--changeset system:create-alter-procedure-GetMgAccountsDone context:any labels:c-any,o-stored-procedure,ot-schema,on-GetMgAccountsDone,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetMgAccountsDone
CREATE OR ALTER PROCEDURE dbo.GetMgAccountsDone
@ProcessId uniqueidentifier , 
@cnt int 
as 
set nocount on 

update MgTransItemProcessing 
set TimeEnd = getdate() , 
NumberOfAccounts = @cnt
where ProcessId =  @ProcessId 

set nocount off 
