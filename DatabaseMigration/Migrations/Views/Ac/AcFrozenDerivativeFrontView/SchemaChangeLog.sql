--liquibase formatted sql

--changeset system:create-alter-view-AcFrozenDerivativeFrontView context:any labels:c-any,o-view,ot-schema,on-AcFrozenDerivativeFrontView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcFrozenDerivativeFrontView
CREATE OR ALTER VIEW dbo.AcFrozenDerivativeFrontView AS
SELECT FD.Id,
FD.HdVersionNo,
FD.HdPendingChanges,
FD.HdPendingSubChanges,
FD.HdEditStamp,
FD.HdCreator,
FD.HdChangeUser,
FD.HdProcessId,
FD.HdStatusFlag,
FD.ReportDate,
FD.IsTradingBook,
FD.DerivativeTypeNo,
FD.PartnerId,
FD.ContractKey,
FD.DateTo,
FD.ContractCurrency,
FD.ContractAmount,
FD.OpponentCurrency,
FD.OpponentAmount,
FD.ReplacementValue,
FD.PendingValuationFlag,
PtDesc.PtDescription + ISNULL( ' (' + PrPub.ShortName + ')','') AS Description,
PrPub.LanguageNo
FROM AcFrozenDerivative AS FD
LEFT OUTER JOIN AcFrozenSecurityBalance AS FSB ON FD.SourceRecordId = FSB.Id
LEFT OUTER JOIN PrPublicDescriptionView AS PrPub ON FSB.ProductId = PrPub.ProductId
LEFT OUTER JOIN PtDescriptionView AS PtDesc ON FD.PartnerId = PtDesc.Id
