--liquibase formatted sql

--changeset system:create-alter-procedure-GetAcComp1Grouping context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAcComp1Grouping,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAcComp1Grouping
CREATE OR ALTER PROCEDURE dbo.GetAcComp1Grouping
  @debug smallint = 0  -- 0=normal, 1=display selects
as 
declare @cErr int 
declare @cRow int 
if @debug = 0 set nocount on 
set deadlock_priority low
begin transaction
set deadlock_priority low
if @debug > 0 select getdate() '10: select into #t1 from AcCompression1 '

-- drop table #t1 
Select Top 50 * 
into #t1
From AcCompression1 with ( readpast updlock rowlock  ) 
Where Status in (2,3)
select @cErr = @@ERROR , @cRow = @@rowcount 
IF @cErr <> 0 begin raiserror( '10: Error! ' , 16 , -1 ) return @cErr end 
if @debug > 0 select @cRow '10: records selected ' 

if exists ( select * from #t1 ) 
begin 
  if @debug > 0 select getdate() '20: updating Status = 9'

  update AcCompression1 
  set Status = 10 
  from AcCompression1 a  
  inner join #t1 t on a.Id = t.Id 

  select @cErr = @@ERROR , @cRow = @@rowcount 
  IF @cErr <> 0 BEGIN ROLLBACK TRAN return 20 END
  if @debug > 0 select @cRow '20: records updated ' 

end else begin 
  if @debug > 0 select getdate() '30: no records found'
end

if @debug = 0 set nocount off 

select * 
from AcCompression1 
where Id in ( select Id from #t1 ) 

commit transaction
