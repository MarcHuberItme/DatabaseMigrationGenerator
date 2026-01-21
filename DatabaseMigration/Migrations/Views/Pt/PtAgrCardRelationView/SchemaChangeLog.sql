--liquibase formatted sql

--changeset system:create-alter-view-PtAgrCardRelationView context:any labels:c-any,o-view,ot-schema,on-PtAgrCardRelationView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAgrCardRelationView
CREATE OR ALTER VIEW dbo.PtAgrCardRelationView AS
SELECT     
PtAgrCardRelation.Id,
PtAgrCardRelation.HdPendingChanges,
PtAgrCardRelation.HdPendingSubChanges, 
PtAgrCardRelation.HdVersionNo,
PtAgrCardRelation.AccountId,
PtAgrCardRelation.PartnerId, 
PtAgrCardRelation.PortfolioId,
PtAgrCardRelation.CardId,
PtAgrCardBase.CardNo, 
PtAgrCardBase.CardType,
PtAccountBase.AccountNo,
PtAccountBase.AccountNoText
FROM         
PtAgrCardRelation INNER JOIN
PtAgrCardBase ON PtAgrCardRelation.CardId = PtAgrCardBase.Id INNER JOIN
PtAccountBase ON PtAgrCardRelation.AccountId = PtAccountBase.Id
