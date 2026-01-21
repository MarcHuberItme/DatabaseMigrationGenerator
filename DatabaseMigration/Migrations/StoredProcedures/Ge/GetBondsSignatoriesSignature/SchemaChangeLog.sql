--liquibase formatted sql

--changeset system:create-alter-procedure-GetBondsSignatoriesSignature context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBondsSignatoriesSignature,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBondsSignatoriesSignature
CREATE OR ALTER PROCEDURE dbo.GetBondsSignatoriesSignature
(@DocType uniqueidentifier, @LeftPartnerNo int, @RightPartnerNo int) AS 

DECLARE @UserbaseIdSigLeft as uniqueidentifier 

DECLARE @UserbaseIdSigRight as uniqueidentifier 


Select @UserbaseIdSigRight = PtUserbase.Id from PtBase 

Inner Join PtUserbase On PtBase.Id = PtUserbase.PartnerId 

Where PartnerNo = @RightPartnerNo 


Select @UserbaseIdSigLeft = PtUserbase.Id from PtBase 

Inner Join PtUserbase On PtBase.Id = PtUserbase.PartnerId 

Where PartnerNo = @LeftPartnerNo 


Select L.DataString as LeftSignatureImage, R.DataString as RightSignatureImage from 

( 

Select top 1 asdocumentdata.DataString from asdocumentdata 
Inner Join AsDocument on asdocumentdata.DocumentId = AsDocument.Id 
Inner Join AsDocumentIndex On AsDocument.Id = AsDocumentIndex.DocumentId 
Where AsDocument.Type = @DocType and AsDocumentIndex.SourceTableName = 'PtUserBase' 
and AsDocumentIndex.SourceRecordId = @UserbaseIdSigLeft 

) L , 

( 

Select top 1 asdocumentdata.DataString from asdocumentdata 
Inner Join AsDocument on asdocumentdata.DocumentId = AsDocument.Id 
Inner Join AsDocumentIndex On AsDocument.Id = AsDocumentIndex.DocumentId 
Where AsDocument.Type = @DocType and AsDocumentIndex.SourceTableName = 'PtUserBase' 
and AsDocumentIndex.SourceRecordId = @UserbaseIdSigRight 

) R 
