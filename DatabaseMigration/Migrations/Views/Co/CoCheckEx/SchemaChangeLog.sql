--liquibase formatted sql

--changeset system:create-alter-view-CoCheckEx context:any labels:c-any,o-view,ot-schema,on-CoCheckEx,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoCheckEx
CREATE OR ALTER VIEW dbo.CoCheckEx AS
Select Distinct A.PrivateProductNo, X.TextShort, Pri.ProductId
From AcBalanceStructure S Join AcBalanceAcctAssignment A On A.BalanceAccountNo =S.BalanceAccountNo
  And A.HdVersionNo<999999999 
Join PrPrivate Pri On Pri.ProductNo=A.PrivateProductNo And Pri.HdVersionNo<999999999
Join AsText X On X.MasterId=Pri.Id And X.LanguageNo=2
Where S.HdVersionNo<999999999 And S.AL1=20

