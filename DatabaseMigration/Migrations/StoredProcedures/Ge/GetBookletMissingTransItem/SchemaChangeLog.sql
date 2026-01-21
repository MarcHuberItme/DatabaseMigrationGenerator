--liquibase formatted sql

--changeset system:create-alter-procedure-GetBookletMissingTransItem context:any labels:c-any,o-stored-procedure,ot-schema,on-GetBookletMissingTransItem,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetBookletMissingTransItem
CREATE OR ALTER PROCEDURE dbo.GetBookletMissingTransItem
@PositionId uniqueidentifier, @IsToIncludeAlreadyPrinted bit, @intTop  int= 0

AS 

DECLARE @SQLString NVARCHAR(1000)

if(@IsToIncludeAlreadyPrinted=0)
--    INSERT INTO #t(ID,ToPrint,TransDate,ValueDate,DebitAmount,CreditAmount,BookletText)	
    SELECT PtTransItem.Id, PtTransItem.HdVersionNo as ToPrint, PtTransItem.TransDate, PtTransItem.ValueDate, PtTransItem.DebitAmount,
	PtTransItem.CreditAmount,  pttransitemtext.BookletText, PtTransItem.AdvicePrinted, PtTransItem.BookletPrintDate ,                 PtTransItem.BookletPageNo , PtTransItem.BookletLineNo   
    FROM PtTransItem
	Inner Join pttransitemtext  on PtTransItem.TextNo = PtTransItemText.TextNo
    WHERE   
              pttransitem.PositionId = @PositionId and   
              pttransitem.BookletPrintDate IS NULL and   
              pttransitemtext.TextNo = pttransitem.TextNo and  
              pttransitem.HdVersionNo between 1 and 999999998
              order by PtTransItem.TransDate DESC

else
begin
   set @SQLString = 
    'SELECT Top ' + cast(@intTop as varchar(32)) + ' PtTransItem.Id, 
	case
		WHEN BookletPrintDate is NULL THEN PtTransItem.HdVersionNo
		ELSE PtTransItem.HdPendingSubChanges

	END as ToPrint,
	PtTransItem.TransDate, PtTransItem.ValueDate, PtTransItem.DebitAmount, PtTransItem.CreditAmount,
	pttransitemtext.BookletText, PtTransItem.AdvicePrinted, PtTransItem.BookletPrintDate , PtTransItem.BookletPageNo ,                 PtTransItem.BookletLineNo FROM PtTransItem 
	Inner Join pttransitemtext  on PtTransItem.TextNo = PtTransItemText.TextNo 
	WHERE   Pttransitem.PositionId = ''' + cast(@PositionId as varchar(50)) + ''' and  
	Pttransitemtext.TextNo = pttransitem.TextNo 
	and  pttransitem.HdVersionNo between 1 and 999999998
	 Order By PtTransItem.TransDate DESC'

  execute  sp_executesql @SQLString
end
