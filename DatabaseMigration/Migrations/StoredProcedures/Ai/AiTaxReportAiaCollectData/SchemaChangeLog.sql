--liquibase formatted sql

--changeset system:create-alter-procedure-AiTaxReportAiaCollectData context:any labels:c-any,o-stored-procedure,ot-schema,on-AiTaxReportAiaCollectData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AiTaxReportAiaCollectData
CREATE OR ALTER PROCEDURE dbo.AiTaxReportAiaCollectData

@Creator varchar(20), 
@TaxReportId uniqueidentifier,
@DisplayResultData bit,
@FillTheFinalStagingArea bit,
@RemoveSpecialCharacters bit

As 

SET NOCOUNT ON;
SET ANSI_WARNINGS OFF;

declare @LanguageNo int = 2
declare @IncomeTypeAIAcoupon int = 1			-->>>	Zinszahlung siehe PrPublicIntTaxIncomeType table
declare @IncomeTypeAIAdividend int = 2			-->>>	Dividendenertrag
declare @IncomeTypeAIATradeSelection int = 4	-->>>	Veräusserungsgewinn
declare @IncomeTypeAIAother int = 3				-->>>	Sonstige Einkünfte
declare @IncomeTypeAIAunclear int = 99			-->>>	Nicht zuordenbare Werte/I
declare @TaxProgramNo int = 1

declare @ReportDate date = (select ReportingPeriod from AiTaxReport where Id = @TaxReportId)
declare @ReportYear int = year(@ReportDate)
declare @TransDateStart date = dateadd(d,1,dateadd(yy,-1,@ReportDate))
declare @StatusValidFrom date = dateadd(d,1,@ReportDate)		-- Use as <
declare @StatusValidTo date = dateadd(d,-1,@ReportDate)		-- Use as >


exec AiTaxReportAiaPartnerSelection @Creator,@TaxReportId,@TaxProgramNo,@ReportYear,@StatusValidFrom,@StatusValidTo 
exec AiTaxReportAiaTransSelection @Creator,@TaxReportId,@TaxProgramNo,@ReportYear,@ReportDate
                                                            ,@LanguageNo,@TransDateStart,@IncomeTypeAIAdividend,@IncomeTypeAIAcoupon
                                                             ,@IncomeTypeAIATradeSelection,@IncomeTypeAIAother,@IncomeTypeAIAunclear
exec AiTaxReportAiaPaymentSelection @Creator,@TaxReportId,@TaxProgramNo,@ReportYear,@ReportDate
                                                            ,@LanguageNo,@TransDateStart,@IncomeTypeAIAdividend,@IncomeTypeAIAcoupon
                                                             ,@IncomeTypeAIATradeSelection,@IncomeTypeAIAother,@IncomeTypeAIAunclear
exec AiTaxReportAiaPrepareFinalData @Creator,@TaxReportId,@TaxProgramNo,@ReportYear,@ReportDate
                                                             ,@StatusValidFrom,@StatusValidTo 
                                                             ,@LanguageNo,@TransDateStart,@IncomeTypeAIAdividend,@IncomeTypeAIAcoupon
                                                             ,@IncomeTypeAIATradeSelection,@IncomeTypeAIAother,@IncomeTypeAIAunclear
exec AiTaxReportAiaSelectContracts @Creator,@TaxReportId,@TaxProgramNo,@ReportYear,@ReportDate
                                                             ,@LanguageNo,@TransDateStart,@IncomeTypeAIAdividend,@IncomeTypeAIAcoupon
                                                             ,@IncomeTypeAIATradeSelection,@IncomeTypeAIAother,@IncomeTypeAIAunclear

BEGIN
begin try
begin tran

if @DisplayResultData = 1
BEGIN
select * from ##PartnerAccPortToReport
select * from ##ListOfTransNosToBeReported
select * from ##ListOfPaymentsToBeReported

-- Selecting data from the simulated (temporary) staging area tables:
select Id,HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp
		,HdVersionNo,HdProcessId,HdStatusFlag,HdNoUpdateFlag,HdPendingChanges,HdPendingSubChanges
		,HdTriggerControl,TaxReportId,PartnerTypeNo,PartnerId,PartnerNoEdited,FiscalCountries,Tin
		,Title,Name,FirstName,MiddleName,NameCont,AddrZip,AddrTown,AddrStreet,AddrHouseNo
		,AddrPOBox,AddrCountryCode,AddrState,AddrFull=replace(replace(AddrFull,CHAR(13),''),CHAR(10),'')
		,Nationalities,DateOfBirth,StatusNo,AcctHolderTypeNo,RefTaxReportPartnerId  
from ##AiTaxReportPartner
select * from ##AiTaxReportPartnerTin
select * from ##AiTaxReportAccount
select * from ##AiTaxReportPayment
select * from ##AiTaxReportSubstantialOwner
END

-- Remove the most special characters from name and address data of the report partners.
-- In the StoredProcedure AiTaxReportValidationSQLs in the checks 16.x will these otherwise complaint.
if @RemoveSpecialCharacters = 1
begin
	update ##AiTaxReportPartner
	set 
	AddrFull = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	REPLACE(AddrFull COLLATE Latin1_General_100_BIN,   '!', ' '),'"', ' '),'#', ' '),'$', ' '),'<', ' '),'>', ' '),'^', ' '),'£', ' '),'¤', ' '),'¥', ' '),'¦', ' '),'§', ' '),'¨', ' '),'©', ' '),'ª', ' '),'«', ' '),'¬', ' '),'®', ' '),'¯', ' '),'°', ' '),'±', ' '),'´', ' '),'·', ' '),'¸', ' '),'º', ' '),'»', ' '),'¼', ' '),'½', ' '),'¾', ' '),'¿', ' '),'÷', ' '),'¹', ' '),'²', ' '),'³', ' '),'%', ' '),'µ', ' '),'~', ' '),'À', 'A'),'Á', 'A'),'Å', 'A'),'Ã', 'A'),'Ê', 'E'),'Ë', 'E'),'Õ', 'O'),'Ò', 'O'),'Ó', 'O'),'Ô', 'O'),'å', 'a'),'ã', 'a'),'ê', 'e'),'ë', 'e'),'à', 'a'),'á', 'a'),'ó', 'o'),'ò', 'o'),'ñ', 'n'),'õ', 'o'),'Š', 'S'),'š', 's'),'Ž', 'Z'),'ž', 'z'),'Ç', 'C'),'ç', 'c'),'''', ' '),'`', ' '),'’', ' ')
	,Name = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	REPLACE(Name COLLATE Latin1_General_100_BIN,       '!', ' '),'"', ' '),'#', ' '),'$', ' '),'<', ' '),'>', ' '),'^', ' '),'£', ' '),'¤', ' '),'¥', ' '),'¦', ' '),'§', ' '),'¨', ' '),'©', ' '),'ª', ' '),'«', ' '),'¬', ' '),'®', ' '),'¯', ' '),'°', ' '),'±', ' '),'´', ' '),'·', ' '),'¸', ' '),'º', ' '),'»', ' '),'¼', ' '),'½', ' '),'¾', ' '),'¿', ' '),'÷', ' '),'¹', ' '),'²', ' '),'³', ' '),'%', ' '),'µ', ' '),'~', ' '),'À', 'A'),'Á', 'A'),'Å', 'A'),'Ã', 'A'),'Ê', 'E'),'Ë', 'E'),'Õ', 'O'),'Ò', 'O'),'Ó', 'O'),'Ô', 'O'),'å', 'a'),'ã', 'a'),'ê', 'e'),'ë', 'e'),'à', 'a'),'á', 'a'),'ó', 'o'),'ò', 'o'),'ñ', 'n'),'õ', 'o'),'Š', 'S'),'š', 's'),'Ž', 'Z'),'ž', 'z'),'Ç', 'C'),'ç', 'c'),'''', ' '),'`', ' '),'’', ' ')
	,NameCont = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	REPLACE(NameCont COLLATE Latin1_General_100_BIN,   '!', ' '),'"', ' '),'#', ' '),'$', ' '),'<', ' '),'>', ' '),'^', ' '),'£', ' '),'¤', ' '),'¥', ' '),'¦', ' '),'§', ' '),'¨', ' '),'©', ' '),'ª', ' '),'«', ' '),'¬', ' '),'®', ' '),'¯', ' '),'°', ' '),'±', ' '),'´', ' '),'·', ' '),'¸', ' '),'º', ' '),'»', ' '),'¼', ' '),'½', ' '),'¾', ' '),'¿', ' '),'÷', ' '),'¹', ' '),'²', ' '),'³', ' '),'%', ' '),'µ', ' '),'~', ' '),'À', 'A'),'Á', 'A'),'Å', 'A'),'Ã', 'A'),'Ê', 'E'),'Ë', 'E'),'Õ', 'O'),'Ò', 'O'),'Ó', 'O'),'Ô', 'O'),'å', 'a'),'ã', 'a'),'ê', 'e'),'ë', 'e'),'à', 'a'),'á', 'a'),'ó', 'o'),'ò', 'o'),'ñ', 'n'),'õ', 'o'),'Š', 'S'),'š', 's'),'Ž', 'Z'),'ž', 'z'),'Ç', 'C'),'ç', 'c'),'''', ' '),'`', ' '),'’', ' ')
    ,FirstName = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	REPLACE(FirstName COLLATE Latin1_General_100_BIN,  '!', ' '),'"', ' '),'#', ' '),'$', ' '),'<', ' '),'>', ' '),'^', ' '),'£', ' '),'¤', ' '),'¥', ' '),'¦', ' '),'§', ' '),'¨', ' '),'©', ' '),'ª', ' '),'«', ' '),'¬', ' '),'®', ' '),'¯', ' '),'°', ' '),'±', ' '),'´', ' '),'·', ' '),'¸', ' '),'º', ' '),'»', ' '),'¼', ' '),'½', ' '),'¾', ' '),'¿', ' '),'÷', ' '),'¹', ' '),'²', ' '),'³', ' '),'%', ' '),'µ', ' '),'~', ' '),'À', 'A'),'Á', 'A'),'Å', 'A'),'Ã', 'A'),'Ê', 'E'),'Ë', 'E'),'Õ', 'O'),'Ò', 'O'),'Ó', 'O'),'Ô', 'O'),'å', 'a'),'ã', 'a'),'ê', 'e'),'ë', 'e'),'à', 'a'),'á', 'a'),'ó', 'o'),'ò', 'o'),'ñ', 'n'),'õ', 'o'),'Š', 'S'),'š', 's'),'Ž', 'Z'),'ž', 'z'),'Ç', 'C'),'ç', 'c'),'''', ' '),'`', ' '),'’', ' ')
	,MiddleName = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	REPLACE(MiddleName COLLATE Latin1_General_100_BIN, '!', ' '),'"', ' '),'#', ' '),'$', ' '),'<', ' '),'>', ' '),'^', ' '),'£', ' '),'¤', ' '),'¥', ' '),'¦', ' '),'§', ' '),'¨', ' '),'©', ' '),'ª', ' '),'«', ' '),'¬', ' '),'®', ' '),'¯', ' '),'°', ' '),'±', ' '),'´', ' '),'·', ' '),'¸', ' '),'º', ' '),'»', ' '),'¼', ' '),'½', ' '),'¾', ' '),'¿', ' '),'÷', ' '),'¹', ' '),'²', ' '),'³', ' '),'%', ' '),'µ', ' '),'~', ' '),'À', 'A'),'Á', 'A'),'Å', 'A'),'Ã', 'A'),'Ê', 'E'),'Ë', 'E'),'Õ', 'O'),'Ò', 'O'),'Ó', 'O'),'Ô', 'O'),'å', 'a'),'ã', 'a'),'ê', 'e'),'ë', 'e'),'à', 'a'),'á', 'a'),'ó', 'o'),'ò', 'o'),'ñ', 'n'),'õ', 'o'),'Š', 'S'),'š', 's'),'Ž', 'Z'),'ž', 'z'),'Ç', 'C'),'ç', 'c'),'''', ' '),'`', ' '),'’', ' ')
	,AddrStreet = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	REPLACE(AddrStreet COLLATE Latin1_General_100_BIN, '!', ' '),'"', ' '),'#', ' '),'$', ' '),'<', ' '),'>', ' '),'^', ' '),'£', ' '),'¤', ' '),'¥', ' '),'¦', ' '),'§', ' '),'¨', ' '),'©', ' '),'ª', ' '),'«', ' '),'¬', ' '),'®', ' '),'¯', ' '),'°', ' '),'±', ' '),'´', ' '),'·', ' '),'¸', ' '),'º', ' '),'»', ' '),'¼', ' '),'½', ' '),'¾', ' '),'¿', ' '),'÷', ' '),'¹', ' '),'²', ' '),'³', ' '),'%', ' '),'µ', ' '),'~', ' '),'À', 'A'),'Á', 'A'),'Å', 'A'),'Ã', 'A'),'Ê', 'E'),'Ë', 'E'),'Õ', 'O'),'Ò', 'O'),'Ó', 'O'),'Ô', 'O'),'å', 'a'),'ã', 'a'),'ê', 'e'),'ë', 'e'),'à', 'a'),'á', 'a'),'ó', 'o'),'ò', 'o'),'ñ', 'n'),'õ', 'o'),'Š', 'S'),'š', 's'),'Ž', 'Z'),'ž', 'z'),'Ç', 'C'),'ç', 'c'),'''', ' '),'`', ' '),'’', ' ')
	,AddrTown = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	REPLACE(AddrTown COLLATE Latin1_General_100_BIN,   '!', ' '),'"', ' '),'#', ' '),'$', ' '),'<', ' '),'>', ' '),'^', ' '),'£', ' '),'¤', ' '),'¥', ' '),'¦', ' '),'§', ' '),'¨', ' '),'©', ' '),'ª', ' '),'«', ' '),'¬', ' '),'®', ' '),'¯', ' '),'°', ' '),'±', ' '),'´', ' '),'·', ' '),'¸', ' '),'º', ' '),'»', ' '),'¼', ' '),'½', ' '),'¾', ' '),'¿', ' '),'÷', ' '),'¹', ' '),'²', ' '),'³', ' '),'%', ' '),'µ', ' '),'~', ' '),'À', 'A'),'Á', 'A'),'Å', 'A'),'Ã', 'A'),'Ê', 'E'),'Ë', 'E'),'Õ', 'O'),'Ò', 'O'),'Ó', 'O'),'Ô', 'O'),'å', 'a'),'ã', 'a'),'ê', 'e'),'ë', 'e'),'à', 'a'),'á', 'a'),'ó', 'o'),'ò', 'o'),'ñ', 'n'),'õ', 'o'),'Š', 'S'),'š', 's'),'Ž', 'Z'),'ž', 'z'),'Ç', 'C'),'ç', 'c'),'''', ' '),'`', ' '),'’', ' ')
	,AddrPOBox = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	REPLACE(AddrPOBox COLLATE Latin1_General_100_BIN,  '!', ' '),'"', ' '),'#', ' '),'$', ' '),'<', ' '),'>', ' '),'^', ' '),'£', ' '),'¤', ' '),'¥', ' '),'¦', ' '),'§', ' '),'¨', ' '),'©', ' '),'ª', ' '),'«', ' '),'¬', ' '),'®', ' '),'¯', ' '),'°', ' '),'±', ' '),'´', ' '),'·', ' '),'¸', ' '),'º', ' '),'»', ' '),'¼', ' '),'½', ' '),'¾', ' '),'¿', ' '),'÷', ' '),'¹', ' '),'²', ' '),'³', ' '),'%', ' '),'µ', ' '),'~', ' '),'À', 'A'),'Á', 'A'),'Å', 'A'),'Ã', 'A'),'Ê', 'E'),'Ë', 'E'),'Õ', 'O'),'Ò', 'O'),'Ó', 'O'),'Ô', 'O'),'å', 'a'),'ã', 'a'),'ê', 'e'),'ë', 'e'),'à', 'a'),'á', 'a'),'ó', 'o'),'ò', 'o'),'ñ', 'n'),'õ', 'o'),'Š', 'S'),'š', 's'),'Ž', 'Z'),'ž', 'z'),'Ç', 'C'),'ç', 'c'),'''', ' '),'`', ' '),'’', ' ')
	,AddrState = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	REPLACE(AddrState COLLATE Latin1_General_100_BIN,  '!', ' '),'"', ' '),'#', ' '),'$', ' '),'<', ' '),'>', ' '),'^', ' '),'£', ' '),'¤', ' '),'¥', ' '),'¦', ' '),'§', ' '),'¨', ' '),'©', ' '),'ª', ' '),'«', ' '),'¬', ' '),'®', ' '),'¯', ' '),'°', ' '),'±', ' '),'´', ' '),'·', ' '),'¸', ' '),'º', ' '),'»', ' '),'¼', ' '),'½', ' '),'¾', ' '),'¿', ' '),'÷', ' '),'¹', ' '),'²', ' '),'³', ' '),'%', ' '),'µ', ' '),'~', ' '),'À', 'A'),'Á', 'A'),'Å', 'A'),'Ã', 'A'),'Ê', 'E'),'Ë', 'E'),'Õ', 'O'),'Ò', 'O'),'Ó', 'O'),'Ô', 'O'),'å', 'a'),'ã', 'a'),'ê', 'e'),'ë', 'e'),'à', 'a'),'á', 'a'),'ó', 'o'),'ò', 'o'),'ñ', 'n'),'õ', 'o'),'Š', 'S'),'š', 's'),'Ž', 'Z'),'ž', 'z'),'Ç', 'C'),'ç', 'c'),'''', ' '),'`', ' '),'’', ' ')
	,Title = REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(REPLACE(
	REPLACE(Title COLLATE Latin1_General_100_BIN,      '!', ' '),'"', ' '),'#', ' '),'$', ' '),'<', ' '),'>', ' '),'^', ' '),'£', ' '),'¤', ' '),'¥', ' '),'¦', ' '),'§', ' '),'¨', ' '),'©', ' '),'ª', ' '),'«', ' '),'¬', ' '),'®', ' '),'¯', ' '),'°', ' '),'±', ' '),'´', ' '),'·', ' '),'¸', ' '),'º', ' '),'»', ' '),'¼', ' '),'½', ' '),'¾', ' '),'¿', ' '),'÷', ' '),'¹', ' '),'²', ' '),'³', ' '),'%', ' '),'µ', ' '),'~', ' '),'À', 'A'),'Á', 'A'),'Å', 'A'),'Ã', 'A'),'Ê', 'E'),'Ë', 'E'),'Õ', 'O'),'Ò', 'O'),'Ó', 'O'),'Ô', 'O'),'å', 'a'),'ã', 'a'),'ê', 'e'),'ë', 'e'),'à', 'a'),'á', 'a'),'ó', 'o'),'ò', 'o'),'ñ', 'n'),'õ', 'o'),'Š', 'S'),'š', 's'),'Ž', 'Z'),'ž', 'z'),'Ç', 'C'),'ç', 'c'),'''', ' '),'`', ' '),'’', ' ')
end

if @FillTheFinalStagingArea = 1
begin
insert into AiTaxReportPartner select * from ##AiTaxReportPartner
insert into AiTaxReportPartnerTin select * from ##AiTaxReportPartnerTin
insert into AiTaxReportAccount select * from ##AiTaxReportAccount
insert into AiTaxReportPayment select * from ##AiTaxReportPayment
insert into AiTaxReportSubstantialOwner select * from ##AiTaxReportSubstantialOwner
end

commit

end try
BEGIN CATCH
    IF @@TRANCOUNT > 0
	begin
                                ROLLBACK TRANSACTION;
		select 'oops it just did not work :-/'
	end
END CATCH;
END

exec AiTaxReportAiaValidateData @Creator,@TaxReportId
