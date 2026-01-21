--liquibase formatted sql

--changeset system:create-alter-view-AsTemplateView context:any labels:c-any,o-view,ot-schema,on-AsTemplateView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsTemplateView
CREATE OR ALTER VIEW dbo.AsTemplateView AS
SELECT DISTINCT 1 AS HdVersionNo, 0 AS HdPendingChanges, 0 AS HdPendingSubChanges, DocName 
FROM     AsTemplate T 
WHERE  T.Disabled = 0
AND       (T.HdVersionNo BETWEEN 1 AND 999999998)
GROUP BY T.DocName
