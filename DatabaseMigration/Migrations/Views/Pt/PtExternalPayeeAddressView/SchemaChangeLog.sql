--liquibase formatted sql

--changeset system:create-alter-view-PtExternalPayeeAddressView context:any labels:c-any,o-view,ot-schema,on-PtExternalPayeeAddressView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtExternalPayeeAddressView
CREATE OR ALTER VIEW dbo.PtExternalPayeeAddressView AS
SELECT     dbo.PtStandingOrder.*, dbo.AsPayee.Beneficary AS Address, dbo.AsPayee.AccountNoExt AS AccountNo, dbo.AsPayee.BCId AS BCId, 
                      dbo.AsPayee.BICId AS BICId, dbo.AsPayee.PCNo AS PCNo
FROM         dbo.AsPayee RIGHT OUTER JOIN
                      dbo.PtStandingOrder ON dbo.AsPayee.Id = dbo.PtStandingOrder.PayeeId
