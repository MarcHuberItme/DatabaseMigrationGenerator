--liquibase formatted sql

--changeset system:create-alter-procedure-GetETPartnerCorrespondence context:any labels:c-any,o-stored-procedure,ot-schema,on-GetETPartnerCorrespondence,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetETPartnerCorrespondence
CREATE OR ALTER PROCEDURE dbo.GetETPartnerCorrespondence
@CorrItemNo smallint, @PartnerNo decimal(8,0)
AS

Select  BT.TextShort + ' ' + convert(nvarchar(20),getdate(),104) as PlaceAndDateLong, PtCorrPartnerViewLang.*, PtAddress.PartnerId as AddressPartnerId,
recv.Address1 as RecvAddress1, recv.Address2 as RecvAddress2,recv.Address3 as RecvAddress3,recv.Address4 as RecvAddress4,recv.Address5 as RecvAddress5,recv.Address6 as RecvAddress6,
case when PtBase.Id <> PtAddress.PartnerId then own.Address1 else null End as OwnerAddress1, 
case when PtBase.Id <> PtAddress.PartnerId then own.Address2 else null End as OwnerAddress2,
case when PtBase.Id <> PtAddress.PartnerId then own.Address3 else null End as OwnerAddress3,
case when PtBase.Id <> PtAddress.PartnerId then own.Address4 else null End as OwnerAddress4,
case when PtBase.Id <> PtAddress.PartnerId then own.Address5 else null End as OwnerAddress5,
case when PtBase.Id <> PtAddress.PartnerId then own.Address6 else null End as OwnerAddress6,
case when PtBase.Id <> PtAddress.PartnerId then Add11.ReportAdrLine else null End as OwnerReportAddrLine
from PtBase
inner join AsCorrItem on AsCorrItem.ItemNo = @CorrItemNo 
inner join PtCorrPartnerViewLang on PtBase.Id = PtCorrPartnerViewLang.PartnerId and PtCorrPartnerViewLang.CorrItemId  = AsCorrItem.Id
inner join PtAddress on PtCorrPartnerViewLang.AddressId = PtAddress.Id
inner join PtAddress Add11 on Add11.PartnerId =PtBase.Id AND Add11.AddressTypeNo = 11 and Add11.HdversionNo between 1 and 999999998
inner join AsBranch on PtBase.BranchNo = AsBranch.BranchNo
left outer join AsText BT on AsBranch.Id = BT.MasterId and BT.LanguageNo = PtCorrPartnerViewLang.CorrLanguageNo
CROSS APPLY dbo.SplitAddressPerColumn(PtAddress.FullAddress, char(13)+char(10)) recv
CROSS APPLY dbo.SplitAddressPerColumn(Add11.FullAddress, char(13)+char(10)) own
Where PartnerNo = @PartnerNo 

