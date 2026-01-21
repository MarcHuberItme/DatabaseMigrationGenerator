--liquibase formatted sql

--changeset system:create-alter-procedure-CheckProxyForAccount context:any labels:c-any,o-stored-procedure,ot-schema,on-CheckProxyForAccount,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CheckProxyForAccount
CREATE OR ALTER PROCEDURE dbo.CheckProxyForAccount
@MasterId UniqueIdentifier,
@SlaveId UniqueIdentifier,
@AccountId UniqueIdentifier,
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
    And P.AccountId = @AccountId
    And R.HdVersionNo < 999999999 And P.HdVersionNo < 999999999)

IF @ProxyDetailId IS NULL
    BEGIN
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
                Select P.* From PtRelationSlave R
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
    END
ELSE
    BEGIN
        Select *, PtProxyDetail.Instruction as InstructionDetail FROM PtProxyDetail Where Id = @ProxyDetailId
    END

