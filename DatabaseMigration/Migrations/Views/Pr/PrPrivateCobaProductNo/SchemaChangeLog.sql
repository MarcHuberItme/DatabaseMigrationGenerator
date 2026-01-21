--liquibase formatted sql

--changeset system:create-alter-view-PrPrivateCobaProductNo context:any labels:c-any,o-view,ot-schema,on-PrPrivateCobaProductNo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PrPrivateCobaProductNo
CREATE OR ALTER VIEW dbo.PrPrivateCobaProductNo AS
select Pr.Id, Pr.ProductNo, Pr.ProductId
from AsGroupMember Gm
inner join AsGroup AS G ON G.Id = Gm.GroupId
inner join AsGroupLabel AS Gl ON G.Id = Gl.GroupId
inner join PrPrivate AS Pr ON Gm.TargetRowId = Pr.Id
WHERE Gl.Name = 'ForexPositionTypeBanks'
