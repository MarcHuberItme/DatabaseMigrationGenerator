--liquibase formatted sql

--changeset system:create-alter-procedure-NcZvBatchFull context:any labels:c-any,o-stored-procedure,ot-schema,on-NcZvBatchFull,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure NcZvBatchFull
CREATE OR ALTER PROCEDURE dbo.NcZvBatchFull
@LastAddressId uniqueidentifier,
@LastExecutionDate DateTime
AS
BEGIN
	SET NOCOUNT ON;
	SELECT TOP 500 py.Id, py.Beneficary
		FROM AsPayee as py
		WHERE PEPCheck = 0
		AND SkipPEPCheck = 0
		AND py.Id > @LastAddressId
		AND py.HdVersionNo < 999999999
		ORDER BY py.Id
END
