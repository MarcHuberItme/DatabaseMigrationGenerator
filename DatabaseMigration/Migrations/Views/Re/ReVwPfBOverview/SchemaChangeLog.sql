--liquibase formatted sql

--changeset system:create-alter-view-ReVwPfBOverview context:any labels:c-any,o-view,ot-schema,on-ReVwPfBOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReVwPfBOverview
CREATE OR ALTER VIEW dbo.ReVwPfBOverview AS
SELECT     RePledgeRegister.PledgeRegisterNo AS [Pfandreg No], RePledgeRegister.PledgeRegisterPartNo AS [Teilpfandreg No], 
                      RePledgeRegister.BCNumber AS [BC No], ReBase.Town AS Ort, RePremises.GBNo AS [GB Nummer], RePremises.GBNoAdd AS [GB Zusatz], 
                      RePremises.GBPlanNo AS Plannummer, RePledgeRegister.ValueAmount AS Deckungswert, AsText_2.TextShort AS Gebäudetyp, 
                      AsText_1.TextShort AS Grundstücktyp, AsText.TextShort AS Liegenschaftstyp
FROM         RePremises INNER JOIN
                      ReBase ON RePremises.ReBaseId = ReBase.Id INNER JOIN
                      ReBuilding ON RePremises.Id = ReBuilding.PremisesId INNER JOIN
                      ReBaseType ON ReBase.BaseTypeNo = ReBaseType.BaseTypeNo INNER JOIN
                      ReBuildingType ON ReBuilding.BuildingTypeNo = ReBuildingType.BuildingTypeNo INNER JOIN
                      RePremisesType ON RePremises.PremisesType = RePremisesType.PremisesType INNER JOIN
                      AsText ON ReBaseType.Id = AsText.MasterId INNER JOIN
                      AsText AsText_1 ON RePremisesType.Id = AsText_1.MasterId INNER JOIN
                      AsText AsText_2 ON ReBuildingType.Id = AsText_2.MasterId RIGHT OUTER JOIN
                      RePledgeRegister ON ReBase.Id = RePledgeRegister.ReBaseId
WHERE     (AsText_2.LanguageNo = 2) AND (AsText_1.LanguageNo = 2) AND (AsText.LanguageNo = 2)
