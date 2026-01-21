--liquibase formatted sql

--changeset system:create-alter-procedure-GetJobToExecute context:any labels:c-any,o-stored-procedure,ot-schema,on-GetJobToExecute,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetJobToExecute
CREATE OR ALTER PROCEDURE dbo.GetJobToExecute
-- GetJobToExecute 0 , '' , 'serh'  
  @mode INT = 0 , -- 0=normal, -1=only write log
  @User VARCHAR(20) = '' , 
  @ActualServer VARCHAR(20) = '' , 
  @AttachedEngine VARCHAR(20) = '' , 
  @ExecutingEngine VARCHAR(20) = '' , 
  @LogId VARCHAR(38) = null , 
  @LogText VARCHAR(100) = '' , 
  @LogResult INT = '' , 
  @JobId VARCHAR(38) = null , 
  @ErrorInfo VARCHAR(50) = '',
  @debug SMALLINT = 0 -- 0=normal, 1=display selects
AS 
DECLARE @cErr INT 
DECLARE @cRow INT 
DECLARE @status VARCHAR(999) 
DECLARE @LogicalName VARCHAR(32) 
DECLARE @rowcountJob INT  
DECLARE @ParameterString VARCHAR(1000) 
DECLARE @JobName VARCHAR(60) 
DECLARE @RestartLevel INT  
DECLARE @OriginalJobId UNIQUEIDENTIFIER

IF @debug > 0 SELECT GETDATE() '000: Started'
IF @debug = 0 SET NOCOUNT ON 

SELECT @LogId = NULLIF( @LogId , '' ) , @JobId = NULLIF( @JobId , '' ) 

IF @LogId IS NOT NULL
BEGIN
-- after job as been processed update the related tables 
  UPDATE BpJobLog SET EndTime = GETDATE() , Result = @LogResult , ResultText = @LogText , 
                      HdChangeDate = GETDATE() , HdChangeUser = @User , HdVersionNo = HdVersionNo + 1 ,
                      ErrorInformation = @ErrorInfo
  WHERE Id = @LogId 
  SELECT @cErr = @@ERROR , @cRow = @@ROWCOUNT
  IF @cErr <> 0 BEGIN RAISERROR( '100: Error while updating "BpJobLog"! ' , 16 , -1 ) RETURN @cErr END 
  IF @debug > 0 SELECT @cRow '100: records updated in table "BpJobLog"' 

  UPDATE BpSingleJob SET State = 2 , HdChangeDate = GETDATE() , HdChangeUser = @User , HdVersionNo = HdVersionNo + 1 
  WHERE Id = @JobId  
  SELECT @cErr = @@ERROR , @cRow = @@ROWCOUNT 
  IF @cErr <> 0 BEGIN RAISERROR( '200: Error while updating "BpSingle"! ' , 16 , -1 ) RETURN @cErr END 
  IF @debug > 0 SELECT @cRow '200: records updated in table "BpSingle"' 
  
END

IF @mode = 0 
BEGIN
  -- search for single jobs to execute 
  BEGIN TRANSACTION
    SELECT TOP 1 @JobId = Id , @LogicalName = LogicalName , @ParameterString = ParameterString , 
                 @JobName = JobName , @AttachedEngine = AttachedEngine, @RestartLevel = RestartLevel ,
                 @OriginalJobId = OriginalJobId 
    FROM BpSingleJob WITH ( XLOCK ) 
    WHERE MinStartTime < GETDATE() AND State = 0 AND AttachedEngine = @AttachedEngine ORDER BY MinStartTime 
    SELECT @cErr = @@ERROR , @cRow = @@ROWCOUNT , @rowcountJob = @@ROWCOUNT 
    IF @cErr <> 0 BEGIN RAISERROR( '300: Error while selecting from "BpSingleJob"! ' , 16 , -1 ) RETURN @cErr END 
    IF @debug > 0 SELECT @cRow '300: records selected from "BpSingleJob"! ' 
  
    IF @rowcountJob = 1 
    BEGIN
      UPDATE BpSingleJob SET state = 1 , HdChangeDate = GETDATE() , HdChangeUser = @User , 
      HdVersionNo = HdVersionNo + 1, StationName = @ActualServer 
      WHERE Id = @JobId 
      SELECT @cErr = @@ERROR , @cRow = @@ROWCOUNT 
      IF @cErr <> 0 BEGIN RAISERROR( '400: Error while updating "BpSingleJob"! ' , 16 , -1 ) RETURN @cErr END 
      IF @debug > 0 SELECT @cRow '400: records updated in table "BpSingle"' 
    END
  COMMIT
  
  IF @rowcountJob = 1 
  BEGIN 
    SELECT @LogId = newid() 
    INSERT INTO BpJobLog ( Id , JobId , LogicalName , JobName , RestartLevel, OriginalJobId, PeriodicJob , 
                           AttachedEngine , ExecutingEngine , StartTime , StationName, HdCreateDate , HdCreator , 
                           HdChangeDate , HdChangeUser , HdVersionNo ) 
    SELECT @LogId , Id , LogicalName , JobName , @RestartLevel , @OriginalJobId , 0,
           AttachedEngine , @ExecutingEngine , GETDATE() , @ActualServer, GETDATE() , @User , GETDATE() , @User , 1 
    FROM BpSingleJob WHERE Id = @JobId 
    SELECT @cErr = @@ERROR , @cRow = @@ROWCOUNT 
    IF @cErr <> 0 BEGIN RAISERROR( '500: Error while inserting into "BpJobLog"! ' , 16 , -1 ) RETURN @cErr END 
    IF @debug > 0 SELECT @cRow '500: records inserted into table "BpJobLog"' 

    -- Output for next job:
    SELECT @JobId JobId , @LogId LogId , @LogicalName LogicalName, @AttachedEngine AttachedEngine, @RestartLevel RestartLevel , 
           @OriginalJobId OriginalJobId , @ParameterString ParameterString , ProjectName, ClassName , 
           @JobName JobName
    FROM AsLogicalTask WHERE LogicalName = @LogicalName 
    SELECT @cErr = @@ERROR , @cRow = @@ROWCOUNT , @rowcountJob = @@ROWCOUNT 
    IF @cErr <> 0 BEGIN RAISERROR( '600: Error while selecting from "AsLogicalTask"! ' , 16 , -1 ) RETURN @cErr END 
    IF @debug > 0 SELECT @cRow '600: records selected from "AsLogicalTask"! ' 
  END
END

IF @debug = 0 SET NOCOUNT OFF

