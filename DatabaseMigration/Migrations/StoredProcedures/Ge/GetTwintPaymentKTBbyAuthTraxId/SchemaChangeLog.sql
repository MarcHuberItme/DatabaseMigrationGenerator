--liquibase formatted sql

--changeset system:create-alter-procedure-GetTwintPaymentKTBbyAuthTraxId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetTwintPaymentKTBbyAuthTraxId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetTwintPaymentKTBbyAuthTraxId
CREATE OR ALTER PROCEDURE dbo.GetTwintPaymentKTBbyAuthTraxId
@AuthTrxId nvarchar(16) AS

SELECT * FROM PtPaymentKTB
WHERE HdVersionNo BETWEEN 1 AND 999999998 
AND AuthTrxId = @AuthTrxId
AND FileSource = 'Twint'

