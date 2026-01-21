--liquibase formatted sql

--changeset system:create-alter-view-EvSelPosTrxView context:any labels:c-any,o-view,ot-schema,on-EvSelPosTrxView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvSelPosTrxView
CREATE OR ALTER VIEW dbo.EvSelPosTrxView AS
SELECT 	TOP 100 PERCENT
	ESP.Id, ESP.HdEditStamp, ESP.HdVersionNo, 
	ESP.EventSelectionId, ESP.EventId, ESP.PositionId, ESP.EventPosNo, ESP.AccountReferenceId, ESP.ExecutedQuantity, 
	ESP.PosProcStatusNo, ESP.TransactionId, ESP.IsSupressed, ESP.HasPosBlocking,
	PTR.TransDate, PTF.PartnerId, PTF.LocGroupId, LOC.NoReporting
FROM 	EvSelectionPos ESP 
JOIN	PtTransaction PTR ON PTR.Id = ESP.TransactionId
JOIN	PtPosition POS ON POS.Id = ESP.PositionId
JOIN	PtPortfolio PTF ON PTF.Id = POS.PortfolioId
JOIN	PrLocGroup LOC ON LOC.Id = POS.ProdLocGroupId
