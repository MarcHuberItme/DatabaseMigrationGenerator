--liquibase formatted sql

--changeset system:create-alter-procedure-GetObligationTotal context:any labels:c-any,o-stored-procedure,ot-schema,on-GetObligationTotal,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetObligationTotal
CREATE OR ALTER PROCEDURE dbo.GetObligationTotal
@ReBaseId UniqueIdentifier
AS
SELECT     SUM(ReObligation.ObligAmount) AS Total
FROM         ReObligation INNER JOIN
                      ReObligPremisesRelation ON ReObligation.Id = ReObligPremisesRelation.ObligationId INNER JOIN
                      RePremises ON ReObligPremisesRelation.PremisesId = RePremises.Id INNER JOIN
                      ReBase ON RePremises.ReBaseId = ReBase.Id
WHERE ReBase.Id = @ReBaseId

