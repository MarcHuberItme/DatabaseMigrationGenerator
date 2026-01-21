--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenOwnSecurityReportView context:any labels:c-any,o-view,ot-schema,on-AcFrozenOwnSecurityReportView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenOwnSecurityReportView
CREATE OR ALTER VIEW dbo.AcFrozenOwnSecurityReportView AS
SELECT SB.HdChangeUser,
SB.HdChangeDate,
SB.ReportDate,
SB.PortfolioNo,
SB.Quantity,
SB.MaturityDate,
SB.InterestRate,
SB.IsinNo,
SB.FundCatSchemeCode,
TxPFCS.TextShort AS FundCatSchemeCodeText,
SB.SecurityType,
TxPST.TextShort AS SecurityTypeText,
SB.RankingNo,
TxPR.TextShort AS RankingNoText,
SB.OwnSecurityValueHoCu,
SB.InstrPartnerNo,
SB.InstrPtAdrLine,
SB.InstrCanton,
ISNULL(BC.ArCode + ' ' + BC.BankName, FP.PtDescription) AS InstrLargeExpGroupText,
SB.MappingTypeNo,
TxFMT.TextShort AS MappingTypeNoText,
SB.MappingFireAccountNo, 
TxFA.TextLong AS MappingFireAccountNoText,
SB.Currency,
SB.FireStockExListingCode,
TxFLC.TextShort AS FireStockExLisingText,
SB.IssuerCodeC510,
TxFC510.TextLong AS IssuerCodeC510Text,
SB.IssuerPartnerNo,
SB.TimeUnitNo,
TxPTU.TextShort AS TimeUnitNoText,
SB.InterestTypeNo,
SB.AccruedInterestHoCu,
SB.CodeC541,
PDV.LongName,
SB.DepositTypeForFire,
TxFDT.TextShort AS DepositTypeForFireText,
SB.CodeC520,
TxC520.TextLong AS CodeC520Text,
Lang.LanguageNo,Pf.CustomerReference
FROM AcFrozenSecurityView AS SB
INNER JOIN AcFireMappingPortfolio AS FMP ON SB.PortfolioId = FMP.PortfolioId
INNER JOIN AcFireMappingDepositType AS FMDT ON SB.DepositTypeForFire = FMDT.DepositTypeNo AND FMP.FireMappingType = FMDT.MappingTypeNo
INNER JOIN AsLanguage AS Lang ON Lang.HdVersionNo BETWEEN 1 AND 999999998
LEFT OUTER JOIN PrPublicDescriptionView AS PDV ON SB.ProductId = PDV.ProductId AND PDV.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN PrPublicFundCatScheme AS PFCS ON SB.FundCatSchemeCode = PFCS.FundCatSchemeCode
LEFT OUTER JOIN AsText AS TxPFCS ON PFCS.Id = TxpFCS.MasterId AND TxPFCS.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN PrPublicSecurityType AS PST ON SB.SecurityType = PST.SecurityType
LEFT OUTER JOIN AsText AS TxPST ON PST.Id = TxPST.MasterId AND TxPST.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN PrPublicTimeUnit AS PTU ON SB.TimeUnitNo = PTU.TimeUnitNo
LEFT OUTER JOIN AsText AS TxPTU ON PTU.Id = TxPTU.MasterId AND TxPTU.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AcFireDepositType AS FDT ON SB.DepositTypeForFire = FDT.DepositTypeNo
LEFT OUTER JOIN AsText AS TxFDT ON FDT.Id = TxFDT.MasterId AND TxFDT.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN PrPublicRanking AS PR ON SB.RankingNo = PR.RankingNo
LEFT OUTER JOIN AsText AS TxPR ON PR.Id = TxPR.MasterId AND TxPR.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AcFireC510 AS FC510 ON SB.IssuerCodeC510 = FC510.C510Code
LEFT OUTER JOIN AsText AS TxFC510 ON FC510.Id = TxFC510.MasterId AND TxFC510.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AcBankCounterparty AS BC ON SB.InstrLargeExpGroupNo = BC.ArCode
LEFT OUTER JOIN PtDescriptionView AS FP ON SB.InstrLargeExpGroupNo = CAST(FP.PartnerNo AS VARCHAR(10)) 
LEFT OUTER JOIN AcFireMappingType AS FMT ON SB.MappingTypeNo = FMT.MappingTypeNo
LEFT OUTER JOIN AsText AS TxFMT ON FMT.Id = TxFMT.MasterId AND TxFMT.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AcFireAccount AS FA ON SB.MappingFireAccountNo = FA.AccountNo
LEFT OUTER JOIN AsText AS TxFA ON FA.Id = TxFA.MasterId AND TxFA.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AcFireStockExListing AS FLC ON SB.FireStockExListingCode = FLC.ListingCode
LEFT OUTER JOIN AsText AS TxFLC ON FLC.Id = TxFLC.MasterId AND TxFLC.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN AcFireC520 AS C520 ON SB.CodeC520 = C520.Code 
LEFT OUTER JOIN AsText AS TxC520 ON C520.Id = TxC520.MasterId AND TxC520.LanguageNo = Lang.LanguageNo
LEFT OUTER JOIN PtPortfolio AS Pf ON SB.PortfolioId = Pf.Id
WHERE FMDT.MappingTypeNo IS NOT NULL
AND CAST(Lang.LanguageNo AS VARCHAR(10)) IN 
(SELECT Value FROM AsParameterView WHERE ParameterName = 'DefaultLanguage' AND GroupName = 'PrintingSystem')
