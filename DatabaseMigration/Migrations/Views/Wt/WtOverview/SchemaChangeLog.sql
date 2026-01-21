--liquibase formatted sql

--changeset system:create-alter-view-WtOverview context:any labels:c-any,o-view,ot-schema,on-WtOverview,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view WtOverview
CREATE OR ALTER VIEW dbo.WtOverview AS
SELECT wt.Employee, wt.Workday, ar.AreaNo, tar.TextShort As AreaText , pr.ProjectNo, tpr.TextShort As ProjectText, tac.textShort AS ActivityText, wt.Hours, wt.Comment, tar.LanguageNo As LanguageNo,  
   year(wt.Workday) as Wtyear, datepart(ww,wt.Workday) As WtWeek, day(wt.Workday) As Wtday,
   IsNull((ar.WatchList | pr.WatchList), ar.WatchList) As WatchList
   from WtArea ar
   join WtWorkTime wt on wt.AreaNo = ar.AreaNo and wt.HdVersionNo < 999999999
   join WtActivity ac on ac.Id = wt.ActivityId
   Left outer join WtProject pr on pr.Id = wt.ProjectId
   left outer join AsText tar ON tar.MasterId = ar.id 
   left outer join AsText tpr on tpr.masterId = pr.Id and tpr.LanguageNo = tar.LanguageNo
   left outer join AsText tac on tac.MasterId = ac.Id and tac.LanguageNo = tar.LanguageNo
