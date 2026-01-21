--liquibase formatted sql

--changeset system:create-alter-procedure-PtCheckResult_InitProcessing context:any labels:c-any,o-stored-procedure,ot-schema,on-PtCheckResult_InitProcessing,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtCheckResult_InitProcessing
CREATE OR ALTER PROCEDURE dbo.PtCheckResult_InitProcessing
    @CheckTypeNo int
AS
    UPDATE PtCheckResult SET IsActualized = 0
    WHERE CheckTypeNo = @CheckTypeNo
       AND IsActualized <> 0
RETURN 0

