--liquibase formatted sql

--changeset system:create-alter-view-EvInsadatatTest_C_View context:any labels:c-any,o-view,ot-schema,on-EvInsadatatTest_C_View,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvInsadatatTest_C_View
CREATE OR ALTER VIEW dbo.EvInsadatatTest_C_View AS
SELECT 	Id, FileName, Recordnumber, Record, BCD, TextCode, TransArt, KdNru, KtNru, GegNru, BasisPreis, KontraktGr, ValNr, ValAnrecht, Stueck, Kurs, 
	Brutto, RueckEg, RueckSf, Steuer, Netto, ErtDat, EgWrg, Valuta, Sachb, WrgEinheit, RechArt, ValZus, SortKey, ImportRemarks
FROM 	EvInsadatatTest
WHERE	TransArt = 'C'
