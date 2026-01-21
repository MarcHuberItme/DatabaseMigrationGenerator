--liquibase formatted sql

--changeset system:create-alter-view-TdSrcCodesOrderSerialTypeView context:any labels:c-any,o-view,ot-schema,on-TdSrcCodesOrderSerialTypeView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view TdSrcCodesOrderSerialTypeView
CREATE OR ALTER VIEW dbo.TdSrcCodesOrderSerialTypeView AS
SELECT 
       HdVersionNo, TdCodeValue AS SerialType, TdCodeDescription AS TextShort
FROM 
       TdCodes
WHERE
       TdCodeGroup = N'TdOrder'
       AND TdCodeItem = N'TdSerialType'
       AND HdVersionNo BETWEEN 1 AND 999999998
