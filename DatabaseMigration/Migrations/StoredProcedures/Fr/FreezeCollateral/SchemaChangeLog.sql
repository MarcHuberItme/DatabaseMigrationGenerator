--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeCollateral context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeCollateral,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeCollateral
CREATE OR ALTER PROCEDURE dbo.FreezeCollateral
@ReportDate datetime

AS
INSERT INTO AcFrozenCollateral(
Id, HdVersionNo, ReportDate, AccountNo, AccountId, C536, C551, FireAccountNo, CollNo, CollType, CollSubType, PriCover, SubPriCover, 
CoValueTotAdjust, CoValueTotCollateral, PledgeValueAssign, C568, ObligAmount)

SELECT NewId(), 1,  @ReportDate As ReportDate, AccountNo, AccountId, C536,  C551, C540, CollNo, CollType, CollSubType, PriCover, SubPriCover, 
CoValueTotAdjust, 
IIF(V.PremisesId Is Null, V.vkadjustfak, Allot.vkadjustfakNew) * PledgevalueAssign As CoValueTotCollateral, 
PledgevalueAssign, V.PremisesId As C568, V.ObligAmount

FROM CoMevview V Outer Apply (
  Select Assign.CollateralId, 
  Sum(MVPremises) As TotalMV, 
  IIF(Sum(TotalPVAssColl)=0,0,Sum(MVPremises)/cast(Sum(TotalPVAssColl) as real)) As vkadjustfakNew
  --,Sum(TotalPVColl) As TotalPV, Sum(TotalPVFColl) As TotalPVF, Sum(TotalPVAssColl) As TotalPVAss,
  From (
    --same collateral with all premises assigned
    Select CollateralId, PremisesId, Max(CoValuetot) As MVPremises
    --Sum(Pledgevalue) As PVPremises, Sum(Pledgevaluefree) As PVFPremises 
    From CoBasecalc
    Where Calcgrp=V.Calcgrp And veragrp=V.veragrp And CollateralId=V.CollateralId And PremisesId Is Not Null
    Group By CollateralId, PremisesId
    ) Assign Outer Apply (
      --based on all list of premises, reverse calculate all PV, PVF assigned to all collaterals
      Select Sum(Pledgevalue-Pledgevaluefree) As TotalPVAssColl
      --,Sum(Pledgevalue) As TotalPVColl, Sum(Pledgevaluefree) As TotalPVFColl
      From CoBaseCalc
      Where Calcgrp=V.Calcgrp And veragrp=V.veragrp And PremisesId=Assign.PremisesId And PremisesId Is Not Null
      ) Premises
    Group By Assign.CollateralId
) Allot

WHERE MevYear = Year(@ReportDate) and MevMonth = Month(@ReportDate)
And Colltype <> 2000

UNION ALL

SELECT NewId(), 1,  @ReportDate As ReportDate, AccountNo, AccountId,Null As C536,  C551, Sub.C540, V.CollNo, Sub.CollType, Sub.CollSubType, PriCover, SubPriCover, 
Null as CoValueTotAdjust, 
Null As CoValueTotCollateral, 
NULL As PledgevalueAssign, V.PremisesId As C568, Cast(Third.ObligAmount*PledgevalueAssign/V.sumpledgevalueass As money) As ObligAmount
FROM CoMevview V Outer Apply (
    Select Distinct CollateralId,
    CASE WHEN AntecedenAmountthird > 0 THEN 7100 WHEN RankRivalryAmountthird > 0 THEN 7200 ELSE NULL END AS CollSubType,
    CASE WHEN AntecedenAmountthird > 0 THEN AntecedenAmountthird
           WHEN RankRivalryAmountthird > 0 THEN RankRivalryAmountthird
           ELSE NULL END AS ObligAmount, O.ObjectSeqNo, C.Copremresult, C.CollNo, C.PremisesId
    From CoBaseCalc C Join ReObligation O On C.ObligationId=O.Id 
    Where Calcgrp=V.Calcgrp And veragrp=V.veragrp And CollateralId=V.CollateralId And PremisesId Is Not Null
      And (AntecedenAmountthird > 0 OR RankRivalryAmountthird > 0)
) Third
Inner Join CoSubtype Sub On Sub.Collsubtype = Third.Collsubtype And Sub.CollType=7000 And Sub.HdVersionNo<999999999

WHERE MevYear = Year(@ReportDate) and MevMonth = Month(@ReportDate)
And V.Colltype <> 2000

