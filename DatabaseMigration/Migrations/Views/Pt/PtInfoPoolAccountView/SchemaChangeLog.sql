--liquibase formatted sql

--changeset system:create-alter-view-PtInfoPoolAccountView context:any labels:c-any,o-view,ot-schema,on-PtInfoPoolAccountView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtInfoPoolAccountView
CREATE OR ALTER VIEW dbo.PtInfoPoolAccountView AS

SELECT
     Ipp.Id, 
     Ipp.HdCreateDate,
     Ipp.HdCreator,
     Ipp.HdChangeDate,
     Ipp.HdChangeUser,
     Ipp.HdEditStamp,
     Ipp.HdVersionNo,
     Ipp.HdProcessId,
     Ipp.HdStatusFlag,
     Ipp.HdNoUpdateFlag,
     Ipp.HdPendingChanges,
     Ipp.HdPendingSubChanges,
     Ipp.HdTriggerControl,
     Ipp.InfoPoolType, 
     Ipp.RemarkDate, 
     Ipp.Remark, 
     Acc.Id AS AccountId, 
     'PtBase' AS TableName, 
     3 AS SortKey
FROM PtAccountBase AS Acc
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PtBase AS Pt ON Pf.PartnerId = Pt.Id
INNER JOIN PtInfoPoolPartner Ipp ON Pf.PartnerId = Ipp.PartnerId
WHERE Ipp.HdVersionNo BETWEEN 1 AND 999999998

UNION ALL 

SELECT      Ipp.Id, 
     Ipp.HdCreateDate,
     Ipp.HdCreator,
     Ipp.HdChangeDate,
     Ipp.HdChangeUser,
     Ipp.HdEditStamp,
     Ipp.HdVersionNo,
     Ipp.HdProcessId,
     Ipp.HdStatusFlag,
     Ipp.HdNoUpdateFlag,
     Ipp.HdPendingChanges,
     Ipp.HdPendingSubChanges,
     Ipp.HdTriggerControl,
     Ipp.InfoPoolType, 
     Ipp.RemarkDate, 
     Ipp.Remark, 
     Acc.Id AS AccountId, 
     'PtPortfolio' AS TableName, 2 AS SortKey
FROM PtAccountBase AS Acc
INNER JOIN PtPortfolio AS Pf ON Acc.PortfolioId = Pf.Id
INNER JOIN PtInfoPoolPortfolio Ipp ON Pf.Id = Ipp.PortfolioId
WHERE Ipp.HdVersionNo BETWEEN 1 AND 999999998

UNION ALL

SELECT 
     Ipp.Id, 
     Ipp.HdCreateDate,
     Ipp.HdCreator,
     Ipp.HdChangeDate,
     Ipp.HdChangeUser,
     Ipp.HdEditStamp,
     Ipp.HdVersionNo,
     Ipp.HdProcessId,
     Ipp.HdStatusFlag,
     Ipp.HdNoUpdateFlag,
     Ipp.HdPendingChanges,
     Ipp.HdPendingSubChanges,
     Ipp.HdTriggerControl,
     Ipp.InfoPoolType, 
     Ipp.RemarkDate, 
     Ipp.Remark, 
     Acc.Id AS AccountId, 
     'PtAccountBase' AS TableName, 1 AS SortKey
FROM PtAccountBase AS Acc
INNER JOIN PtInfoPoolAccount Ipp ON Acc.Id = Ipp.AccountId
WHERE Ipp.HdVersionNo BETWEEN 1 AND 999999998
