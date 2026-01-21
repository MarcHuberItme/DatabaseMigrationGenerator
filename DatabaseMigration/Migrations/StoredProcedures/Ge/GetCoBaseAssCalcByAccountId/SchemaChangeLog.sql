--liquibase formatted sql

--changeset system:create-alter-procedure-GetCoBaseAssCalcByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCoBaseAssCalcByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCoBaseAssCalcByAccountId
CREATE OR ALTER PROCEDURE dbo.GetCoBaseAssCalcByAccountId
@VeraGroup int,
@LanguageNo tinyint,
@AccountId uniqueidentifier

As

Select C.Id, C.CollateralId, SX.TextShort As SubTypeTx, B.Collno, C.Pledgevalueassign, Cast(C.Pledgevalueassign/IsNull(C.Rate,1) As Money) As PVAssign, B.Collsubtype,
X.TextShort As Class, BC.Pricover, BC.SubpriCover, BC.Typecov, C.Calcgrp,
BC.CompTypeNoF, CX.TextShort As CompTypeNoFDesc,
BC.CompTypeNoV, CVX.TextShort As CompTypeNoVDesc
From CoBaseAssCalc C Join CoTypeCov T On C.Typecov = T.Typecov
Join AsText X On X.MasterId = T.Id And X.LanguageNo = @LanguageNo
Join CoBase B On B.Id = C.CollateralId Join CoSubType ST On B.CollSubType = ST.CollSubType
Join AsText SX On SX.MasterId = ST.Id And SX.LanguageNo = @LanguageNo
Join CoBaseCalc BC On C.CoBaseCalcId = BC.Id
Left Outer Join PrPrivateCompType CT On CT.CompTypeNo = BC.CompTypeNoF
Left Outer Join AsText CX On CT.Id = CX.MasterId And CX.LanguageNo = @LanguageNo
Left Outer Join PrPrivateCompType CVT On CVT.CompTypeNo = BC.CompTypeNoV
Left Outer Join AsText CVX On CVT.Id = CVX.MasterId And CVX.LanguageNo = @LanguageNo
Where C.HdVersionNo > 0 And C.HdVersionNo < 999999999 And C.PledgeValueAssign >= 0
And C.AccountId = @AccountId
And C.Veragrp = @VeraGroup
Order By C.Veragrp Desc, BC.Pricover Asc, BC.SubpriCover Asc, BC.Typecov Asc, C.PledgeValueAssign Desc, B.CollNo Asc

