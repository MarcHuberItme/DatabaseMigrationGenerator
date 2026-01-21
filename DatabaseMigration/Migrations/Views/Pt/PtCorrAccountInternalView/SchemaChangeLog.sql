--liquibase formatted sql

--changeset system:create-alter-view-PtCorrAccountInternalView context:any labels:c-any,o-view,ot-schema,on-PtCorrAccountInternalView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCorrAccountInternalView
CREATE OR ALTER VIEW dbo.PtCorrAccountInternalView AS
SELECT TOP 100 PERCENT  *  FROM PtCorrAccount
