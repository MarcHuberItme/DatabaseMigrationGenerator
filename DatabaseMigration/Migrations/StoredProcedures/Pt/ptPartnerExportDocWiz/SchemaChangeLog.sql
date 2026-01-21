--liquibase formatted sql

--changeset system:create-alter-procedure-ptPartnerExportDocWiz context:any labels:c-any,o-stored-procedure,ot-schema,on-ptPartnerExportDocWiz,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure ptPartnerExportDocWiz
CREATE OR ALTER PROCEDURE dbo.ptPartnerExportDocWiz
--Store Procedure: ptPartnerExportDocWiz
@AddressId uniqueidentifier,
@UserId uniqueidentifier
As
/*
Declare @AddressId AS uniqueidentifier
Declare @User AS uniqueidentifier
Set @AddressId = '{8C0878A4-A5AF-4798-974C-6E3A022BBDE8}'
Set @UserId = '{EC860976-B8C0-4252-81FC-70DB37475CDF}'
*/


SELECT 	PT.PartnerId
,	PT.AddressId 
,	PT.CarrierTypeNo
,	PT.DeliveryRuleNo
,	PT.IsPrimaryCorrAddress


FROM  PtCorrPartner AS PT

WHERE	Pt.HdVersionNo BETWEEN 1 AND 999999998
		AND PT.AddressId = @AddressId 

