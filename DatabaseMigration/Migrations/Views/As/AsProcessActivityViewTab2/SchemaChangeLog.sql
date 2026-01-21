--liquibase formatted sql

--changeset system:create-alter-view-AsProcessActivityViewTab2 context:any labels:c-any,o-view,ot-schema,on-AsProcessActivityViewTab2,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsProcessActivityViewTab2
CREATE OR ALTER VIEW dbo.AsProcessActivityViewTab2 AS
SELECT Top 1 StartType, 
IsPrivileged, 
IsStartableByPrivileged, 
DailyGoAfterHour, 
DailyGoAfterMinute, 
DailyGoBeforeHour, 
DailyGoBeforeMinute, 
RunAtStartup
RunOnStation, 
RunOptional from AsProcessActivity
