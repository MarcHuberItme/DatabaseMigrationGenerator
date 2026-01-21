--liquibase formatted sql

--changeset system:create-alter-view-CoVeraEndDay context:any labels:c-any,o-view,ot-schema,on-CoVeraEndDay,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoVeraEndDay
CREATE OR ALTER VIEW dbo.CoVeraEndDay AS
select coveradet.accountid,max(coveradet.veragrp) as veragrp,max(coveradet.veradate) as veradate,cast(coveradet.veradate as date) as veradatenotime 
from  coveradet,coveragrp
where 
coveradet.verabflag = 1 and 
coveradet.colworkingtype = 130 and 
coveradet.wheredowecamefrom = 0 and 
coveradet.veragrp = coveragrp.veragrp and 
coveragrp.verastat = 100
group by 
accountid, cast(coveradet.veradate as date)
