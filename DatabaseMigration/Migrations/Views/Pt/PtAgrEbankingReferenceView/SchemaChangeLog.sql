--liquibase formatted sql

--changeset system:create-alter-view-PtAgrEbankingReferenceView context:any labels:c-any,o-view,ot-schema,on-PtAgrEbankingReferenceView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrEbankingReferenceView
CREATE OR ALTER VIEW dbo.PtAgrEbankingReferenceView AS
SELECT ptagrebanking.Id,
ptagrebanking.HdCreateDate,
ptagrebanking.HdCreator,
ptagrebanking.HdChangeDate,
ptagrebanking.HdChangeUser,
ptagrebanking.HdEditStamp,
ptagrebanking.HdVersionNo,
ptagrebanking.HdProcessId,
ptagrebanking.HdStatusFlag,
ptagrebanking.HdNoUpdateFlag,
ptagrebanking.HdPendingChanges,
ptagrebanking.HdPendingSubChanges,
ptagrebanking.HdTriggerControl,
ptagrebanking.PartnerId,
ptagrebanking.ContactPersonId,
ptagrebanking.SeqNo,
ptagrebanking.VersionNo,ptagrebanking.MgVTNo,
ptagrebanking.MgVTNo + ' / ' + PtDescriptionView.PtDescription as AgreementRef, PtDescriptionView.PtDescription
from ptagrebanking
inner join PtDescriptionView on ptagrebanking.PartnerId = PtDescriptionView.id

