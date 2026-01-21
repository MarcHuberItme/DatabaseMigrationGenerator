--liquibase formatted sql

--changeset system:create-alter-procedure-CalculateExpensesForTransItems context:any labels:c-any,o-stored-procedure,ot-schema,on-CalculateExpensesForTransItems,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CalculateExpensesForTransItems
CREATE OR ALTER PROCEDURE dbo.CalculateExpensesForTransItems
(@PositionId  as uniqueidentifier,
/*@ValueDateBegin  as datetime,
@ValueDateEnd  as datetime*/

@TransDateBegin  as datetime,
@TransDateEnd  as datetime
)
AS
Select  IsNull(SUM(A.ExpenseFactor * CNT),0) as ExpensesForTransItems from
(
Select  pttransitem.textno, pttransitemtext.ExpenseFactor ,  count(*) as CNT  from pttransitem
inner join pttransitemtext on pttransitemText.textno = pttransitem.textno
Where PositionId = @PositionId
and TransDate>  @TransDateBegin  and TransDate <=@TransDateEnd  
and Detailcounter >0
and Pttransitem.HdVersionNo between 1 and 999999998
and PtTransItem.IsInactive = 0
group by pttransitem.textno, pttransitemtext.ExpenseFactor 
)A
