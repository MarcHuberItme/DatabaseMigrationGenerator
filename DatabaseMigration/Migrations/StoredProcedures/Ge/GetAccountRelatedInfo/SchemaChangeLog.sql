--liquibase formatted sql

--changeset system:create-alter-procedure-GetAccountRelatedInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAccountRelatedInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAccountRelatedInfo
CREATE OR ALTER PROCEDURE dbo.GetAccountRelatedInfo

@PrReferenceId uniqueidentifier  
As DECLARE @strAccountId As uniqueidentifier  
DECLARE @strPartnerId As uniqueidentifier  
DECLARE @decPartnerNo As decimal(11,0)   
DECLARE @strPartnerNoEdited As nvarchar(20)  
DECLARE @strPortfolioId As uniqueidentifier  
DECLARE @decPortfolioNo As decimal(11,0)   
DECLARE @decAccountNo As decimal(11,0)   
DECLARE @strAccountNoEdited As nvarchar(20)
DECLARE @strAccountNoIBAN As nvarchar(31)    
DECLARE @strFirstName As nvarchar(25)  
DECLARE @strMiddleName As nvarchar(25)  
DECLARE @strName As nvarchar(25)  
DECLARE @dtmDateOfBirth as datetime  
DECLARE @dtmTerminationDate as datetime  
DECLARE @strAdviceAdrLine As nvarchar(50)  
DECLARE @strAddressStreet As nvarchar(25)  
DECLARE @strAddressHouseNO As nvarchar(10)  
DECLARE @strAddressZip As nvarchar(13)  
DECLARE @strAddressTown As nvarchar(25)  
DECLARE @strAddressCountry As nvarchar(2)  
DECLARE @strAccCurrency As char(3)  
DECLARE @strPositionId As uniqueidentifier  
DECLARE @strCustomerReference As nvarchar(100)  
DECLARE @blnRecIsBlocked As bit  
DECLARE @blnIsPayOutAllowed As bit  
DECLARE @blnIsPayInAllowed As bit  
DECLARE @blnIsPayOutBooklet As bit  
DECLARE @blnIsPayInBooklet As bit  
DECLARE @intOpenIssuesCount As int  
DECLARE @blnIsPayInNeedsBooklet AS bit  
DECLARE @blnIsToClose AS bit  
DECLARE @blnIsPayOutNeedsBooklet AS bit  
DECLARE @blnHasStaffRebate AS bit
DECLARE @dtmCurrentDate as datetime
DECLARE @MgSITZ as smallint
DECLARE @BlockingId    as uniqueidentifier
DECLARE @BlockingReasonId  as uniqueidentifier
DECLARE @intProductNo AS int
DECLARE @strBlockComment As nvarchar(100)
DECLARE @blnRequiresIdent AS bit  
DECLARE @strPfCurrency AS CHAR(3)
DECLARE @WithdrawCommRelevant bit

SELECT @dtmCurrentDate=getdate()

select  
@strAccountId=PrReference.AccountId,  
@decAccountNo=PtAccountBase.AccountNo,  
@strAccountNoEdited=PtAccountBase.AccountNoEdited, 
@strAccountNoIBAN=PtAccountBase.AccountNoIbanForm,   
@strAccCurrency=PrReference.Currency,  
@strCustomerReference=ISNULL(PtAccountBase.CustomerReference,''),  
@strName=ISNULL(PtBase.Name,''),  
@strFirstName=ISNULL(PtBase.FirstName,''),  
@strMiddleName=ISNULL(PtBase.MiddleName,''),  
@dtmDateOfBirth=ISNULL(PtBase.DateOfBirth,''),  
@strAdviceAdrLine=ISNULL(PtAddress.AdviceAdrLine,''),  
@strAddressStreet=ISNULL(PtAddress.Street,''),  
@strAddressHouseNO=ISNULL(PtAddress.HouseNo,''),  
@strAddressZip=ISNULL(PtAddress.Zip,''),  
@strAddressTown=ISNULL(PtAddress.Town,''),  
@strAddressCountry=ISNULL(PtAddress.CountryCode,''),  
@strPortfolioId=PtAccountBase.PortfolioId,  
@decPortfolioNo=PtPortfolio.PortfolioNo,  
@decPartnerNo=PtBase.PartnerNo,  
@strPartnerNoEdited=PtBase.PartnerNoEdited,  
@strPartnerId=PtPortfolio.PartnerId,
@dtmTerminationDate=PtAccountBase.TerminationDate,
@MgSITZ=PtAccountBase.MgSITZ,
@intProductNo=PrPrivate.ProductNo,
@blnRequiresIdent=PrPrivate.RequiresIdent,
@strPfCurrency = PtPortfolio.Currency, 
@WithdrawCommRelevant = PrPrivate.WithdrawCommRelevant
from  
 PrReference
INNER JOIN PtAccountBase On   PrReference.Accountid = PtAccountBase.Id
INNER JOIN PtPortfolio On PtAccountBase.PortfolioId = PtPortfolio.Id
INNER JOIN PtBase On PtPortfolio.PartnerId = PtBase.Id
Inner Join PrPrivate On PrReference.ProductId = PrPrivate.Productid
LEFT OUTER JOIN PtAddress ON PtBase.Id = PtAddress.PartnerId and PtAddress.AddressTypeNo = 11
Where  
 PrReference.Id=@PrReferenceId and  
 PrReference.HdVersionNo between 1 and 999999998  

EXECUTE GetStaffRebateInfo @strPartnerId,@dtmCurrentDate,0,@HasStaffRebate=@blnHasStaffRebate OUTPUT


IF NOT(@strPortfolioId IS NULL)  
BEGIN  
 Select @strPositionId=id, @blnIsToClose=IsToClose   
 From PtPosition  
 Where  
 ProdReferenceId=@PrReferenceId AND  
 PortfolioId=@strPortfolioId AND  
 HdVersionNo between 1 and 999999998  
END  

SET @blnRecIsBlocked=1  

EXECUTE Blockingcheck 'PtAccountBase',@strAccountId, 
		@blnRecIsBlocked=@blnRecIsBlocked OUTPUT,
		@BlockingId = @BlockingId OUTPUT,
		@BlockingReasonId = @BlockingReasonId OUTPUT
		
Set @blnIsPayOutAllowed=0  
Set @blnIsPayOutBooklet=0  
Set @blnIsPayInAllowed=0  
Set @blnIsPayInBooklet=0  

EXECUTE GetAccountPayInPayOutInfo  @PrReferenceId,  
@blnIsPayOutAllowed=@blnIsPayOutAllowed OUTPUT, @blnIsPayOutBooklet=@blnIsPayOutBooklet OUTPUT,  
@blnIsPayInAllowed=@blnIsPayInAllowed OUTPUT, @blnIsPayInBooklet=@blnIsPayInBooklet OUTPUT,  
@blnIsPayOutNeedsBooklet=@blnIsPayOutNeedsBooklet OUTPUT, @blnIsPayInNeedsBooklet=@blnIsPayInNeedsBooklet OUTPUT  
EXECUTE GetPartnerOpenIssues  @strPartnerId, @OpenIssuesCount=@intOpenIssuesCount OUTPUT  

select @strBlockComment = ptBlocking.BlockComment from ptBlocking where id = @BlockingId

select  
@strAccountId as AccountId,  
@strPartnerId as PartnerId,  
@decPartnerNo as PartnerNo,  
@strPartnerNoEdited as PartnerNoEdited,
@strAccountNoIBAN as AccountNoIBAN,   
@strPortfolioId as PortfolioId,   
@decPortfolioNo as PortfolioNo,   
@decAccountNo as AccountNo,  
@strAccountNoEdited as AccountNoEdited,  
@strFirstName as FirstName,  
@strMiddleName as MiddleName,   
@strName as Name,   
@dtmDateOfBirth as DateOfBirth,   
@strAdviceAdrLine as AdviceAdrLine,  
@strAddressStreet as AddressStreet,   
@strAddressHouseNO as AddressHouseNO,   
@strAddressZip as AddressZip,   
@strAddressTown as AddressTown,   
@strAddressCountry as AddressCountry,   
@strAccCurrency as AccCurrency,   
@strPositionId as PositionId,   
@strCustomerReference as CustomerReference,  
@PrReferenceId as ProdReferenceId,  
@blnRecIsBlocked as IsBlocked,  
@blnIsPayOutAllowed as IsPayOutAllowed,  
@blnIsPayOutBooklet as IsPayOutBooklet,  
@blnIsPayInAllowed as IsPayInAllowed,  
@blnIsPayInBooklet as IsPayInBooklet,  
@blnIsPayOutNeedsBooklet as IsPayOutNeedsBooklet,  
@blnIsPayInNeedsBooklet as IsPayInNeedsBooklet,  
@intOpenIssuesCount as OpenIssuesCount,
@dtmTerminationDate as TerminationDate,
@MgSITZ as MgSITZ,
@blnHasStaffRebate as HasStaffRebate,
@BlockingId as BlockingId,
@BlockingReasonId as BlockingReasonId,
@intProductNo as ProductNo, 
@strBlockComment as BlockComment,
@blnIsToClose as IsToClose,
@blnRequiresIdent as RequiresIdent ,
@strPfCurrency as PortfolioCurrency,
@WithdrawCommRelevant as WithdrawCommRelevant

