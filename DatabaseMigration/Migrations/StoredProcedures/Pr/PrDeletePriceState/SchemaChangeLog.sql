--liquibase formatted sql

--changeset system:create-alter-procedure-PrDeletePriceState context:any labels:c-any,o-stored-procedure,ot-schema,on-PrDeletePriceState,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PrDeletePriceState
CREATE OR ALTER PROCEDURE dbo.PrDeletePriceState
   @lngProdNum    int,          /* Product Number of Product to delete */
   @bytState      tinyint         /* State which is to eliminate                   */

/* No Return Values */

AS
   SET NOCOUNT ON

   DELETE
      FROM  PrComposedPrice
      WHERE State = @bytState AND
            PrivateComponentNo IN
               (
               SELECT PrivateComponentNo
               FROM   PrPrivateComponent
               WHERE  PrivateCurrRegionId IN
                  (
                  SELECT Id
                  FROM   PrPrivateCurrRegion
                  WHERE  ProductNo = @lngProdNum
                  )
               )

