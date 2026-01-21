--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenPtValueAndEarningView context:any labels:c-any,o-view,ot-schema,on-AcFrozenPtValueAndEarningView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenPtValueAndEarningView
CREATE OR ALTER VIEW dbo.AcFrozenPtValueAndEarningView AS
SELECT 
Pt.Id AS PartnerId,
Pt.PartnerNo AS PartnerNo, 
Pt.SexStatusNo,
Pt.LegalStatusNo,
Pt.NogaCode2008,
Pt.BranchNo,
Pt.TerminationDate,
Adr.ReportAdrLine,
St.Town,
FP.Canton,
Adr.CountryCode AS FiscalDomicileCountry,
Nationality,
Employees, 
ISNULL(FP.MainPartnerNo, Pt.PartnerNoText) AS MainPartnerNo, 
CRM.HdCreateDate,
CRM.BalanceDay,
CRM.DebitAmountHoCu,
CRM.CreditAmountHoCu,
CRM.PortfolioValueHoCu,
CRM.PortfolioAcruedInterestHoCu,
CRM.RecCount AS Account_Count,
CRM.EbankingAgr AS WithEbankingAgr,
CRM.RetainedMail,
CRM.OnlyEbankingDeliveryForAccount,
CRM.KO_ValueHoCu,
CRM.HBLN_Quantity,
CRM.Privor_ValueHoCu, 
CRM.Bonus_ValueHoCu,
CRM.Fonds_ValueHoCu,
CRM.Hypothek_ValueHoCu,
CRM.Vorschuss_ValueHoCu,
CRM.IsUSPerson,
CRM.HasCard,
CRM.WithW9,
CRM.WithEuInfoX,
CASE WHEN Pt.TerminationDate IS NULL THEN 0 ELSE 1 END AS Terminated,
CASE WHEN YearOfBirth = 0 THEN NULL ELSE YearOfBirth END AS YearOfBirth,
Ug.Description AS ConsultantTeam,
Ug.MainBranchNo AS ConsultantTeamBranchNo,
Tx_Ug.TextShort AS ConsultantTeamText,
ISNULL(Ug.IsCrossborderTeam,0) AS IsCrossborderTeam,
ISNULL(CB_List.IsCrossborderAllowed,0) AS IsCrossborderAllowed,
Court.AmountHoCu AS Earning_Courtage,
Depgeb.AmountHoCu AS Earning_DepositFee,
VaMandate.AmountHoCu AS Earning_AssetManagement,
Devisen.AmountHoCu AS Earning_Forex,
Treuhand.AmountHoCu AS Earning_TrustServices,
Steuern.AmountHoCu AS Earning_TaxServices,
Tresor.AmountHoCu AS Earning_SafeDeposit,
SollZinsen.AmountHoCu AS Earing_DebitInterests,
HabenZinsen.AmountHoCu AS Earning_CreditInterests,
Abschluss.AmountHoCu AS Earning_Closing,
Kassenobli.AmountHoCu AS Earning_OwnBonds,
Rest.AmountHoCu AS Earning_Others,
TotalErtrag.AmountHoCu AS Earning_Total,
Ug.Id AS ConsultantTeamId

FROM AcFrozenPtBalanceSummary AS CRM
LEFT OUTER JOIN PtBase AS Pt ON CRM.PartnerId = Pt.Id
LEFT OUTER JOIN PtAddress AS Adr ON Pt.Id = Adr.PartnerId AND Adr.AddressTypeNo = 11
LEFT OUTER JOIN AsBranch AS Br ON Pt.BranchNo = Br.BranchNo
LEFT OUTER JOIN AcFrozenPartnerView AS FP ON CRM.PartnerId = FP.PartnerId AND CRM.BalanceDay = FP.ReportDate
LEFT OUTER JOIN AsSwissTown AS St ON FP.SwissTownNo = St.SwissTownNo 
LEFT OUTER JOIN AsUserGroup AS Ug ON Pt.ConsultantTeamName = Ug.UserGroupName
LEFT OUTER JOIN AsText AS Tx_Ug ON Ug.Id = Tx_Ug.MasterId AND Tx_Ug.LanguageNo = 2
LEFT OUTER JOIN (SELECT DISTINCT EvalYear FROM AcFrozenPtEarningSummary) AS E_Year ON EvalYear > 0
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo = 1 GROUP BY EvalYear, PartnerId) AS Court ON CRM.PartnerId = Court.PartnerId AND Court.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo = 2 GROUP BY EvalYear, PartnerId) AS Depgeb ON CRM.PartnerId = Depgeb.PartnerId AND Depgeb.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo = 3 GROUP BY EvalYear, PartnerId) AS VaMandate ON CRM.PartnerId = VaMandate.PartnerId AND VaMandate.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo = 4 GROUP BY EvalYear, PartnerId) AS Devisen ON CRM.PartnerId = Devisen.PartnerId AND Devisen.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo = 5 GROUP BY EvalYear, PartnerId) AS Treuhand ON CRM.PartnerId = Treuhand.PartnerId AND Treuhand.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo = 6 GROUP BY EvalYear, PartnerId) AS Steuern ON CRM.PartnerId = Steuern.PartnerId AND Steuern.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo = 7 GROUP BY EvalYear, PartnerId) AS Tresor ON CRM.PartnerId = Tresor.PartnerId AND Tresor.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo = 8 GROUP BY EvalYear, PartnerId) AS SollZinsen ON CRM.PartnerId = SollZinsen.PartnerId AND SollZinsen.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo = 9 GROUP BY EvalYear, PartnerId) AS HabenZinsen ON CRM.PartnerId = HabenZinsen.PartnerId AND HabenZinsen.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo = 10 GROUP BY EvalYear, PartnerId) AS Abschluss ON CRM.PartnerId = Abschluss.PartnerId AND Abschluss.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo = 11 GROUP BY EvalYear, PartnerId) AS Kassenobli ON CRM.PartnerId = Kassenobli.PartnerId AND Kassenobli.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary WHERE CalcValueTypeNo > 11 GROUP BY EvalYear, PartnerId) AS Rest ON CRM.PartnerId = Rest.PartnerId AND Rest.EvalYear = E_Year.EvalYear 

LEFT OUTER JOIN (SELECT PartnerId, EvalYear, SUM(AmountHoCu) AS AmountHoCu FROM AcFrozenPtEarningSummary GROUP BY EvalYear, PartnerId) AS TotalErtrag ON CRM.PartnerId = TotalErtrag.PartnerId AND TotalErtrag.EvalYear = E_Year.EvalYear
LEFT OUTER JOIN (
	SELECT IsoCode, 1 AS IsCrossborderAllowed
	FROM AsGroupType AS AGT
	INNER JOIN AsGroupTypeLabel AS AGTL ON AGT.Id = AGTL.GroupTypeId
	INNER JOIN AsGroupMember AS AGM ON AGT.Id = AGM.GroupTypeId
	INNER JOIN AsGroupLabel AS AGL ON AGM.GroupId = AGL.GroupId
	INNER JOIN AsCountry AS AC ON AGM.TargetRowId = AC.Id
	WHERE AGT.TableName = 'AsCountry' AND AGTL.Name = 'Crossborder' AND AGL.Name = 'CrossborderAllowed'
	AND AGT.HdVersionNo BETWEEN 1 AND 999999998
	AND AGTL.HdVersionNo BETWEEN 1 AND 999999998
	AND AGM.HdVersionNo BETWEEN 1 AND 999999998) AS CB_List ON Adr.CountryCode = CB_List.IsoCode


