--liquibase formatted sql

--changeset system:create-alter-procedure-GetPriceDevForMMContract context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPriceDevForMMContract,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPriceDevForMMContract
CREATE OR ALTER PROCEDURE dbo.GetPriceDevForMMContract
@ContractId uniqueidentifier

AS
Select * from PtAccountPriceDeviation where Id in
(
select DebitPriceDeviationId from PtContractPartner where contractId = @ContractId 
)
or Id in 
(
select CreditPriceDeviationId from PtContractPartner where contractId = @ContractId
)
