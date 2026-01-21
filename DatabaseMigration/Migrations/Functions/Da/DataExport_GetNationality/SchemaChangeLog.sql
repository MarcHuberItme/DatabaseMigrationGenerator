--liquibase formatted sql

--changeset system:create-alter-function-DataExport_GetNationality context:any labels:c-any,o-function,ot-schema,on-DataExport_GetNationality,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function DataExport_GetNationality
CREATE OR ALTER FUNCTION dbo.DataExport_GetNationality
(@PartnerId As Uniqueidentifier,
 @LanguageNo As Int)
RETURNS nvarchar(100)
AS
BEGIN
   DECLARE @nat nvarchar(32)
   DECLARE @Nationalität nvarchar(100)
   Set @Nationalität = ''

   DECLARE natCursor CURSOR FAST_FORWARD
   FOR SELECT  ISnull(t.TextShort , n.CountryCode) FROM PtNationality n
      JOIN AsCountry c on c.ISOCode = n.CountryCode
      LEFT OUTER JOIN AsText t ON t.MasterId = c.Id AND t.LanguageNo = @LanguageNo
   WHERE n.partnerId = @PartnerId

   OPEN natCursor
   FETCH NEXT FROM natCursor into @nat
   WHILE @@FETCH_STATUS = 0
   BEGIN
      If Len(@Nationalität) > 0
         SET @Nationalität = @Nationalität + ', '
      SET  @Nationalität = @Nationalität + IsNull(@Nat,'')
      FETCH NEXT FROM natCursor into @nat
   END
   CLOSE natCursor
   DEALLOCATE natCursor

   RETURN @Nationalität
END
