--liquibase formatted sql

--changeset system:create-alter-procedure-DataExport_GetAccounts context:any labels:c-any,o-stored-procedure,ot-schema,on-DataExport_GetAccounts,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DataExport_GetAccounts
CREATE OR ALTER PROCEDURE dbo.DataExport_GetAccounts
    @PartnerId uniqueidentifier,
    @LanguageNo int AS
SELECT  IsNull(t.TextShort,'') As Bez,
   Substring(Cast(a.AccountNo as varchar(20)),3,18) As Nr,
   Substring(a.AccountNoEdited,4, Len(a.AccountNoEdited)-2) As NrFormatted,
   IsNull(Convert(varchar(25),pos.ValueProductCurrency,1),'0.00') As SignedSaldoFormatted,
   LEFT(a.AccountNoEdited,2) As Rub,
   IsNull(a.CustomerReference,'') As Untertitel,
   ref.Currency As WaehrungBez

 
FROM PtPortfolio p 
   JOIN PtAccountBase a on p.Id = a.PortfolioId
   LEFT OUTER JOIN PrReference ref on ref.AccountId = a.Id
   LEFT OUTER JOIN PtPosition pos on pos.ProdReferenceId = ref.Id
   LEFT OUTER JOIN PtAccountAvisText t on t.AccountId = a.Id and t.LanguageNo = @LanguageNo

Where p.PartnerId = @PartnerId
   AND a.TerminationDate Is NULL
   AND a.HdVersionNo Between 1 AND 999999998
ORDER BY a.AccountNo

