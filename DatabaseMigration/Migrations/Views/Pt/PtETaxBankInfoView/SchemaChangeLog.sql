--liquibase formatted sql

--changeset system:create-alter-view-PtETaxBankInfoView context:any labels:c-any,o-view,ot-schema,on-PtETaxBankInfoView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtETaxBankInfoView
CREATE OR ALTER VIEW dbo.PtETaxBankInfoView AS
Select Cast(U.Value As nvarchar(20)) As Uid, 
Cast(LEI.Value As nvarchar(20)) As Lei, 
Cast(BN.Value As nvarchar(60)) As Name
From AsParameter As BSN Join AsParameter As LEI On BSN.ParamGroupId=LEI.ParamGroupId
Join AsParameter As BN On BSN.ParamGroupId=BN.ParamGroupId
Join AsParameter As U On BSN.ParamGroupId=U.ParamGroupId
Join AsParameterGroup G On BSN.ParamGroupId=G.Id And G.GroupName='System'
Where BSN.Name='BankShortName' And LEI.Name='LEI' And BN.Name='BankName' And U.Name='UID'

