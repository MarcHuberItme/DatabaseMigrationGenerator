--liquibase formatted sql

--changeset system:create-alter-function-FintechPartnersOnboarding context:any labels:c-any,o-function,ot-schema,on-FintechPartnersOnboarding,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function FintechPartnersOnboarding
CREATE OR ALTER FUNCTION dbo.FintechPartnersOnboarding
(@helpType as tinyint, @fintechName as varchar(50), @externalApplicationCode as varchar(50), @consultantTeam as varchar(50), @oaAppIdentifier as nvarchar(200), @DefaultAccountProduct as int, @InvestmentAccountProduct as int)
RETURNS @result TABLE(seq  INT PRIMARY KEY,info nvarchar(4000))

as
begin
	Declare @instruction as nvarchar(4000)
	Declare @seq as int
   
   set @seq = 1
   --Manual Instruction
   if(@helpType = 1)   
   begin
	set @instruction = 'Open Finstar Client and a create System Parameter Group';
	set @instruction = @instruction + Char(13) + Char(9) + 'ParamGroup Name = ' + @fintechName;
	INSERT INTO @result(seq,info) values (@seq,@instruction);
	set @seq = @seq+1;

	set @instruction = 'Define following system parameters';
	set @instruction = @instruction + Char(13) + Char(9) + 'AppIdentifier = ' + @oaAppIdentifier;
	set @instruction = @instruction + Char(13) + Char(9) + 'CardTypeNoLangMap = ';
	set @instruction = @instruction + Char(13) + Char(9) + 'ConsultantTeamName = ' + @consultantTeam;
	set @instruction = @instruction + Char(13) + Char(9) + 'ExternalApplicationCode = ' + @externalApplicationCode;
	set @instruction = @instruction + Char(13) + Char(9) + 'Noga2008Code = 970000';
	set @instruction = @instruction + Char(13) + Char(9) + 'RepStatusNo = 1';
	set @instruction = @instruction + Char(13) + Char(9) + 'ServiceLevelNo = 70';

	INSERT INTO @result(seq,info) values (@seq,@instruction);
	set @seq = @seq+1;

	set @instruction = 'Define JCS Job in JCS Admin (Job Definition) ';
	set @instruction = @instruction + Char(13) + Char(9) + 'JobName = ' + @fintechName + 'PartnerImportJob';
	set @instruction = @instruction + Char(13) + Char(9) + 'Assembly = FssPartnerImportJob';
	set @instruction = @instruction + Char(13) + Char(9) + 'Class = Finstar.Integration.ExternalPartnerImport.PartnerImportJob';
	set @instruction = @instruction + Char(13) + Char(9) + 'Endless job = True';
	set @instruction = @instruction + Char(13) + Char(9) + 'Base priority = Normal';
	set @instruction = @instruction + Char(13) + Char(9) + 'Auto starting = True';
	set @instruction = @instruction + Char(13) + Char(9) + 'Parameters (Key, Value)';
	set @instruction = @instruction + Char(13) + Char(9) + Char(9)+ 'Application Code = ' + @fintechName;
	set @instruction = @instruction + Char(13) + Char(9) + Char(9)+ rtrim('WatchFolder = D:\Finstar\ ') + @fintechName + 'PartnerImport\incoming';
	set @instruction = @instruction + Char(13) + Char(9) + Char(9)+ 'IncludeSubdirectories = true';
	set @instruction = @instruction + Char(13) + Char(9) + Char(9)+ 'ScanInterval = 00:00:30';
	set @instruction = @instruction + Char(13) + Char(9) + Char(9)+ 'WaitTimeSpan = 00:00:10';
	set @instruction = @instruction + Char(13) + Char(9) + Char(9)+ 'FileReadDelay = 00:00:10';
	set @instruction = @instruction + Char(13) + Char(9) + Char(9)+ 'DocumentFormat = DoApiFsPartner';
	INSERT INTO @result(seq,info) values (@seq,@instruction);
	set @seq = @seq+1;
	
	set @instruction = 'Create direcotry in FIBA01 ';
	set @instruction = @instruction + Char(13) + Char(9)+ rtrim('mkdir D:\Finstar\ ') + @fintechName + 'PartnerImport\incoming' ;
	INSERT INTO @result(seq,info) values (@seq,@instruction);
	set @seq = @seq+1;

	set @instruction = 'Select the newly saved Job and press button "Create new endless task". An entry under the task tab should appear.';	
	INSERT INTO @result(seq,info) values (@seq,@instruction);
	set @seq = @seq+1;
	
	
   end
   ELSE
   begin
	set @instruction = 'DECLARE @ParamGroupId as uniqueidentifier';
	set @instruction = @instruction + Char(13) + 'DECLARE @groupName as varchar(50)';
	set @instruction = @instruction + Char(13) + 'DECLARE @groupDescription as varchar(1000)';
	set @instruction = @instruction + Char(13) + 'DECLARE @ParamName as varchar(30)';
	set @instruction = @instruction + Char(13) + 'DECLARE @ParamValue as nvarchar(1000)';
	set @instruction = @instruction + Char(13) + 'DECLARE @ParamDescription as nvarchar(1000)';
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;

	set @instruction = 'set @groupName = ''' + @fintechName + '''';
	set @instruction = @instruction + Char(13) + 'set @groupDescription = ''' + @fintechName + ' partner import''';	
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;


	set @instruction = 'if exists(select * from AsParameterGroup where GroupName = @groupName)';
	set @instruction =  @instruction + Char(13) + 'begin';
	set @instruction =  @instruction + Char(13) + 'select @ParamgroupId = Id  from AsParameterGroup where GroupName = @groupName';
	set @instruction =  @instruction + Char(13) + 'end';
	set @instruction =  @instruction + Char(13) + 'else';
	set @instruction =  @instruction + Char(13) + 'begin';
	set @instruction =  @instruction + Char(13) + 'select @ParamGroupId = newid();';
	set @instruction =  @instruction + Char(13) + 'INSERT INTO AsParameterGroup(Id,HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,GroupName,Description) VALUES'
	set @instruction =  @instruction + Char(13) + '(@ParamGroupId,getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@groupName,@groupDescription)';
	set @instruction =  @instruction + Char(13) + 'end';
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;
	
	set @instruction =  Char(13) + 'SET @ParamName = ''AppIdentifier''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = ''' + @oaAppIdentifier + '''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''OaApp.AppIdentifier value for ' + @fintechName + '''';		
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;

	set @instruction =  Char(13) + 'SET @ParamName = ''CardTypeNoLangMap''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = ''' + '''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''PtCardType Mapping''';	
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;

	set @instruction =  Char(13) + 'SET @ParamName = ''ConsultantTeamName''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = ''' + @consultantTeam + '''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''Default value for Consultant Team UserGroup''';	
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;

	set @instruction =  Char(13) + 'SET @ParamName = ''ExternalApplicationCode''';
	set @instruction =  @instruction  + Char(13) +'SET @ParamValue = ''' + @externalApplicationCode + '''';
	set @instruction =  @instruction  + Char(13) +'SET @ParamDescription = ''AsExternalApplication.ApplicationCode''';	
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;

	set @instruction =  Char(13) + 'SET @ParamName = ''Noga2008Code''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = ''970000''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = null';	
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;

	set @instruction =  Char(13) + 'SET @ParamName = ''RepStatusNo''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = ''1''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''PtBase.RepStatusNo - Default value for RepStatusNo associated with PtBase''';	
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;


	set @instruction =  Char(13) + 'SET @ParamName = ''RepStatusNo''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = ''1''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''PtBase.RepStatusNo - Default value for RepStatusNo associated with PtBase''';	
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;
	
	
	set @instruction =  Char(13) + 'SET @ParamName = ''InsertInvestmentPortfolio''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = ''''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''1=Create InvestmentPortfolio''';	
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;
	
	set @instruction =  Char(13) + 'SET @ParamName = ''InsertDefaultEbankingAgreement''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = ''''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''1=Create DefaultEbankingAgreement''';	
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;

	set @instruction =  Char(13) + 'SET @ParamName = ''InsertDefaultCardAgreements''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = ''''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''1=Create DefaultCardAgreements''';	
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;

	set @instruction =  Char(13) + 'SET @ParamName = ''InvestmentEbankingAgreement''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = ''''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''1=Create InvestmentEbankingAgreement''';	
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;

	set @instruction =  Char(13) + 'SET @ParamName = ''InsertInvestmentCardAgreements''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = ''''';
	set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''1=Create InvestmentCardAgreements''';	
	set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
	set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
	set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;
	
	
	if(@DefaultAccountProduct is not null)
	begin
		set @instruction =  Char(13) + 'SET @ParamName = ''DefaultAccountProduct''';
		set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = '''' + @DefaultAccountProduct + ''';
		set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''PrPrivate.ProductNo for DefaultAccountProduct.  NULL/Blank means no default account will be created''';	
		set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))''';
		set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
		set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
		INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;	
	end

	if(@InvestmentAccountProduct is not null)
	begin
		set @instruction =  Char(13) + 'SET @ParamName = ''InvestmentAccountProduct''';
		set @instruction =  @instruction  + Char(13) + 'SET @ParamValue = '''' + @InvestmentAccountProduct + ''';
		set @instruction =  @instruction  + Char(13) + 'SET @ParamDescription = ''PrPrivate.ProductNo for InvestmentAccountProduct. NULL/Blank means no investment account will be created''';	
		set @instruction =  @instruction  + Char(13) + 'if not(exists(select * from AsParameter where ParamGroupId = @ParamGroupId and Name = @Paramname))';
		set @instruction =  @instruction  + Char(13) + 'INSERT INTO AsParameter (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,ParamGroupId,Name,Value,Description) VALUES ';
		set @instruction =  @instruction  + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@ParamGroupId,@Paramname,@ParamValue,@ParamDescription);' 
		INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;	
	end	
	
	set @instruction =  Char(13) + 'DECLARE @JobAgentId as uniqueidentifier;';
	set @instruction = @instruction + Char(13) + 'set @JobAgentId = ''85E6B194-15B8-4BEB-81FA-407DE4FC6247'''
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;
	
	set @instruction =  Char(13) + 'DECLARE @JcsJobName as nvarchar(100);';
	set @instruction = @instruction + Char(13) + 'DECLARE @AssemblyName as nvarchar(520);';
	set @instruction = @instruction + Char(13) + 'DECLARE @ClassName as nvarchar(520);';
	set @instruction = @instruction + Char(13) + 'DECLARE @Params as nvarchar(4000);';
	set @instruction = @instruction + Char(13) + 'set @JcsJobName = ''' + @fintechName + 'PartnerImportJob''';
	set @instruction = @instruction + Char(13) + 'set @AssemblyName = ''FssPartnerImportJob''';
	set @instruction = @instruction + Char(13) + 'set @ClassName = ''Finstar.Integration.ExternalPartnerImport.PartnerImportJob''';
	set @instruction = @instruction + Char(13) + 'set @Params = ''ApplicationCode=' + @fintechName +','
	set @instruction = @instruction + rtrim('WatchFolder=D:\Finstar\ ') + @fintechName + 'PartnerImport\incoming,'
	set @instruction = @instruction + 'SearchPattern=raw-data.json,IncludeSubdirectories=true,'
	set @instruction = @instruction + 'ScanInterval=00:01:00,WaitTimeSpan=00:10:00,FileReadDelay=00:00:30,DocumentFormat=DoApiFsPartnerJSON''';	
	set @instruction = @instruction + Char(13) + 'if not(exists(select * from BPJobBase where JobName = @JcsJobName))';
	set @instruction =  @instruction + Char(13) + 'INSERT INTO BPJobBase (HdCreateDate,HdCreator,HdChangeDate,HdChangeUser,HdEditStamp,HdVersionNo,HdTriggerControl,JobName,AssemblyName,ClassName,IsEndless,IsWorker,IsPausable,Param,BasePriority,MaxRetries,AutoStarting,JobAgentGroupId,MaxInstances,MaxInstancesPerAgent) VALUES ';
	set @instruction =  @instruction  + Char(13) + '(getdate(),SYSTEM_USER,getdate(),SYSTEM_USER,newid(),1,1,@JcsJobName,@AssemblyName,@ClassName,1,0,0,@Params,2,0,0,@JobAgentId,0,0)'
	INSERT INTO @result(seq,info) values (@seq,@instruction); set @seq = @seq+1;
	
   end
   return
end

