--liquibase formatted sql

--changeset system:create-alter-view-CoEngDetViewAcc context:any labels:c-any,o-view,ot-schema,on-CoEngDetViewAcc,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoEngDetViewAcc
CREATE OR ALTER VIEW dbo.CoEngDetViewAcc AS
SELECT	
				c.id,
				c.HdCreateDate, 
				c.HdEditStamp,
				c.HdStatusFlag, 
				c.HdPendingChanges, 
				c.HdPendingSubChanges, 
				c.HdVersionNo,
				C.HdProcessId,
				c.veragrp,
				c.veradate,				
				c.accountid,
				d.AccountNoText,
                                                                d.AccountNoEdited,
				e.PartnerId as Clientid,
				(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype = 1 and
                                                                                isGeneralSummary = 0) 
					as debitbalance,					
				(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype = 2 and
                                                                                isGeneralSummary = 0) 
					as existinglimit,					
				(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype = 3 and
                                                                                isGeneralSummary = 0) 
					as intrestoutstanding,	
				(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype = 4 and
                                                                                isGeneralSummary = 0) 
					as existingamoamount,	
				(select top (1) remark from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype = 4 and
                                                                                isGeneralSummary = 0) 
					as existingamoremark,	
				(select top (1) dateamount from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype = 4 and
                                                                                isGeneralSummary = 0) 
					as existingdateamo,	
				(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype = 5 and
                                                                                isGeneralSummary = 0) 
					as valuationallowance,	
				(select top (1) Compwbbez from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype = 5 and
                                                                                isGeneralSummary = 0) 
					as Compwbbez,	
/* if a new limit is specify overwrite existing egagement with new limit */
				(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype in (6,1001) and
                                                                                isGeneralSummary = 0 order by engtype desc) 
					as accengagament,
				(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype = 1001 ) 
					as newlimit,	
				(select top (1) amount from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype = 3001) 
					as newamoamount,	
				(select top (1) dateamount from coengdetcalc 
					where 
					coengdetcalc.veragrp = c.veragrp and 
					coengdetcalc.accountid = c.accountid and
					coengdetcalc.engtype = 3001) 
					as newdateamo,	
				(select sum(Pledgevalueassign) 	from cobaseasscalc
					where 	
					cobaseasscalc.accountid = c.accountid and
					cobaseasscalc.veragrp = c.veragrp and
					cobaseasscalc.typecov = 6)
					as weakblanko,
				(select sum(Pledgevalueassign) 	from cobaseasscalc
					where 	
					cobaseasscalc.accountid = c.accountid and
					cobaseasscalc.veragrp = c.veragrp and
					cobaseasscalc.typecov = 5)
					as blanko,
				(select sum(Pledgevalueassign) 	from cobaseasscalc
					where 	
					cobaseasscalc.accountid = c.accountid and
					cobaseasscalc.veragrp = c.veragrp and
					cobaseasscalc.typecov = 4)
					as unkurant,
				(select sum(Pledgevalueassign) 	from cobaseasscalc
					where 	
					cobaseasscalc.accountid = c.accountid and
					cobaseasscalc.veragrp = c.veragrp and
					cobaseasscalc.typecov = 2)
					as kurant,
				(select sum(Pledgevalueassign) 	from cobaseasscalc
					where 	
					cobaseasscalc.accountid = c.accountid and
					cobaseasscalc.veragrp = c.veragrp and
					cobaseasscalc.typecov = 1)
					as kurantgpf,
				(select sum(Pledgevalueassign) 	from cobaseasscalc
					where 	
					cobaseasscalc.accountid = c.accountid and
					cobaseasscalc.veragrp = c.veragrp and
					cobaseasscalc.typecov = 3)
					as kurantoerk,
				(select sum(Pledgevalueassign) 	from cobaseasscalc
					where 	
					cobaseasscalc.accountid = c.accountid and
					cobaseasscalc.veragrp = c.veragrp and
					cobaseasscalc.typecov in (1,2,3,4,5,6))
					as totamount	
FROM				CoEngcalc as a,coveradet as c,ptaccountbase as d,ptportfolio as e
				where
					a.engstat = 100 and
					a.veragrp = c.veragrp and
					c.Colworkingtype = 130 and
					d.id = c.accountid and
                                                                                e.id = d.portfolioid

