--liquibase formatted sql

--changeset system:create-alter-view-PtBaseReferenceView context:any labels:c-any,o-view,ot-schema,on-PtBaseReferenceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtBaseReferenceView
CREATE OR ALTER VIEW dbo.PtBaseReferenceView AS
select
pb.Id as PartnerId,
pb.PartnerNo,
pb.PartnerNoEdited,
pb.PartnerNoText,
pa.ReportAdrLine,
pa.NameLine
from PtBase pb
left join PtAddress pa on pa.PartnerId = pb.Id and pa.AddressTypeNo = 11 and pa.HdVersionNo < 999999999
where pb.HdVersionNo < 999999999
