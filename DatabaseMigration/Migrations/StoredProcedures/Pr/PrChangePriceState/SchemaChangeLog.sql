--liquibase formatted sql

--changeset system:create-alter-procedure-PrChangePriceState context:any labels:c-any,o-stored-procedure,ot-schema,on-PrChangePriceState,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PrChangePriceState
CREATE OR ALTER PROCEDURE dbo.PrChangePriceState
   @lngProdNum       int,               /* Product Number of Product to change  */
   @bytBeforeState   tinyint,          /* State  to change from                           */
   @bytAfterState      tinyint,          /* State to change to                                */
   @strUserName      varchar(15)  /* Creator name (actual user)                    */

/* No Return Values */

AS
   SET NOCOUNT ON

   UPDATE PrComposedPrice
      SET State = @bytAfterState, HdCreator = @strUserName
      WHERE State = @bytBeforeState AND
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

