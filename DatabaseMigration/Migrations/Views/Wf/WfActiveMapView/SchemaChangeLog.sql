--liquibase formatted sql

--changeset system:create-alter-view-WfActiveMapView context:any labels:c-any,o-view,ot-schema,on-WfActiveMapView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfActiveMapView
CREATE OR ALTER VIEW dbo.WfActiveMapView AS
SELECT DISTINCT wma.Id , wma.HdCreateDate , wma.HdCreator , wma.HdProcessId  
	, wma.HdChangeDate, wma.HdChangeUser , wma.HdEditStamp  
	, wma.HdVersionNo, wma.HdStatusFlag , wpr.HdNoUpdateFlag   
	, wma.HdPendingChanges , wma.HdPendingSubChanges , wma.HdTriggerControl 
	, wpr.Id AS ProcessId , wpr.CreationDate , wpr.DynamicDescription 
	, wma.Name AS MapName , wma.MapNo , wpr.Instanciator 
	, aus.FullName , wma.MapStatus
FROM WfMap wma 
INNER JOIN WfProcess wpr ON wma.MapNo = wpr.MapNo 
INNER JOIN AsUser aus ON wpr.Instanciator = aus.UserName 



