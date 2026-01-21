--liquibase formatted sql

--changeset system:create-alter-view-VaPortfolioMarginView context:any labels:c-any,o-view,ot-schema,on-VaPortfolioMarginView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view VaPortfolioMarginView
CREATE OR ALTER VIEW dbo.VaPortfolioMarginView AS
SELECT 		TOP 100 PERCENT
		PTF.Id, NULL AS HdProcessId, PTF.HdVersionNo, 
		PTF.HdCreateDate, PTF.HdEditStamp,
 		0 AS HdPendingChanges, 0 AS HdPendingSubChanges, 
		VPM.VaRunId,
		PTF.PortfolioNo, PTF.PortfolioNoEdited, PTF.PartnerId, PBA.ConsultantTeamName,
		IsNull(ADR.ReportAdrLine,IsNull(PBA.FirstName + ' ','') + 
		IsNull(PBA.Name,'') + ' ' + IsNull(ADR.Town,'')) AS PtDescription,
		SUM(IsNull(VPV.MarketValueCHF, 0)) AS SumMarketValueCHF,
		SUM(IsNull(VPM.CalculatedMarginHoCu, 0)) AS SumCalculatedMarginHoCu, 
		SUM(IsNull(VPM.NecessaryMarginHoCu, 0)) AS SumNecessaryMarginHoCu, 
		SUM(IsNull(VPM.CorrectionCollateralValueHoCu, 0)) AS SumCorrCollateralValueHo,
		VBM.AccountReferenceId, VBM.BookedMarginAcCu,
		ACC.AccountNo, ACC.AccountNoEdited,
		COUNT(POS.HdCreateDate) AS PosTotalCnt, IsNull(ERR.CNT_Error, 0) AS PosErrorCnt
FROM 		VaPosMargin VPM
JOIN		PtPosition POS ON POS.Id = VPM.PositionId
JOIN		VaPublicView VPV ON VPV.PositionId = POS.Id AND VPV.VaRunId = VPM.VaRunId
JOIN		PtPortfolio PTF ON PTF.Id = POS.PortfolioId
JOIN		PtBase PBA ON PBA.Id = PTF.PartnerId
LEFT OUTER JOIN	PtAddress ADR ON PBA.Id = ADR.PartnerId And ADR.AddressTypeNo = 11
LEFT OUTER JOIN (SELECT  VPM_2.VaRunId, POS_2.PortfolioId, COUNT(VPM_2.HdCreateDate) CNT_Error
		FROM	VaPosMargin VPM_2
		JOIN	PtPosition POS_2 ON POS_2.Id = VPM_2.PositionId
		WHERE	VPM_2.MarginProcStatusNo = 9
		GROUP BY VPM_2.VaRunId, POS_2.PortfolioId) AS ERR 
		ON ERR.VaRunId = VPM.VaRunId AND ERR.PortfolioId = PTF.Id
LEFT OUTER JOIN	VaBookedMargin VBM ON PTF.Id = VBM.PortfolioId
LEFT OUTER JOIN	PrReference REF ON REF.Id = VBM.AccountReferenceId
LEFT OUTER JOIN	PtAccountBase ACC ON ACC.Id = REF.AccountId
GROUP BY	PTF.Id, PTF.HdVersionNo, PTF.HdCreateDate, PTF.HdEditStamp,
		VPM.VaRunId, PTF.PortfolioNo, PTF.PortfolioNoEdited, PTF.PartnerId, PBA.ConsultantTeamName,
		IsNull(ADR.ReportAdrLine,IsNull(PBA.FirstName + ' ','') + IsNull(PBA.Name,'') + ' ' + IsNull(ADR.Town,'')),
		VBM.AccountReferenceId, BookedMarginAcCu, ACC.AccountNo, ACC.AccountNoEdited,
		IsNull(ERR.CNT_Error, 0)
