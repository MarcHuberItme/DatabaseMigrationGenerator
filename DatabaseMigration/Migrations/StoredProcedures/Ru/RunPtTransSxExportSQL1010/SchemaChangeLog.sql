--liquibase formatted sql

--changeset system:create-alter-procedure-RunPtTransSxExportSQL1010 context:any labels:c-any,o-stored-procedure,ot-schema,on-RunPtTransSxExportSQL1010,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RunPtTransSxExportSQL1010
CREATE OR ALTER PROCEDURE dbo.RunPtTransSxExportSQL1010
@DateFrom datetime, 
@DateTo datetime,
@StornoPortfolioNo bigint,
@LanguageNo int,
@FileTypeNo INT = 300,
@ExportTypeNo INT = 11,
@MaxTradesPerFile INT = 1000,
@DebugMode BIT = 0

AS

BEGIN
insert into #SMR81_DataExtract
SELECT distinct 
           TOP (@MaxTradesPerFile)
           -- Support fields
           PrPublic.InstrumentTypeNo,
		   PTTR.PortfolioID as BROKERPORTFOLIOID, 
           Isnull(PTTRPS.ID,(PTTR.ID)) AS PTTRANSTRADEID, 
           PTTRANSTRADEPRESETTLEMENTID = PTTRPS.ID, -- wird nicht für File sondern nur für 1999 Sequenz benötigt.
           POD.PORTFOLIONO, 
           TOM.ISSTOCKEXORDER, 
           TOM.TRADINGORDERID, 
           TOM.BANKINTERNALREFERENCE, 
           PTTRANSACTION.TRANSNO, 
           ENTERINGFIRMORDERCAPACITYPortfolioNo = POR.PORTFOLIONO,
           ENTERINGFIRMORDERCAPACITYPartnerNo = PB.PartnerNo,
           -- Fields for SIX
           ISNULL(UPPER(PTO.BANKSHORTNAMEPARTNER), '') + Isnull(REPLACE(PTTRPS.ID, '-', ''),REPLACE(PTTR.ID, '-', '')) AS TXREPORTID,
           0 AS TXREPORTTRANSTYPE, 
           ISNULL(UPPER(PTO.BANKSHORTNAMEPARTNER), '') + Isnull(REPLACE(PTTRPS.ID, '-', ''),REPLACE(PTTR.ID, '-', '')) AS TXGROUPID, 
           1 AS INSTRUMENTTYPE, 
           REPLACE(REPLACE(REPLACE(REPLACE(ISnull(PTTRPS.StockExRef, Isnull(PTTR.StockExRef, '')),':',''),'-',''),'+',''),'_','') AS TRDMATCHID, 
           CASE WHEN 
               PTTRPS.LastMkt  is not null then pttrps.LastMkt
               ELSE
               CASE 
	  WHEN Isnull(PTTR.LastMkt,'') = '' or PTTR.LastMkt = 'Multiple'
	  THEN Isnull(PTP.MarketIdentCode,'') 
	  ELSE PTTR.LastMkt 
	END
           END AS VenueCode,
           --CASE WHEN PTTR.LastMkt IS NULL THEN Isnull(PTP.MarketIdentCode,'') ELSE PTTR.LastMkt END AS VenueCode,
           --Isnull(PTP.MarketIdentCode,'') AS VenueCode,
           PrPublic.ISINNO AS ISIN, 
           '' AS CFICODE, 
           '' AS UNDERLYINGISIN, 
           '' AS UNDERLYINGISIN2, 
           '' AS UNDERLYINGISIN3, 
           abs(convert(decimal(20,6),isnull(pttrps.quantity,isnull(PTTR.QUANTITY,0))))     AS LASTQTY, 
           convert(decimal(20,6),isnull(pttrps.price, isnull(PTTR.Price,0)))               AS LastPx,
           CASE
               WHEN PRPUBLIC.UNITNO IN(1)
               THEN 1
               ELSE 2
           END AS PRICETYPE, 
           FORMAT(isnull(pttrps.PriceDate, PTTR.Pricedate), 'yyyyMMdd-HH:mm:ss.mmm' + '0000') AS EXECUTIONTIME, 
           CONVERT(CHAR(8), PTM.PAYMENTDATE, 112) AS SETTLDATE,
           CASE
               WHEN PTT.TRANSTYPENO IN(54, 601, 621)
               THEN 1
               ELSE 2
           END AS ENTERINGFIRMSIDE, 
           '' AS ENTERINGFIRMSECONDARYCLORDID,
                CASE WHEN pl.PortfolioNo is not null THEN 'P' ELSE 'R' END AS ENTERINGFIRMORDERCAPACITY,            
                null AS ENTERINGFIRMPARTYID, 
           null AS ENTERINGFIRMPERSON, 
           CONTRAFIRMSUBTYPE = CAST(NULL AS NVARCHAR(4)), 
           '' as ContraFirmSubTypeCode,
                CONTRAFIRMPARTYID = CAST(NULL AS NVARCHAR(35)),
           ISNULL(TOM.BeneficialOwnerSMR8, '') AS BENEFICIALOWNER, 
           PTM.PAYMENTCURRENCY AS CURRENCY, 
           cast(case 
                  when Pttrps.LastMkt Is null
	  then abs(PTTR.marketvaluehocu)
       	  else abs(PTTRPS.Quantity * pttrps.Price * (pttr.MarketValueHoCu / pttr.Price / pttr.Quantity))
	  end AS decimal(20,2)) as CHFAMOUNT,  -- The field must be provided for new reports if the PriceType field is either value 6 (Spread) or 9 (Yield).
           --CONVERT(CHAR(8), STV.PAYMENTDATE, 112) AS EXPIRATIONDATE, -- for TOFF
          -- ISNULL(CONVERT(CHAR(8), CF.DUEDATE, 112),'') AS EXPIRATIONDATE,
                '' AS EXPIRATIONDATE, 
                '' AS OptionType,
           '' as StrikePrice,
           '' as StrikePriceType,
           '' AS LEVERAGEINDICATOR, -- NEED TO BE CHECKED STILL !
           case when TS.TradingSystemCode = 'HBL' then 'Y' else 'N' end as OrderTransmission, -- Order in BSZ-Finstar traded over HBL
           case when (PTO.IsListingOrder = 1 or PTO.IsPooledOrder = 1) then 'Y' else 'N' end AS AggregatedOrder, -- listing order
           '' AS UNDERLYINGISIN4, 
           TOM.ISOFFEXCHANGE 
         FROM PtTransTrade PTTR
         INNER JOIN PTTRANSMESSAGE PTM ON PTM.ID = PTTR.TransMessageId
                                          AND PTM.HDVERSIONNO BETWEEN 1 AND 999999998
         INNER JOIN PTTRADINGORDERMESSAGE TOM ON PTM.ID = TOM.TRANSMESSAGEID
                                                 AND TOM.HDVERSIONNO < 999999999
                                                 AND TOM.BeneficialOwnerSMR8 IS NOT NULL
                                                 AND TOM.IsStockExOrder = 0
         INNER JOIN PRPUBLICTRADINGPLACE PTP ON PTP.ID = TOM.PUBLICTRADINGPLACEID
                                              AND PTP.HDVERSIONNO BETWEEN 1 AND 999999998
		 INNER JOIN PtTradingSystem TS on TS.Id = TOM.TradingSystemId 
 					AND TS.HdVersionNo between 1 and 999999998
         INNER JOIN PTTRANSACTION ON PTTRANSACTION.ID = PTM.TRANSACTIONID
                                     AND PTTRANSACTION.HDVERSIONNO BETWEEN 1 AND 999999998
         JOIN PTTRADINGORDER PTO ON TOM.TRADINGORDERID = PTO.ID
         JOIN PTPORTFOLIO POR ON TOM.SECURITYPORTFOLIOID = POR.ID
         JOIN PTBASE PB ON POR.PARTNERID = PB.ID
         INNER JOIN PRPUBLIC ON PRPUBLIC.ID = PTO.PublicId
         LEFT OUTER JOIN PTPORTFOLIO POD ON POD.ID = PTTR.PortfolioId
         LEFT OUTER JOIN PTTRANSTYPE PTT ON PTT.TransTypeNo = PTO.TransTypeNo
		 and PTT.HdVersionNo between 1 and 999999998
         LEFT OUTER JOIN PRPUBLICCF CF ON CF.PUBLICID = PrPublic.ID
                                                                            AND CF.CashFlowFuncNo = 1
                                                                            AND CF.PaymentFuncNo = 18
                                              AND CF.HDVERSIONNO < 999999999
         LEFT OUTER JOIN PtTransTradePreSettlement PTTRPS ON PTTRPS.TransTradeId = PTTR.TransTradeIdBroker
                                              AND PTTRPS.HDVERSIONNO < 999999999
         left join #PortfolioList pl on POR.PortfolioNo = pl.PortfolioNo
         left outer join ptTransSxRegisterPlus PTSRP on PTSRP.SourceRecId = Isnull(PTTRPS.ID,(PTTR.ID)) 
                       and PTSRP.HdCreateDate > dateadd(day,-10,@DateFrom)
                       and PTSRP.HdVersionNo between 1 and 999999998
             left outer join PtTransSxExportRun PTSER on PTSRP.ExportID = PTSER.Id 
                           and FileTypeNo = @FileTypeNo 
                           and ExportTypeNo = @ExportTypeNo 
    WHERE
		  PTTR.PriceDate between dateadd(day,-90,@DateFrom) and @DateTo
		  AND PTTR.HdVersionNo between 1 and 999999998
          AND PTTRANSACTION.TRANSDATE >= @DateFrom 
--          AND PTTRANSACTION.TRANSDATE <= @DateTo   -- not necessary because select of PTTR.PriceDate
          AND TOM.SECURITYPORTFOLIOID IS NOT NULL
          AND PTO.CANCELLEDSTATUS = 0
          AND POD.PORTFOLIONO <> @StornoPortfolioNo
          AND POR.PORTFOLIONO <> @StornoPortfolioNo
          AND EXISTS(select  * from PRPUBLICSIXREPORTING PPUSR WHERE PPUSR.PUBLICID = PRPUBLIC.ID
                                            AND PPUSR.DATEFROM <= PTTR.PriceDate
                                            AND PPUSR.DATETO >= PTTR.PriceDate
                                            AND PPUSR.HASTOBEREPORTED = 1
                                            AND PPUSR.HDVERSIONNO BETWEEN 1 AND 999999998)
          and PTSRP.Id is null   -- instead of "AND NOT EXISTS..."
          and (PTM.TRANSMSGSTATUSNO is null or PTM.TRANSMSGSTATUSNO <> 2)
ORDER By PtTransaction.TransNo
END
