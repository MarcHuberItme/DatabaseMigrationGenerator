--liquibase formatted sql

--changeset system:create-alter-view-WfVwProcessLog context:any labels:c-any,o-view,ot-schema,on-WfVwProcessLog,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwProcessLog
CREATE OR ALTER VIEW dbo.WfVwProcessLog AS
SELECT Id, MapNo, VariableInstanceSet, Status, DynamicDescription, InstanciationType, Agent, Instanciator, CreationDate, FinishDate FROM WfProcess 
UNION
SELECT ProcessId as Id, MapNo, VariableInstanceSet, Status, DynamicDescription, InstantiationType AS InstanciationType, Agent, Instantiator AS Instanciator, CreationDate, FinishDate FROM WfProcessLog

