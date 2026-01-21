--liquibase formatted sql

--changeset system:create-alter-view-AcReportDetail context:any labels:c-any,o-view,ot-schema,on-AcReportDetail,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcReportDetail
CREATE OR ALTER VIEW dbo.AcReportDetail AS
SELECT     PB.PartnerNo, PB.LegalStatusNo, PB.BusinessTypeCode, PB.FirstName, PB.Name, PF.PortfolioNo,   Ac2.*
 FROM        PtBase PB INNER JOIN
                    PtPortFolio PF ON PB.Id = PF.PartnerId INNER JOIN
                    PtPosition PS ON PF.Id = PS.PortfolioId INNER JOIN
                    AcCompression2 Ac2 ON Ac2.PositionId = PS.Id
 WHERE     PB.HdVersionNo BETWEEN 1 AND 999999998 
 AND 	    PF.HdVersionNo BETWEEN 1 AND 999999998 
 AND 	    PS.HdVersionNo BETWEEN 1 AND 999999998
