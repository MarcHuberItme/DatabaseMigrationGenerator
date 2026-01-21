--liquibase formatted sql

--changeset system:create-alter-view-PtPositionSecDetailView context:any labels:c-any,o-view,ot-schema,on-PtPositionSecDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionSecDetailView
CREATE OR ALTER VIEW dbo.PtPositionSecDetailView AS
SELECT                  TOP 100 PERCENT
		POS.Id, POS.HdCreateDate, POS.HdCreator, POS.HdChangeDate, POS.HdChangeUser, 
		POS.HdEditStamp, POS.HdVersionNo, POS.HdProcessId, POS.HdStatusFlag, 
		POS.HdNoUpdateFlag, POS.HdPendingChanges, POS.HdPendingSubChanges, POS.HdTriggerControl,
		POS.Quantity,
		POS.LatestTransDate,
		PTF.PortfolioNoEdited,
		PDV.PtDescription, 
		REF.Currency,
		PUB.Id AS PublicId,
		PUB.IsinNo,
		PUB.VdfInstrumentSymbol,
		PUB.SecurityType,
		LCG.GroupNo, 
    		IsNull(Convert(varchar,REF.InterestRate) + ' % ', '')
    		+ IsNull(Convert(varchar,REF.MaturityDate,104) + ' ', '')
   		+ IsNull(REF.SpecialKey + ' ','')
    		+ IsNull(Convert(varchar,OBJ.ObjectSeqNo), '')
   		+ IsNull(Convert(varchar,OBL.ObjectSeqNo), '')
   		+ IsNull(Convert(varchar,INS.ObjectSeqNo), '') as ReferenceData,
		POS.MaturityInfoTypeNo
FROM 		PtPosition POS
JOIN		PtPortfolio PTF ON PTF.Id = POS.PortfolioId
JOIN		PtDescriptionView PDV ON PDV.Id = PTF.PartnerId 
JOIN		PrReference REF ON REF.Id = POS.ProdReferenceId
JOIN		PrPublic PUB ON PUB.ProductId = REF.ProductId
JOIN		PrLocGroup LCG ON LCG.Id = POS.ProdLocGroupId 
LEFT OUTER JOIN	PrObject OBJ on OBJ.Id = REF.ObjectId 
LEFT OUTER JOIN ReObligation OBL on OBL.Id = REF.ObligationId 
LEFT OUTER JOIN PrInsurancePolice INS on INS.Id = REF.InsurancePoliceId  
