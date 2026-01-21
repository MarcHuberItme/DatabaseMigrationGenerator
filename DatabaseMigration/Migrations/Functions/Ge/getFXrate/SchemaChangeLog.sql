--liquibase formatted sql

--changeset system:create-alter-function-getFXrate context:any labels:c-any,o-function,ot-schema,on-getFXrate,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function getFXrate
CREATE OR ALTER FUNCTION dbo.getFXrate
(
    @AsOfDate datetime,
    @fromCurr char(3),
    @toCurr char(3)
)
RETURNS @table table(FxRate FLOAT)
AS
BEGIN
insert into @table
select 
(	select	top 1 Rate 
	from	(	select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
				union  
				select 'CHF', 'CHF', @AsOfDate, dateadd(dd,1,@AsOfDate), @AsOfDate, 1	) CRR
	where	CRR.CySymbolTarget = 'CHF' 
			and CRR.CySymbolOriginate = @fromCurr
			and @AsOfDate >= cast(CRR.ValidFrom as date)
			and @AsOfDate < cast(CRR.ValidTo as date)
	order by CRR.HdChangeDate desc
)
/
(	select	top 1 Rate 
	from	(	select CySymbolTarget, CySymbolOriginate, ValidFrom, ValidTo, HdChangeDate, Rate from CyRateRecent where RateType = 203
				union  
				select 'CHF', 'CHF', @AsOfDate, dateadd(dd,1,@AsOfDate), @AsOfDate, 1	) CRR
				where	CRR.CySymbolTarget = 'CHF' 
						and CRR.CySymbolOriginate = @toCurr
						and @AsOfDate >= cast(CRR.ValidFrom as date)
						and @AsOfDate < cast(CRR.ValidTo as date)
				order by CRR.HdChangeDate desc
)

return

END

