--liquibase formatted sql

--changeset system:create-alter-view-PtUserReferenceView context:any labels:c-any,o-view,ot-schema,on-PtUserReferenceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtUserReferenceView
CREATE OR ALTER VIEW dbo.PtUserReferenceView AS
select
au.Id as UserId,
au.FullName,
au.Department,
au.UserName,
pb.PartnerId,
pb.PartnerNo,
pb.PartnerNoEdited,
pb.PartnerNoText,
pb.ReportAdrLine,
pb.NameLine
from AsUser au
join PtBaseReferenceView pb on pb.PartnerId = au.PartnerId
