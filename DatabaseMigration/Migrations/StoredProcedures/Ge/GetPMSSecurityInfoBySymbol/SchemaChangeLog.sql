--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSSecurityInfoBySymbol context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSSecurityInfoBySymbol,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSSecurityInfoBySymbol
CREATE OR ALTER PROCEDURE dbo.GetPMSSecurityInfoBySymbol
@VdfInstrumentSymbol  varchar(12)
As
Declare @publicId UniqueIdentifier
Select @publicId  = ID from PrPublic Where VdfInstrumentSymbol = @VdfInstrumentSymbol  

exec GetPMSSecurityInfo @publicId
