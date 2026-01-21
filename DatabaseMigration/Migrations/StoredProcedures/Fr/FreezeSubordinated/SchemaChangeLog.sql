--liquibase formatted sql

--changeset system:create-alter-procedure-FreezeSubordinated context:any labels:c-any,o-stored-procedure,ot-schema,on-FreezeSubordinated,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure FreezeSubordinated
CREATE OR ALTER PROCEDURE dbo.FreezeSubordinated
@ReportDate datetime

As

UPDATE AcFrozenAccount SET Subordinated = 2 WHERE AccountId in (
    SELECT AccountId FROM AcFrozenCollateral coll WHERE coll.ReportDate = AcFrozenAccount.ReportDate and coll.CollType = 6000 and coll.CollSubType = 6200 
	)
and AcFrozenAccount.ReportDate = @ReportDate

