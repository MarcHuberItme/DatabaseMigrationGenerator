--liquibase formatted sql

--changeset system:create-alter-procedure-GetPrPrivateCompTypeByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPrPrivateCompTypeByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPrPrivateCompTypeByAccountId
CREATE OR ALTER PROCEDURE dbo.GetPrPrivateCompTypeByAccountId
@VeraGroup int,
@CompTypeNo1 int,
@CompTypeNo2 int,
@LanguageNo tinyint,
@AccountId uniqueidentifier

As

Select Distinct T.*, CT.TextShort As CompTypeNoTx,
LX.TextShort As SecurityLevelNoTx
From PrPrivateCompType T Join PrPrivateSecurityLevel L On T.SecurityLevelNo = L.SecurityLevelNo
Join AsText LX On L.Id = LX.MasterId And LX.LanguageNo = @LanguageNo
Join AsText CT On T.Id = CT.MasterId And CT.LanguageNo = @LanguageNo
Where T.CompTypeNo In (@CompTypeNo1, @CompTypeNo2)
Or T.CompTypeNo In (
Select BC.CompTypeNoF As CompTypeNo
From CoBaseAssCalc C Join CoBaseCalc BC On C.CoBaseCalcId = BC.Id
Where C.AccountId = @AccountId And C.Veragrp = @VeraGroup
Union
Select BC.CompTypeNoV As CompTypeNo
From CoBaseAssCalc C Join CoBaseCalc BC On C.CoBaseCalcId = BC.Id
Where C.AccountId = @AccountId And C.Veragrp = @VeraGroup)

