--liquibase formatted sql

--changeset system:create-alter-view-PtTransMessageFuturesPosView context:any labels:c-any,o-view,ot-schema,on-PtTransMessageFuturesPosView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtTransMessageFuturesPosView
CREATE OR ALTER VIEW dbo.PtTransMessageFuturesPosView AS
select 
     Pos.Id, 
     Pos.HdCreateDate,
     Pos.HdCreator,
     Pos.HdChangeDate,
     Pos.HdChangeUser,
     Pos.HdEditStamp,
     Pos.HdVersionNo,
     Pos.HdProcessId,
     Pos.HdStatusFlag,
     Pos.HdNoUpdateFlag,
     Pos.HdPendingChanges,
     Pos.HdPendingSubChanges,
     Pos.HdTriggerControl,
     Pos.Id PositionId, 
     Pos.PortfolioId,
     PtBase.Id PartnerId, 
     AsUserGroup.Description SachB,
     IsNull(A.ReportAdrLine,IsNull(PtBase.FirstName + ' ','') + IsNull(PtBase.Name,'') + ' ' + IsNull(A.Town,'')) AS PtDescription,
     Pos.Quantity, 
     PUB.Id PublicId,
     PrPublicDescriptionViewToff.PublicDescription,
     Pos.ProdLocGroupId, 
     IsNull(Convert(varchar,REF.InterestRate) + ' % ', '')
     + IsNull(Convert(varchar,REF.MaturityDate,104) + ' ', '')
     + IsNull(REF.SpecialKey + ' ','')
     + IsNull(Convert(varchar,OBJ.ObjectSeqNo), '')
     + IsNull(Convert(varchar,OBL.ObjectSeqNo), '')
     + IsNull(Convert(varchar,INS.ObjectSeqNo), '') as ReferenceData,
     REF.Currency,
     Pos.LatestTransDate,
     PrPublicDescriptionViewToff.LanguageNo
FROM PtPosition POS
JOIN PtPortfolioView PF on PF.Id = POS.PortfolioId
and PF.HdVersionNo between 1 and 999999998
JOIN PtBase on PtBase .Id = PF.PartnerId
and PtBase .HdVersionNo between 1 and 999999998
LEFT OUTER JOIN AsUserGroup on AsUserGroup.UserGroupName = PtBase.ConsultantTeamName
and  AsUserGroup.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN	PtAddress A ON PtBase.Id = A.PartnerId And A.AddressTypeNo = 11
JOIN PrReference REF on REF.Id = POS.ProdReferenceId
and REF.HdVersionNo between 1 and 999999998
JOIN PrPublic PUB on PUB.ProductId = REF.ProductId
and PUB.HdVersionNo between 1 and 999999998
JOIN PrPublicDescriptionViewToff on PrPublicDescriptionViewToff.Id = PUB.Id
and PrPublicDescriptionViewToff.HdVersionNo between 1 and 999999998
LEFT OUTER JOIN	PrObject OBJ on OBJ.Id = REF.ObjectId 
LEFT OUTER JOIN ReObligation OBL on OBL.Id = REF.ObligationId 
LEFT OUTER JOIN PrInsurancePolice INS on INS.Id = REF.InsurancePoliceId  
where exists(select * From PtTransMessageFuturesView F WHERE F.PositionId = POS.Id
and F.HdVersionNo between 1 and 999999998)
