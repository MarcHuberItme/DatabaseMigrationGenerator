--liquibase formatted sql

--changeset system:create-alter-view-AsBranchView context:any labels:c-any,o-view,ot-schema,on-AsBranchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsBranchView
CREATE OR ALTER VIEW dbo.AsBranchView AS
select AsBranch.Id, AsBranch.BranchNo, AsText.TextShort, AsText.LanguageNo from AsBranch 
left join AsText on AsBranch.Id = AsText.MasterId
