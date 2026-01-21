--liquibase formatted sql

--changeset system:create-alter-view-AsParameterView context:any labels:c-any,o-view,ot-schema,on-AsParameterView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsParameterView
CREATE OR ALTER VIEW dbo.AsParameterView AS
SELECT     TOP 100 PERCENT g.HdVersionNo, g.GroupName, p.[Name] As ParameterName, p.[Value]
FROM         AsParameterGroup g LEFT OUTER JOIN
                   AsParameter p ON g.Id = p.ParamGroupId
WHERE     (g.HdVersionNo BETWEEN 1 AND 999999998) 
    AND (p.HdVersionNo BETWEEN 1 AND 999999998) 
ORDER BY g.GroupName



