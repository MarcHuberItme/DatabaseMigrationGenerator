--liquibase formatted sql

--changeset system:create-alter-view-PtAccountDirDebitInternalView context:any labels:c-any,o-view,ot-schema,on-PtAccountDirDebitInternalView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountDirDebitInternalView
CREATE OR ALTER VIEW dbo.PtAccountDirDebitInternalView AS
SELECT TOP 100 PERCENT  *  FROM PtAccountDirectDebiting
