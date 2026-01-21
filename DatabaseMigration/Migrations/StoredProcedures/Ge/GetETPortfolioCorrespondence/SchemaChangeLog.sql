--liquibase formatted sql

--changeset system:create-alter-procedure-GetETPortfolioCorrespondence context:any labels:c-any,o-stored-procedure,ot-schema,on-GetETPortfolioCorrespondence,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetETPortfolioCorrespondence
CREATE OR ALTER PROCEDURE dbo.GetETPortfolioCorrespondence
@CorrItemNo smallint, @PortfolioNo decimal(11,0)
AS


Select BT.TextShort + ' ' + convert(nvarchar(20),getdate(),104) as PlaceAndDateLong, PtCorrPortfolioViewLang.*, PtAddress.PartnerId as AddressPartnerId, PortfolioId, PtBase.Id as PartnerId,
recv.Address1 as RecvAddress1, recv.Address2 as RecvAddress2,recv.Address3 as RecvAddress3,recv.Address4 as RecvAddress4,recv.Address5 as RecvAddress5,recv.Address6 as RecvAddress6,
case when PtBase.Id <> PtAddress.PartnerId then own.Address1 else null End as OwnerAddress1, 
case when PtBase.Id <> PtAddress.PartnerId then own.Address2 else null End as OwnerAddress2,
case when PtBase.Id <> PtAddress.PartnerId then own.Address3 else null End as OwnerAddress3,
case when PtBase.Id <> PtAddress.PartnerId then own.Address4 else null End as OwnerAddress4,
case when PtBase.Id <> PtAddress.PartnerId then own.Address5 else null End as OwnerAddress5,
case when PtBase.Id <> PtAddress.PartnerId then own.Address6 else null End as OwnerAddress6,
case when PtBase.Id <> PtAddress.PartnerId then Add11.ReportAdrLine else null End as OwnerReportAddrLine

from PtPortfolio 
inner join PtBase on PtPortfolio.PartnerId = PtBase.Id
inner join AsCorrItem on AsCorrItem.ItemNo = @CorrItemNo
inner join PtCorrPortfolioViewLang on PtPortfolio.Id = PtCorrPortfolioViewLang.PortfolioId and PtCorrPortfolioViewLang.CorrItemId  = AsCorrItem.Id
inner join PtAddress on PtCorrPortfolioViewLang.AddressId = PtAddress.Id
inner join PtAddress Add11 on Add11.PartnerId =PtBase.Id AND Add11.AddressTypeNo = 11 and Add11.HdversionNo between 1 and 999999998
inner join AsBranch on PtBase.BranchNo = AsBranch.BranchNo
left outer join AsText BT on AsBranch.Id = BT.MasterId and BT.LanguageNo = PtCorrPortfolioViewLang.CorrLanguageNo
CROSS APPLY dbo.SplitAddressPerColumn(PtAddress.FullAddress, char(13)+char(10)) recv
CROSS APPLY dbo.SplitAddressPerColumn(Add11.FullAddress, char(13)+char(10)) own
Where PortfolioNo = @PortfolioNo 

