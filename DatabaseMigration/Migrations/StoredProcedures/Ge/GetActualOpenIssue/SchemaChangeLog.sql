--liquibase formatted sql

--changeset system:create-alter-procedure-GetActualOpenIssue context:any labels:c-any,o-stored-procedure,ot-schema,on-GetActualOpenIssue,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetActualOpenIssue
CREATE OR ALTER PROCEDURE dbo.GetActualOpenIssue
as
Declare @Today AS datetime
set @Today = GETDATE()

SELECT I.*,P.Id AS PartnerId, P.PartnerNoEdited, P.Name, P.FirstName, P.NameCont, P.ConsultantTeamName, T.DefaultGroup, T.PreActivation
FROM PtOpenIssue I
JOIN PtBase P ON P.Id = I.PartnerId
JOIN PtOpenIssueType T ON T.TypeNo = I.TypeNo
WHERE I.ActivationDate <= @Today
 AND I.StatusNo = 5
 AND I.ProcessId Is Null
 AND I.HdVersionNo < 999999999
 AND T.WorkflowMapName <> ''

