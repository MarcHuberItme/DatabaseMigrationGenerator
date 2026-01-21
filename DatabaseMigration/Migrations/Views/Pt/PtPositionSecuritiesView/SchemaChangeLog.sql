--liquibase formatted sql

--changeset system:create-alter-view-PtPositionSecuritiesView context:any labels:c-any,o-view,ot-schema,on-PtPositionSecuritiesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionSecuritiesView
CREATE OR ALTER VIEW dbo.PtPositionSecuritiesView AS
Select 
    Pos.ID,
    Pos.HdCreateDate, 
    Pos.HdCreator, 
    Pos.HdChangeDate, 
    Pos.HdEditStamp, 
    Pos.HdVersionNo, 
    Pos.HdProcessId, 
    Pos.HdStatusFlag, 
    Pos.HdNoUpdateFlag, 
    Pos.HdPendingChanges, 
    Pos.HdPendingSubChanges, 
    Pos.HdTriggerControl, 
    Pos.PortfolioID,
    Pos.Quantity,
    Pos.ProdLocGroupID,
    Portfolio.CustomerReference as PortfolioName,
    PTE.ShortName As Description,
    Ref.ID As ProdReferenceID, Ref.Currency As PositionCurrency,
    IsNull(Convert(varchar,Ref.InterestRate) + ' % ', '')
    + IsNull(Convert(varchar,Ref.MaturityDate,104) + ' ', '')
    + IsNull(Ref.SpecialKey + ' ','')
    + IsNull(Convert(varchar,Obj.ObjectSeqNo), '')
    + IsNull(Convert(varchar,Og.ObjectSeqNo), '')
    + IsNull(Convert(varchar,Ins.ObjectSeqNo), '') As ReferenceData, 
    Pub.Id As PublicID,
    PubDesc.PublicDescription, 
    PubDesc.ShortName, 
    PubDesc.LongName, 
    Pub.InstrumentTypeNo,
    Pub.NominalCurrency,
    Pub.ISINNo,
    Pub.VDFInstrumentSymbol,
    Pub.UnitNo,
    Pub.SecurityType, 
    Pub.IssuerId, 
    PTE.LanguageNo,
    IsNull(Pos.BookletLine,0)  As HasPendingOrder,
    Pos.IsToClose,
    Obj.ObjectSeqNo as ObjectObjectSeqNo,
    Og.ObjectSeqNo as ObligationObjectSeqNo,
    Ins.ObjectSeqNo as InsuranceObjectSeqNo,
    Obj.Id as ObjectId,
    Og.Id as ObligationId,
    Ins.Id as InsuranceId,
    replace (IsNull(Obj.Description,IsNull(Og.Description,IsNull(Ins.Description,''))),  Char(13) + Char(10)   ,' / ') as [ObjectDescription]
From PtPosition Pos Join PrReference Ref On Pos.ProdReferenceID = Ref.ID And Pos.ProdLocGroupID Is Not Null
        And Ref.AccountID Is Null And Pos.HdVersionNo < 999999999 And Ref.HdVersionNo<999999999
    Inner Join PrPublic Pub On Pub.ProductID = Ref.ProductID And Pub.HdVersionNo < 999999999
    Inner Join PtPortfolio Portfolio on Pos.PortfolioID = Portfolio.Id
    Inner Join PrPublicText PTE ON PTE.PublicId = PUB.Id And PTE.HdVersionNo < 999999999
    Inner Join PrPublicDescriptionView PubDesc ON PubDesc.Id = PUB.Id and PubDesc.HdVersionNo < 999999999
    and PubDesc.LanguageNo = PTE.LanguageNo
    Left Outer Join PrObject Obj On Ref.ObjectID=Obj.ID And Obj.HdVersionNo < 999999999
    Left Outer Join ReObligation Og On Ref.ObligationID=Og.ID And Og.HdVersionNo < 999999999
    Left Outer Join PrInsurancePolice Ins On Ref.InsurancePoliceID=Ins.ID And Ins.HdVersionNo < 999999999




