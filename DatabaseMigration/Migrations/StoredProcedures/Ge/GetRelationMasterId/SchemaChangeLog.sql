--liquibase formatted sql

--changeset system:create-alter-procedure-GetRelationMasterId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetRelationMasterId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetRelationMasterId
CREATE OR ALTER PROCEDURE dbo.GetRelationMasterId
    @ParentTableId UniqueIdentifier,
    @RelationTypeNo int

AS
    DECLARE @MasterId UNIQUEIDENTIFIER

    Set @MasterId = (SELECT Id from PtRelationMaster
                     WHERE PartnerId = @ParentTableId
                      And RelationTypeNo = @RelationTypeNo
                      And (HdVersionNo BETWEEN 1 AND 999999998))

    IF @MasterId IS NULL
        BEGIN
          set @MasterId = NewId()
          SELECT @MasterId
             INSERT INTO PtRelationMaster (Id,PartnerId,RelationTypeNo,HdVersionNo)
                                       VALUES (@MasterId,@ParentTableId,@RelationTypeNo,1)
        END
    ELSE
        SELECT @MasterId

