--liquibase formatted sql

--changeset system:create-alter-view-PtRelationTypeView context:any labels:c-any,o-view,ot-schema,on-PtRelationTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtRelationTypeView
CREATE OR ALTER VIEW dbo.PtRelationTypeView AS
SELECT PtRelationType.Id, PtRelationType.RelationTypeNo, AsText.TextShort, AsText.LanguageNo FROM PtRelationType
INNER JOIN AsText ON PtRelationType.Id = AsText.MasterId
