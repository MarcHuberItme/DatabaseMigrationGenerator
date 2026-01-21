--liquibase formatted sql

--changeset system:create-alter-function-GetTransTypeNoListByGroupLbl context:any labels:c-any,o-function,ot-schema,on-GetTransTypeNoListByGroupLbl,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetTransTypeNoListByGroupLbl
CREATE OR ALTER FUNCTION dbo.GetTransTypeNoListByGroupLbl
(
	@GroupTypeLbl varchar(50),
	@GroupLbl varchar(50)
)

RETURNS @Table TABLE(	--Return type of the function
TransTypeNo int
)
AS
BEGIN

INSERT INTO @Table
SELECT TransTypeNo FROM PtTransType AS C 
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

RETURN

END
