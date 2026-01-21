--liquibase formatted sql

--changeset system:create-alter-view-vePartnerIdentifcation context:any labels:c-any,o-view,ot-schema,on-vePartnerIdentifcation,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view vePartnerIdentifcation
CREATE OR ALTER VIEW dbo.vePartnerIdentifcation AS
SELECT     dbo.PtBase.PartnerNo, dbo.PtIdentification.*
FROM         dbo.PtBase INNER JOIN
                      dbo.PtIdentification ON dbo.PtBase.Id = dbo.PtIdentification.PartnerId
