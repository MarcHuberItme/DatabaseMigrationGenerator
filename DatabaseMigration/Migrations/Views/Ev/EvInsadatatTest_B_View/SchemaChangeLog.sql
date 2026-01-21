--liquibase formatted sql

--changeset system:create-alter-view-EvInsadatatTest_B_View context:any labels:c-any,o-view,ot-schema,on-EvInsadatatTest_B_View,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvInsadatatTest_B_View
CREATE OR ALTER VIEW dbo.EvInsadatatTest_B_View AS
SELECT 	Id, FileName, Recordnumber, Record, BCD, TextCode, TransArt, KdNru, KtNru, GegNru, BasisPreis, KontraktGr, ValNr, ValAnrecht, Stueck, Kurs, 
	KurswAWrg, MarchAWrg, CourtAWrg, StGebAWrg, SpeseAWrg, NettoAWrg, AWrg, ChAWrgKto, NettoKWrg, KWrg, ChAWrgSfr, NettoSfr, BDatum, Valuta, ValZus, SortKey, ImportRemarks
FROM 	EvInsadatatTest
WHERE	TransArt = 'B'
