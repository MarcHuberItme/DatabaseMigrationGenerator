--liquibase formatted sql

--changeset system:create-alter-procedure-PrCopyPriceState context:any labels:c-any,o-stored-procedure,ot-schema,on-PrCopyPriceState,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure PrCopyPriceState
CREATE OR ALTER PROCEDURE dbo.PrCopyPriceState
   @lngProdNum       int,               /* Product Number of Product to copy   */
   @bytBeforeState   tinyint,          /* State to copy from                              */
   @bytAfterState      tinyint,          /* State to copy to                                 */
   @strCreator           varchar(15)  /* "username" of initiator                        */

/* No Return Values */

AS 

   SET NOCOUNT ON

   INSERT INTO PrComposedPrice
      (HdCreator, HdVersionNo, HdTriggerControl,
       PrivateComponentNo, ValidFrom, ValidTo, InterestRate,
       CommissionRate, ProvisionRate, State)
   SELECT
       @strCreator, HdVersionNo, HdTriggerControl,
       PrivateComponentNo, ValidFrom, ValidTo, InterestRate,
       CommissionRate, ProvisionRate, @bytAfterState 
   FROM   PrComposedPrice
   WHERE  State = @bytBeforeState AND
             PrivateComponentNo IN
                (
                SELECT  PrivateComponentNo
                FROM    PrPrivateComponent
                WHERE   PrivateCurrRegionId IN
                   (
                   SELECT Id
                   FROM   PrPrivateCurrRegion
                   WHERE  ProductNo = @lngProdNum
                   )
                )

