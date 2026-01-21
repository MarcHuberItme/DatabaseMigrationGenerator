--liquibase formatted sql

--changeset system:create-alter-function-FintechOnboardingDocumentGen context:any labels:c-any,o-function,ot-schema,on-FintechOnboardingDocumentGen,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function FintechOnboardingDocumentGen
CREATE OR ALTER FUNCTION dbo.FintechOnboardingDocumentGen
(@languageNo as int, @fintechName as varchar(50), @DefaultProductNo as int = null, @InvestmentProductNo as int = null, @ExpectedInvestPtfTypeNo as int = null)
RETURNS @result TABLE(seq  INT PRIMARY KEY,summary nvarchar(1000), details nvarchar(4000), comments nvarchar(4000))
AS
BEGIN
	Declare @summary as nvarchar(1000)
	Declare @instruction as nvarchar(4000)
	Declare @comments as nvarchar(4000)
	Declare @seq as int
	set @seq = 1

	DECLARE @ExternalApplication as varchar(100)
	DECLARE @ConsultantTeam as varchar(100)
	DECLARE @ConsultantTeamDescription as varchar(100)
	DECLARE @AppIdentifier as varchar(100)
	DECLARE @DefaultPortfolio as varchar(30)
	DECLARE @InvestmentPortfolio as nvarchar(30)
	DECLARE @ServiceSegment as nvarchar(100)
	DECLARE @DefaultProductAllowed as bit
	DECLARE @InvestmentProductAllowed as bit
	DECLARE @fullyQualifiedName as varchar(100)
	DECLARE @BusParamValue as nvarchar(2000)
	
	--Fintechs Name
	set @summary = 'Review & Validate';
	set @instruction = 'Fintechs Name = ' + @fintechName;
	INSERT INTO @result(seq,summary,details) values (@seq,@summary,@instruction); set @seq = @seq+1;
 
 	--Create Directory
	set @summary = 'Manual Step';
	set @instruction = 'Create directory on FIBA host' + char(13) + 'd:\\finstar\\' + @fintechName + 'PartnerImport\\incoming'
	set @instruction = @instruction + CHAR(13) + 'Also please arrange appropriate copy jobs with the help of ITINFRA'
	INSERT INTO @result(seq,summary,details) values (@seq,@summary,@instruction); set @seq = @seq+1;

	--External Application
	select @ExternalApplication = AsExternalApplication.ApplicationCode from AsExternalApplication
	inner join Astext AsExternalApplicationText on AsExternalApplication.Id = AsExternalApplicationText.MasterId and AsExternalApplicationText.MasterTableName = 'AsExternalApplication'
	and AsExternalApplicationText.LanguageNo = @languageNo where AsExternalApplicationText.TextShort = @fintechName
 	set @summary = 'Review  & Validate';
	set @instruction = 'ExternalApplication = ' + isnull(@ExternalApplication,'');
	set @comments = 'Table Administration : AsExternalApplication.ApplicationCode/TextShort'
	INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
		
	--Consultant Team
	select @ConsultantTeam = AsUserGroup.UserGroupName, @ConsultantTeamDescription = Astext.TextShort from AsUserGroup
	left outer join astext on asusergroup.id = astext.masterid and astext.MasterTableName = 'AsUserGroup' and astext.LanguageNo = @languageNo
	where astext.TextShort like '%' + @fintechName + '%'
	set @summary = 'Review  & Validate';
	set @instruction = 'Consultant Team = ' + isnull(@ConsultantTeam,'');
	set @comments = 'Fintar Client --> User Administration / TextShort' + CHAR(13) + 'User group  where TextShort contains the name of the fintech'
	INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;	

	--AppIdentifier
	select @AppIdentifier = OaApp.AppIdentifier from OaApp
	inner join Astext OaAppText on OaApp.Id = OaAppText.MasterId and OaAppText.MasterTableName = 'OaApp' and OaAppText.LanguageNo = @languageNo
	where OaAppText.TextShort = @fintechName

	set @summary = 'Review  & Validate';
	set @instruction = 'AppIdentifier = ' + isnull(@AppIdentifier,'');
	set @comments = 'Table Administration : OaApp.AppIdentifier/TextShort'
	INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;

	--InvestmentPortfolio
	
	if(@ExpectedInvestPtfTypeNo is not null)
	BEGIN
		select @InvestmentPortfolio=Value from OaBusinessParameterLookup(@ExternalApplication,'fs.api.investment.portfolio.default.typeNo')
		if(@ExpectedInvestPtfTypeNo <> @InvestmentPortfolio)
			set @summary = 'Error - Fix';
		ELSE
			set @summary = 'Review & Validate';
		
		
		set @instruction = 'Investment Portfolio Type = ' + IsNull(@InvestmentPortfolio,'');
		set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=fs.api.investment.portfolio.default.typeNo)'
		INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
	END
	
	--ServiveSegment
	select @ServiceSegment=Value from OaBusinessParameterLookup(@ExternalApplication,'fs.api.partner.default.segmentNo')
	set @summary = 'Review & Validate';
	set @instruction = 'Bedrfniskategorie = ' + IsNull(@ServiceSegment,'');
	set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=fs.api.partner.default.segmentNo)'
	INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
	

	--DefaultPortfolio
	select @DefaultPortfolio=Value from OaBusinessParameterLookup(@ExternalApplication,'fs.api.partner.default.portfolio.typeNo')
	set @summary = 'Review & Validate';
	set @instruction = 'Default Portfolio Type = ' + ISnull(@DefaultPortfolio,'');
	set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=fs.api.partner.default.portfolio.typeNo)'
	INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
	
	
	--BranchNo
	DECLARE @branchNo as nvarchar(100)
	select @branchNo=Value from OaBusinessParameterLookup(@ExternalApplication,'fs.api.partner.default.branchNo')
	set @summary = 'Review & Validate';
	set @instruction = 'BranchNo = ' + ISnull(@branchNo,'');
	set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=fs.api.partner.default.branchNo)'
	INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;


	--Default Portfolio Correspondance Rules
	DECLARE @CarrierTypeNo as nvarchar(100)
	select @CarrierTypeNo=Value from OaBusinessParameterLookup(@ExternalApplication,'fs.api.partner.default.portfolio.correspondence.carrierTypeNo')
	set @summary = 'Review & Validate';
	set @instruction = 'Default/Portfolio CarrierTypeNo = ' + ISnull(@CarrierTypeNo,'');
	set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=fs.api.partner.default.portfolio.correspondence.carrierTypeNo)'
	INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
	
	IF( @ExpectedInvestPtfTypeNo is not null)
	BEGIN
		--Investment Portfolio Correspondance Rules
		select @CarrierTypeNo=Value from OaBusinessParameterLookup(@ExternalApplication,'fs.api.investment.portfolio.default.correspondence.carrierTypeNo')
		set @summary = 'Review & Validate';
		set @instruction = 'Investment/Portfolio CarrierTypeNo = ' + ISnull(@CarrierTypeNo,'');
		set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=fs.api.investment.portfolio.default.correspondence.carrierTypeNo)'
		INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
	END

	--Default Account Correspondance Rules
	if(@DefaultProductNo is not null)
	BEGIN
		select @CarrierTypeNo=Value from OaBusinessParameterLookup(@ExternalApplication,'fs.api.money.account.default.correspondence.carrierTypeNo')
		set @summary = 'Review & Validate';
		set @instruction = 'Investment/Portfolio CarrierTypeNo = ' + ISnull(@CarrierTypeNo,'');
		set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=fs.api.money.account.default.correspondence.carrierTypeNo)'
		INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
	END
	
	--Investment Account Correspondance Rules
	if(@InvestmentProductNo is not null)
	BEGIN
		set @fullyQualifiedName='fs.api.investment.account.default.correspondence.carrierTypeNo'
		select @BusParamValue=Value from OaBusinessParameterLookup(@ExternalApplication,@fullyQualifiedName)
		set @summary = 'Review & Validate';
		set @instruction = 'Investment/Portfolio Correspondance CarrierTypeNo = ' + ISnull(@BusParamValue,'');
		set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=' + @fullyQualifiedName + ')'
		INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
		
		
		set @fullyQualifiedName='fs.api.investment.account.default.correspondence.deliveryRuleNo'
		select @BusParamValue=Value from OaBusinessParameterLookup(@ExternalApplication,@fullyQualifiedName)
		set @summary = 'Review & Validate';
		set @instruction = 'Investment/Portfolio Correspondance DeliveryRule = ' + ISnull(@BusParamValue,'');
		set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=' + @fullyQualifiedName+')'
		INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;		
		
	END
	
	--DefaultProductNo
	set @summary = 'Review & Validate';
	set @instruction = 'Default AccountProduct = ' + isnull(cast(@DefaultProductNo as varchar),'');
	INSERT INTO @result(seq,summary,details) values (@seq,@summary,@instruction); set @seq = @seq+1;
	--
	if(exists(select * from OaBusinessParameterLookup(@ExternalApplication,'fs.api.money.account.openBanking.allowedProducts') where rtrim(Value) = cast(@DefaultProductNo as nvarchar)))
	BEGIN
		set @DefaultProductAllowed = 1
	END
	ELSE
	BEGIN		
		set @DefaultProductAllowed = 0
	END
	
	if(@DefaultProductAllowed=0 and @DefaultProductNo is not null)
	BEGIN
		set @summary = 'Resolve';
		set @instruction = 'Default Product No ' + IsNull(cast(@DefaultProductNo as varchar),'') + ' is not in allowed list';
		set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=fs.api.money.account.openBanking.allowedProducts)'
		INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
	END
	ELSE
	BEGIN
		set @summary = 'Review & Validate';
		set @instruction = 'Default Product No ' + IsNull(cast(@DefaultProductNo as varchar),'') + ' is in allowed list';
		set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=fs.api.money.account.openBanking.allowedProducts)'
		INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
	END

	--InvestmentProductAllowed
	set @summary = 'Review & Validate';
	set @instruction = 'Investment Account Product = ' + isnull(cast(@InvestmentProductNo as varchar),'');
	INSERT INTO @result(seq,summary,details) values (@seq,@summary,@instruction); set @seq = @seq+1;

	if(exists(select * from OaBusinessParameterLookup(@ExternalApplication,'fs.api.money.account.openBanking.allowedProducts') where rtrim(Value) = cast(@InvestmentProductNo as nvarchar)))
	BEGIN
		set @InvestmentProductAllowed = 1
	END
	ELSE
	BEGIN
		set @InvestmentProductAllowed = 0
	END
	if(@InvestmentProductAllowed=0 and @InvestmentProductNo is not null)
	BEGIN
		set @summary = 'Resolve';
		set @instruction = 'Investment Product No ' + IsNull(cast(@InvestmentProductNo as varchar),'') + ' is not in allowed list';
		set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=fs.api.money.account.openBanking.allowedProducts)'
		INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
	END
	ELSE
	BEGIN
		set @summary = 'Review & Validate';
		set @instruction = 'Investment Product No ' + IsNull(cast(@InvestmentProductNo as varchar),'') + ' is in allowed list';
		set @comments = 'Source : OaBusinessParameterSetting (FullyQualifiedName=fs.api.money.account.openBanking.allowedProducts)'
		INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
	END

	set @summary = 'Stop here review & validate again';
	set @instruction = 'Proceed to next steps only if you are happy with the values above'
	set @comments = 'If there is no value in step ' + cast(@seq+2 as varchar(10)) + ', then some configuration is missing.'
	INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;	
		
		
	--Syntax
	set @summary = 'Syntax';
	set @instruction = 'exec OnboardAFintechForPartnerImport <FintechName>, <ApplicationCode>, <Consultantname>, <AppIdentifier>, <DefaultProductNo>, <InvestmentProductNo>, [0|1] '
	INSERT INTO @result(seq,summary,details) values (@seq,@summary,@instruction); set @seq = @seq+1;

	--Command to Execute
	set @summary = 'Execute Stored Proc';
	set @comments = 'For copy and paste'
	if(@ExpectedInvestPtfTypeNo is not null)
		set @instruction = 'exec OnboardAFintechForPartnerImport ' + @fintechName + ', ' + @ExternalApplication + ', '+isnull(@ConsultantTeam,'')+', '+@AppIdentifier + ', ' + isnull(cast(@DefaultProductNo as varchar),'') + ', ' + isnull(cast(@InvestmentProductNo as varchar),'') +', 1'
	ELSE
		set @instruction = 'exec OnboardAFintechForPartnerImport ' + @fintechName + ', ' + @ExternalApplication + ', '+isnull(@ConsultantTeam,'')+', '+@AppIdentifier + ', ' + isnull(cast(@DefaultProductNo as varchar),'') + ', ' + isnull(cast(@InvestmentProductNo as varchar),'') +', 0'
	INSERT INTO @result(seq,summary,details,comments) values (@seq,@summary,@instruction,@comments); set @seq = @seq+1;
	RETURN;
END

