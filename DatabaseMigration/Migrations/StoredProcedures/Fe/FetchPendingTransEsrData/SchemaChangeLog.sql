--liquibase formatted sql

--changeset system:create-alter-procedure-FetchPendingTransEsrData context:any labels:c-any,o-stored-procedure,ot-schema,on-FetchPendingTransEsrData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FetchPendingTransEsrData
CREATE OR ALTER PROCEDURE dbo.FetchPendingTransEsrData
@TransEsrFileId UniqueIdentifier, @AccountId UniqueIdentifier
As
insert into PtTransEsrFetched
(
TransEsrFileId,
TransEsrDataId
)
select @TransEsrFileId as TransEsrFileId, D.Id From PtTransEsrData as D
Left Outer Join PtTransEsrFetched as F On D.Id = F.TransEsrDataId
where AccountId = @AccountId And F.TransEsrDataId is Null AND D.TransDate > DATEADD(year, -1, GETDATE()) And D.HdVersionNo < 999999999
