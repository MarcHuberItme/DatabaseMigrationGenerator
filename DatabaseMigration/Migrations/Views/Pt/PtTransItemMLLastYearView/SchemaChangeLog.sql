--liquibase formatted sql

--changeset system:create-alter-view-PtTransItemMLLastYearView context:any labels:c-any,o-view,ot-schema,on-PtTransItemMLLastYearView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransItemMLLastYearView
CREATE OR ALTER VIEW dbo.PtTransItemMLLastYearView AS
select top 100 percent
	TI.Id, PAB.AccountNo, PR.Currency, PAB.CustomerReference, TI.DebitAmount, TI.CreditAmount, 
	TI.MessageId, TI.HdCreateDate, TI.TransDateTime, TI.ValueDate, TI.HdCreator, TI.DetailCounter, TI.RealDate, PP.LatestTransDate, TI.TextNo, TI.TransText, TI.TransDate
	from 
	PtAccountBase as PAB
	inner join PrReference as PR ON PAB.Id = PR.AccountId
	inner join PrPrivate as P ON PR.ProductId = P.ProductId AND P.ProductNo Between 8999 AND 9999
	inner join PtPosition as PP ON PR.Id = PP.ProdReferenceId 
	inner join PtTransItem as TI ON PP.Id = TI.PositionId 
	WHERE PAB.AccountNo BETWEEN 900000000 AND 999999999
	
