--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSConsultantTeams context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSConsultantTeams,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSConsultantTeams
CREATE OR ALTER PROCEDURE dbo.GetPMSConsultantTeams
@RC  int
AS
Select top (@RC) PartnerNo,ConsultantTeamName, PtBase.Id as PartnerBaseId, PtPMSConsultTeamTransfer.* from PtPMSPartnerTransfer
inner join PtBase on PtPMSPartnerTransfer.PartnerId = PtBase.Id and PtBase.ConsultantTeamName is not null
left outer join PtPMSConsultTeamTransfer on PtBase.Id = PtPMSConsultTeamTransfer.PartnerId
Where (PtPMSConsultTeamTransfer.LastTransferProcessId is null)
or (PtPMSConsultTeamTransfer.LastConsTeamName <> PtBase.ConsultantTeamName and PtPMSConsultTeamTransfer.HdCreateDate = 
(
Select max(HdCreateDate) from PtPMSConsultTeamTransfer h Where h.PartnerId = PtBase.Id
)
)

