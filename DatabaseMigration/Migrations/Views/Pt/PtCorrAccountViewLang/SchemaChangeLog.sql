--liquibase formatted sql

--changeset system:create-alter-view-PtCorrAccountViewLang context:any labels:c-any,o-view,ot-schema,on-PtCorrAccountViewLang,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtCorrAccountViewLang
CREATE OR ALTER VIEW dbo.PtCorrAccountViewLang AS
SELECT TOP 100 PERCENT
	 cor.*, adr.CorrespondenceLanguageNo As CorrLanguageNo
FROM PtCorrAccountView AS cor
   JOIN PtAddress adr on adr.Id = cor.AddressId


