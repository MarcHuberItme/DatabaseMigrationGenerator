--liquibase formatted sql

--changeset system:create-alter-view-PtTransOrderInfoMainledgerView context:any labels:c-any,o-view,ot-schema,on-PtTransOrderInfoMainledgerView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransOrderInfoMainledgerView
CREATE OR ALTER VIEW dbo.PtTransOrderInfoMainledgerView AS
Select top 100 percent
	TM.Id AS MessageId, PPO.HdCreateDate AS OrderCreateDate, PPO.HdCreator AS OrderCreator, 
	PPO.OrderDate, PPOD.OrderId, PPOD.HdCreateDate AS OrderDetailCreateDate, PPOD.HdCreator AS OrderDetailCreator,
	PPO.OrderType, Tx.TextShort, TM.HdCreateDate AS TM_HdCreateDate, TM.HdCreator AS TM_HdCreator
	FROM PtTransMessage AS TM
	INNER JOIN PtPaymentOrderDetail PPOD ON TM.SourceRecId = PPOD.ID 
	INNER JOIN PtPaymentOrder PPO ON PPOD.OrderId = PPO.Id
	LEFT OUTER JOIN PtPaymentOrderType PPOT ON PPO.OrderType = PPOT.OrderTypeNo
	LEFT OUTER JOIN AsText AS Tx ON PPOT.Id = Tx.MasterId AND Tx.MasterTableName = 'PtPaymentOrderType' AND Tx.LanguageNo = 2
	WHERE 
	TM.SourceTableName = 'PtPaymentOrderDetail'
