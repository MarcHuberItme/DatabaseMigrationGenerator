--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPortfolioCorrInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPortfolioCorrInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPortfolioCorrInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSPortfolioCorrInfo
@PotfolioCorrId UniqueIdentifier
As
SELECT 
		Pf.PortfolioId, 
		Pf.AddressId AS AddressId, 
		Pf.AttentionOf AS AttentionOf,
		Pf.CarrierTypeNo AS CarrierTypeNo, 
		Pf.DeliveryRuleNo AS DeliveryRuleNo,
		Pf.DetourGroup AS DetourGroup,
		Pf.IsPrimaryCorrAddress,
		PfItem.CopyNumber AS CopyNumber,
		V1.CorrItemId As CorrItemId,
		CorrespondenceLanguageNo As CorrLanguageNo,
		PtPortfolio.PartnerId
	FROM PtCorrPortfolio AS Pf
	inner join AsParameterView on GroupName = 'PM1'  and ParameterName = 'PM1DocCorrItemNo'
	 inner join AsCorrItem on AsParameterView.Value = AsCorrItem.ItemNo  
	INNER JOIN PtCorrPortfolioItemGroup AS PfItem ON PfItem.CorrPortfolioId = Pf.Id AND PfItem.CopyNumber > 0 AND (PfItem.HdVersionNo BETWEEN 1 AND 999999998)
	INNER JOIN AsCorrItemAssign AS V1 ON PfItem.CorrItemGroupNo = V1.CorrItemGroupNo AND (V1.HdVersionNo BETWEEN 1 AND 999999998) and V1.CorrItemId = AsCorrItem.Id  
	INNER JOIN PtAddress on PtAddress.Id = Pf.AddressId
	INNER JOIN PtPortfolio on Pf.PortfolioId = PtPortfolio.Id
	WHERE Pf.Id =  @PotfolioCorrId
