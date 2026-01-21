--liquibase formatted sql

--changeset system:create-alter-view-IfCamtStatementFileSearchView context:any labels:c-any,o-view,ot-schema,on-IfCamtStatementFileSearchView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view IfCamtStatementFileSearchView
CREATE OR ALTER VIEW dbo.IfCamtStatementFileSearchView AS
select data.Id                           as FileId,
       statement.Id                      as StatementId,
       deliveryHistory.Id                as DeliveryHistoryId,
       deliverySetting.Name              as TransformationSettingName,
       account.AccountNoIbanElect        as Iban,
       account.Id                        as AccountId,
       statement.CreateDate              as CreationDateTime,
       statement.FromDate,
       statement.ToDate,
       deliverySetting.Type              as CamtMessageType,
       deliverySetting.IsEbankingVisible as IsVisibleForEBanking,
       setting.Value                     as CamtSchemaVersion,
       data.HdVersionNo                  as FileHdVersionNo,
       statement.HdVersionNo             as StatementHdVersionNo,
       account.ProductNo                 as AccountProductNo
from IfDeliveryHistory deliveryHistory
         inner join IfCamtStatementDelivery statement on statement.TransformId = deliveryHistory.Id
         inner join IfDeliveryItem deliveryItem on deliveryItem.Id = deliveryHistory.DeliveryItemId
         inner join IfDeliverySetting deliverySetting on deliverySetting.Id = deliveryHistory.DeliverySettingId
         inner join PtAccountAllView account on account.Id = deliveryItem.RefItemId
         inner join IfSettingGroup settingGroup on settingGroup.Id = deliveryItem.LoadSettingGroupId
         inner join IfSetting setting
                    on setting.SettingGroupId = settingGroup.Id AND setting.HdVersionNo < 999999999 and
                       setting.HdVersionNo > 0
         inner join IfSettingConfig settingConfig
                    on settingConfig.Id = setting.SettingConfigId AND settingConfig.Name = 'Schema' AND
                       settingConfig.HdVersionNo < 999999999 and settingConfig.HdVersionNo > 0
         join IfDeliveryDocumentData data on data.DeliveryHistoryId = deliveryHistory.Id
