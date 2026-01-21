--liquibase formatted sql

--changeset system:create-alter-view-TdSrcCodesOrderTypeView context:any labels:c-any,o-view,ot-schema,on-TdSrcCodesOrderTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view TdSrcCodesOrderTypeView
CREATE OR ALTER VIEW dbo.TdSrcCodesOrderTypeView AS
SELECT 
       HdVersionNo, TdCodeValue AS OrderType, TdCodeDescription AS TextShort
FROM 
       TdCodes
WHERE
       TdCodeGroup = N'TdOrder'
       AND TdCodeItem = N'TdOrderType'
       AND HdVersionNo BETWEEN 1 AND 999999998
