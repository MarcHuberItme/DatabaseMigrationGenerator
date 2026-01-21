--liquibase formatted sql

--changeset system:create-alter-procedure-GetBalance_LimitsBySecurityId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBalance_LimitsBySecurityId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBalance_LimitsBySecurityId
CREATE OR ALTER PROCEDURE dbo.GetBalance_LimitsBySecurityId
@strSecurityId	uniqueidentifier,
@curLimitsAmount money OUTPUT

AS

SET @curLimitsAmount=0
Select @curLimitsAmount=Sum(AvailableAmount-UsedAmount) from PtAgrSecurityPosition
inner join PtAgrSecurityVersion on PtAgrSecurityPosition.SecurityVersionId = PtAgrSecurityVersion.Id
Where PtAgrSecurityVersion.AgrSecurityId 
= @strSecurityId

