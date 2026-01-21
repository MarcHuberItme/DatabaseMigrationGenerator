--liquibase formatted sql

--changeset system:create-alter-procedure-GetMgDocuments context:any labels:c-any,o-stored-procedure,ot-schema,on-GetMgDocuments,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetMgDocuments
CREATE OR ALTER PROCEDURE dbo.GetMgDocuments
-- GetMgDocuments '19990101' , 1 
  @Month datetime = null , 
  @debug smallint = 0  -- 0=normal, 1=display selects
as 
declare @cErr int 
declare @cRow int 
if @debug = 0 set nocount on 

begin transaction

if @debug > 0 select getdate() '10: select into #t1 from MgEBankingDoc '

-- drop table #t1 

Select Top 50 * 
into #t1
From MgEBankingDoc with ( tablockx ) 
Where MigrationTime is Null 
And ErrorTextFull is Null 
Order By AccountNo , SubAccountNo, CreateDate
select @cErr = @@ERROR , @cRow = @@rowcount 
IF @cErr <> 0 begin raiserror( '10: Error! ' , 16 , -1 ) return @cErr end 
if @debug > 0 select @cRow '10: records selected ' 

if exists ( select * from #t1 ) 
begin 
  if @debug > 0 select getdate() '20: updating to 1.1.1901'

  update MgEBankingDoc with ( tablockx ) 
  set MigrationTime = '19010101' 
  from MgEBankingDoc b 
  inner join #t1 t on b.Id = t.Id 

  select @cErr = @@ERROR , @cRow = @@rowcount 
  IF @cErr <> 0 BEGIN ROLLBACK TRAN return 20 END
  if @debug > 0 select @cRow '20: records updated ' 

end else begin 
  if @debug > 0 select getdate() '30: no records found'
end

if @debug = 0 set nocount off 

select * from #t1 

commit transaction

