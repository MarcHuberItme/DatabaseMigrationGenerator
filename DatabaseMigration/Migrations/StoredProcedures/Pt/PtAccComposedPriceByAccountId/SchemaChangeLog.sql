--liquibase formatted sql

--changeset system:create-alter-procedure-PtAccComposedPriceByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-PtAccComposedPriceByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtAccComposedPriceByAccountId
CREATE OR ALTER PROCEDURE dbo.PtAccComposedPriceByAccountId
@id uniqueidentifier
as
select ptaccountcomposedprice.*,ptaccountcomponent.accountbaseid 
from ptaccountcomposedprice,ptaccountcomponent 
Where ptaccountcomponent.Id = ptaccountcomposedprice.AccountComponentId  
and ptaccountcomponent.AccountBaseId =   @id
