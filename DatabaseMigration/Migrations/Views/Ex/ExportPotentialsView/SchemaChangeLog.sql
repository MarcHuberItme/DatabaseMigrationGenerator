--liquibase formatted sql

--changeset system:create-alter-view-ExportPotentialsView context:any labels:c-any,o-view,ot-schema,on-ExportPotentialsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ExportPotentialsView
CREATE OR ALTER VIEW dbo.ExportPotentialsView AS
SELECT          PB.Id AS partner_id
                , POT.Id as potentials_id
                , POT.EntryType AS potentials_typeNo
                , POT.ALCategory AS potentials_categoryNo
                , POT.ContactReportId AS potentials_contactReportId
                , POT.PotentialLevel AS potentials_probabilityNo
                , ISNULL(POT.CustodianNo, 8) AS potentials_custodianName
                , POT.Amount AS potentials_amount
                , POT.MaturityDate AS potentials_maturityDate
                , POT.Deadline AS potentials_dueDate
                , POT.ResultCode AS potentials_result
                , POT.MotiveCloseTypeNo AS potentials_closureReasonNo
                , POT.Remarks AS potentials_remarks
                , GETUTCDATE() AS lastSyncDate
FROM            PtBase PB
JOIN            PtAddress PAD on PAD.PartnerId = PB.Id
                    AND PAD.AddressTypeNo = 11
                    AND PAD.HdVersionNo < 999999999
JOIN            PtDescriptionView PDV ON PDV.Id = PB.Id
JOIN            PtExternalALInfo POT ON POT.PartnerId = PB.Id
LEFT JOIN       PtExternalALCustodian CUST ON CUST.CustodianNo = POT.CustodianNo
                    AND CUST.HdVersionNo < 999999999
WHERE           POT.HdVersionNo < 999999999
AND             POT.ResultCode = 1
AND             PB.TerminationDate IS NULL
AND             PB.ConsultantTeamName NOT IN ('557', '52') --keine Neonkunden | 52 = Buchhaltung
AND             PB.ServiceLevelNo NOT IN (10, 15) --10 technischer Grund | 15 VDF Institution  

