--liquibase formatted sql

--changeset system:create-alter-procedure-PsGetBranchLabelText context:any labels:c-any,o-stored-procedure,ot-schema,on-PsGetBranchLabelText,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PsGetBranchLabelText
CREATE OR ALTER PROCEDURE dbo.PsGetBranchLabelText
    @BranchNo Integer,
    @LanguageNo Tinyint
AS
SELECT  l.Label, t.TextLong
FROM PsBranchLabel l 
    JOIN PsBranchLabelText blt ON l.Id = blt.LabelId
    LEFT OUTER JOIN AsBranch b ON b.Id = blt.BranchId
    JOIN AsText t ON t.MasterId = blt.Id AND t.LanguageNo = @LanguageNo
WHERE  b.BranchNo = @BranchNo or b.BranchNo Is Null

