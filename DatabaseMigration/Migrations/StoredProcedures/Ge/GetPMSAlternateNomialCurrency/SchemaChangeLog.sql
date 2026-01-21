--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSAlternateNomialCurrency context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSAlternateNomialCurrency,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSAlternateNomialCurrency
CREATE OR ALTER PROCEDURE dbo.GetPMSAlternateNomialCurrency
@PublicId UniqueIdentifier
As
Select top 1 PrReference.Currency
 from PrPublic
inner join PrReference  on PrPublic.ProductId = PrReference.ProductId
Where PrPublic.Id =@PublicId 
group by PrReference.Currency
Order by count(*) desc
