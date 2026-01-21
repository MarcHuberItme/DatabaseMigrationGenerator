--liquibase formatted sql

--changeset system:create-alter-procedure-GetMgTransItems context:any labels:c-any,o-stored-procedure,ot-schema,on-GetMgTransItems,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetMgTransItems
CREATE OR ALTER PROCEDURE dbo.GetMgTransItems
@ProcessId uniqueidentifier , 
@debug smallint = 0 
as
if @debug = 0 set nocount on 

select i.* 
from MgTransItem i with( nolock ) inner join MgTransItemAccount a with( nolock ) on i.FinstarNo = a.FinstarNo and i.WrgA = a.WrgA 
where ProcessId = @ProcessId 
  and MigInstruction = 1 

if @debug = 0 set nocount off
