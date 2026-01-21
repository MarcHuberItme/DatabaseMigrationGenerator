--liquibase formatted sql

--changeset system:create-alter-view-PtAccountAllViewNoPL context:any labels:c-any,o-view,ot-schema,on-PtAccountAllViewNoPL,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountAllViewNoPL
CREATE OR ALTER VIEW dbo.PtAccountAllViewNoPL AS
SELECT TOP 100 PERCENT * FROM PtAccountAllView
