--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSEvTemplateInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSEvTemplateInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSEvTemplateInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSEvTemplateInfo

@TransactionId UniqueIdentifier
As

Select TemplateNo,TemplateGroupNo, PaymentTypeNo, PMSFunctionCode  from PtTransaction
inner join EvVariant on PtTransaction.EventVariantId = EvVariant.Id
inner join EvTemplate on EvVariant.EventTemplateId = EvTemplate.Id
Where PtTransaction.Id = @TransactionId 
