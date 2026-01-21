--liquibase formatted sql

--changeset system:create-alter-procedure-PrPrivateByPositionId context:any labels:c-any,o-stored-procedure,ot-schema,on-PrPrivateByPositionId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PrPrivateByPositionId
CREATE OR ALTER PROCEDURE dbo.PrPrivateByPositionId
@id uniqueidentifier
as
SELECT     PrPrivate.*
FROM         PtPosition INNER JOIN
                      PrReference ON PtPosition.ProdReferenceId = PrReference.Id INNER JOIN
                      PrPrivate ON PrReference.ProductId = PrPrivate.ProductId
Where PtPosition.Id = @id
