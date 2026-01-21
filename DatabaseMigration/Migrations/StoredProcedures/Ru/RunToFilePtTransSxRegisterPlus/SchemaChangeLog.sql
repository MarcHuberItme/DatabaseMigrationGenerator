--liquibase formatted sql

--changeset system:create-alter-procedure-RunToFilePtTransSxRegisterPlus context:any labels:c-any,o-stored-procedure,ot-schema,on-RunToFilePtTransSxRegisterPlus,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure RunToFilePtTransSxRegisterPlus
CREATE OR ALTER PROCEDURE dbo.RunToFilePtTransSxRegisterPlus
@FileTypeNo INT, -- 300
@ExportTypeNo INT, -- 11, 12, 13, 16, 21, 22, 23, 26 for FinfraG Art 39
@StatusPending INT, -- 30
@StatusFileExported INT, -- 40
@DebugMode BIT = 0,
@ProductionMode BIT = 1

AS

BEGIN
    -- Return variables
    DECLARE @ErrorMessage NVARCHAR(MAX); -- VARCHAR(128) should be enough
    DECLARE @ErrorNo INT = 0;
    
    IF OBJECT_ID('tempdb..#ResultTable') IS NOT NULL
        DROP TABLE #ResultTable;
    CREATE TABLE #ResultTable
    (FileName NVARCHAR(60), 
     FileContent VARCHAR(MAX)
    );
    
    IF OBJECT_ID('tempdb..#PtTransSxRegisterPlusRaw') IS NOT NULL DROP TABLE #PtTransSxRegisterPlusRaw
    create table #PtTransSxRegisterPlusRaw
    (TxReportID	 nvarchar(52) --String-52
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
    ,BankInternalReference nvarchar(100) -- This is the only field that is just for ordering and not written to CSV!
    )

    BEGIN TRY
        IF NOT EXISTS
        (
            SELECT *
            FROM PtExportFileType
            WHERE FileTypeNo = @FileTypeNo
                    AND HdVersionNo BETWEEN 1 AND 999999998
        )
        BEGIN
            SET @ErrorMessage = 'Incorrect FileTypeNo in input parameter (see the table: PtExportFileType)';
            SET @ErrorNo = @ErrorNo + 10;
        END
        ELSE
            PRINT 'FileTypeNo check OK';

        IF NOT EXISTS
        (
            SELECT *
            FROM PtExportDataType
            WHERE DataTypeNo = @ExportTypeNo
                    AND HdVersionNo BETWEEN 1 AND 999999998
        )
        BEGIN
            SET @ErrorMessage = ISNULL(@ErrorMessage + ' and ', '') + 'Incorrect ExportTypeNo in input parameter (see the table: PtExportDataType)';
            SET @ErrorNo = @ErrorNo + 100;
        END
        ELSE
            PRINT 'ExportTypeNo check OK';

        IF NOT EXISTS
        (
            SELECT *
            FROM PtExportStatus
            WHERE StatusNo = @StatusPending
                    AND HdVersionNo BETWEEN 1 AND 999999998
        )
        BEGIN
            SET @ErrorMessage = ISNULL(@ErrorMessage + ' and ', '') + 'Incorrect StatusNoPending in input parameter (see the table: PtExportStatus)';
            SET @ErrorNo = @ErrorNo + 1000;
        END
        ELSE
            PRINT 'StatusPending check OK';

        IF NOT EXISTS
        (
            SELECT *
            FROM PtExportStatus
            WHERE StatusNo = @StatusFileExported
                    AND HdVersionNo BETWEEN 1 AND 999999998
        )
        BEGIN
            SET @ErrorMessage = ISNULL(@ErrorMessage + ' and ', '') + 'Incorrect StatusNoFileExported in input parameter (see the table: PtExportStatus)';
            SET @ErrorNo = @ErrorNo + 10000;
        END
        ELSE
            PRINT 'StatusFileExported check OK';

        IF @ErrorNo = 0
        BEGIN
            -- Declares
            DECLARE @SqlCommandExportToFile VARCHAR(MAX);
            DECLARE @SqlCommandDecoder VARCHAR(MAX);
            DECLARE @cnt INT = 0;
            DECLARE @ExportId UNIQUEIDENTIFIER;
            DECLARE @Filename VARCHAR(60);
            DECLARE @FileContentResult VARCHAR(MAX);

            DECLARE smr81_cursor CURSOR
            FOR SELECT Id, FileName
                FROM PtTransSxExportRun
                WHERE FileTypeNo = @FileTypeNo
                        AND ExportTypeNo = @ExportTypeNo
                        AND StatusNo = @StatusPending
                ORDER BY ExportDate;
            OPEN smr81_cursor;
            
            FETCH NEXT FROM smr81_cursor INTO @ExportId, @Filename;
            WHILE @@FETCH_STATUS = 0
            BEGIN
                SET @cnt = @cnt + 1;
                
                SET @SqlCommandDecoder =
                (
                    SELECT TOP (1) PTSRPDT.Decoder
                    FROM PtTransSxRegisterPlusDataType PTSRPDT
                    JOIN PtTransSxRegisterPlus PTSRP ON PTSRPDT.XmlDataType = PTSRP.XmlDataSetType
                    WHERE PTSRP.ExportID = @ExportId
                    ORDER BY SourceRecId
                );
                SET @SqlCommandExportToFile =
                (
                    SELECT TOP (1) PTSRPDT.ExportToFileSQL
                    FROM PtTransSxRegisterPlusDataType PTSRPDT
                    JOIN PtTransSxRegisterPlus PTSRP ON PTSRPDT.XmlDataType = PTSRP.XmlDataSetType
                    WHERE PTSRP.ExportID = @ExportId
                    ORDER BY SourceRecId
                );

                IF @DebugMode = 1
                    PRINT 'Running the step: ' + CAST(@cnt AS NVARCHAR(10)) + ' @SqlCommandExportToFile length: ' + CAST(LEN(@SqlCommandExportToFile) AS NVARCHAR(10)) + ' ExportID: ' + CAST(@ExportId AS NVARCHAR(70));

                IF @SqlCommandExportToFile IS NOT NULL AND @SqlCommandDecoder IS NOT NULL
                BEGIN
                    IF @DebugMode = 10
                        SELECT TOP (1) PTSRPDT.XmlDataType,
                                     CONVERT(TEXT, PTSRPDT.ExportToFileSQL)
                        FROM PtTransSxRegisterPlusDataType PTSRPDT
                        JOIN PtTransSxRegisterPlus PTSRP ON PTSRPDT.XmlDataType = PTSRP.XmlDataSetType
                        WHERE PTSRP.ExportID = @ExportId
                        ORDER BY SourceRecId;

                    IF @DebugMode = 10
                        PRINT @SqlCommandExportToFile;
                        
                    --co robimy jak jest wiecej plikow: return table (FileName, FileContent)
                    --what we do as there are more files: return table (FileName, FileContent)

                    IF OBJECT_ID('tempdb..#PtTransSxRegisterPlusTemp') IS NOT NULL
                        DROP TABLE #PtTransSxRegisterPlusTemp;
                        
                    SELECT ExportID, 
                           ExportSQLSeqNo, 
                           SourceTableName, 
                           SourceRecId, 
                           IsSuppressed, 
                           XmlDataSetType, 
                           XmlDataSet = CONVERT(XML, XmlDataSet)
                    INTO #PtTransSxRegisterPlusTemp
                    FROM PtTransSxRegisterPlus
                    WHERE ExportID = @ExportId AND HdVersionNo BETWEEN 1 AND 999999998
                    ORDER BY SourceRecId;
                    
                    -- TODO use a permanent / regular table. Clean up with truncate before use.
                    EXEC (@SqlCommandDecoder);
                    EXEC (@SqlCommandExportToFile);

                    TRUNCATE TABLE #PtTransSxRegisterPlusRaw;
                    
                    IF NOT EXISTS
                    (
                        SELECT * FROM #ResultTable
                    ) 
                    BEGIN
                        SET @ErrorMessage = 'Temporary table #ResultTable is empty.';
                        SET @ErrorNo = @ErrorNo + 100000;
                        PRINT 'Temporary table check Failed';
                    END
                    ELSE
                        PRINT 'Temporary table check OK';

                    UPDATE #ResultTable
                    SET FileName = @Filename
                    WHERE FileName IS NULL OR FileName = ''

                END
                ELSE
                BEGIN
                    -- Write an empty file (just header and EoF line)
                    INSERT INTO #ResultTable (FileName, FileContent)
                    VALUES (@Filename, 'TxReportID;TxReportTransType;TxGroupID;InstrumentType;TrdMatchID;VenueCode;ISIN;CFICode;UnderlyingISIN;UnderlyingISIN2;UnderlyingISIN3;LastQty;LastPx;PriceType;ExecutionTime;SettlDate;EnteringFirmSide;EnteringFirmSecondaryClOrdID;EnteringFirmOrderCapacity;EnteringFirmPartyID;EnteringFirmPerson;ContraFirmSubType;ContraFirmSubTypeCode;ContraFirmPartyID;BeneficialOwner;Currency;CHFAmount;ExpirationDate;OptionType;StrikePrice;StrikePriceType;LeverageIndicator;OrderTransmission;AggregatedOrder;UnderlyingISIN4' + CHAR(13) + CHAR(10) + 'EoF')
                END;

                -- Update the Export Run entry anyway
                IF @ProductionMode = 1
                    UPDATE PtTransSxExportRun SET 
                        StatusNo = @StatusFileExported, 
                        HdVersionNo = HdVersionNo + 1, 
                        HdChangeDate = GETDATE(), 
                        HdChangeUser = SYSTEM_USER
                    WHERE Id = @ExportId;
                    
                FETCH NEXT FROM smr81_cursor INTO @ExportId, @Filename;
            END; -- WHILE
        END;
    END TRY
    BEGIN CATCH
        PRINT 'Catch Section';
        DECLARE @ErrMsg NVARCHAR(60) = ERROR_MESSAGE();
        DECLARE @ErrNo int = ERROR_NUMBER();
        -- try to build as first step the string, and then print it out
        PRINT 'CATCH ERROR Message:' + @ErrMsg + ' ERROR Number: ' + CAST(@ErrNo AS NVARCHAR(10));
        IF @ErrorNo <> 0
        BEGIN
            SET @ErrorMessage = N'Could not start the procedure: Invalid Parameters =>' + @ErrMsg;
            RAISERROR(@ErrorMessage, 1, 16);
        END;
        
        IF @ErrNo <> 0
        BEGIN
            SET @ErrorNo = @ErrNo;
            SET @ErrorMessage = N'Could not start the procedure: ' + @ErrMsg;
            RAISERROR(@ErrorMessage, 1, 16);
        END;
    END CATCH;
    
    -- Do clean-ups here
    CLOSE smr81_cursor;
    DEALLOCATE smr81_cursor;

    -- If everything is good, then return the ResultTable, otherwise the ErrorNo
    IF @ErrorNo = 0
    BEGIN
        SELECT * FROM #ResultTable ORDER BY FileName;
    END
    ELSE
        SELECT @ErrorNo;

END;
