--liquibase formatted sql

--changeset system:create-alter-view-PtPaynetBillerView context:any labels:c-any,o-view,ot-schema,on-PtPaynetBillerView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPaynetBillerView
CREATE OR ALTER VIEW dbo.PtPaynetBillerView AS
SELECT
-- PtPaynetAccount = PA
PA.AccountIdent,
PA.AccountIdentType,
PA.BillerId,

-- PtPaynetBiller = PB
PB.BillerStatus,
PB.PaynetBillerId,

-- PtPaynetBillerText = PBT
PBT.Name as BillerName,
PBT.LanguageNo

FROM PtPaynetAccount as PA
INNER JOIN PtPaynetBiller as PB ON PB.Id = PA.BillerId
INNER JOIN PtPaynetBillerText as PBT on PBT.BillerId = PB.Id
