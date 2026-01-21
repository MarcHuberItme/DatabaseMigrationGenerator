--liquibase formatted sql

--changeset system:create-alter-view-EsEventSubscriptionView context:any labels:c-any,o-view,ot-schema,on-EsEventSubscriptionView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EsEventSubscriptionView
CREATE OR ALTER VIEW dbo.EsEventSubscriptionView AS
select EsEventSubscription.Id,
EsEventSubscription.HdCreateDate,
EsEventSubscription.HdCreator,
EsEventSubscription.HdChangeDate,
EsEventSubscription.HdChangeUser,
EsEventSubscription.HdEditStamp,
EsEventSubscription.HdVersionNo,
EsEventSubscription.HdProcessId,
EsEventSubscription.HdStatusFlag,
EsEventSubscription.HdNoUpdateFlag,
EsEventSubscription.HdPendingChanges,
EsEventSubscription.HdPendingSubChanges,
EsEventSubscription.HdTriggerControl,
EsEventSubscription.Name, EsEventSubscription.EventSubscriptionNo,
EsEvent.IntegrationEventName,
EsEventSubscription.EventNo,
EsEventSubscription.ChannelTypeNo,
EsEventSubscription.ApplicationCode, EsEventSubscription.DataTemplate  from EsEventSubscription
inner join EsEvent on EsEventSubscription.EventNo = EsEvent.EventNo
