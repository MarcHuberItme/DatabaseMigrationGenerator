--liquibase formatted sql

--changeset system:create-alter-view-MgAvProdAccountMappingInitView context:any labels:c-any,o-view,ot-schema,on-MgAvProdAccountMappingInitView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view MgAvProdAccountMappingInitView
CREATE OR ALTER VIEW dbo.MgAvProdAccountMappingInitView AS
select Pr.ProductNo, Tx.TextShort,A.Id AS AccountId, A.AccountNo, A.CustomerReference, Ref.Id AS ReferenceId
from PtBase as Pt
INNER JOIN PtPortfolio as Pf on Pt.Id = Pf.PartnerId
INNER JOIN PtAccountBase AS A on A.PortfolioId = Pf.Id
INNER JOIN PrReference AS Ref on A.Id = Ref.AccountId
INNER JOIN PrPrivate as Pr ON Pr.ProductId IS NOT NULL
INNER JOIN AsText as Tx ON Pr.Id = Tx.MasterId AND Tx.LanguageNo = 2
WHERE 
--KFH
(Pt.PartnerNo = 700001 AND Pr.ProductNo BETWEEN 3000 AND 3049 AND
(
	(A.CustomerReference = 'KFH Abwicklungskonto GLKB' AND Tx.TextShort LIKE 'KFH_% GLKB %')
	OR
	(A.CustomerReference = 'KFH Abwicklungskonto GKB' AND Tx.TextShort LIKE 'KFH_% GKB %')
	OR
	(A.CustomerReference = 'KFH Abwicklungskonto NAB' AND Tx.TextShort LIKE 'KFH_% NAB %')
))

OR
--BPK
( Pt.PartnerNo = 700002 AND Pr.ProductNo BETWEEN 3050 AND 3099 AND 
(
	(A.CustomerReference = 'BPK Abwicklungskonto CS' AND Tx.TextShort LIKE 'BPK_% CS %')
))

OR
--AWI
(Pt.PartnerNo = 700218 AND Pr.ProductNo BETWEEN 3100 AND 3149 AND 
(
	(A.CustomerReference = 'AWI Abwicklungskonto CS' AND Tx.TextShort LIKE 'AWI_% CS %')
))

OR
--SVE
(Pt.PartnerNo = 700226 AND Pr.ProductNo BETWEEN 3150 AND 3199 AND 
(
	(A.CustomerReference = 'SVE Abwicklungskonto UBS' AND Tx.TextShort LIKE 'SVE_% UBS %')
))

OR
--JJS
(Pt.PartnerNo = 700225 AND Pr.ProductNo BETWEEN 3200 AND 3249 AND 
(
	(A.CustomerReference = 'JJS Abwicklungskonto UBS' AND Tx.TextShort LIKE 'JJS_% UBS %')
))

OR
--IST
(Pt.PartnerNo = 700277 AND Pr.ProductNo BETWEEN 3350 AND 3399 AND 
(
	(A.CustomerReference = 'IST Abwicklungskonto ZKB' AND Tx.TextShort LIKE 'IST_% ZKB %')
))
