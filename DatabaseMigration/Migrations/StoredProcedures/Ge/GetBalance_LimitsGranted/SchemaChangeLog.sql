--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_LimitsGranted context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_LimitsGranted,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_LimitsGranted
CREATE OR ALTER PROCEDURE dbo.GetBalance_LimitsGranted
 @PositionId  uniqueidentifier,    
 @LimitsGranted money OUTPUT    
AS  
  DECLARE @decAccountNo as DECIMAL(11)
  DECLARE @decPortfolioNo as DECIMAL(11)
  DECLARE @LimitByPortfolio as money
  DECLARE @LimitByAccount as money
 
  DECLARE @HasCredit2Active bit
  DECLARE @decAccountId As uniqueidentifier 
  DECLARE @LimitByAccountFromCoBase As Money

--Call stored procedure for Systemparameter Credit.HasCredit2Active
EXECUTE @HasCredit2Active = HasCredit2Active

if (@HasCredit2Active = 1)
  Begin
    Select @LimitByAccountFromCoBase=IsNull(Sum(BValue),0)
    From Credit2LimitsGrantedView
    Where PosId = @PositionId and BValue is not null

    set @LimitsGranted = @LimitByAccountFromCoBase
  End;
else
  Begin
    select @decAccountNo = AccountNo, @decPortfolioNo = PortfolioNo, @decAccountId=AccountId 
    from PtPositionView 
    where Id = @PositionId

    if @decAccountNo is not NULL
      begin
        Select @LimitByAccount = ISNULL(Sum(Value),0) 
        from  PtAccountCompValuesValidView 
        where MgVBNR = @decAccountNo and Value is not null 
      end

    if @decPortfolioNo is not NULL
      begin
        Select @LimitByPortfolio = ISNULL(Sum(Value),0) 
        from  PtAccountCompValuesValidView 
        where MgVBNR = @decPortfolioNo and Value is not null 
      end

    If @decAccountId Is Not Null
      begin
        Select @LimitByAccountFromCoBase=IsNull(Sum(BValue),0)
        From CoBase
        Where AccountId=@decAccountId And InactFlag=0 And BValue Is Not Null And HdVersionNo<999999999
      end

      set @LimitsGranted = @LimitByPortfolio + @LimitByAccount + @LimitByAccountFromCoBase 
  End;

