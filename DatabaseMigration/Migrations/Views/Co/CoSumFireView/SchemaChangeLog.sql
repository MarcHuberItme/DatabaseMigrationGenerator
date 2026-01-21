--liquibase formatted sql

--changeset system:create-alter-view-CoSumFireView context:any labels:c-any,o-view,ot-schema,on-CoSumFireView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoSumFireView
CREATE OR ALTER VIEW dbo.CoSumFireView AS
/* 
Diese View stellt pro Deckungsausscheidung/Gesamtengagement (calcgrp) 
folgende Wert zur Verfügung:
- Den Wert der Sicherheit (covaluetot)
- Die Summe aller möglichen Belehnungen (sumpledgvalue)
- Die Summe aller zugewiesenen Belehnungen auf Kreditkonti (sumpledvalueassignd)
- Die Summe der noch freien Belehnungen (sumpledvaluefree)
- Den Faktor zwecks Berechnung prozentualer Anteil Verkehrswert im  Verhältnis zur aktuellen zugewiesene Belehnung / aller zugewiesen Belehnung (Beispiel siehe unten) für Fire

Zu diesem Zwecke werden die Sätze in COBASECALC summiert.
In Cobasecalc sind Sätze nach folgender Granularität vorhanden:

Kontosicherheit - einer 
Wertschriften - mehrere
Versicherungen - einer
Bürgschaft - einer 
Übrige - einer 
Grundpfand (Ein Schuldbrief)- mehrere pro Grundstück und Tranchen (durch Aufsplittung Kurant/unkurant und gemischtes Wohnen)


In dieser View werden Grundpfänder auf Grundstücke gruppiert, alle anderen Sicherheiten werden auf die Sicherheit selber gruppiert. 


Der Zugriff erfolgt bei Grundpfänder dann auch NUR mit der PremisesID ! (Ein Zugriff über die Collateralid vom Schuldbrief führt zu keinem Treffer)

Inhalt Feld Wert der Sicherheit (covaluetot), immer in CHF
Kontosicherheit - Kontosaldo
Wertschriften - Marktwert aller Titel
Versicherungen - Rückkaufwert
Bürgschaft - Bürgschaftsbetrag
Übrige - Betrag (aus Sicherheitenverwaltung)
Grundpfand (Ein Schuldbrief)- Verkehrswert vom jeweiligen Grundstück

Beispiel:
Schuldbrief (NR 100) mit einem Nominal 300'000 verweisend auf ein Grundstück mit Verkehrswert 1'000'0000
Kredit 300 mit 150'000 Saldo, zugewiesen auf Schuldbrief mit 150'000 
Kredit 301 mit  50'000 Saldo, zugewiesen auf Schuldbrief mit  50'000

Beispiel Kredit 300

200'000  (Summe aller zugewiesenen Belehnungen )       1'000'0000 (Verkehrswert Grundstück)
-------                                                                             =   ----------- 
150'000   Konrkete Zuweisung auf Kredit 300)                  VKAdjust  ( zu berechnen Verkehrswert adjustiert prozentual aufgeteilt)

Nach Formelnumwandlung haben wir das hier:
                  1'000'0000 (Verkehrswert Grundstück)
VKAdjust =   -----------                  * 150'000   (Zugeweisen auf Kredit 300)  
                    200'000  (Summe aller zugewiesenen Belehnungen )  

Kredit 300 mit 150'000 Saldo, zugewiesen auf Schuldbrief mit 150'000 , somit VKAdjust = 750'000
Kredit 301 mit  50'000 Saldo, zugewiesen auf Schuldbrief mit  50'000 , somit VKAdjust = 250'000

Zum Berechnen vom 
VKAdjust ( zu berechnen Verkehrswert prozentual aufgeteilt) = pledgevalueass (aus cobaseasscal) * vkadjustfak (aus dieser View)

Falls einzele Wertschriftenposition zusammen ein Collateral bilden gilt folgendes:

Martkwert aller Position                                                         Marktwert einer Position
------------------------------------                                                  =     -------------------------------------
Martkwert aller Position (adjustiert, siehe oben)                     Adjustierte Marktwert einer Position

Nach Formelumwandung haben wir das hier
                                                                                                              Martkwert aller Position (adjustiert, siehe oben) 
Adjustierte Marktwert einer Position = Marktwert einer Position *           ------------------------------------
                                                                                                              Martkwert aller Position 

Felder covaluetot und covalueint:

Applikatorisch wird sichergestellt, dass in alle Cobsacalc Sätze (nach der obigen Gruppierung) die gleichen Werte geladen werden. Sofern diese beiden Werte (min, max) unterschiedlich sind liegt ein Fehler vor, der abgeklärt werden muss...
*/
select   cobasecalc.calcgrp,
            max(cobasecalc.veragrp) as veragrp,
            cobasecalc.collateralid,
            max(cobasecalc.collno) as collno,
/*            (select Collno from cobase where id = cobasecalc.collateralid) as collno,*/
            null as PremisesId,
            null as gbdes,
            max(covaluetot) as covaluetot,
           sum(pledgevalue) as sumpledgevalue,
           sum(pledgevaluefree) as sumpledgevaluefree,
           sum(pledgevalue) - sum(pledgevaluefree) as sumpledgevalueass,
           case 
              when cast((sum(pledgevalue) - sum(pledgevaluefree)) AS real) <> 0
              then   
                 cast(max(covaluetot) as real) / cast((sum(pledgevalue) - sum(pledgevaluefree)) AS real) 
                else 0 
          end  as vkadjustfak,
           count(*) as sumrecords,
           min(covaluetot) as covalueint,
           case 
             when max(covaluetot) <> min(covaluetot)
             then 1
          else 0 
          end  as errorflag
          from cobasecalc ,coveradet
         where cobasecalc.PremisesId is null and  cobasecalc.collateralid is not null 
          and coveradet.collateralid = cobasecalc.collateralid 
          and coveradet.calcgrp = cobasecalc.calcgrp and coveradet.veragrp = cobasecalc.veragrp
          and coveradet.wheredowecamefrom = 0
         group by cobasecalc.calcgrp,cobasecalc.collateralid
union
        select 
        cobasecalc.calcgrp,
        max(cobasecalc.veragrp) as veragrp,
        null as collateralid,
        null as collno,
        PremisesId,
        (select ISNULL(RePremises.GBNo, 0)  + ' ' + ISNULL(RePremises.GBNoAdd, 0)
		 + ' ' + ISNULL(RePremises.GBPlanNo, 0)  + ' ' + ISNULL(RePremises.Town, '')  from RePremises
         where id =         PremisesId) as gbdes,
        max(covaluetot) as covaluetot,
        sum(pledgevalue) as sumpledgevalue,
        sum(pledgevaluefree) as sumpledgevaluefree,
        sum(pledgevalue) - sum(pledgevaluefree) as sumpledgevalueass,
           case 
              when cast((sum(pledgevalue) - sum(pledgevaluefree)) AS real) <> 0
              then   
                 cast(max(covaluetot) as real) / cast((sum(pledgevalue) - sum(pledgevaluefree)) AS real) 
                else 0 
          end  as vkadjustfak,
        count(*) as sumrecords,
        min(covaluetot) as covalueint,
       case 
          when max(covaluetot) <> min(covaluetot)
        then 1
       else 0
       end as errorflag
       from cobasecalc,coveradet
       where PremisesId is not null 
          and coveradet.collateralid = cobasecalc.collateralid and coveradet.calcgrp = cobasecalc.calcgrp and coveradet.veragrp = cobasecalc.veragrp
          and coveradet.wheredowecamefrom = 0
       group by cobasecalc.calcgrp,PremisesId
