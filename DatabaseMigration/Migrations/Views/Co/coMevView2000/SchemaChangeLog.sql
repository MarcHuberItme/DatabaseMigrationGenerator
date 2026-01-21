--liquibase formatted sql

--changeset system:create-alter-view-coMevView2000 context:any labels:c-any,o-view,ot-schema,on-coMevView2000,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view coMevView2000
CREATE OR ALTER VIEW dbo.coMevView2000 AS
SELECT        a.id,
              a.HdCreateDate, 
              a.HdEditStamp,
              a.HdStatusFlag, 
              a.HdPendingChanges, 
              a.HdPendingSubChanges, 
              a.HdVersionNo,
              a.HdProcessId,
              a.mevyear,
              a.mevmonth,                
              a.accountid,
              a.AccountNo,     
              a.VaRunID,
              a.portfolioid,
              b.portfoliono,
              a.C551,
              a.veragrp,
              a.Veradate,
              a.Calcgrp,
              a.CollateralId,
              a.collno,
              a.Collsubtype,
              a.Pricover,
              a.SubpriCover,
              a.Colltype,
              a.cobasecalcid,
              a.CoValuetotkw,
              a.Currency,
              a.CoValuetot,
              a.vkadjustfak,   
              a.CoValuetotAdjust,
              a.Pledgevalueassign,
              b.posquantid,
              b.InstrumentTypeno,
              b.ISINNo,
              b.PublicId,
              b.Description,
              b.collateralvaluechf as poscollateralvaluechf,
/* sieh CoSumFireView */
              case when (a.CoValuetotAdjust / a.CoValuetot) <>0
                then 
                 cast((b.collateralvaluechf * (a.CoValuetotAdjust / a.CoValuetot)) as money)
                else 0  
                end as poscollateralvaluechfAdjust,
              b.totalvaluechf as postotalvaluechf,
              case when (a.CoValuetotAdjust / a.CoValuetot) <>0
                then 
                   cast((b.totalvaluechf * (a.CoValuetotAdjust / a.CoValuetot)) as money)
                else 0  
                end as postotalvaluechfAdjust,
              case when (a.CoValuetotAdjust / a.CoValuetot) <>0
                then 
                   cast((b.ValQuantity * (a.CoValuetotAdjust / a.CoValuetot)) as money)
                else 0  
                end as PosValQuantityAdjust,
              b.ActualQuantity ,
              b.ValQuantity,
              b.Id As PositionId
                FROM    comevview as a,ptpositionvaluationview as b 
                where a.portfolioid is not null and
                 a.colltype = 2000 and
                 a.portfolioid = b.portfolioid and
                 a.varunid = b.varunid and
                 b.languageno = 2 and
                 isnull(b.collateralvaluechf,0) <> 0
