--liquibase formatted sql

--changeset system:create-alter-view-PtAccountInternalView context:any labels:c-any,o-view,ot-schema,on-PtAccountInternalView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountInternalView
CREATE OR ALTER VIEW dbo.PtAccountInternalView AS
SELECT * FROM PtAccountBase
