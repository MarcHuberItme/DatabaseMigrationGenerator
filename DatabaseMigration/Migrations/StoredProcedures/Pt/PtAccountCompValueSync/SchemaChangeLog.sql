--liquibase formatted sql

--changeset system:create-alter-procedure-PtAccountCompValueSync context:any labels:c-any,o-stored-procedure,ot-schema,on-PtAccountCompValueSync,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtAccountCompValueSync
CREATE OR ALTER PROCEDURE dbo.PtAccountCompValueSync
@AccountId  uniqueidentifier	

As	
	
UPDATE Compo SET SyncValue = CompoValue.Value, SyncValidTo = CompoPeriod.ValidTo, SyncValidFrom = CompoValue.ValidFrom
FROM PtAccountComponent Compo 
Left Outer Join PtAccountCompValidPeriodView CompoPeriod On Compo.Id=CompoPeriod.Id
Left Outer Join PtAccountCompValue CompoValue On CompoValue.AccountComponentId=Compo.Id And CompoValue.ValidFrom=CompoPeriod.ValidFrom 
                                                                                        And CompoValue.HdVersionNo < 999999999
WHERE Compo.AccountBaseId = @AccountId
