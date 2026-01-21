--liquibase formatted sql

--changeset system:create-alter-view-AsSwissTownView context:any labels:c-any,o-view,ot-schema,on-AsSwissTownView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsSwissTownView
CREATE OR ALTER VIEW dbo.AsSwissTownView AS
SELECT     TOP 100 PERCENT
                   Id,
                   HdVersionNo,
                   HdPendingChanges,
                   HdPendingSubChanges,
                   SwissTownNo,
                   CantonSymbol,
                   Population,
                   Surface,
                   LanguageNo,
                   ISNULL(Town + ' ', '') + ISNULL(CantonSymbol, '  ')                                 AS Town,
	   Town AS TownSearch
FROM         AsSwissTown
WHERE     (HdVersionNo BETWEEN 1 AND 999999998)
