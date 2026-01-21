--liquibase formatted sql

--changeset system:create-alter-view-PtSADPaymentView context:any labels:c-any,o-view,ot-schema,on-PtSADPaymentView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtSADPaymentView
CREATE OR ALTER VIEW dbo.PtSADPaymentView AS
Select O.OrderNo, O.ExportFileID, P.SequenceNo, 
 P.PayeeName, P.PayeeFurtherInfo, P.PayeeAddress, P.PayeePostCode, P.PayeeCity, 
 P.BenBankName, P.BenBankFurtherInfo, P.BenBankStreet, P.BenBankPostCode, P.BenBankCity, 
 P.OrderIssuerName, P.OrderIssuerFurtherInfo, P.OrderIssuerStreet, P.OrderIssuerPostCode, P.OrderIssuerCity, 
 P.InfoBlock1, P.InfoBlock2, P.InfoBlock3,
 M.*, M.CreditClearingNo As CreditBCNo, M.CreditBeneficiaryAccountNoIBAN As CreditBeneficiaryAccount,
 OD.BeneficiaryName As OrderBeneficiaryName, OD.BeneficiaryStreetName As OrderBeneficiaryStreetName, 
 OD.BeneficiaryBuildingNo As OrderBeneficiaryBuildingNo, OD.BeneficiaryPostCode As OrderBeneficiaryPostCode, 
 OD.BeneficiaryTownName As OrderBeneficiaryTownName, OD.BeneficiaryCountry As OrderBeneficiaryCountry
From PtTransMessage M Left Outer Join PtSADPayment P on M.Id = P.TransMessageId
 Left Outer Join PtSADOrder O on P.OrderId = O.Id
 Left Outer Join PtPaymentOrderDetail OD On M.SourceTableName='PtPaymentOrderDetail' And M.SourceRecId=OD.Id

