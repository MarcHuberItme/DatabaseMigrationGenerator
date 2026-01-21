--liquibase formatted sql

--changeset system:create-alter-view-PtInsaXHoldingView context:any labels:c-any,o-view,ot-schema,on-PtInsaXHoldingView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtInsaXHoldingView
CREATE OR ALTER VIEW dbo.PtInsaXHoldingView AS
SELECT FileTypeCode, Status, TransdateStart, TransdateFinish, PositionId, AccountId, InsaRecord,
  Substring(InsaRecord,  1,  8 ) AS IKdNr,
  Substring(InsaRecord,  9,   1 ) AS Del1,
  Substring(InsaRecord, 10,  10 ) AS IKtNr,
  Substring(InsaRecord, 20,   1 ) AS Del2,
  Substring(InsaRecord, 21,  10 ) AS IValNr,
  Substring(InsaRecord, 31,   1 ) AS Del3,
  Substring(InsaRecord, 32,   4 ) AS IZusatz1,
  Substring(InsaRecord, 36,   6 ) AS IZusatz2,
  Substring(InsaRecord, 42,   1 ) AS Del4,
  Substring(InsaRecord, 43,  16 ) AS IBestand,
  Substring(InsaRecord, 59,   1 ) AS Del5,
  Substring(InsaRecord, 60,  14 ) AS ISaldo,
  Substring(InsaRecord, 74,   1 ) AS Del6,
  Substring(InsaRecord, 75,   2 ) AS ITitArt,
  Substring(InsaRecord, 77,   1 ) AS Del7,
  Substring(InsaRecord, 78,   4 ) AS IWrg,
  Substring(InsaRecord, 82,   1 ) AS Del8,
  Substring(InsaRecord, 83,   6 ) AS ICoupon,
  Substring(InsaRecord, 89,   1 ) AS Del9,
  Substring(InsaRecord, 90,   4 ) AS IZinsTerm,
  Substring(InsaRecord, 94,   1 ) AS Del10,
  Substring(InsaRecord, 95,   3 ) AS IAnzFaell,
  Substring(InsaRecord, 98,   1 ) AS Del11,
  Substring(InsaRecord, 99,   8 ) AS IVerfall,
  Substring(InsaRecord, 107,  1 ) AS Del12,
  Substring(InsaRecord, 108,  4 ) AS ITitDom,
  Substring(InsaRecord, 112,  1 ) AS Del13,
  Substring(InsaRecord, 113,  2 ) AS IBranche,
  Substring(InsaRecord, 115,  1 ) AS Del14,
  Substring(InsaRecord, 116, 19 ) AS IBasis,
  Substring(InsaRecord, 135,  1 ) AS Del15,
  Substring(InsaRecord, 136,  4 ) AS IJJMM,
  Substring(InsaRecord, 140,  1 ) AS Del16,
  Substring(InsaRecord, 141, 24 ) AS IText,
  Substring(InsaRecord, 165,  4 ) AS DStNr
FROM 	PtInsaFileXHolding XHOL
JOIN	PtInsaInterfaceController CON ON CON.Id = XHOL.ControllerId
