--liquibase formatted sql

--changeset system:create-alter-view-EvInsadatatTest_DK_View context:any labels:c-any,o-view,ot-schema,on-EvInsadatatTest_DK_View,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvInsadatatTest_DK_View
CREATE OR ALTER VIEW dbo.EvInsadatatTest_DK_View AS
SELECT 	Id, FileName, Recordnumber, Record, BCD, TextCode, TransArt, KdNru, KtNru, GegNru, BasisPreis, KontraktGr, ValNr, ValAnrecht, Stueck, Kurs, Marchzins, Spesen, DevKurs, 
	Courtage, UmsAbgabe, EBV, EndBetrag, BDatum, Valuta, DstNr, Sachb, AbrWrg, WrgEinheit, RechArt, ValZus, BetragSfr, SortKey, ImportRemarks
FROM 	EvInsadatatTest
WHERE	TransArt IN ('D', 'K')
