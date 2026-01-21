--liquibase formatted sql

--changeset system:create-alter-view-PtPortfolioSOKOKonsView context:any labels:c-any,o-view,ot-schema,on-PtPortfolioSOKOKonsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPortfolioSOKOKonsView
CREATE OR ALTER VIEW dbo.PtPortfolioSOKOKonsView AS
SELECT TOP 100 PERCENT
       PfBase.Depot_Nr, PfBase.Partnerbezeichnung
	 , PfBase.Depot_Art, PfBase.Depot_Bez, PfBase.Wrg, PfBase.SBCode, PfBase.Sachbearbeiter
	 , Satz = convert(nvarchar(10),cast(100 - PfBase.VA_Satz as int)) + ' %'
	 , Rebate = convert(nvarchar(10),cast(PfBase.VA_Satz as int)) + ' %'
     , Depotgeb_Satz = convert(nvarchar(10),cast(100 - PfBase.Depotgeb_Satz as int)) + ' %'
	 , Depotgeb_Rebate = convert(nvarchar(10),cast(PfBase.Depotgeb_Satz as int)) + ' %'
     , StockEx_Satz =	case when isnull(LevelTariff,'') not in ('','0','0.00') then LevelTariff 
							 when isnull(LevelFixCharge,'') not in ('','0','0.00') then LevelFixCharge 
							 when isnull(PfBase.Rabatt_Flag,'') = '1' then 'Personal' end 
							 + isnull(' ' + case when isnull(IsTariffPercent,0) = 1 then '%' else AmountCurrency end,'')
	 , StockEx_Rebate = CASE WHEN PfBase.Rabatt = '' then PfBase.Rabatt else PfBase.Rabatt + ' %' end
     , PortfolioId, PartnerId
	 , VA_ValidFrom = isnull(VA_ChangeDate,HdCreateDate)
	 , Depot_ValidFrom = isnull(Depot_ChangeDate,HdCreateDate)
	 , StockEx_ValidFrom = isnull(StockEx_ChangeDate,HdCreateDate)
	 , isnull(MarketValueCHF,0) AS MarketValueCHF
	 , PfBase.Personal, PfBase.Jugend
	 , Kommentar
FROM
(SELECT Pf.PortfolioNo AS Depot_Nr, PtAddress.ReportAdrLine AS Partnerbezeichnung,
		Geb_Datum = Case When Ptb.DateOfBirth IS NOT NULL THEN LEFT(CONVERT(CHAR,Ptb.DateOfBirth,104),10) ELSE LEFT(CAST(' ' as char),10) END,
		Pf.PortfolioTypeNo AS Depot_Art, T.TextShort AS Depot_Bez, Pf.Currency AS Wrg, 
		Pf.AssetChargeRebate AS VA_Satz,Pf.DepotChargeRebate AS Depotgeb_Satz,
		Ptb.ConsultantTeamName as SBCode, T2.TextShort AS Sachbearbeiter, 
		Personal = CASE WHEN pub.RankNo IS NULL THEN 'Nein' ELSE 'Ja' END,
		Jugend = CASE WHEN pf.PortfolioTypeNo <> 5006 THEN 'Nein' ELSE 'Ja' END,
		T1.TextShort AS Rang,
	    PortfolioId = Pf.Id, Pf.PartnerId, AH_VA.ChangeDate as VA_ChangeDate, AH_Depot.ChangeDate as Depot_ChangeDate,
		AH_StockEx.ChangeDate as StockEx_ChangeDate, Pf.HdCreateDate, 
        Rabatt = CASE WHEN St.TransSxRebateNo IS NULL Then Char('') ELSE Cast(St.TransSxRebateNo AS Char(3)) END,
		Rabatt_Flag = CASE WHEN pub.HasStaffRebate IS NULL Then Char('') ELSE Cast(pub.HasStaffRebate AS Char(1)) END,
		Tarif_Nr = CASE WHEN St.TariffNo IS NULL THEN Char('') ELSE Cast(St.TariffNo AS Char(4)) END,
		st.TransSxRebateNo,
		CalculationUnit = convert(nvarchar(10),PTST.CalculationUnit),PTST.IsTariffPercent,
		MinAmount=convert(nvarchar(10),PTSTS.MinAmount),LevelTariff=convert(nvarchar(10),PTSTS.LevelTariff),
		LevelFixCharge=convert(nvarchar(10),PTSTS.LevelFixCharge), PTST.AmountCurrency,
		Eval.MarketValueCHF AS MarketValueCHF,
		T0.TextLong AS Tarifbezeichnung, PCR.Text AS Kommentar
FROM	PtPortfolio Pf
		JOIN PtPortfolioType PfT       ON Pf.PortfolioTypeNo = PfT.PortfolioTypeNo 
		JOIN AsText T                  ON PfT.Id = T.MasterId AND T.LanguageNo = 2
		JOIN PtBase Ptb                ON Ptb.Id = Pf.PartnerId 
		JOIN PtAddress                 ON Pf.PartnerId = PtAddress.PartnerId 
		LEFT JOIN PtPortfolioSxTariff St ON Pf.SxSpecialTariffId = St.Id
		LEFT JOIN PtTransSxTariff PTST ON PTST.TariffNo = st.TariffNo
		LEFT JOIN PtTransSxTariffScale PTSTS on PTSTS.TariffId = PTST.Id
		LEFT JOIN AsText T0 ON St.Id = T0.MasterId AND T0.LanguageNo = 2
		LEFT JOIN PtUserBase  pub      ON Pf.PartnerId = Pub.PartnerId and pub.leavingDate is Null
		LEFT JOIN PtUserTimeRank       ON pub.RankNo = PtUserTimeRank.RankNo
		LEFT JOIN AsText T1            ON PtUserTimeRank.Id = T1.MasterId AND T1.LanguageNo = 2
		LEFT JOIN AsUserGroup aug      ON ptb.ConsultantTeamName = aug.UserGroupName
		LEFT JOIN AsText T2            ON aug.Id = T2.MasterId AND T2.LanguageNo = 2
		LEFT JOIN AsHistory AH_VA      ON AH_VA.Id = Pf.Id AND AH_VA.TableName = 'PtPortfolio' AND AH_VA.MutField like '%AssetChargeRebate%' AND Pf.AssetChargeRebate is not null
		                                  AND AH_VA.VersionNo = (select Top 1 VersionNo from AsHistory where Id = Pf.Id AND TableName = 'PtPortfolio' AND MutField like '%AssetChargeRebate%' order by VersionNo Desc)
		LEFT JOIN AsHistory AH_Depot   ON AH_Depot.Id = Pf.Id AND AH_Depot.TableName = 'PtPortfolio' AND AH_Depot.MutField like '%DepotChargeRebate%' AND Pf.DepotChargeRebate is not null
		                                  AND AH_VA.VersionNo = (select Top 1 VersionNo from AsHistory where Id = Pf.Id AND TableName = 'PtPortfolio' AND MutField like '%DepotChargeRebate%' order by VersionNo Desc)
		LEFT JOIN AsHistory AH_StockEx ON AH_StockEx.Id = Pf.Id and AH_StockEx.TableName = 'PtTransSxTariffScale'
		     AND (AH_StockEx.MutField like '%MinAmount%' or AH_StockEx.MutField like '%LevelTariff%' or AH_StockEx.MutField like '%LevelFixCharge%') and Pf.SxSpecialTariffId is not null
			 AND AH_VA.VersionNo = (select Top 1 VersionNo from AsHistory where Id = Pf.Id AND TableName = 'PtTransSxTariffScale' AND (MutField like '%MinAmount%' or MutField like '%LevelTariff%' or MutField like '%LevelFixCharge%') order by VersionNo Desc)
	    LEFT JOIN VaPublicView EVAL    ON Pf.Id = EVAL.PortfolioId AND EVAL.VaRunId = (Select Id from VaRun VR where  VR.ValuationDate = (select max(ValuationDate) from VaRun))
		LEFT JOIN PtContactReport PCR  ON PCR.PartnerId = Pf.PartnerId and PCR.TopicId = (select Id from AsContactTopic ACT where ACT.TopicNo = 188)
WHERE	PtAddress.AddressTypeNo = 11
		AND	isnull(Pf.TerminationDate,getdate()) >= getdate()
		AND	Pf.PortfolioTypeNo <> 5000
		AND (PfT.IsCustomer = 1  and PfT.IsBroker = 0 and PfT.IsEffectsTrader = 0)
		AND     ((Pf.AssetChargeRebate is not null AND PF.AssetChargeRebate > 0) OR (Pf.DepotChargeRebate is not null AND PF.DepotChargeRebate > 0) OR (Pf.SxSpecialTariffId IS NOT NULL OR pub.HasStaffRebate = 1))
)       as PfBase
