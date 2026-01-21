--liquibase formatted sql

--changeset system:create-alter-view-PtAccountCompView context:any labels:c-any,o-view,ot-schema,on-PtAccountCompView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountCompView
CREATE OR ALTER VIEW dbo.PtAccountCompView AS
SELECT TOP 100 PERCENT
A.Id, A.HdPendingChanges, A.HdPendingSubChanges, A.HdVersionNo, 
A.AccountBaseId, A.PrivateComponentId, A.PrivateCompTypeId, 
A.PriorityOfInterestCalculation, A.PriorityOfPayback, A.PriorityOfLegalReporting,
A.IsOldComponent,
A.MgVBNR, A.MgLIMITE, A.MgDECKWERT, A.MgVERFALL,
P.PrivateComponentNo, T.LanguageNo, T.TextShort, T.TextLong,
IsNull(T.TextShort,'') + ' (' + IsNull(CAST(A.MgVBNR AS nvarchar(11)),'-') + ')   ' + ISNULL(CAST(A.MgLIMITE AS nvarchar(15)),'') Description,
V.ValidFrom, V.ValidTo, CV.Value, V.LValues, V.HValues,
Case When CT.SecurityLevelNo=99 And V.Id Is Not Null 
    Then T.TextShort+' ('+ Cast(CV.Value As varchar(12))+', '+ Convert(char(10), V.ValidFrom, 104)+' - '+IsNull(Convert(char(10), V.ValidTo, 104),'')+')' 
  Else IsNull(T.TextShort,'') + ' (' + IsNull(CAST(A.MgVBNR AS nvarchar(11)),'-') + ')   ' + ISNULL(CAST(A.MgLIMITE AS nvarchar(15)),'') End As Credit2Desc,
Cast(Case When CT.SecurityLevelNo=99 Then 1 Else 0 End As Bit) As Credit2Only
FROM PtAccountComponent A Join PrPrivateComponent P ON A.PrivateComponentId = P.Id
Join PrPrivateCompType CT On A.PrivateCompTypeId=CT.Id 
Join AsText T ON A.PrivateCompTypeId = T.MasterId
Left Outer Join PtAccountCompValidPeriodView V On A.Id=V.Id
Left Outer Join PtAccountCompValue CV On CV.AccountComponentId=A.Id And CV.ValidFrom=V.ValidFrom And CV.HdVersionNo < 999999999

