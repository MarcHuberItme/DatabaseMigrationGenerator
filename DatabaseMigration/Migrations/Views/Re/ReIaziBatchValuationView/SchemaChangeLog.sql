--liquibase formatted sql

--changeset system:create-alter-view-ReIaziBatchValuationView context:any labels:c-any,o-view,ot-schema,on-ReIaziBatchValuationView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReIaziBatchValuationView
CREATE OR ALTER VIEW dbo.ReIaziBatchValuationView AS
Select A.*, V.StatusNo, V.QualityNo, V.LastPrice, V.LastValuationDate, 
V.LastIntPrice, V.LastIntValuationDate, V.LastIntPriceSigned,
V.Price, V.ValuationDate, Info, IaziWSProcessId,
Cast('FsMissingData:'+IsNull(V.FsMissingData,'')
	+ CHAR(13)+CHAR(10)+'IaziMissingData:'+IsNull(V.IaziParaList,'')
	+ CHAR(13)+CHAR(10)+'Comment:'+IsNull(P.Comment,'')  As nvarchar(4000)) As Notes
From RePremisesRelAccount A Join ReIaziBatchValuation V On A.Id=V.PremisesRelAccountId
	Join ReIaziWSProcess P On V.IaziWSProcessId=P.Id


