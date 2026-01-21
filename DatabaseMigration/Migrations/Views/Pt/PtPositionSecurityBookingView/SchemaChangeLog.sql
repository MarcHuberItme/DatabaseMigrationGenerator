--liquibase formatted sql

--changeset system:create-alter-view-PtPositionSecurityBookingView context:any labels:c-any,o-view,ot-schema,on-PtPositionSecurityBookingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtPositionSecurityBookingView
CREATE OR ALTER VIEW dbo.PtPositionSecurityBookingView AS
Select TI.Id, 
    TI.HdCreateDate, 
    TI.HdCreator, 
    TI.HdChangeDate, 
    TI.HdChangeUser,
    TI.HdEditStamp, 
    TI.HdVersionNo, 
    TI.HdProcessId, 
    TI.HdStatusFlag, 
    TI.HdNoUpdateFlag, 
    TI.HdPendingChanges, 
    TI.HdPendingSubChanges, 
    TI.HdTriggerControl, 
    B.ID As PartnerID, 
    B.PartnerNoEdited,
    PO.ID As PortfolioID, 
    PO.PortfolioNoEdited, 
    PO.Currency,
    Pos.ID As PositionID, 
    Pos.Quantity As ActualQuantity,
    PV.ID As PublicID, 
    PV.ISINNo, 
    PV.ShortName As Description, 
    PV.InstrumentTypeNo, 
    L.GroupNo As LocGroupNo,
    TI.TransDate, 
    TI.TransDateTime, 
    TI.TextNo, 
    TI.DebitQuantity, 
    TI.CreditQuantity, 
    TI.ValueDate,
    Case When M.TradePrice Is Not Null Then M.TradePrice
        When M.TradePrice Is Null And TI.MgKurs=0 Then Null
        Else TI.MgKurs End As TradePrice, 
    PV.NominalCurrency As PriceCurrency,
    IX.TextShort As SecurityType, 
    TX.TextShort As BookingText, 
    M.TradeDate, 
    M.BankInternalReference,
    PV.LanguageNo
From PtTransItem TI Inner Join PtPosition Pos On TI.PositionID=Pos.ID 
    Inner Join PrLocGroup L On Pos.ProdLocGroupID=L.ID
    Inner Join PtPortfolio PO On Pos.PortfolioID=PO.ID
    Inner Join PtBase B On PO.PartnerID=B.ID
    Inner Join PrReference Ref on Pos.ProdReferenceID = Ref.ID
    Inner Join PrPublicDescriptionView PV On PV.ProductID = Ref.ProductID
    Inner Join PrPublicInstrumentType IT On PV.InstrumentTypeNo=IT.InstrumentTypeNo 
    Inner Join AsText IX On IX.MasterID=IT.ID And IX.LanguageNo=PV.LanguageNo 
    Inner Join PtTransItemText TT On TI.TextNo=TT.TextNo 
    Inner Join AsText TX On TX.MasterID=TT.ID And TX.LanguageNo=PV.LanguageNo 
    Left Outer Join PtTransMessage M On TI.MessageID=M.ID And M.HdVersionNo<999999999
WHERE TI.HdVersionNo between 1 and 999999998
    And Pos.HdVersionNo<999999999
    And B.HdVersionNo<999999999
    And PO.HdVersionNo<999999999
    And Pos.HdVersionNo < 999999999
    And Ref.HdVersionNo < 999999999
