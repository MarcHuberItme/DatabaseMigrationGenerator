--liquibase formatted sql

--changeset system:create-alter-view-coKreditView context:any labels:c-any,o-view,ot-schema,on-coKreditView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view coKreditView
CREATE OR ALTER VIEW dbo.coKreditView AS
select a.id as id1,a.partnerno as partnerno1,a.id as id2, a.partnerno as partno2,
/* gleicher partnernummer gefunden wird angezeigt */
 '1' as glnr
from ptbase a 
union 
select c.id as id1,c.partnerno as partnerno1,b.id as id2, b.partnerno as partnerno2,
(case when (c.id = b.id)
      then '1' 
      else '0'
end)
as glnr
from ptbase b,ptbase c
where (b.id in 
/* es wird geschaut, ob der selektierte Kreditnehmer noch weitere Kundennummer hat, abfrage ist mehrfach verschachtelt da Kundenummer unter Umständen mehrfach zugewiesen wurden */
(select coengclisameview.memberid  from coengclisameview where 
masterid in 
(select distinct masterid from coengclisameview where memberid in 
(select distinct memberid from coengclisameview where masterid in 
(select masterid from coengclisameview where memberid = c.id)))))
