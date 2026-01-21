--liquibase formatted sql

--changeset system:create-alter-view-MpMarginAdminDetailView context:any labels:c-any,o-view,ot-schema,on-MpMarginAdminDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MpMarginAdminDetailView
CREATE OR ALTER VIEW dbo.MpMarginAdminDetailView AS
select * from MpMargin
