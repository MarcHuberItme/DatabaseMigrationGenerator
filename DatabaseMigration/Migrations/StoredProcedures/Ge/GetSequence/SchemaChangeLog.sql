--liquibase formatted sql

--changeset system:create-alter-procedure-GetSequence context:any labels:c-any,o-stored-procedure,ot-schema,on-GetSequence,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetSequence
CREATE OR ALTER PROCEDURE dbo.GetSequence
    @SequenceName Varchar(30),
    @SequenceNo Integer OUTPUT

AS 

UPDATE AsSequence
   SET SequenceNo = SequenceNo + 1
   WHERE SequenceName = @SequenceName

If @@RowCount = 0 
     Return (-1)
 

SET @SequenceNo = (SELECT SequenceNo from AsSequence
                    WHERE SequenceName = @SequenceName)

