--liquibase formatted sql

--changeset system:create-alter-procedure-GenerateInternationalIban context:any labels:c-any,o-stored-procedure,ot-schema,on-GenerateInternationalIban,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GenerateInternationalIban
CREATE OR ALTER PROCEDURE dbo.GenerateInternationalIban
@CountryCode Char(2),
@BankCode Varchar(10),
@AccountNumber Varchar(12),
@AccountNoIbanElect Varchar(28) Output,
@AccountNoIbanForm Varchar(36) Output,
@ErrorMessage Varchar(80) Output

--Declare @CountryCode As Char(2)
--Declare @BankCode As Varchar(10)
--Declare @AccountNumber As Varchar(12)

As
Declare	@IbanCountryCode char(2)
Declare	@IbanIbanLen int
Declare	@IbanCheckDigitLen int
Declare	@IbanBankCodeLen int
Declare	@IbanAccountNoLen int
Declare	@IbanCalcCHCC varchar(10) 

Declare @IbanStrV0 As varchar(28)
Declare @IbanStrV1 As varchar(28)
Declare @IbanCC As int
Declare @IbanStrV9 As varchar(28)
Declare @IbanFP As int
Declare @IbanStrFV0 As varchar(36)
Declare @IbanStrFV9 As varchar(36)

Declare @IbanStruct As Table
(
	CountryCode char(2),
	IbanLen int,
	CheckDigitLen int,
	BankCodeLen int,
	AccountNoLen int,
	CalcCHCC varchar(10)
)

SET NOCOUNT ON

Insert @IbanStruct Values ('CH',21,2,5,12,'121700')
Insert @IbanStruct Values ('DE',22,2,8,10,'131400')
Insert @IbanStruct Values ('LT',20,2,5,11,'212900')	

--example CH
--Set @CountryCode='CH'
--Set @BankCode='8307'
--Set @AccountNumber=200139304
--200020013	CH7408307000200020013	IBAN CH74 0830 7000 2000 2001 3
--200139304	CH0508307000200139304	IBAN CH05 0830 7000 2001 3930 4

----example DE
--Set @CountryCode='DE'
--Set @BankCode='37040044'
--Set @AccountNumber=0532013000
----DE89370400440532013000

----example LT
--Set @CountryCode='LT'
--Set @BankCode='10000'
--Set @AccountNumber=11101001000
----LT121000011101001000
--123456789012345678901
--LT12 1000 0111 0100 1000

Set @ErrorMessage=''
If Len(@CountryCode)<>2 
	Begin
		Set @ErrorMessage='Country code ' + @CountryCode + ' not as ISOCode (two chars)!'
		Set @AccountNoIbanElect=''
		Set @AccountNoIbanForm=''
		Return
	End

Select @IbanCountryCode=CountryCode,
  @IbanIbanLen=IbanLen, 
  @IbanCheckDigitLen=CheckDigitLen, 
  @IbanBankCodeLen=BankCodeLen, 
  @IbanAccountNoLen=AccountNoLen, 
  @IbanCalcCHCC=CalcCHCC
From @IbanStruct Where CountryCode=@CountryCode

If @@ROWCOUNT=0 
	Begin
		Set @ErrorMessage='Country code ' + @CountryCode + ' not configured!'
		Set @AccountNoIbanElect=''
		Set @AccountNoIbanForm=''
		Return
	End 

If Len(@BankCode)>@IbanBankCodeLen
	Begin
		Set @ErrorMessage='Bank code ' + @BankCode + ' longer than maximum ' + Format(@IbanBankCodeLen,'0')
		Set @AccountNoIbanElect=''
		Set @AccountNoIbanForm=''
		Return
	End

If Len(@AccountNumber)>@IbanAccountNoLen
	Begin
		Set @ErrorMessage='Bank account number ' + @AccountNumber + ' longer than maximum ' + Format(@IbanAccountNoLen,'0')
		Set @AccountNoIbanElect=''
		Set @AccountNoIbanForm=''
		Return
	End

Set @IbanStrV0=Right(Replicate('0',@IbanBankCodeLen)+@BankCode,@IbanBankCodeLen) 
	+Right(Replicate('0',@IbanAccountNoLen)
	+@AccountNumber,@IbanAccountNoLen)

Set @IbanStrV1=@IbanStrV0+@IbanCalcCHCC
Set @IbanCC=98-(Cast(@IbanStrV1 As Decimal(28)) % 97)

Set @IbanStrV9=@CountryCode+Format(@IbanCC, Replicate('0',@IbanCheckDigitLen))+@IbanStrV0

Set @IbanFP=1
Set @IbanStrFV0='IBAN '

While @IbanFP<=@IbanIbanLen
	Begin
		Set @IbanStrFV0 =@IbanStrFV0 + SubString(@IbanStrV9, @IbanFP,4)+' '
		Set @IbanFP=@IbanFP+4	
	End

Set @IbanStrFV9=RTRIM(@IbanStrFV0)


Set @AccountNoIbanElect=@IbanStrV9
Set @AccountNoIbanForm=@IbanStrFV9

Select @AccountNoIbanElect As AccountNoIbanElect, @AccountNoIbanForm As AccountNoIbanForm, @ErrorMessage As ErrorMessage, Cast(Case When Len(@ErrorMessage)>0 Then 1 Else 0 End As bit) As HasError

SET NOCOUNT OFF


