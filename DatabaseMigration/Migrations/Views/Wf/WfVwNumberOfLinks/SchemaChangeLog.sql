--liquibase formatted sql

--changeset system:create-alter-view-WfVwNumberOfLinks context:any labels:c-any,o-view,ot-schema,on-WfVwNumberOfLinks,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WfVwNumberOfLinks
CREATE OR ALTER VIEW dbo.WfVwNumberOfLinks AS
SELECT MapNo, FromStepNo AS StepNo, LinkType, COUNT(*) AS NoOfLinks 
FROM WfLink 
GROUP By MapNo, FromStepNo, LinkType

