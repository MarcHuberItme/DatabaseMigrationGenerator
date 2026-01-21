--liquibase formatted sql

--changeset system:create-alter-procedure-GetAlRightsGivenByPartnerId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetAlRightsGivenByPartnerId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetAlRightsGivenByPartnerId
CREATE OR ALTER PROCEDURE dbo.GetAlRightsGivenByPartnerId
@PartnerId uniqueidentifier,
@ExclCollectiveFlag integer,
@PerDate DateTime,
@RelationTypeNo integer
As
SELECT * FROM GetALRightsGivenIds (@PartnerId, @ExclCollectiveFlag, @PerDate, @RelationTypeNo)

