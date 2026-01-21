--liquibase formatted sql

--changeset system:create-alter-view-PtInnerCashDeskView context:any labels:c-any,o-view,ot-schema,on-PtInnerCashDeskView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtInnerCashDeskView
CREATE OR ALTER VIEW dbo.PtInnerCashDeskView AS
SELECT tri.MessageId , pab.AccountNo , SUM( tri.DebitAmount ) AS Agio , ref.Currency
	FROM PtTransItem tri 
	INNER JOIN PtPosition pos ON tri.PositionId = pos.Id 
	INNER JOIN PrReference ref ON pos.ProdReferenceId = ref.Id
	INNER JOIN PtAccountBase pab ON ref.AccountId = pab.Id
WHERE ref.Currency = 'USD' AND tri.DebitAmount <> 0
and tri.HdVersionNo between 1 and 999999998
GROUP BY tri.MessageId , pab.AccountNo , ref.Currency

