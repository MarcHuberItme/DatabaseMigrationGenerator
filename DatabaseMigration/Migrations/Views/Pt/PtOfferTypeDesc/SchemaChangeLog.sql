--liquibase formatted sql

--changeset system:create-alter-view-PtOfferTypeDesc context:any labels:c-any,o-view,ot-schema,on-PtOfferTypeDesc,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtOfferTypeDesc
CREATE OR ALTER VIEW dbo.PtOfferTypeDesc AS
SELECT     TOP 100 PERCENT
                   o.Id, 
                   o.HdStatusFlag,
                   o.HdPendingChanges,
                   o.HdPendingSubChanges,
                   o.HdVersionNo, 
                   o.HdProcessId, 
                   o.EbInfoId,
                   o.Id as OfferId,
                   o.OfferTypeNo,
                   o.OfferStatusNo,
                   o.BankSpeakerId,
                   o.CustSpeaker,
                   o.ValidToDate,
                   AsText.TextShort + ' - ' + AsText_1.TextShort AS OfferDesc

FROM        PtOffer o INNER JOIN
                  PtOfferStatus ON o.OfferStatusNo = PtOfferStatus.OfferStatusNo
                  INNER JOIN
                  PtOfferType ON o.OfferTypeNo = PtOfferType.OfferTypeNo
                  INNER JOIN
                  AsText ON PtOfferType.Id = AsText.MasterId INNER JOIN
                  AsText AsText_1 ON PtOfferStatus.Id = AsText_1.MasterId

WHERE    (AsText.LanguageNo = 2) AND (AsText_1.LanguageNo = 2)
