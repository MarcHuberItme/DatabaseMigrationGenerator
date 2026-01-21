--liquibase formatted sql

--changeset system:create-alter-procedure-GetDeliveryHistoriesByDeliverySettingAndState context:any labels:c-any,o-stored-procedure,ot-schema,on-GetDeliveryHistoriesByDeliverySettingAndState,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetDeliveryHistoriesByDeliverySettingAndState
CREATE OR ALTER PROCEDURE dbo.GetDeliveryHistoriesByDeliverySettingAndState
@DeliverySettingName nvarchar(255),
@State int,
@DateFrom DateTime = null
AS

IF @DateFrom IS NULL
BEGIN
	SET @DateFrom = GetDate()
END

SELECT TOP (1000) [IfDeliveryHistory].*
FROM [IfDeliveryHistory]
WHERE (
		[IfDeliveryHistory].[Id] IN (
			(
				SELECT TOP (20) [IfDeliveryHistory].[Id]
				FROM [IfDeliveryHistory]
				WHERE (
						[IfDeliveryHistory].[DeliverySettingId] = (
							SELECT TOP (1000) [IfDeliverySetting].[Id]
							FROM [IfDeliverySetting]
							WHERE ([IfDeliverySetting].[Name] = @DeliverySettingName)
							AND [IfDeliverySetting].[HdVersionNo] BETWEEN 1 AND 999999998
							)
						)
					AND ([IfDeliveryHistory].[State] = @State)
					AND [IfDeliveryHistory].[HdVersionNo] BETWEEN 1 AND 999999998

				ORDER BY [IfDeliveryHistory].[StartDateTime]
				)
			)
		)
AND IfDeliveryHistory.HdChangeDate < @DateFrom
AND [IfDeliveryHistory].[HdVersionNo] BETWEEN 1 AND 999999998

