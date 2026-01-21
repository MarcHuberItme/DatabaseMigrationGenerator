--liquibase formatted sql

--changeset system:create-alter-procedure-GetCardPendingChanges context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCardPendingChanges,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCardPendingChanges
CREATE OR ALTER PROCEDURE dbo.GetCardPendingChanges
@CardId UniqueIdentifier

AS

select
       c.*,
       wi.Param, 
       wi.Id AS WiId
from
       PtAgrCard a inner join
       PtAgrCardBase b on b.Id = a.CardId inner join
       BpJobWorkItem wi on wi.RefTable = 'ptagrcard' and wi.RefId = a.Id and wi.Status = 0 inner join
       PtAgrCard c  on c.CardId = b.Id and c.CardStatus = 0 and c.Id <> a.Id and wi.Param like '%' + cast(c.Id as nvarchar(max)) + '%'
where  a.id = @CardId 
       and a.HdVersionNo < 999999999
       and b.HdVersionNo < 999999999
       and wi.HdVersionNo < 999999999
       and c.HdVersionNo < 999999999

