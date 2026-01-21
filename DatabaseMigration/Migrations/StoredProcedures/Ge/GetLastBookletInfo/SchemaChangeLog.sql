--liquibase formatted sql

--changeset system:create-alter-procedure-GetLastBookletInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetLastBookletInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetLastBookletInfo
CREATE OR ALTER PROCEDURE dbo.GetLastBookletInfo

@PositionId  uniqueidentifier

As
	DECLARE @BookletLineNo int
	DECLARE @BookletPageNo int
	DECLARE @BookletMgtBalance money
	DECLARE @BookletPrintDate datetime

/*  Get Last BookletLineNo, BookletPageNo, BookletPrintDate */
Select 
	@BookletLineNo = ISNULL(BookletLine,0), 
	@BookletPageNo = ISNULL(BookletPage,1), 
	@BookletPrintDate = BookletPrintDate,
	@BookletMgtBalance = ISNULL(BookletBalance,0)
from
	PtPosition
Where 
    Id = @PositionId and     
	HdVersionNo between 1 and 9999998

if(@@ROWCOUNT = 0)
BEGIN
	SET @BookletLineNo = 0
	SET @BookletPageNo = 1
	SET @BookletPrintDate = NULL
END

Select  @BookletLineNo AS BookletLineNo,
	@BookletPageNo AS BookletPageNo,
	@BookletPrintDate AS BookletPrintDate,	
	@BookletMgtBalance As BookletMgtBalance
