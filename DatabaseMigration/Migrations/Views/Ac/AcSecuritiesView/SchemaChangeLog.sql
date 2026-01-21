--liquibase formatted sql

--changeset system:create-alter-view-AcSecuritiesView context:any labels:c-any,o-view,ot-schema,on-AcSecuritiesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcSecuritiesView
CREATE OR ALTER VIEW dbo.AcSecuritiesView AS
SELECT 	DV.IsinNo, Dv.NominalCurrency, DV.PublicDescription, RD.*
FROM 	PrPublicDescriptionView DV LEFT OUTER JOIN AcReportDetail RD ON RD.PublicProductNo = DV.IsinNo
WHERE LanguageNo = 1
