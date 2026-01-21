--liquibase formatted sql

--changeset system:create-alter-procedure-CheckProxyForPortfolio context:any labels:c-any,o-stored-procedure,ot-schema,on-CheckProxyForPortfolio,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CheckProxyForPortfolio
CREATE OR ALTER PROCEDURE dbo.CheckProxyForPortfolio
@MasterId UniqueIdentifier,
@SlaveId UniqueIdentifier,
@PortfolioId UniqueIdentifier,
@Date Datetime

AS

declare @ProxyDetailId uniqueidentifier

Set @ProxyDetailId = (Select P.Id From PtRelationSlave R
    Left Outer Join PtProxyDetail P
    On R.Id = P.RelationSlaveId
    Where R.MasterId = @MasterId
    And R.PartnerId = @SlaveId
    And P.ValidFrom <= @Date And (P.ValidTo >= @Date Or P.ValidTo is Null)
    And P.PortfolioId = @PortfolioId
    And R.HdVersionNo < 999999999 And P.HdVersionNo < 999999999)

IF @ProxyDetailId IS NULL
    BEGIN
        Select P.*  From PtRelationSlave R
        Left Outer Join PtProxyDetail P
        On R.Id = P.RelationSlaveId
        Where R.MasterId = @MasterId
        And R.PartnerId = @SlaveId
        And P.ValidFrom <= @Date And (P.ValidTo >= @Date Or P.ValidTo is Null)
        And P.PortfolioId Is NULL And P.AccountId Is NULL
        And R.HdVersionNo < 999999999 And P.HdVersionNo < 999999999
    END
ELSE
    BEGIN
        Select * FROM PtProxyDetail Where Id = @ProxyDetailId
    END

