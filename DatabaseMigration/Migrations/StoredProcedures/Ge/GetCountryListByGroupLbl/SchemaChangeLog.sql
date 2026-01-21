--liquibase formatted sql

--changeset system:create-alter-procedure-GetCountryListByGroupLbl context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCountryListByGroupLbl,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCountryListByGroupLbl
CREATE OR ALTER PROCEDURE dbo.GetCountryListByGroupLbl

@GroupTypeLbl varchar(50),
@GroupLbl varchar(50)

AS

SELECT IsoCode FROM AsCountry AS C 
INNER JOIN AsGroupMember    AS GM  ON GM.TargetRowId = C.Id 
INNER JOIN AsGroup                 AS G   ON G.Id = GM.GroupId 
INNER JOIN AsGroupType         AS GT  ON GT.Id = GM.GroupTypeId 
INNER JOIN AsGroupLabel        AS GL  ON GL.GroupId = G.Id 
INNER JOIN AsGroupTypeLabel AS GTL ON GTL.GroupTypeId = GT.Id 
WHERE GTL.Name = @GroupTypeLbl AND GL.Name = @GroupLbl
AND C.HdVersionNo BETWEEN 1 AND 999999998
AND G.HdVersionNo BETWEEN 1 AND 999999998
AND GT.HdVersionNo BETWEEN 1 AND 999999998
AND GL.HdVersionNo BETWEEN 1 AND 999999998
AND GTL.HdVersionNo BETWEEN 1 AND 999999998

