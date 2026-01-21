--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSOwnBondTransPublicInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSOwnBondTransPublicInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSOwnBondTransPublicInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSOwnBondTransPublicInfo

@TransMesssageId UniqueIdentifier

As

Select PublicId,VDFInstrumentSymbol,TitleNo,FunctionCode,InstrumentTypeNo,PrPublicRefType.FieldShortLong,PrPublicCF.ProdReferenceId from PtTransMsgDetailView 
inner join PtOwnBondCF on PtTransMsgDetailView.OwnBondCFId = PtOwnBondCF.Id
inner join PrPublicCF on PtOwnBondCF.PublicCFId = PrPublicCF.Id
inner join PrPublic on PrPublicCF.PublicId = PrPublic.Id
inner join PrReference on PrPublicCF.ProdReferenceId = PrReference.Id
inner join PrPublicRefType on PrPublic.RefTypeNo = PrPublicRefType.RefTypeNo
Where TransMessageId = @TransMesssageId
