--liquibase formatted sql

--changeset system:create-alter-procedure-swMtAccounts context:any labels:c-any,o-stored-procedure,ot-schema,on-swMtAccounts,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure swMtAccounts
CREATE OR ALTER PROCEDURE dbo.swMtAccounts
--(SP: swMtAccounts)
@SettingId uniqueidentifier
AS
Select MA.SWIFT_ADR
, MA.AccountMessageNumber
, MA.LastTransDate, MA.MessageType
, REF.Currency, CB.MinorUnit
, POS.ValueProductCurrency
, MA.ID as MtAccountId
, AB.AccountNo
, AB.ID as AccountId
, MA.IsToSendSummary
, MA.DateFrom
, MA.LastAdhocTransDateTime
From swMtAccount MA
Inner Join ptAccountBase AB on AB.ID = MA.AccountId And MA.HdVersionNo<999999999
Inner Join prReference REF on REF.AccountId = AB.Id 
Inner Join ptPosition POS on POS.ProdReferenceId = REF.Id
Inner Join CyBase CB On REF.Currency=CB.Symbol
Where (DateTo is Null or DateTo >=  CONVERT(varchar(8), GetDate(), 112))
	AND DateFrom <  CONVERT(varchar(8), GetDate(), 112)
   AND SwSettingId = @SettingId

