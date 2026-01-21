--liquibase formatted sql

--changeset system:create-alter-procedure-PtCheckResult_NewMatch context:any labels:c-any,o-stored-procedure,ot-schema,on-PtCheckResult_NewMatch,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtCheckResult_NewMatch
CREATE OR ALTER PROCEDURE dbo.PtCheckResult_NewMatch
    @PartnerId varchar(60),
   @CheckTypeNo int,
   @MatchCategoryNo int,
   @MatchDate datetime,
   @Score float,
   @MatchListContent nvarchar(2000)  
AS
   DECLARE @OldMatchCategoryNo int
   DECLARE @OldBankVerificationResultNo int
   DECLARE @OldMatchId uniqueidentifier
   DECLARE @ProfileId uniqueidentifier
   DECLARE @MaxOldMatchCategoryNo int
   DECLARE @NewBankVerificationResult int


   -- Aktueller Record in PtCheckResult suchen, falls vorhanden
   SELECT TOP 1 @OldMatchId = cr.Id, @OldMatchCategoryNo = cr.MatchCategoryNo, @ProfileId = p.Id
   FROM PtCheckResult cr
      RIGHT OUTER JOIN PtProfile p 
	 ON p.Id = cr.ProfileId 
         AND cr.CheckTypeNo = @CheckTypeNo
         AND (cr.HdVersionNo BETWEEN 1 AND 999999998)
      JOIN PtBase b ON b.Id = p.PartnerId
   WHERE b.Id = @PartnerId
   ORDER BY cr.MatchDate DESC

   -- Falls Record der Kategorie 0 vorhanden, checken ob er innerhalb eines Jahres schon beurteilt wurde.
   IF @OldMatchCategoryNo = 0
   BEGIN
      SELECT @MaxOldMatchCategoryNo = MAX(MatchCategoryNo) 
      FROM PtCheckResult
      WHERE ProfileId = @ProfileId
          AND MatchDate > Dateadd(year, -1, Getdate())

      IF  @MaxOldMatchCategoryNo > 0 
          SET @NewBankVerificationResult = 200                -- no check necessary
      ELSE
          SET @NewBankVerificationResult = NULL               -- manual ceck            
      
   END
   
   
   -- Neuer Match, 
   IF @OldMatchCategoryNo IS NULL                             -- New match
       OR @OldMatchCategoryNo = 0                             -- Match again
   BEGIN
      INSERT INTO PtCheckResult (
         HdVersionNo,
         ProfileId, 
         CheckTypeNo, 
         MatchCategoryNo,
         MatchDate,
         Score,
         IsActualized,
         BankVerificationResultNo,
         MatchListContent)
      VALUES (
         1,
         @ProfileId, 
         @CheckTypeNo, 
         @MatchCategoryNo, 
         @MatchDate, 
         @Score,
         1,
         @NewBankVerificationResult,
         @MatchListContent)
      RETURN 1
   END
   ELSE
   BEGIN
      UPDATE PtCheckResult 
      SET IsActualized = 1
      WHERE Id = @OldMatchId

      RETURN 0
   END   
    
