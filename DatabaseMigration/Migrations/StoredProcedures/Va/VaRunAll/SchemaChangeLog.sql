--liquibase formatted sql

--changeset system:create-alter-procedure-VaRunAll context:any labels:c-any,o-stored-procedure,ot-schema,on-VaRunAll,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaRunAll
CREATE OR ALTER PROCEDURE dbo.VaRunAll
--Store Procedure: VaAllRun
@LanguageNo smallint

AS

Select R.Id
, R.ValuationDate
, R.LatestValuationDate
, IPTXT.TextShort AS IncludedPositions
, STTXT.TextShort AS SynchronizeType
, VTTXT.TextShort AS ValuationType
, VSTXT.TextShort AS ValuationStatus
, R.ValuationTargetStatusNo
, VSTXT2.TextShort AS ValuationStatus
, R.PartnerId	
, B.PartnerNoEdited AS PartnerNo
, isnull(B.Name, '') + ' ' + isnull(B.FirstName, '') AS PartnerName
, R.PortfolioId 
, P.PortfolioNoEdited AS PortfolioNo
from VaRun R
Left Outer Join VaIncludedPosition IP on IP.IncludedPositionsNo = R.IncludedPositionsNo
Left Outer Join AsText IPTXT on IPTXT.MasterId = IP.Id AND IPTXT.LanguageNo = @LanguageNo
Left Outer Join VASynchronizeType ST on ST.SynchronizeTypeNo = R.SynchronizeTypeNo
Left Outer Join AsText STTXT on STTXT.MasterId = ST.Id AND STTXT.LanguageNo = @LanguageNo
Left Outer Join VaValuationType VT on VT.ValuationTypeNo = R.ValuationTypeNo
Left Outer Join AsText VTTXT on VTTXT.MasterId = VT.Id AND VTTXT.LanguageNo = @LanguageNo
Left Outer Join VaValuationStatus VS on VS.ValuationStatusNo = R.ValuationStatusNo
Left Outer Join ASText VSTXT on VSTXT.MasterId = VS.Id AND VSTXT.LanguageNo = @LanguageNo
Left Outer Join VaValuationStatus VS2 on VS2.ValuationStatusNo = R.ValuationTargetStatusNo
Left Outer Join ASText VSTXT2 on VSTXT2.MasterId = VS2.Id AND VSTXT2.LanguageNo = @LanguageNo
Left Outer Join PtBase B on R.PartnerId = B.Id
Left Outer Join PtPortfolio P on R.PortfolioId = P.Id
