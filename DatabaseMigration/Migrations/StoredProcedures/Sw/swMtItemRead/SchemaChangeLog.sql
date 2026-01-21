--liquibase formatted sql

--changeset system:create-alter-procedure-swMtItemRead context:any labels:c-any,o-stored-procedure,ot-schema,on-swMtItemRead,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure swMtItemRead
CREATE OR ALTER PROCEDURE dbo.swMtItemRead
--(SP: swMtItemRead Input swMtAccount.Id)
@ID Uniqueidentifier
as

Select Top 100 MI.MessageNumber
, MI.ValueDate
, MI.TransDate
, MI.CreditDebit
, MI.Currency
, MI.Amount
, 'NTRFNONREF' as Reference
, CAST(REPLACE(CAST(MultiPurposeField as varchar(max)),'??','') AS [nvarchar](390)) AS MultiPurposeField
, Transmitted
, MI.TransItemId
, MI.ProcessId
From swMtItem MI 
Where MI.MtAccountId = @ID
   AND Transmitted = 0
Order by ValueDate DESC
