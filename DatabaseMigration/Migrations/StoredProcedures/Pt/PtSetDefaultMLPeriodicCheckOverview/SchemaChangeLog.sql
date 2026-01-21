--liquibase formatted sql

--changeset system:create-alter-procedure-PtSetDefaultMLPeriodicCheckOverview context:any labels:c-any,o-stored-procedure,ot-schema,on-PtSetDefaultMLPeriodicCheckOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PtSetDefaultMLPeriodicCheckOverview
CREATE OR ALTER PROCEDURE dbo.PtSetDefaultMLPeriodicCheckOverview
	@PartnerID uniqueidentifier 
AS
BEGIN
	-- SET NOCOUNT ON added to prevent extra result sets from
	-- interfering with SELECT statements.
	SET NOCOUNT ON;

	DECLARE @User varchar(max) = 'INT\brm'

	SET xact_abort ON

	BEGIN TRANSACTION

	-- Insert default records into PtMLPeriodicCheckOverview
	INSERT INTO PtMLPeriodicCheckOverview
	(
		HdCreator, HdChangeUser, HdVersionNo, HdPendingChanges, HdPendingSubChanges, HdTriggerControl, 
		PartnerId, CustomerTypeNoCalculated, TemplateNoCalculated
	)
	VALUES (@User, @User, 1, 0, 0, 1, @PartnerID, 50, 50)


	-- Insert records into AsNavigationIndex
	INSERT INTO AsNavigationIndex
	(
		Id, HdCreator, HdChangeUser, HdVersionNo, HdPendingChanges, HdPendingSubChanges, TableName, 
		ParentTableName, ParentTableId, RootTableName, RootTableId, Status
	)
	VALUES (NEWID(), @User, @User, 1, 1, 1, 'PtMLPeriodicCheckOverview', 'PtBase', @PartnerID, 'PtBase', @PartnerID, 5)

	-- Insert records into AsNavigationIndexSub
	INSERT INTO AsNavigationIndexSub
	(
		Id, TableName, NavigationIndexId, ConfStatus
	)
	SELECT
		NEWID(), 'PtMLPeriodicCheckOverview', ai.Id, 5
	FROM PtBase base
	JOIN AsNavigationIndex ai ON ai.ParentTableId = base.Id and ai.TableName = 'PtMLPeriodicCheckOverview'
	WHERE NOT EXISTS
	(
		SELECT 1
		FROM AsNavigationIndexSub ans
		WHERE ans.NavigationIndexId = ai.Id
	)

	COMMIT TRANSACTION


END
