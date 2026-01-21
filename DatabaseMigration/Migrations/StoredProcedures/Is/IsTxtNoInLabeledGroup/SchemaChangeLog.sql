--liquibase formatted sql

--changeset system:create-alter-procedure-IsTxtNoInLabeledGroup context:any labels:c-any,o-stored-procedure,ot-schema,on-IsTxtNoInLabeledGroup,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure IsTxtNoInLabeledGroup
CREATE OR ALTER PROCEDURE dbo.IsTxtNoInLabeledGroup
 @TextNo smallint,
    @GroupLabel NVarChar(32),
    @Result TINYINT OUTPUT
As
Declare @txtNoId Uniqueidentifier
Select @txtNoId  = Id from PtTransItemText Where TextNo = @TextNo

exec isInLabeledGroup @txtNoId, @GroupLabel , @Result 
