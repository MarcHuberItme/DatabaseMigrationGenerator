--liquibase formatted sql

--changeset system:create-alter-procedure-PositionValueCheck context:any labels:c-any,o-stored-procedure,ot-schema,on-PositionValueCheck,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PositionValueCheck
CREATE OR ALTER PROCEDURE dbo.PositionValueCheck
@PositionId uniqueidentifier
AS
    select
            sum(DebitAmount) as DebitSum,sum(creditamount)as CreditSum 
    from 
            pttransitem
    WHERE 
              Pttransitem.PositionId = @PositionId and 
              Pttransitem.HdVersionNo between 1 and 999999998
