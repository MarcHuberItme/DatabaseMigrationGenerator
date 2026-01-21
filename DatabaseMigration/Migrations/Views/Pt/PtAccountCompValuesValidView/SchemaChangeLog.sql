--liquibase formatted sql

--changeset system:create-alter-view-PtAccountCompValuesValidView context:any labels:c-any,o-view,ot-schema,on-PtAccountCompValuesValidView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountCompValuesValidView
CREATE OR ALTER VIEW dbo.PtAccountCompValuesValidView AS
SELECT  
  dbo.PtAccountComponent.AccountBaseId ,
  dbo.PtAccountComponent.MgVBNR,
  dbo.PtAccountComponent.Id,
  dbo.PtAccountCompValue.ValidFrom,  
  MIN(ISNULL(PtAccountCompValue_1.ValidFrom,'9999-12-31 23:59:59.998')) as VT,   
  PtAccountCompValue.[Value]
FROM  
  dbo.PtAccountComponent INNER JOIN  
  dbo.PrPrivateCompType ON   
  dbo.PtAccountComponent.PrivateCompTypeId = dbo.PrPrivateCompType.Id INNER JOIN  
  dbo.PtAccountCompValue ON   
  dbo.PtAccountComponent.Id = dbo.PtAccountCompValue.AccountComponentId AND
  dbo.PtAccountCompValue.HdVersionNo BETWEEN 1 AND 999999998 LEFT OUTER JOIN  
  dbo.PtAccountCompValue PtAccountCompValue_1 ON   
  dbo.PtAccountCompValue.ValidFrom < PtAccountCompValue_1.ValidFrom AND   
  dbo.PtAccountCompValue.AccountComponentId = PtAccountCompValue_1.AccountComponentId  AND
  PtAccountCompValue_1.HdVersionNo BETWEEN 1 AND 999999998
WHERE  PrPrivateCompType.IsDebit = 1
       AND GETDATE() >= PtAccountCompValue.ValidFrom
       AND PtAccountCompValue.[Value] < 900000000000000
       AND PtAccountCompValue.HdVersionNo BETWEEN 1 AND 999999998
       AND PtAccountComponent.HdVersionNo BETWEEN 1 AND 999999998
GROUP BY   
  dbo.PtAccountComponent.AccountBaseId ,
  dbo.PtAccountComponent.MgVBNR,
  dbo.PtAccountComponent.Id,
  dbo.PtAccountCompValue.ValidFrom  ,
  PtAccountCompValue.[Value]
HAVING  
  (MIN(ISNULL(PtAccountCompValue_1.ValidFrom,'9999-12-31 23:59:59.998')) > GETDATE()) 
/*OR    (MIN(PtAccountCompValue_1.ValidFrom) IS NULL)*/

