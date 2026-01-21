--liquibase formatted sql

--changeset system:create-alter-view-WfActiveProcessView context:any labels:c-any,o-view,ot-schema,on-WfActiveProcessView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfActiveProcessView
CREATE OR ALTER VIEW dbo.WfActiveProcessView AS
SELECT DISTINCT wpr.Id , wpr.HdCreateDate , wpr.HdCreator , wpr.HdProcessId  
	, wpr.HdChangeDate, wpr.HdChangeUser , wpr.HdEditStamp  
	, wpr.HdVersionNo, wpr.HdStatusFlag , wpr.HdNoUpdateFlag   
	, wpr.HdPendingChanges , wpr.HdPendingSubChanges , wpr.HdTriggerControl 
	, wpr.Id AS ProcessId , wpr.CreationDate , wpr.DynamicDescription 
	, wma.Name , aus.FullName , wma.MapNo , wpr.Instanciator  
FROM AsUnconfirmed aun
RIGHT OUTER JOIN WfProcess wpr ON aun.ProcessId = wpr.Id
INNER JOIN WfMap wma ON wpr.MapNo = wma.MapNo AND wma.MapStatus = 32
INNER JOIN AsUser aus ON wpr.Instanciator = aus.UserName 

