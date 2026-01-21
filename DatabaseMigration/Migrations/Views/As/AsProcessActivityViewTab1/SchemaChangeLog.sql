--liquibase formatted sql

--changeset system:create-alter-view-AsProcessActivityViewTab1 context:any labels:c-any,o-view,ot-schema,on-AsProcessActivityViewTab1,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsProcessActivityViewTab1
CREATE OR ALTER VIEW dbo.AsProcessActivityViewTab1 AS

Select top 1 ProcessName,
ProcessType,
ProcessGroup, 
ProcessGroupNo, 
ProcessNoInGroup, 
ExecutableProject, 
ExecutableClassName, 
StartParameters, 
SpecialInformation,
EngineDescriptor, 
EnginePackageCount from AsProcessActivity

