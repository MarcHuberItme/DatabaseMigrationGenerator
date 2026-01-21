--liquibase formatted sql

--changeset system:create-alter-procedure-CyRateRule_GetRuleForImport context:any labels:c-any,o-stored-procedure,ot-schema,on-CyRateRule_GetRuleForImport,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CyRateRule_GetRuleForImport
CREATE OR ALTER PROCEDURE dbo.CyRateRule_GetRuleForImport
@PaymentInstrumentNo  as integer
AS
Select RR.*,FactorOriginate, FactorTarget 
from cyRateRule RR
Inner join cyRatePresentation RP on RR.cySymbolOriginate = RP.cySymbolOriginate AND RR.cySymbolTarget = RP.cySymbolTarget
Where PaymentInstrumentNo = @PaymentInstrumentNo  
AND RR.cySymbolOriginate <> 'CHF'
--And AutomaticImport  <> 0
