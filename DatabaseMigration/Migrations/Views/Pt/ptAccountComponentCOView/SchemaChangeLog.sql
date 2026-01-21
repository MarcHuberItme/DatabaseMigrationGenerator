--liquibase formatted sql

--changeset system:create-alter-view-ptAccountComponentCOView context:any labels:c-any,o-view,ot-schema,on-ptAccountComponentCOView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ptAccountComponentCOView
CREATE OR ALTER VIEW dbo.ptAccountComponentCOView AS
Select	a1.Id
		, a1.HdCreateDate
		, a1.HdEditStamp
		, a1.HdStatusFlag
		, a1.HdPendingChanges
		, a1.HdPendingSubChanges
		, a1.HdVersionNo
		, a1.HdProcessId
		, k1.collclean
		, null as veragrp
		, null as originaccountcomponentid
		, a1.ContractBaseId
		, a1.AccountBaseId
		, a1.PrivateComponentId
		, a1.PrivateCompTypeId
		, a1.PriorityOfInterestCalculation
		, a1.PriorityOfPayback
		, a1.PriorityOfLegalReporting
		, a1.IsOldComponent
		, a1.Duration
		, a1.DurationTypeId
		, a1.PrivateCompCharacteristicNo
		, a1.Remark
		, a1.MgVBNR
		, a1.MgVBSUBKTNR
		, a1.MgLIMITE
		, a1.MgVERKWERT
		, a1.MgDECKWERT
		, a1.MgRANG
		, a1.MgVORGANG
		, a1.MgVERFALL
		, a1.MgBEMERKUNG
		, a1.MgGBNR
		, a1.MgOBJPLZ
		, a1.MgOBJPLZZUSATZ
		, a1.MgOBJTYP
		, a1.MgVWDATUM
		, a1.MgVWART
		, a1.MgANLGWERT
		, a1.MgVARLIM
		, a1.MgMAXLIMITE
		, a1.MgTOLERANZ
		, a1.MgVrxKey
		, a1.MgReactivation
FROM	PtAccountComponent a1 
JOIN	PtAccountBase k1 ON a1.accountbaseid = k1.id 
			AND a1.HdVersionNo <999999999
JOIN	PrPrivateCompType T ON a1.PrivateCompTypeId =T.Id 
			AND T.HdVersionNo<999999999 
			AND (k1.collclean = 0 Or (K1.CollClean=1 And T.SecurityLevelNo<>99))
UNION ALL
SELECT	a2.Id
		, a2.HdCreateDate
		, a2.HdEditStamp
		, a2.HdStatusFlag
		, a2.HdPendingChanges
		, a2.HdPendingSubChanges
		, a2.HdVersionNo
		, a2.HdProcessId
		, k2.collclean
		, a2.veragrp
		, a2.originaccountcomponentid
		, null as ContractBaseId
		, a2.AccountBaseId
		, a2.PrivateComponentId
		, a2.PrivateCompTypeId
		, a2.PriorityOfInterestCalculation
		, a2.PriorityOfPayback
		, a2.PriorityOfLegalReporting
		, a2.IsOldComponent
		, a2.Duration
		, a2.DurationTypeId
		, a2.PrivateCompCharacteristicNo
		, a2.Remark
		, null as MgVBNR
		, null as MgVBSUBKTNR
		, null as MgLIMITE
		,(
		SELECT	SUM(RV.LendingLimit)
		FROM	ReValuation RV
		JOIN	CoBaseCalc CBC on CBC.PremisesId = RV.PremisesId
		JOIN	CoBaseasscalc CBAC on CBAC.Cobasecalcid = CBC.Id
		WHERE	CBAC.Veragrp = a2.VeraGrp
		AND		a2.PrivateCompTypeId in		(
											SELECT	Id
											FROM	PrPrivateCompType
											WHERE	CompTypeNo in (CBC.CompTypeNoV, CBC.CompTypeNoF)
											)
		AND		CBAC.AccountId = a2.AccountBaseId
		AND		RV.Id =	(
						SELECT	TOP (1) RV2.Id
						FROM	ReValuation RV2
						WHERE	RV2.PremisesId = CBC.PremisesId
						AND		RV2.HdVersionNo < 999999999
						AND		RV2.ValuationStatusCode = 3
						ORDER	BY RV2.ValuationDate DESC
						)
		) as MgVERKWERT
		, null as MgDECKWERT
		, null as MgRANG
		, null as MgVORGANG
		, null as MgVERFALL
		, null as MgBEMERKUNG
		, null as MgGBNR
		, (
		SELECT	TOP (1) PREM.Zip
		FROM	RePremises PREM
		JOIN	CoBaseCalc CBC on CBC.PremisesId = PREM.Id
		JOIN	CoBaseAssCalc CBAC on CBAC.Cobasecalcid = CBC.Id
		WHERE	CBAC.Veragrp = a2.VeraGrp
		AND		a2.PrivateCompTypeId in		(
											SELECT	Id
											FROM	PrPrivateCompType
											WHERE	CompTypeNo in (CBC.CompTypeNoV, CBC.CompTypeNoF)
											)
		AND		CBAC.AccountId = a2.AccountBaseId
		) as MgOBJPLZ
		, null as MgOBJPLZZUSATZ,

		(SELECT			TOP 1 'MgOBJTYP' =
						CASE 
						WHEN   (BC.Copremresult = 10 AND PREM.PremisesType = 1)      --EFH, STWG und PremisesType = EFH
						THEN   1                                                     --Einfamilienhaus
						WHEN   (BC.Copremresult = 10 AND PREM.PremisesType in (2,4)) --EFH, STWG und PremisesType = STWE
						THEN   3                                                     --STWE Wohnung
						WHEN   BC.Copremresult = 20                                  --MFH
						THEN   2                                                     --Mehrfamilienhaus
						WHEN   BC.Copremresult = 30                                  --Ferienhaus
						THEN   12                                                    --Ferienhaus
						WHEN   BC.Copremresult = 40                                  --Büro- und Geschäftshäuser
						THEN   5                                                     --Büro-/Geschäftshaus
						WHEN   BC.Copremresult = 50                                  --gemischter Wohnbau
						THEN   4                                                     --Gemischter Wohnbau
						WHEN   BC.Copremresult = 60                                  --Gewerbliche Objekte
						THEN   6                                                     --Gewerbliche Baute
						WHEN   BC.Copremresult = 70                                  --Industriebauten gross
						THEN   10                                                    --Industrie / Grossgewerbe
						WHEN   BC.Copremresult = 75                                  --Lagerhäuser
						THEN   6                                                     --Gewerbliche Baute
						WHEN   BC.Copremresult = 80                                  --Restaurants, Hotels
						THEN   9                                                     --Restaurant / Hotel
						WHEN   BC.Copremresult = 90                                  --Landw. Liegenschaft
						THEN   8                                                     --Landwirtschaftliches Objekt
						WHEN   BC.Copremresult = 95                                  --Bauland
						THEN   11                                                    --Bauland
						WHEN   (BC.Copremresult in (100, 101, 102, 103, 104, 105, 106)
										AND PREM.PremisesType = 1)                    --Individuelles Wohnen und PremisesType = EFH
						THEN   1                                                      --Einfamilienhaus
						WHEN   (BC.Copremresult in (100, 101, 102, 103, 104, 105, 106)
										AND PREM.PremisesType in (2,4))               --Individuelles Wohnen 50/20 und PremisesType = STWE
						THEN   3                                                      --STWE Wohnung
						WHEN   (BC.Copremresult in (100, 101, 102, 103, 104, 105, 106)
										AND PREM.PremisesType not in (1,2,4))         --Individuelles Wohnen 50/20 und PremisesType weder EFH noch STWE (sehr unwahrscheinlich)
						THEN   49                                                     --übrige Objekte
						WHEN   BC.Copremresult = 110                                  --Bauland für Wohnliegenschaften
						THEN   11                                                     --Bauland
						WHEN   BC.Copremresult = 115                                  --Bauland (nicht Wohnliegenschaften)
						THEN   11                                                     --Bauland
						WHEN   (BC.Copremresult in (120, 121, 122, 123, 124, 125)
										AND PREM.PremisesType = 3)                    --übrige Objekte individuell und PremisesType = MFH
						THEN   2                                                      --Mehrfamilienhaus
						WHEN   (BC.Copremresult in (120, 121, 122, 123, 124, 125)
										AND PREM.PremisesType = 5)                    --übrige Objekte individuell und PremisesType = gemischter Wohnbau
						THEN   4                                                      --gemischter Wohnbau
						WHEN   (BC.Copremresult in (120, 121, 122, 123, 124, 125)
										AND PREM.PremisesType = 6)                    --übrige Objekte individuell und PremisesType = Landwirtschaft
						THEN   8                                                      --Landwirtschaftliche Objekte
						WHEN   (BC.Copremresult in (120, 121, 122, 123, 124, 125)
										AND PREM.PremisesType = 7)                    --übrige Objekte individuell und PremisesType = Land
						THEN   11                                                     --Bauland
						WHEN   (BC.Copremresult in (120, 121, 122, 123, 124, 125)
										AND PREM.PremisesType = 9)                    --übrige Objekte individuell und PremisesType = Gewerbe/Industrie/Büro/Verkauf
						THEN   6                                                      --gewerbliche Baute
						WHEN   (BC.Copremresult in (120, 121, 122, 123, 124, 125)
										AND PREM.PremisesType not in (3, 5, 6, 7, 9)) --übrige Objekte individuell und PremisesType = EFH oder STWE oder übrige Objekte
						THEN   49                                                     --übrige Objekte
						WHEN   BC.Copremresult = 130                                  --Zugehör
						THEN   49                                                     --übrige Objekte
						WHEN   (BC.Copremresult = 150 and PREM.PremisesType = 1)      --EFH, STWE > 80% und PremisesType = EFH
						THEN   1                                                      --Einfamilienhaus
						WHEN   (BC.Copremresult = 150 and PREM.PremisesType in(2,4))  --EFH, STWE > 80% und PremisesType = STWE
						THEN   3                                                      --STWE
						WHEN   BC.Copremresult = 151                                  --MFH > 80%
						THEN   2                                                      --Mehrfamilienhaus
						WHEN   BC.Copremresult = 152                                  --Ferienhaus > 70%
						THEN   12                                                     --Ferienhaus
						WHEN   BC.Copremresult = 153                                  --Büro und Geschäft > 70%
						THEN   5                                                      --Büro-/Geschäftshaus
						WHEN   BC.Copremresult = 154                                  --gemischter Wohnbau > 80%
						THEN   4                                                      --gemischter Wohnbau
						WHEN   BC.Copremresult = 155                                  --gewerbliche Objekte > 70%
						THEN   6                                                      --gewerbliche Baute
						WHEN   BC.Copremresult = 156                                  --Industrie > 60%
						THEN   10                                                     --Industrie / Grossgewerbe
						WHEN   BC.Copremresult = 157                                  --Lagerhäuser > 60%
						THEN   6                                                      --gewerbliche Baute
						WHEN   BC.Copremresult = 158                                  --Restaurants > 70%
						THEN   9                                                      --REstaurant / Hotel
						WHEN   BC.Copremresult = 159                                  --Bauland > 70%
						THEN   11                                                     --Bauland
						WHEN   BC.Copremresult = 910                                  --EFH Liquidationswert
						THEN   1                                                      --Einfamilienhaus
						WHEN   BC.Copremresult = 910                                  --EFH Liquidationswert
						THEN   1                                                      --Einfamilienhaus
						WHEN   BC.Copremresult = 920                                  --MFH Liquidationswert
						THEN   2                                                      --Mehrfamilienhaus
						WHEN   BC.Copremresult = 950                                  --gemischter Wohnbau Liquidationswert
						THEN   4                                                      --gemischter Wohnbau
						WHEN   BC.Copremresult = 960                                  --Gewerbe Liquidationswert
						THEN   6                                                      --gewerbliche Baute
						WHEN   BC.Copremresult = 970                                  --Industrie Liquidationswert
						THEN   10                                                     --Industrie / Grossgewerbe
						WHEN   BC.Copremresult = 995                                  --Bauland Liquidationswert
						THEN   11                                                     --Bauland
						ELSE   49                                                     --Rest in übrige
						END
		FROM         CoBaseCalc BC
		JOIN         CoBaseasscalc BAC on BAC.Cobasecalcid = BC.Id
		LEFT JOIN    RePremises PREM ON PREM.Id = BC.PremisesId
		WHERE        a2.veragrp = BAC.veragrp
		AND          a2.privatecomptypeid in (select id from PrPrivateCompType where CompTypeNo in (BC.CompTypeNoV, BC.CompTypeNoF))
		AND          BAC.accountid = a2.AccountBaseId)
		, (SELECT	TOP (1) RV.ValuationDate
		FROM	ReValuation RV
		JOIN	CoBaseCalc CBC on CBC.PremisesId = RV.PremisesId
		JOIN	CoBaseasscalc CBAC on CBAC.Cobasecalcid = CBC.Id
		WHERE	CBAC.Veragrp = a2.VeraGrp
		AND		a2.PrivateCompTypeId in		(
											SELECT	Id
											FROM	PrPrivateCompType
											WHERE	CompTypeNo in (CBC.CompTypeNoV, CBC.CompTypeNoF)
											)
		AND		CBAC.AccountId = a2.AccountBaseId
		AND		RV.Id =	(
						SELECT	TOP (1) RV2.Id
						FROM	ReValuation RV2
						WHERE	RV2.PremisesId = CBC.PremisesId
						AND		RV2.HdVersionNo < 999999999
						AND		RV2.ValuationStatusCode = 3
						ORDER	BY RV2.ValuationDate DESC
						)
		) as  MgVWDATUM
		, null as MgVWART
		, null as MgANLGWERT
		, null as MgVARLIM
		, null as MgMAXLIMITE
		, null as MgTOLERANZ
		, null as MgVrxKey
		, null as MgReactivation
FROM	CoPtAccountComponent a2
JOIN	PtAccountBase k2 ON k2.Id = a2.AccountBaseId
WHERE	k2.collclean = 1

