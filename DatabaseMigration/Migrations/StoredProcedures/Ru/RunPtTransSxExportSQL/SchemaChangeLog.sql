--liquibase formatted sql

--changeset system:create-alter-procedure-RunPtTransSxExportSQL context:any labels:c-any,o-stored-procedure,ot-schema,on-RunPtTransSxExportSQL,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RunPtTransSxExportSQL
CREATE OR ALTER PROCEDURE dbo.RunPtTransSxExportSQL
@FileTypeNo INT, -- 300
@ExportTypeNo INT, -- 11, 12, 13, 16, 21, 22, 23, 26 for FinfraG Art 39
@MaxTradesPerFile INT, -- 1000
@DebugMode BIT = 0

AS

BEGIN
    DECLARE @ParamsAsString VARCHAR(200) = 'DECLARE @FileTypeNo INT = ' + CAST(@FileTypeNo AS VARCHAR(10)) + '; DECLARE @ExportTypeNo INT = ' + CAST(@ExportTypeNo AS VARCHAR(10)) + '; DECLARE @MaxTradesPerFile INT = ' + CAST(@MaxTradesPerFile AS VARCHAR(10)) + ';';
    
    DECLARE @SqlCommand VARCHAR(MAX);
    DECLARE @cnt INT = 0;
    DECLARE @maxSequence INT = 0;
    
    IF OBJECT_ID('tempdb..#SMR81_DataExtract') IS NOT NULL DROP TABLE #SMR81_DataExtract
    create table #SMR81_DataExtract( InstrumentTypeNo tinyint
    ,BROKERPORTFOLIOID uniqueidentifier
    ,PTTRANSTRADEID uniqueidentifier
    ,PTTRANSTRADEPRESETTLEMENTID uniqueidentifier    -- this is just used for sequence 1999 and not for the result file
    ,PORTFOLIONO bigint
    ,ISSTOCKEXORDER bit
    ,TRADINGORDERID uniqueidentifier
    ,BANKINTERNALREFERENCE nvarchar(100)
    ,TRANSNO bigint
    ,ENTERINGFIRMORDERCAPACITYPortfolioNo bigint
    ,ENTERINGFIRMORDERCAPACITYPartnerNo bigint
    ,TxReportID	 nvarchar(52) --String-52
    ,TxReportTransType	 tinyint -- 0…9 --Integer-1
    ,TxGroupID	 nvarchar(52) --String-52
    ,InstrumentType	 tinyint -- 0…9 --Integer-1
    ,TrdMatchID	 nvarchar(200) --String-200
    ,VenueCode	 nvarchar(4) -- ISO 10383 --MIC
    ,ISIN	 nvarchar(12) --Isin
    ,CFICode	 nvarchar(6) -- ISO 10962:2015 the FIRDS CFI validations --CFI
    ,UnderlyingISIN	 nvarchar(12) --Isin
    ,UnderlyingISIN2	 nvarchar(12) --Isin
    ,UnderlyingISIN3	 nvarchar(12) --Isin
    ,LastQty	 Decimal(20,6) --Decimal
    ,LastPx	 Decimal(20,6) --Decimal
    ,PriceType	 tinyint -- 0…9 --Integer-1
    ,ExecutionTime	 nvarchar(24) -- YYYYMMDD-HH:MM:SS.CCC --Timestamp
    ,SettlDate	 nvarchar(8) -- YYYYMMDD --Date
    ,EnteringFirmSide	 tinyint -- 0…9 --Integer-1
    ,EnteringFirmSecondaryClOrdID	 nvarchar(52) --String-52
    ,EnteringFirmOrderCapacity	 nvarchar(1) --String-1
    ,EnteringFirmPartyID	 nvarchar(4) -- MemberId --Party
    ,EnteringFirmPerson	 nvarchar(35) --String-35
    ,ContraFirmSubType	 nvarchar(4) --String-4
    ,ContraFirmSubTypeCode	 nvarchar(4) --String-4
    ,ContraFirmPartyID	 nvarchar(35) --String-35
    ,BeneficialOwner	 nvarchar(700) --String-700
    ,Currency	 nvarchar(3) -- SIX supported currencies --Currency
    ,CHFAmount	 Decimal(20,6) --Decimal
    ,ExpirationDate	 nvarchar(8) -- YYYYMMDD --Date
    ,OptionType	 nvarchar(1) --String-1
    ,StrikePrice	 nvarchar(21) --Decimal as text because '' (empty string) should be possible
    ,StrikePriceType	 nvarchar(1) -- 0…9 --Integer-1 as text because '' (empty string) should be possible
    ,LeverageIndicator	 nvarchar(21) --Decimal as text because '' (empty string) should be possible
    ,OrderTransmission	 nvarchar(1) -- Y or N --Boolean
    ,AggregatedOrder	 nvarchar(1) -- Y or N --Boolean
    ,UnderlyingISIN4	 nvarchar(700) --Isin
    ,IsOffExchange bit -- this is just used for sequence 1046 and not for the result file.
    )

    -- Set all sequences for a new run
    UPDATE PtTransSxExportSQL SET ExecStart = NULL, ExecCompleted = NULL, ReportDate = NULL WHERE FileTypeNo = @FileTypeNo AND DataTypeNo = @ExportTypeNo;

    SET @cnt = (SELECT MIN(SequenceNo) FROM PtTransSxExportSQL WHERE FileTypeNo = @FileTypeNo AND DataTypeNo = @ExportTypeNo AND IsSuspended = 0 AND HdVersionNo BETWEEN 1 AND 999999998)

    SET @maxSequence = (SELECT MAX(SequenceNo) FROM PtTransSxExportSQL WHERE FileTypeNo = @FileTypeNo AND DataTypeNo = @ExportTypeNo AND IsSuspended = 0 AND HdVersionNo BETWEEN 1 AND 999999998)

    WHILE @cnt <= @maxSequence
    BEGIN
        UPDATE PtTransSxExportSQL SET ExecStart = GETDATE() WHERE FileTypeNo = @FileTypeNo AND DataTypeNo = @ExportTypeNo AND SequenceNo = @cnt AND IsSuspended = 0 AND HdVersionNo BETWEEN 1 AND 999999998;

        -- If UPDATE did not work, the sequence does not exist
        IF @@ROWCOUNT = 0
        BEGIN
            SET @cnt = @cnt + 1;
            CONTINUE;
        END;

        SET @SqlCommand = (SELECT CAST(SqlCommand AS NVARCHAR(MAX)) FROM PtTransSxExportSQL WHERE FileTypeNo = @FileTypeNo AND DataTypeNo = @ExportTypeNo AND SequenceNo = @cnt AND IsSuspended = 0 AND HdVersionNo BETWEEN 1 AND 999999998);

        -- If the SQL Command is identical to another, then use the sequence SQL code from that one. Example: 'IDENTICAL WITH 11'
        IF LEFT(@SqlCommand, 14) = 'IDENTICAL WITH'
        BEGIN
            DECLARE @IdenticalDataType INT = CAST(SUBSTRING(@SqlCommand, 16, 2) AS INT)
            SET @SqlCommand = (SELECT CAST(SqlCommand AS NVARCHAR(MAX)) FROM PtTransSxExportSQL WHERE FileTypeNo = @FileTypeNo AND DataTypeNo = @IdenticalDataType AND SequenceNo = @cnt AND IsSuspended = 0 AND HdVersionNo BETWEEN 1 AND 999999998);
        END;

        IF @SqlCommand IS NOT NULL
        BEGIN
            IF @DebugMode = 1
                PRINT 'Executing SequenceNo: ' + CAST(@cnt AS NVARCHAR(10))
                    + '; for (FileTypeNo,ExportTypeNo):(' 
                    + CAST(@FileTypeNo AS NVARCHAR(10)) + ',' + CAST(@ExportTypeNo AS NVARCHAR(10)) + ')';

            IF @DebugMode = 10
                PRINT @SqlCommand;

            exec(@ParamsAsString + ' ' + @SqlCommand);
        END;

        UPDATE PtTransSxExportSQL SET ExecCompleted = GETDATE() WHERE FileTypeNo = @FileTypeNo AND DataTypeNo = @ExportTypeNo AND SequenceNo = @cnt AND IsSuspended = 0 AND HdVersionNo BETWEEN 1 AND 999999998;

        SET @cnt = @cnt + 1;
    END; -- WHILE

    UPDATE PtTransSxExportSQL SET ReportDate = CAST(GETDATE() AS DATE) WHERE FileTypeNo = @FileTypeNo AND DataTypeNo = @ExportTypeNo;
END;
