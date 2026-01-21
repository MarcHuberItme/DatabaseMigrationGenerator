--liquibase formatted sql

--changeset system:create-alter-procedure-GetCurrencyListForDerivative context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCurrencyListForDerivative,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCurrencyListForDerivative
CREATE OR ALTER PROCEDURE dbo.GetCurrencyListForDerivative

@ReportDate datetime
AS
DECLARE @CyList VARCHAR(500)
DECLARE @dfltCyList VARCHAR(500)
DECLARE @sqlCommand VARCHAR(1000)
SET @dfltCyList = ('''CHF'', ''USD'', ''GBP'', ''JPY'', ''CAD'', ''AUD'', ''EUR'', ''NOK'', ''NZD'', ''SEK'', ''DKK'', ''ILS''')
SELECT @CyList = value FROM AsParameter WHERE Name = 'IntrRateCyList'
If (@CyList is null)
  BEGIN
    SET @CyList = @dfltCyList
  END
SET @sqlCommand = 'SELECT Symbol AS Currency FROM CyBase WHERE Symbol IN (' + @CyList + ') ORDER BY Symbol ASC'
EXEC (@sqlCommand)
