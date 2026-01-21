--liquibase formatted sql

--changeset system:create-alter-procedure-GetPartnerIdentificationDoc context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPartnerIdentificationDoc,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPartnerIdentificationDoc
CREATE OR ALTER PROCEDURE dbo.GetPartnerIdentificationDoc

@PartnerId uniqueidentifier,  
@IdentificationId uniqueidentifier  
  
AS  
  
 Select AsDocumentData.*   
 from
  AsDocument
INNER JOIN AsDocumentData ON AsDocument.Id = AsDocumentData.DocumentId
INNER JOIN AsDocumentIndex ON  AsDocumentIndex.Documentid = AsDocumentData.DocumentId
and AsDocumentIndex.Documentid=AsDocument.Id 
 where  
  AsDocumentIndex.SourceTableName = 'PtIdentification' and  
  AsDocumentIndex.SourceRecordId = @IdentificationId          
Order By AsDocumentData.HdCreateDate DESC  

