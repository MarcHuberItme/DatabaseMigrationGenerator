--liquibase formatted sql

--changeset system:create-alter-function-GetPM1PrivateProdGroupLabel context:any labels:c-any,o-function,ot-schema,on-GetPM1PrivateProdGroupLabel,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetPM1PrivateProdGroupLabel
CREATE OR ALTER FUNCTION dbo.GetPM1PrivateProdGroupLabel
(
@ProductNo int
)
RETURNS varchar(50)
AS BEGIN
RETURN (
select  isnull(AsGroupLabeL.Name,'Rest') as GroupLabel from PrPrivate
left outer join AsGroupTypeLabel on AsGroupTypeLabel.Name = 'PM1AccountGrouping'
left outer join AsGroupMember on PrPrivate.Id = AsGroupMember.TargetRowId and AsGroupMember.GroupTypeId = AsGroupTypeLabel.GroupTypeId
left outer join AsGroupLabeL on AsGroupMember.GroupId = AsGroupLabel.GroupId
left outer join AsText on PrPrivate.Id  =AsText.MasterId and AsText.LanguageNo = 2
Where PrPrivate.ProductNo =@ProductNo
)
END

