--liquibase formatted sql

--changeset system:create-alter-view-PtFSExternalPartnerView context:any labels:c-any,o-view,ot-schema,on-PtFSExternalPartnerView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtFSExternalPartnerView
CREATE OR ALTER VIEW dbo.PtFSExternalPartnerView AS
Select S.*, P.FinstarRoleNo, P.AccountNoFrom, P.AccountNoTo, UPPER(P.BankShortName) As PartnerBank
From PtFSExternalPartner P Join PtFSExternalPartnerSetting S On P.ExternalPartnerCode=S.ExternalPartnerCode
Where P.HdVersionNo<999999999 And S.HdVersionNo<999999999

