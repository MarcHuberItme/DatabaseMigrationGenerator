--liquibase formatted sql

--changeset system:create-alter-procedure-GetPMSPortfolioCorrForArchive context:any labels:c-any,o-stored-procedure,ot-schema,on-GetPMSPortfolioCorrForArchive,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetPMSPortfolioCorrForArchive
CREATE OR ALTER PROCEDURE dbo.GetPMSPortfolioCorrForArchive
@PortfolioNo decimal(11,0) ,  @corrItemNo smallint
As

Select top 1 PtCorrPortfolioViewLang.*, PartnerId
from PtPortfolio
inner join AsCorrItem on AsCorrItem.ItemNo = @corrItemNo 
inner join PtCorrPortfolioViewLang on PtPortfolio.Id = PtCorrPortfolioViewLang.PortfolioId and PtCorrPortfolioViewLang.CorrItemId  = AsCorrItem.Id
Where PortfolioNo = @PortfolioNo
