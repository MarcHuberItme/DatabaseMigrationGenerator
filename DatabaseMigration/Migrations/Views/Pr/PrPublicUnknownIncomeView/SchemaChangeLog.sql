--liquibase formatted sql

--changeset system:create-alter-view-PrPublicUnknownIncomeView context:any labels:c-any,o-view,ot-schema,on-PrPublicUnknownIncomeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPublicUnknownIncomeView
CREATE OR ALTER VIEW dbo.PrPublicUnknownIncomeView AS
SELECT	PUI.Id, 
	PUI.HdPendingChanges,
	PUI.HdPendingSubChanges, 
	PUI.HdVersionNo, 
	PUI.PublicId, 
	PUI.TaxYear,
	PUV.PublicDescription,
	PUV.LanguageNo
FROM	PrPublicUnknownIncome PUI
JOIN	PrPublicDescriptionView PUV	ON PUV.Id = PUI.PublicId
