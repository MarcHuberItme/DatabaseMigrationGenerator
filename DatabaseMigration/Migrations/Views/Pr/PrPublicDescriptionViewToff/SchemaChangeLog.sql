--liquibase formatted sql

--changeset system:create-alter-view-PrPublicDescriptionViewToff context:any labels:c-any,o-view,ot-schema,on-PrPublicDescriptionViewToff,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicDescriptionViewToff
CREATE OR ALTER VIEW dbo.PrPublicDescriptionViewToff AS
SELECT TOP 100 PERCENT
    PrPublicDescriptionView.*, 
    PrPublicCf.DueDate
FROM PrPublicDescriptionView
LEFT OUTER JOIN PrPublicCf
   ON PrPublicCf.PublicId  = PrPublicDescriptionView.Id 

