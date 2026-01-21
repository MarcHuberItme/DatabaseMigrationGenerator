--liquibase formatted sql

--changeset system:create-alter-view-AsCountryNameView context:any labels:c-any,o-view,ot-schema,on-AsCountryNameView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsCountryNameView
CREATE OR ALTER VIEW dbo.AsCountryNameView AS
SELECT
AsCountry.Id,
AsText.LanguageNo,
AsCountry.ISOCode, 
AsText.TextShort
FROM AsCountry
JOIN AsText ON AsCountry.Id = AsText.MasterId
