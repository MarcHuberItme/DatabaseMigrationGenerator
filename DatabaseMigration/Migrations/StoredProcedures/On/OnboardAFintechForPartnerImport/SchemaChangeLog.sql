--liquibase formatted sql

--changeset system:create-alter-procedure-OnboardAFintechForPartnerImport context:any labels:c-any,o-stored-procedure,ot-schema,on-OnboardAFintechForPartnerImport,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure OnboardAFintechForPartnerImport
CREATE OR ALTER PROCEDURE dbo.OnboardAFintechForPartnerImport
(@fintechName as varchar(50), @externalApplicationCode as varchar(50), @consultantTeam as varchar(50), @oaAppIdentifier as nvarchar(200), @DefaultAccountProduct as int, @DefaultInvestmentProduct as int,@ExecuteSQL as bit = 0)
As
BEGIN TRY
    if(not(exists(select * from asusergroup where UserGroupName = @consultantTeam)))
        RAISERROR ('Invalid UserGroup. Consultant [%s] does not exist in AsUserGroup',16,-1, @consultantTeam );

    if(not(exists(select * from OaApp where AppIdentifier = @oaAppIdentifier)))
        RAISERROR ('Invalid AppIdentifier.  [%s] does not exist in OaApp',16,-1, @oaAppIdentifier );

    if(not(exists(select * from AsExternalApplication where ApplicationCode = @externalApplicationCode)))
        RAISERROR ('Invalid ApplicationCode.  [%s] does not exist in AsExternalApplication',16,-1, @externalApplicationCode );

    DECLARE SqlLinesCursor CURSOR FOR
    select * from FintechPartnersOnboarding(2,@fintechName,@externalApplicationCode, @consultantTeam, @oaAppIdentifier, @DefaultAccountProduct, @DefaultInvestmentProduct)

    if(@ExecuteSQL=0)
        print '--Test Mode - Only SQLs have been generated. No SQL has been executed'
    ELSE
        print '--Execute Mode - Following SQLs have been executed'
    DECLARE @SEQ as int
    DECLARE @SQL as nvarchar(4000)
    DECLARE @fullSQLTEXT as nvarchar(max)
    open SqlLinesCursor
    FETCH NEXT from SqlLinesCursor into @SEQ, @SQL
    WHILE @@FETCH_STATUS = 0
    BEGIN
        PRINT @SQL
        if(@fullSQLTEXT is null)
            set @fullSQLTEXT = @SQL
        else
            set @fullSQLTEXT = @fullSQLTEXT + @SQL
        FETCH NEXT from SqlLinesCursor into @SEQ, @SQL
    END
    --PRINT LEFT(@fullSQLTEXT,2000)
    --PRINT RIGHT(@fullSQLTEXT,len(@fullSQLTEXT)-2000)
    if(@ExecuteSQL=1)
        exec sp_executesql @fullSQLTEXT
    CLOSE SqlLinesCursor
    DEALLOCATE SqlLinesCursor

END TRY
BEGIN CATCH
    CLOSE SqlLinesCursor
    DEALLOCATE SqlLinesCursor
  SELECT
    ERROR_NUMBER() AS ErrorNumber,
    ERROR_STATE() AS ErrorState,
    ERROR_SEVERITY() AS ErrorSeverity,
    ERROR_PROCEDURE() AS ErrorProcedure,
    ERROR_LINE() AS ErrorLine,
    ERROR_MESSAGE() AS ErrorMessage;
END CATCH

