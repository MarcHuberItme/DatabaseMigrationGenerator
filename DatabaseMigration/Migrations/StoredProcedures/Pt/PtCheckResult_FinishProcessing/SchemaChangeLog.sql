--liquibase formatted sql

--changeset system:create-alter-procedure-PtCheckResult_FinishProcessing context:any labels:c-any,o-stored-procedure,ot-schema,on-PtCheckResult_FinishProcessing,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtCheckResult_FinishProcessing
CREATE OR ALTER PROCEDURE dbo.PtCheckResult_FinishProcessing
     @CheckTypeNo int
AS
   INSERT PtCheckResult
      (HdVersionNo, ProfileId, CheckTypeNo, MatchCategoryNo, BankVerificationResultNo, MatchDate, Score, IsActualized)
      SELECT 1 As HdVersionNo, ProfileId, CheckTypeNo, 0 As MatchCategoryNo, 200 As BankVerificationResultNo, GetDate() As MatchDate,0 As Score,1 As IsActualized 
         FROM PtCheckResultLatestView
         WHERE CheckTypeNo = @CheckTypeNo 
         AND MatchCategoryNo > 0
         AND IsActualized = 0
         AND BankVerificationResultNo  >= 100

    INSERT PtCheckResult
      (HdVersionNo, ProfileId, CheckTypeNo, MatchCategoryNo, MatchDate, Score, IsActualized)
      SELECT 1 As HdVersionNo, ProfileId, CheckTypeNo, 0 As MatchCategoryNo, GetDate() As MatchDate,0 As Score,1 As IsActualized 
         FROM PtCheckResultLatestView
         WHERE CheckTypeNo = @CheckTypeNo 
         AND MatchCategoryNo > 0
         AND IsActualized = 0
         AND (BankVerificationResultNo  < 100 or BankVerificationResultNo Is Null)

RETURN 0
