--liquibase formatted sql

--changeset system:create-alter-view-OaNotificationRuleView context:any labels:c-any,o-view,ot-schema,on-OaNotificationRuleView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view OaNotificationRuleView
CREATE OR ALTER VIEW dbo.OaNotificationRuleView AS
select 
	r.Id as RuleId,
	agrapp.AgrEBankingId,
	AsText.TextShort as ApplicationCode,
	r.Name, 
	r.WithDetails, 
	r.PushEnabled, 
	r.AllAccounts,
	r.AllPortfolio,
	ic.MinAmount as InstantConfigMinAmount, 
	ic.MaxAmount as InstantConfigMaxAmount,
	txt.TextShort as TextShort,
	txt.TextLong as TextLong
from 
	OaNotificationGeneral g
	right outer join OaNotificationSet s on g.NotificationSetId = s.Id and s.HdVersionNo between 0 and 999999998
	right outer join OaNotificationRule r on s.Id = r.NotificationSetId and r.HdVersionNo between 0 and 999999998
	left outer join OaNotificationInstantConfig ic on r.Id = ic.NotificationRuleId and ic.HdVersionNo between 0 and 999999998
	join OaNotificationTrigger t on r.NotificationTriggerId = t.Id and t.HdVersionNo between 0 and 999999998
	join OaAgrApp agrapp on g.AgrAppId = agrapp.Id and agrapp.HdVersionNo between 0 and 999999998
	join OaApp app on agrapp.AppId = app.Id and app.HdVersionNo between 0 and 999999998
	left outer join PtAgrEBanking eb on agrapp.AgrEBankingId = eb.Id and eb.HdVersionNo between 0 and 999999998
	join PtAddress addr on eb.PartnerId = addr.PartnerId and addr.AddressTypeNo = 11 and addr.HdVersionNo between 0 and 999999998
	left outer join OaNotificationText txt on case when r.WithDetails = 1 then t.DetailedTextId else t.SimpleTextId end = txt.Id and txt.LanguageNo = isnull(addr.PreferredLanguageNo, 2) and txt.HdVersionNo between 0 and 999999998
	left outer join AsText on app.Id = AsText.MasterId and AsText.MasterTableName = 'OaApp' and AsText.LanguageNo = isnull(addr.PreferredLanguageNo, 2)
where 
	r.IsActive = 1
	and g.IsActive = 1
	and g.HdVersionNo between 0 and 999999998
