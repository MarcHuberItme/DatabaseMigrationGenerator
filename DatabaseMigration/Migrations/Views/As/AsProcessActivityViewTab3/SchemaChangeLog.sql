--liquibase formatted sql

--changeset system:create-alter-view-AsProcessActivityViewTab3 context:any labels:c-any,o-view,ot-schema,on-AsProcessActivityViewTab3,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsProcessActivityViewTab3
CREATE OR ALTER VIEW dbo.AsProcessActivityViewTab3 AS
SELECT ActualState, 
ActuallyHandledDate, 
LastStartTime, 
LastEndTime, 
LastAliveTime, 
MaxAliveTimeCount, 
MaxMissingAliveMessages from AsProcessActivity
