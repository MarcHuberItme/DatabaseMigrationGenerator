--liquibase formatted sql

--changeset system:create-alter-view-CoMevview context:any labels:c-any,o-view,ot-schema,on-CoMevview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoMevview
CREATE OR ALTER VIEW dbo.CoMevview AS
SELECT cobaseasscalc.id,
    cobaseasscalc.HdCreateDate, 
    cobaseasscalc.HdEditStamp,
    cobaseasscalc.HdStatusFlag, 
    cobaseasscalc.HdPendingChanges, 
    cobaseasscalc.HdPendingSubChanges, 
    cobaseasscalc.HdVersionNo,
    cobaseasscalc.HdProcessId,
    cocalcmev.mevyear,
    cocalcmev.mevmonth,                
    cocalcmev.accountid,    
    ptaccountbase.AccountNo,     
    'N' + convert(varchar(11), ptaccountbase.AccountNo) as C551,
    CASE /* Real estate take out of Copremres */
        when cosubtype.Colltype = 7000 then Copremres.C540 
/* accounts / securites take out of fire */
        when cosubtype.Colltype IN (2000) then NULL else 
/* rest out of cosubtype */
            cosubtype.C540 end as C540,

    Case 
        when (ptAccountBase.MinimumCapitalViolated = 1 OR PtAccountBase.MinimumAmortisationViolated = 1) and CoBasecalc.C536 = 20 Then 21
        when (ptAccountBase.MinimumCapitalViolated = 1 OR PtAccountBase.MinimumAmortisationViolated = 1) and CoBasecalc.C536 = 22 Then 23
        when (ptAccountBase.MinimumCapitalViolated = 1 OR PtAccountBase.MinimumAmortisationViolated = 1) and CoBasecalc.C536 = 24 Then 25
        when (ptAccountBase.MinimumCapitalViolated = 1 OR PtAccountBase.MinimumAmortisationViolated = 1)
            and cobasecalc.Collsubtype in (1100,5000,5001,6004) Then 21
        else IsNull(CoBasecalc.C536,0) end as C536, 
					    
    cocalcmev.veragrp,
    cobaseasscalc.Veradate,
    cobaseasscalc.Calcgrp,
    cobaseasscalc.CollateralId,
/*
    cobase.collno,
    cobase.Collsubtype,
    cobase.Colltype,

*/
    cobasecalc.collno,
    cobasecalc.Collsubtype,
    cobasecalc.Pricover,
    cobasecalc.SubpriCover,
    cobasecalc.Colltype,
    cobasecalc.id as cobasecalcid,
    cobasecalc.CoValuetotkw,
    cobasecalc.Currency,
    cobasecalc.CoValuetot,
    cobaseasscalc.Typecov,

    CASE
        when (cobasecalc.PremisesId is not null) then
/* Bestimmen Wert der Sicherheit im Verhältnis der gesamten Zuweisung/konkreter Zuweisung vom Grundstück 
bezogen auf das einzelne Grundstück , Details siehe View CoSumfire */
            cobaseasscalc.Pledgevalueassign * 
                (select vkadjustfak 
	from CoSumfireView 
	where Cosumfireview.premisesid = cobasecalc.PremisesId and Cosumfireview.Calcgrp = cobaseasscalc.Calcgrp)
        else
/* Bestimmen Wert der Sicherheit im Verhältnis der gesamten Zuweisung/konkreter Zuweisung der Sicherheit 
bezogen auf die Sicherheit  , Details siehe View CoSumfire */
            cobaseasscalc.Pledgevalueassign * 
                (select vkadjustfak 
	from CoSumfireView 
	where Cosumfireview.collateralid = cobaseasscalc.CollateralId and Cosumfireview.Calcgrp = cobaseasscalc.Calcgrp)         
        end as CoValuetotAdjust,
    CASE
        when (cobasecalc.PremisesId is not null) then
                (select  sumpledgevalueass 
	from CoSumfireView 
	where Cosumfireview.premisesid = cobasecalc.PremisesId and Cosumfireview.Calcgrp = cobaseasscalc.Calcgrp)
        else
                (select  sumpledgevalueass 
	from CoSumfireView 
	where Cosumfireview.collateralid = cobaseasscalc.CollateralId and Cosumfireview.Calcgrp = cobaseasscalc.Calcgrp)         
        end as  sumpledgevalueass,

    CASE
        when (cobasecalc.PremisesId is not null) then
                (select vkadjustfak 
	from CoSumfireView 
	where Cosumfireview.premisesid = cobasecalc.PremisesId and Cosumfireview.Calcgrp = cobaseasscalc.Calcgrp)
        else
	(select vkadjustfak 
	from CoSumfireView 
	where Cosumfireview.collateralid = cobaseasscalc.CollateralId and Cosumfireview.Calcgrp = cobaseasscalc.Calcgrp)         
        end as vkadjustfak,

    cobaseasscalc.Pledgevalueassign,
    cobasecalc.PremisesId,
    copremres.Copremresult as copremresCopremresult,

    CASE
        when (cobasecalc.PremisesId is not null) then cast(cobasecalc.ObligAmount * (cobaseasscalc.Pledgevalueassign / SB.PledgeValueAssignedColl) as money)
        else null end as ObligAmount,
	CASE 
		when (cobasecalc.PremisesId is not null) then cast(cobaseasscalc.Pledgevalueassign / SB.PledgeValueAssignedColl as float) 
		Else null end As ObligAmountFactor,

    cobasecalc.VaRunID,
/* cobase.portfolioid*/ 
    cobasecalc.portfolioid

FROM cocalcmev inner join cobaseasscalc on cocalcmev.accountid = cobaseasscalc.accountid
    and cocalcmev.veragrp = cobaseasscalc.veragrp
/* read only the latest calcgrp for this collateral in the same period as the account, 
otherwise we may get problems if an account / collateral record is removed from the  table cobaseass during the month */
    and cobaseasscalc.calcgrp = 
            (select a.calcgrp 
            from cocalcmev as a 
            where a.collateralid = cobaseasscalc.collateralid
		and cocalcmev.mevyear = a.mevyear and cocalcmev.mevmonth = a.mevmonth)
inner join cobasecalc on cobasecalc.id = cobaseasscalc.Cobasecalcid
outer apply (
	select cast(sum(IsNull(pledgevalue,0)-IsNull(Pledgevaluefree,0)) as float) as PledgeValueAssignedColl
	from cobasecalc c 
	where c.PremisesId is not null 
	And c.PremisesId=cobasecalc.PremisesId
	and c.Calcgrp=cobasecalc.Calcgrp
	and c.CollateralId=cobaseasscalc.CollateralId
	group by c.CollateralId
	) SB
/*                        inner join cobase    on cobase.id = cobaseasscalc.collateralid */
inner join cosubtype on cosubtype.Collsubtype = cobasecalc.Collsubtype
/* on    cosubtype.Collsubtype = cobase.Collsubtype*/ 
                        
inner join ptaccountbase on cocalcmev.accountid = ptaccountbase.id
LEFT OUTER JOIN Copremres on Copremres.Copremresult = cobasecalc.Copremresult
where cocalcmev.accountid is not null
