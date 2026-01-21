--liquibase formatted sql

--changeset system:create-alter-procedure-GetItemsOfCorrGroup context:any labels:c-any,o-stored-procedure,ot-schema,on-GetItemsOfCorrGroup,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetItemsOfCorrGroup
CREATE OR ALTER PROCEDURE dbo.GetItemsOfCorrGroup
@CorrItemGroupNo integer,
@LanguageNo tinyint
AS

Select I.Id,I.ItemNo,T.TextShort From AsCorrItem As I
Join AsCorrItemAssign As A On I.Id = A.CorrItemId
Join AsText As T On I.Id = T.MasterId
Where A.CorrItemGroupNo = @CorrItemGroupNo
And T.LanguageNo = @LanguageNo
And A.HdVersionNo <> 999999999
