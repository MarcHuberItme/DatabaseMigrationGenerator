--liquibase formatted sql

--changeset system:create-alter-view-CoEinzelWbMonthView context:any labels:c-any,o-view,ot-schema,on-CoEinzelWbMonthView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoEinzelWbMonthView
CREATE OR ALTER VIEW dbo.CoEinzelWbMonthView AS
select
akt.collno ,
akt.wbdescription , akt.WBPartnerNo,
akt.actflag ,
akt.dayendflag ,
akt.monthendflag ,
akt.quartendflag ,
akt.mevyear ,
akt.mevmonth ,
akt.ownerid ,
akt.ptdescription ,
akt.accountnoedited ,
akt.veragrp ,   
akt.veradate ,   
akt.veradateshort ,   
akt.limit ,   
akt.debitbalance ,   
akt.deckungswertohnewb ,   
akt.currency ,   
akt.limitkw ,   
akt.debitbalancekw ,   
akt.exflag ,   
akt.wbassigned ,   
akt.productid ,   
akt.producttext ,   
akt.collateralid ,   
akt.accountid ,   
akt.coveradetid ,   
akt.allowanceamount ,   
akt.accrualsamount ,   
akt.riskamount  
 from CoEinzelWbview as akt where 
(monthendflag = 1) 

