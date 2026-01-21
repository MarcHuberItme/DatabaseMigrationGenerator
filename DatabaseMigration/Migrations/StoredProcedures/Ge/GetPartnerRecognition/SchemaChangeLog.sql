--liquibase formatted sql

--changeset system:create-alter-procedure-GetPartnerRecognition context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPartnerRecognition,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPartnerRecognition
CREATE OR ALTER PROCEDURE dbo.GetPartnerRecognition
@PartnerId uniqueidentifier,    
@Type int    
    
AS    
    
Select AsDocumentData.*     
from AsDocumentData  
  
INNER JOIN AsDocument ON AsDocumentData.DocumentId = AsDocument.Id  
INNER JOIN AsDocumentIndex On AsDocumentIndex.DocumentId = AsDocument.Id  
INNER JOIN PtRecognition ON AsDocumentIndex.SourceRecordId = PtRecognition.Id  
INNER JOIN AsDocumentFormat ON AsDocumentData.Format = AsDocumentFormat.Format  
Where  
 AsDocumentFormat.IsPicture =1  
 and PtRecognition.PartnerId =  @PartnerId     
 and AsDocumentIndex.SourceTableName = 'PtRecognition'     
 and PtRecognition.RecognitionTypeNo = @Type     
Order By AsDocumentData.HdCreateDate DESC

