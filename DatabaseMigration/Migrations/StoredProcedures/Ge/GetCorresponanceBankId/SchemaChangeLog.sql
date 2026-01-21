--liquibase formatted sql

--changeset system:create-alter-procedure-GetCorresponanceBankId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCorresponanceBankId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCorresponanceBankId
CREATE OR ALTER PROCEDURE dbo.GetCorresponanceBankId
@BICId uniqueidentifier,  
@StartBICIndexId uniqueidentifier,  
@Purpose int  
  
As  
  
DECLARE @strPreBicId as uniqueidentifier  
DECLARE @strPrReferenceId as uniqueidentifier  
  
select @strPreBicId=PreBICId from AsBicPiChain where BICId = @BICId and Purpose = @Purpose  
/*This Procedure involves recursion. The below IF-ELSE is the STOPPING Criteria*/
if @strPreBicId = @StartBICIndexId  
begin
 /*Recursion Stopping Criteria Matched. This is the final node, we were looking for*/
 select
  @strPrReferenceId = CorrespondentPrReferenceId
--  @strCorrespondantAccountId = CorresondentAccountId, 
--  @strCurrency = Currency  
 from AsBICRelation   
 where   
  BICGrantorId=@StartBICIndexId
  and BICCorrespondentId=@BICId  
  and Purpose = @Purpose  
 
-- select @strPrReferenceId=Id  
-- from PrReference  
-- Where  
--  AccountId = @strCorrespondantAccountId  
--  and Currency = @strCurrency  
  
 select   
  @StartBICIndexId AS StartGranterId,  
  @BICId As CorrespondanceBICIndexId,   
  --@strCorrespondantAccountId As CorrespondantAccountId,  
  --@strCurrency as CorresondantCurrency,  
  @strPrReferenceId as ProdReferenceId  
end  
else 
  /*Go Deeper into recursion*/ 
 EXEC GetCorresponanceBankId @strPreBicId,@StartBICIndexId,@Purpose
