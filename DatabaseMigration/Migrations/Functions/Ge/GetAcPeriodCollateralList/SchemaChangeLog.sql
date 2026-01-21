--liquibase formatted sql

--changeset system:create-alter-function-GetAcPeriodCollateralList context:any labels:c-any,o-function,ot-schema,on-GetAcPeriodCollateralList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetAcPeriodCollateralList
CREATE OR ALTER FUNCTION dbo.GetAcPeriodCollateralList
(@AccPeriod int)
RETURNS @AcPeriodCollateralList  TABLE
(
AccountancyPeriod int not null, 
HypoGroup nvarchar(25) null, 
HypoObjType tinyint  null,
CollateralType nvarchar(25) null,
PartnerNo decimal (8,0) null,
AccountNo decimal(11,0) null,
AccountNoEdited nvarchar(20) null,
DomicileCountry nvarchar(2) null,
InterestRate decimal (19,6) null,
ValueProductCurrency money null,
ValueBasicCurrency money null,
RefCurrency char(3) null,
ProductNo int null,
ProductTextG nvarchar(25) null,
CollateralCompTypeNo int null,
CompTypeTextG nvarchar(25) null,
UnclaimedLoanLimit money null,
Limit money null,
SecurityLevelNo tinyint null,
SecLevelTextG nvarchar(25) null,
BranchNo int null,
MgSachb tinyint null,
MigSachbText nvarchar(10) null,
Town nvarchar(30) null,
PriorityOflegalReporting int null,
CounterValue int null,
HdCreateDate datetime null,
EvaluationDate datetime null,
VirtualDate datetime null
)
AS
Begin

DECLARE @DateFrom DATETIME
DECLARE @DateTo DATETIME

SET @DateFrom = Str(@AccPeriod) + '01' 
SET @DateTo = DATEADD(month,1,@DateFrom) - 0.000001	


insert into @AcPeriodCollateralList
SELECT ac2.AccountancyPeriod
		, 'HypoGroup' = 
			CASE
				WHEN ac2.PrivateProductNo BETWEEN '3001' AND '3009' 	THEN '01 Produkte 3001-3009'				
				WHEN ac2.PrivateProductNo IN ('3020','3024') 			THEN '02 Produkte 3020,3024'
				WHEN ac2.PrivateProductNo IN ('3040','3044') 			THEN '03 Produkte 3040,3044'
				WHEN ac2.PrivateProductNo IN ('3045','3046') 			THEN '04 Produkte 3045,3046'
				ELSE '04 Rest'
			END 
		, ISNULL(x.HypoObjTyp,0) As HypoObjType
		, 'CollateralType' = 
			CASE 
				WHEN ppct.PriorityOfLegalReporting LIKE '30%' THEN '01 Grundpfand'
				WHEN ppct.PriorityOfLegalReporting LIKE '32%' THEN '02 Faustpfand'
				WHEN ppct.PriorityOfLegalReporting LIKE '34%' THEN '03 Bürgschaft'
				WHEN ppct.PriorityOfLegalReporting LIKE '38%' THEN '04 Blanko'
				WHEN ppct.PriorityOfLegalReporting LIKE '37%' THEN '05 BlankoWB'
				WHEN ppct.PriorityOfLegalReporting LIKE '79%' THEN '06 Ueberzogen'
				ELSE '07 Rest'
			END
		, ptb.PartnerNo, /*pad.ReportAdrLine,*/ pab.AccountNo, pab.AccountNoEdited
		, SubString(ac2.KeyString, 47, 2) As DomicileCountry, SubString(ac2.KeyString, 171, 10) As InterestRate, 
--		, ac2.ValueProductCurrency As Ktowhg
 ac2.ValueProductCurrency 
, ac2.ValueBasicCurrency, ref.Currency As RefCurrency, ac2.PrivateProductNo As ProductNo
		, ast.TextShort As ProductTextG, SubString(ac2.KeyString, 149, 7) As CollateralCompTypeNo, ast1.TextShort As CompTypeTextG
		, ac2.UnclaimedLoanLimit 
--		, CASE WHEN ac2.PrivateCompTypeNo <> 15 THEN (ac2.ValueProductCurrency - ac2.UnclaimedLoanLimit) END As Limite
		, CASE WHEN ac2.PrivateCompTypeNo <> 15 THEN (ac2.ValueBasicCurrency - ac2.UnclaimedLoanLimit) END As Limit
		, ppsl.SecurityLevelNo, ast2.TextShort As SecLevelTextG, ptb.BranchNo, ptb.MgSachb, MgA02.Text as MigSachbText, AsBranch.Town, ppct.PriorityOflegalReporting
		, ac2.CounterValue,ac2.HdCreateDate,ac2.EvaluationDate,ac2.VirtualDate
FROM	AcCompression2 ac2 
JOIN	PrReference ref ON ref.id = ac2.PrReferenceId
JOIN	PrPrivate ppr ON ppr.ProductId = ref.ProductId 
JOIN	Astext ast ON ast.MasterId = ppr.id and ast.LanguageNo = 2
LEFT OUTER JOIN PrPrivateCompType ppct ON ppct.CompTypeNo = ac2.PrivateCompTypeNo
LEFT OUTER JOIN	PrPrivateSecurityLevel ppsl ON ppsl.SecurityLevelNo = ppct.SecurityLevelNo
JOIN	Astext ast1 ON ast1.MasterId = ppct.id and ast1.LanguageNo = 2 
LEFT OUTER JOIN	Astext ast2 ON ast2.MasterId = ppsl.id and ast2.LanguageNo = 2
JOIN	PtAccountBase pab ON pab.id = ref.AccountId 
JOIN	PtPortfolio ppf ON ppf.id = pab.PortfolioId 
JOIN	PtBase ptb ON ptb.id = ppf.PartnerId 
--JOIN	PtAddress pad ON pad.PartnerId = ptb.id and pad.AddressTypeNo = 11 
LEFT OUTER JOIN MgA02  ON Ptb.MgSachb = MgA02.MigValue
LEFT OUTER JOIN AsBranch ON Ptb.BranchNo = AsBranch.BranchNo 
LEFT OUTER JOIN PtBusinessType pbt ON pbt.NogaCode = ptb.BusinessTypeCode
LEFT OUTER JOIN MgA21 ON MgA21.MigValue = pab.MgObjekt
------

LEFT OUTER JOIN

(
-- Objekttyp pro Konto mit höchster Limite (<> MgOBJTYP Null bzw 0) holen
SELECT DISTINCT prp.ProductNo, pab.AccountNo, Min(pac.MgOBJTYP) As HypoObjTyp
FROM PtAccountComposedPrice pacp
INNER JOIN PtAccountComponent pac ON pacp.AccountComponentId = pac.Id 
INNER JOIN PtAccountBase pab ON pac.AccountBaseId = pab.Id
INNER JOIN PrReference prr ON pab.Id = prr.AccountId
INNER JOIN PrPrivate prp ON prr.ProductId = prp.ProductId
INNER JOIN (
			SELECT pab.AccountNo, Max(pacp.Value) As ValueMax
			FROM PtAccountComposedPrice pacp
			INNER JOIN PtAccountComponent pac ON pacp.AccountComponentId = pac.Id 
			INNER JOIN PtAccountBase pab ON pac.AccountBaseId = pab.Id
			INNER JOIN PrReference prr ON pab.Id = prr.AccountId
			INNER JOIN PrPrivate prp ON prr.ProductId = prp.ProductId
			WHERE prp.ProductNo BETWEEN 3001 AND 3999
			AND pacp.Value <> 0
			AND pac.MgOBJTYP IS NOT NULL
			AND pac.IsOldComponent = 0
			GROUP BY pab.AccountNo
			) y 
ON pab.AccountNo = y.AccountNo AND pacp.Value = y.ValueMax
WHERE prp.ProductNo BETWEEN 3001 AND 3999
AND pab.TerminationDate IS NULL
AND pab.OpeningDate <= @DateTo
AND pacp.Value <> 0
AND pac.MgOBJTYP IS NOT NULL
AND pac.IsOldComponent = 0
GROUP BY prp.ProductNo, pab.AccountNo
) x ON pab.AccountNo = x.AccountNo

------

WHERE ac2.AmountType = '1' 
AND ac2.AccountancyPeriod = @AccPeriod
AND ac2.PrivateProductNo BETWEEN '3001' and '3999'
AND SubString(ac2.KeyString, 171, 10) NOT LIKE '%---%'
AND pab.TerminationDate is null

	RETURN
END
