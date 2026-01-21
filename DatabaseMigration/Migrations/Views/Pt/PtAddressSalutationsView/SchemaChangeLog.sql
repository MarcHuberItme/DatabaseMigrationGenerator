--liquibase formatted sql

--changeset system:create-alter-view-PtAddressSalutationsView context:any labels:c-any,o-view,ot-schema,on-PtAddressSalutationsView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAddressSalutationsView
CREATE OR ALTER VIEW dbo.PtAddressSalutationsView AS
Select Ads.Type, T.LanguageNo, ISNULL(T.TextLong,'') AS TextLong, ISNULL(T.TextShort,'') AS TextShort
From PtAddressSalutations AdS
Left Outer Join AsText T On Ads.Id = T.MasterId
Where AdS.HdVersionNo < 999999999
