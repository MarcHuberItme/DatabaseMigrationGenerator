--liquibase formatted sql

--changeset system:create-alter-view-ReObligationSearchView context:any labels:c-any,o-view,ot-schema,on-ReObligationSearchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReObligationSearchView
CREATE OR ALTER VIEW dbo.ReObligationSearchView AS
SELECT TOP 100 PERCENT O.Id, O.HdCreateDate, O.HdCreator, O.HdChangeDate, 
O.HdChangeUser, O.HdEditStamp, ISNULL(O.HdVersionNo, 1) AS HdVersionNo, O.HdProcessId, 
O.HdStatusFlag, O.HdNoUpdateFlag, O.HdPendingChanges, O.HdPendingSubChanges, O.HdTriggerControl,
O.ObjectSeqNo, O.ObligAmount, O.ObligTypeNo, O.ObligDate, O.ObligRank, 
O.ObligeeStatusNo, O.ObligeeTypeNo, 
P.Zip, P.SwissTownNo, P.GBNo, P.GBNoAdd, P.GBPlanNo, P.Street, P.HouseNo,
PC.PremisesCountObligation, OC.ObligationCountPremises, OO.OwnerCount, OO.OwnerPartnerNo,

Case When C.UsedCollaterals Is Null Then 'Not used!' Else 'Used with '+ cast(C.UsedCollaterals as varchar) End +
Case When C.UsedCollaterals Is Null Then '' When C.UsedCollaterals=1 Then ' --> '+cast(C.LastCollNo as varchar) Else ', LastCollNo --> ' + cast(C.LastCollNo as varchar) End +
Case When C.UsedCollaterals Is Null Then '' Else IIF(FirstActivateDate Is Null,'',', ActivateDate --> {'+CONVERT(varchar, FirstActivateDate, 120)+ '}')  End +
Case When C.UsedCollaterals Is Null Then '' Else IIF(FirstInActivateDate Is Null,'',', InactivateDate --> {'+CONVERT(varchar, FirstInactivateDate, 120)+ '}')  End As WarningText
 
From ReObligation O Join ReObligPremisesRelation R On O.Id=R.ObligationId And O.HdVersionNo<999999999 And R.HdVersionNo<999999999 
Join (Select ObligationId, Count(Distinct PremisesId) As PremisesCountObligation
    From ReObligPremisesRelation 
	Where HdVersionNo < 999999999 
	Group By ObligationId) PC On PC.ObligationId = R.ObligationId 
Join (Select PremisesId, Count(Distinct ObligationId) As ObligationCountPremises
    From ReObligPremisesRelation 
	Where HdVersionNo < 999999999 
	Group By PremisesId) OC On OC.PremisesId=R.PremisesId 
Join RePremises P On P.Id=R.PremisesId And P.HdVersionNo<999999999 And P.GBNo<>'COPY' And P.TerminationDate Is Null 
Join ReBase B On P.ReBaseId=B.Id And B.HdVersionNo<999999999 And B.TerminationDate Is Null 
Left Outer Join (Select OW.ReBaseId, Count(PartnerId) As OwnerCount, Min(PB.PartnerNo) As OwnerPartnerNo
     From ReBasePtRel RL Join PtBase PB On RL.PartnerId=PB.Id
		And RL.HdVersionNo<999999999 And RL.ValidTo Is Null
		And PB.HdVersionNo<999999999 And PB.TerminationDate Is Null
     Join ReOwner OW On RL.Id=OW.PartnerRelId And RL.ReBaseId=OW.ReBaseId And OW.HdVersionNo<999999999
     Group By OW.ReBaseId) OO On OO.ReBaseId=B.Id 
Outer Apply (
	Select ObligationId, Count(Id) As UsedCollaterals, Max(CollNo) As LastCollNo, 
	Min(Case When ActivateDate Is Null Then Null When ActivateDate<GetDate() Then Null Else ActivateDate End) As FirstActivateDate,
	Min(Case When InactivateDate Is Null Then Null When InactivateDate<GetDate() Then Null Else InactivateDate End) As FirstInactivateDate
	From CoBase
	Where CollType=7000 And NOT(Inactflag=1 And (ActivateDate Is Null Or ActivateDate<=getdate()))
	And ObligationId=O.Id
	Group By ObligationId
) C


