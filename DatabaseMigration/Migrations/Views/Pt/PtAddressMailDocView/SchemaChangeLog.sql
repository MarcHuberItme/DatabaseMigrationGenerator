--liquibase formatted sql

--changeset system:create-alter-view-PtAddressMailDocView context:any labels:c-any,o-view,ot-schema,on-PtAddressMailDocView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAddressMailDocView
CREATE OR ALTER VIEW dbo.PtAddressMailDocView AS

SELECT TOP 100 PERCENT 

M.Id, 
M.HdVersionNo, 
M. HdPendingChanges, 
M.HdPendingSubChanges, 
M.HdEditStamp, 
M.HdProcessId,
M.HdCreateDate, 
M.HdChangeDate,
M.HdChangeUser,
M.HdCreator,
M.AddressMailId, 
M.DocumentId, 
D.Type, 
D.VirtualDate, 
D.PartnerId, 
D.PortfolioId, 
D.AccountBaseId, 
D.Amount

FROM PtAddressMailDoc AS M

INNER JOIN AsDocument AS D ON M.DocumentId = D.Id
