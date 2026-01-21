--liquibase formatted sql

--changeset system:create-alter-procedure-GetETAccountCorrespondence context:any labels:c-any,o-stored-procedure,ot-schema,on-GetETAccountCorrespondence,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetETAccountCorrespondence
CREATE OR ALTER PROCEDURE dbo.GetETAccountCorrespondence
@CorrItemNo smallint, @AccountNo decimal(11,0)
AS

Select BT.TextShort + ' ' + convert(nvarchar(20),getdate(),104) as PlaceAndDateLong, PtCorrAccountViewLang.*, PtAddress.PartnerId as AddressPartnerId, PortfolioId, AccountId, PtBase.Id as PartnerId,
recv.Address1 as RecvAddress1, recv.Address2 as RecvAddress2,recv.Address3 as RecvAddress3,recv.Address4 as RecvAddress4,recv.Address5 as RecvAddress5,recv.Address6 as RecvAddress6,
case when PtBase.Id <> PtAddress.PartnerId then own.Address1 else null End as OwnerAddress1, 
case when PtBase.Id <> PtAddress.PartnerId then own.Address2 else null End as OwnerAddress2,
case when PtBase.Id <> PtAddress.PartnerId then own.Address3 else null End as OwnerAddress3,
case when PtBase.Id <> PtAddress.PartnerId then own.Address4 else null End as OwnerAddress4,
case when PtBase.Id <> PtAddress.PartnerId then own.Address5 else null End as OwnerAddress5,
case when PtBase.Id <> PtAddress.PartnerId then own.Address6 else null End as OwnerAddress6,
case when PtBase.Id <> PtAddress.PartnerId then Add11.ReportAdrLine else null End as OwnerReportAddrLine

from PtAccountBase 
inner join PtPortfolio on PtAccountBase.PortfolioId = PtPortfolio.Id
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
inner join AsCorrItem on AsCorrItem.ItemNo = @CorrItemNo
inner join PtCorrAccountViewLang on PtAccountBase.Id = PtCorrAccountViewLang.AccountId and PtCorrAccountViewLang.CorrItemId  = AsCorrItem.Id
inner join PtAddress on PtCorrAccountViewLang.AddressId = PtAddress.Id
inner join PtAddress Add11 on Add11.PartnerId =PtBase.Id AND Add11.AddressTypeNo = 11 and Add11.HdversionNo between 1 and 999999998
inner join AsBranch on PtBase.BranchNo = AsBranch.BranchNo
left outer join AsText BT on AsBranch.Id = BT.MasterId and BT.LanguageNo = PtCorrAccountViewLang.CorrLanguageNo
CROSS APPLY dbo.SplitAddressPerColumn(PtAddress.FullAddress, char(13)+char(10)) recv
CROSS APPLY dbo.SplitAddressPerColumn(Add11.FullAddress, char(13)+char(10)) own
Where AccountNo = @AccountNo 

