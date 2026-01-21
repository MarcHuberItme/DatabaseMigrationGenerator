--liquibase formatted sql

--changeset system:create-alter-procedure-NcZvBatchDelta context:any labels:c-any,o-stored-procedure,ot-schema,on-NcZvBatchDelta,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure NcZvBatchDelta
CREATE OR ALTER PROCEDURE dbo.NcZvBatchDelta
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
		AND py.HdChangeDate > @LastExecutionDate
		ORDER BY py.Id
END
