--liquibase formatted sql

--changeset system:create-alter-procedure-GetMgAccounts context:any labels:c-any,o-stored-procedure,ot-schema,on-GetMgAccounts,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetMgAccounts
CREATE OR ALTER PROCEDURE dbo.GetMgAccounts
/*
truncate table MgTransItemProcessing 
update MgTransItemAccount set ClientId = null , Processid = null 
exec GetMgAccounts 'E8CEDD93-BFD8-442B-A7A7-D401499649A5' , '0E1ADDC1-C491-43D4-B9B5-575569C1D9B8' 
, 1 
*/
@ClientId uniqueidentifier ,  
@ProcessId uniqueidentifier ,  
@debug smallint = 0  -- 0=normal, 1=display selects
as 
declare @cnt2 int 
declare @table1 nvarchar(255) 
declare @cmd nvarchar(4000) 
declare @FinstarNo1 decimal(11) 
declare @FinstarNo2 decimal(11) 
declare @WrgA1 char(3) 
declare @WrgA2 char(3) 
declare @HostName nvarchar(128) 
declare @HostProcess nvarchar(8) 
declare @dummyInt int 

if @debug = 0 set nocount on 

begin transaction

if @debug > 0 select getdate() '10: select into #t1'
select Top 20 m.FinstarNo , m.WrgA , right( '00000000000' + convert(varchar,FinstarNo) , 11 ) + WrgA FinstarNo_WrgA 
into #t1
from MgTransItemAccount m with ( tablockx ) 
where PositionId is null
  and Errortext is null
  and ClientId is null
order by FinstarNo , WrgA 
--           + ' where (Ag in (10,20,30,80)) and MigInstruction = 1 ' 
IF @@ERROR <> 0 BEGIN ROLLBACK TRAN return 10 END
if @debug > 0 select count(*) '10: select count(*) from #t1 ' from #t1 

if not exists ( select * from #t1 ) 
begin 
-- falls nichts gefunden wurde, MgTransItemAccount bereinigen und nochmals versuchen. 
    if @debug > 0 select getdate() '20: update MgTransItemAccount (bereinigen)'
    update MgTransItemAccount
    set ClientId = null
      , ProcessId = null
    where ClientId = @ClientId
      and PositionId is null
      and Errortext is null
    IF @@ERROR <> 0 BEGIN ROLLBACK TRAN return 20 END
if @debug > 0 select count(*) '10: select count(*) from #t1 ' from #t1 

    if @debug > 0 select getdate() '30: insert into #t1'
    insert into #t1
    select Top 20 FinstarNo , WrgA , right( '00000000000' + convert(varchar,FinstarNo) , 11 ) + WrgA FinstarNo_WrgA 
    from MgTransItemAccount with ( tablockx ) 
    where PositionId is null
      and Errortext is null
      and ClientId is null
    order by FinstarNo , WrgA 
    --           + ' where (Ag in (10,20,30,80)) and MigInstruction = 1 ' 
    IF @@ERROR <> 0 BEGIN ROLLBACK TRAN return 30 END
if @debug > 0 select count(*) '10: select count(*) from #t1 ' from #t1 

end

if ( select Count(*) from #t1 ) > 0 
begin
  if @debug > 0 select getdate() '40: insert into MgTransItemProcessing'
  insert into MgTransItemProcessing 
  select @ClientId , @ProcessId , ( select hostname from master..sysprocesses where spid = @@spid ) 
       , min( right( '00000000000' + convert(varchar,FinstarNo) , 11 ) + WrgA ) 
       , max( right( '00000000000' + convert(varchar,FinstarNo) , 11 ) + WrgA ) 
       , 20 , getdate() , null 
  from #t1 
  IF @@ERROR <> 0 BEGIN ROLLBACK TRAN return 40 END
if @debug > 0 select count(*) '10: select count(*) from #t1 ' from #t1 

  if @debug > 0 select getdate() '50: update MgTransItemAccount (neue Accounts zum migrieren)'
  update MgTransItemAccount 
  set ClientId = @ClientId , ProcessId = @ProcessId 
  from MgTransItemAccount a inner join #t1 on a.FinstarNo = #t1.FinstarNo and a.WrgA = #t1.WrgA 
  IF @@ERROR <> 0 BEGIN ROLLBACK TRAN return 50 END
if @debug > 0 select count(*) '10: select count(*) from #t1 ' from #t1 
end

if @debug > 0 select getdate() '60: select from MgTransItemAccount'
select FinstarNo , WrgA 
from #t1 
IF @@ERROR <> 0 BEGIN ROLLBACK TRAN return 60 END
if @debug > 0 select count(*) '10: select count(*) from #t1 ' from #t1 

commit transaction

if @debug = 0 set nocount off 

