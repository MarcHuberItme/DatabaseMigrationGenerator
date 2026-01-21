--liquibase formatted sql

--changeset system:create-alter-view-PtAccountCompValidPeriodView context:any labels:c-any,o-view,ot-schema,on-PtAccountCompValidPeriodView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountCompValidPeriodView
CREATE OR ALTER VIEW dbo.PtAccountCompValidPeriodView AS
Select SV.Id, SV.LValues, SV.HValues, SV.ValidFrom, Min(VT.ValidFrom) As ValidTo
From (
  Select C.Id, COUNT(V.Id) As ValueCounts, 
   SUM(Case When Cast(V.ValidFrom As Date)<=Cast(GETDATE() As Date) Then 1 Else 0 End) As LValues,
  Case When SUM(Case When Cast(V.ValidFrom As Date)<=Cast(GETDATE() As Date) Then 1 Else 0 End)>0 
    Then MAX(Case When Cast(V.ValidFrom As Date)<=Cast(GETDATE() As Date) Then V.ValidFrom Else '19000101' End)
   When SUM(Case When Cast(V.ValidFrom As Date)<=Cast(GETDATE() As Date) Then 1 Else 0 End)=0 
    Then MIN(Case When Cast(V.ValidFrom As Date)>Cast(GETDATE() As Date) Then V.ValidFrom 
   Else '20991231' End) End As ValidFrom,
  SUM(Case When V.ValidFrom>GETDATE() Then 1 Else 0 End) As HValues
 From PtAccountComponent C Join PrPrivateCompType CT On C.PrivateCompTypeId=CT.Id 
 Join PtAccountCompValue V On V.AccountComponentId=C.Id
 Where C.HdVersionNo < 999999999 And C.IsOldComponent=0
  And CT.IsDebit=1 And CT.IsFixed=0
  And V.HdVersionNo < 999999999
 Group By C.Id
) SV Left Outer Join PtAccountCompValue VT On SV.Id=VT.AccountComponentId 
 And VT.ValidFrom>SV.ValidFrom And VT.HdVersionNo < 999999999
Group By SV.Id, SV.LValues, SV.HValues, SV.ValidFrom
