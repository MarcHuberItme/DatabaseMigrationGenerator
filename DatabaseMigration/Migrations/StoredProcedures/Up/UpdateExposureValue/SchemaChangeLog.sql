--liquibase formatted sql

--changeset system:create-alter-procedure-UpdateExposureValue context:any labels:c-any,o-stored-procedure,ot-schema,on-UpdateExposureValue,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UpdateExposureValue
CREATE OR ALTER PROCEDURE dbo.UpdateExposureValue
@PledgeRegisterId UniqueIdentifier,
@ValueTypeNo Smallint

AS

UPDATE RePledgeRegister 
SET ExposureDate = GETDATE(), 
ExposureValue = 
( 
     SELECT SUM(RPV.Amount) AS Amount 
     FROM RePremisesValues RPV 
     WHERE PremisesId IN 
     ( 
          SELECT RP.Id 
          FROM RePledgeRegister RPR2 
          LEFT OUTER JOIN RePremises RP ON RPR2.ReBaseId = RP.ReBaseId 
          WHERE RPR2.Id = RPR.Id 
          AND RP.HdVersionNo BETWEEN 1 AND 999999998 
     ) 
     AND RPV.ValueTypeNo = @ValueTypeNo
     AND RPV.ValueDate = 
     ( 
          SELECT MAX( ValueDate ) 
          FROM RePremisesValues RPV2 
          WHERE RPV2.PremisesId = RPV.PremisesId 
          AND RPV2.ValueTypeNo = RPV.ValueTypeNo 
          AND RPV2.HdVersionNo BETWEEN 1 AND 999999998 
     ) 
     AND RPV.HdVersionNo BETWEEN 1 AND 999999998 
) 
FROM RePledgeRegister RPR 
WHERE RPR.Id = @PledgeRegisterId
AND RPR.HdVersionNo BETWEEN 1 AND 999999998 
