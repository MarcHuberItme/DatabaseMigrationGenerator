--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPartnerCorrInfo context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPartnerCorrInfo,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPartnerCorrInfo
CREATE OR ALTER PROCEDURE dbo.GetPMSPartnerCorrInfo
@partnerNo  decimal (8,0), @corrItemNo smallint
AS
Select PtCorrPartnerViewLang.*
from PtBase
inner join AsCorrItem on AsCorrItem.ItemNo = @corrItemNo 
inner join PtCorrPartnerViewLang on PtBase.Id = PtCorrPartnerViewLang.PartnerId and PtCorrPartnerViewLang.CorrItemId  = AsCorrItem.Id
Where PartnerNo = @partnerNo  
