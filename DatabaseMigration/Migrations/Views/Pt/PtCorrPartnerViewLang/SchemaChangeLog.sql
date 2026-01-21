--liquibase formatted sql

--changeset system:create-alter-view-PtCorrPartnerViewLang context:any labels:c-any,o-view,ot-schema,on-PtCorrPartnerViewLang,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCorrPartnerViewLang
CREATE OR ALTER VIEW dbo.PtCorrPartnerViewLang AS
SELECT TOP 100 PERCENT
	 cor.*, adr.CorrespondenceLanguageNo As CorrLanguageNo
FROM PtCorrPartnerView AS cor
   JOIN PtAddress adr on adr.Id = cor.AddressId


