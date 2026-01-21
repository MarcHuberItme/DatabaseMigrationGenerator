--liquibase formatted sql

--changeset system:create-alter-procedure-GetPtAccountComposedPriceByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPtAccountComposedPriceByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPtAccountComposedPriceByAccountId
CREATE OR ALTER PROCEDURE dbo.GetPtAccountComposedPriceByAccountId
@ReferenceDate datetime,
@AccountId uniqueidentifier

As

Select ACP.*
From PtAccountComposedPrice ACP Join PtAccountComponent AC On ACP.AccountComponentId = AC.Id
And ((ACP.ValidTo Is Null And ACP.Value <> 0)
Or (ACP.ValidTo Is Null And ACP.Value = 0 And AC.IsOldComponent = 0)
Or ACP.ValidTo> = @ReferenceDate)
And ACP.ValidFrom <= @ReferenceDate
Join PrPrivateCompType T On AC.PrivateCompTypeId = T.Id And T.HdVersionNo > 0 And T.HdVersionNo < 999999999
And (T.IsFixed = 0 Or (T.IsFixed = 1 And ACP.Value > 0))
Where AC.AccountBaseId = @AccountId

