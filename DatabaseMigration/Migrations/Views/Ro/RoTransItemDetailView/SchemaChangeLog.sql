--liquibase formatted sql

--changeset system:create-alter-view-RoTransItemDetailView context:any labels:c-any,o-view,ot-schema,on-RoTransItemDetailView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view RoTransItemDetailView
CREATE OR ALTER VIEW dbo.RoTransItemDetailView AS
SELECT TOP 100 PERCENT tid.*
FROM RoTransItemDetail tid
WHERE NOT EXISTS (
		SELECT Id
		FROM RoTransItemDetail ti
		WHERE ti.CancelTransMsgId = tid.TransMessageId
		)
	AND (tid.CancelTransMsgId IS NULL OR tid.ReversalIndicator = 0)

