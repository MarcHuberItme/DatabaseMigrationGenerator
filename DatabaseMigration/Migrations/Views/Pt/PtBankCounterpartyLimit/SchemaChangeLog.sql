--liquibase formatted sql

--changeset system:create-alter-view-PtBankCounterpartyLimit context:any labels:c-any,o-view,ot-schema,on-PtBankCounterpartyLimit,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtBankCounterpartyLimit
CREATE OR ALTER VIEW dbo.PtBankCounterpartyLimit AS
SELECT List.ArCode, List.PartnerNoText, List.PartnerId, List.LimitTypeNo, List.ValidFrom, GL.AmountHoCu, FutureList.ValidFrom AS NextValidFrom, FutureDetail.AmountHoCu AS NextAmountHoCu
FROM (
	SELECT Pt.ArCode, Pt.Id AS PartnerId, Pt.PartnerNoText, GLT.LimitTypeNo, MAX(GL.ValidFrom) AS ValidFrom
	FROM PtBase AS Pt
	FULL JOIN PtGeneralLimitType AS GLT ON Pt.HdVersionNo BETWEEN 1 AND 999999998 AND GLT.HdVersionNo BETWEEN 1 AND 999999998
	LEFT OUTER JOIN PtGeneralLimit AS GL ON Pt.Id = GL.PartnerId AND GLT.LimitTypeNo = GL.LimitTypeNo AND GL.HdVersionNo BETWEEN 1 AND 999999998 AND GL.ValidFrom <= GETDATE()
	WHERE Pt.Id IN (SELECT PartnerId FROM PtGeneralLimit)
	GROUP BY Pt.ArCode, Pt.PartnerNoText, Pt.Id , GLT.LimitTypeNo) AS List
LEFT OUTER JOIN PtGeneralLimit AS GL ON List.PartnerId = GL.PartnerId AND List.LimitTypeNo = GL.LimitTypeNo AND List.ValidFrom = GL.ValidFrom
LEFT OUTER JOIN (
	SELECT PartnerId, GL.LimitTypeNo, MIN(GL.ValidFrom) AS ValidFrom
	FROM PtGeneralLimit AS GL 
	WHERE GL.ValidFrom > GETDATE() AND GL.HdVersionNo BETWEEN 1 AND 999999998   
	GROUP BY GL.PartnerId , GL.LimitTypeNo) AS FutureList ON List.PartnerId = FutureList.PartnerId AND List.LimitTypeNo = FutureList.LimitTypeNo
LEFT OUTER JOIN PtGeneralLimit AS FutureDetail ON FutureList.PartnerId = FutureDetail.PartnerId AND FutureList.LimitTypeNo = FutureDetail.LimitTypeNo AND FutureList.ValidFrom = FutureDetail.ValidFrom
