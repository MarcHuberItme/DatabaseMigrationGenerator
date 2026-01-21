--liquibase formatted sql

--changeset system:create-alter-function-DtaFileUploadList context:any labels:c-any,o-function,ot-schema,on-DtaFileUploadList,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function DtaFileUploadList
CREATE OR ALTER FUNCTION dbo.DtaFileUploadList
(
    @EBankingID uniqueidentifier,
    @BeginNo int,
    @ListLen int)
RETURNS @DtaUploadTab TABLE(
    Id uniqueidentifier,
    FileName varchar(100),
    MgVTNo varchar(100),
    StatusText tinyint,
    CanBeProcessed tinyint,
    ImportDate Datetime,
    FileStatus tinyint,
    NumOfPayments int,
    NumOfErrorPayments int,
    ParseErrors int,
    TotalPaymentAmount money,
    RowNumber int,
    VisumStatus int
) AS
BEGIN   

    DECLARE @RecordsToRetrieve int
    DECLARE @RowCounter int

    DECLARE @Id uniqueidentifier
    DECLARE @FileName varchar(100)
    DECLARE @MgVTNo varchar(100)
    DECLARE @StatusText tinyint
    DECLARE @CanBeProcessed tinyint
    DECLARE @ImportDate datetime
    DECLARE @FileStatus tinyint

    DECLARE @NumOfPayments int
    DECLARE @NumOfErrorPayments int
    DECLARE @ParseErrors int
    DECLARE @TotalPaymentAmount money
    DECLARE @VisumStatus int
    DECLARE @CompletedPayment int
    DECLARE @OrderCount int

    SET @RecordsToRetrieve = @BeginNo + @ListLen

    
    DECLARE File_Cursor CURSOR FAST_FORWARD
    FOR
    SELECT DISTINCT F.Id, F.Filename, EI.MgVTNo, 
 StatusText =
Case
	when F.FileStatus > 3 then 99 --fehlerhaft
	when F.FileStatus <= 1 then 0 --in bearbeitung
	when F.FileStatus = 2 then 1 --unvisiert
	when (min(O.Status) = 2 or min(O.Status) = 3) and F.FileStatus = 3 then 2 --Bereit zur Ausführung
	when min(O.Status) = 4 and max(O.Status) = 4 and F.FileStatus = 3 then 4 --Ausgeführt
	--when max(O.Status) >= 4 and min(O.Status) < 4 and F.FileStatus = 3 then 3 --Teilausgeführt
	when min(O.Status) = 10 and max(O.Status) = 10 and F.FileStatus = 3 then 2
	when min(O.Status) = 12 and F.FileStatus = 3 then 5 --Pendent über Ausführungsdatum hinaus
end, F.ImportDate, FileStatus, F.CanBeProcessed, count(O.Id) as OrderCount
FROM PtAgrEbanking as E
    INNER JOIN PtAgrEbankingdetail as D on E.Id = D.AgrEbankingId
    INNER JOIN CMFileConfirmation as C on D.AccountId = C.AccountId
    INNER JOIN CMFileImportProcess as F on C.FileImportProcessId = F.id
    LEFT OUTER JOIN PtPaymentOrder as O On F.Id = O.FileImportProcessId AND O.HdVersionNo < 999999999 AND O.Status <> 13 
    INNER JOIN PtAgrEbanking as EI on F.EbankingId = EI.Id
    WHERE E.Id = @EBankingID
        AND D.HasAccess = 1 AND D.InternetBankingAllowed = 1 AND D.ValidFrom < GetDate() AND D.ValidTo > GetDate()
        AND F.SystemCode != 'PAIN001'
        AND F.HdVersionNo < 999999999 AND C.HdVersionNo < 999999999 AND D.HdVersionNo < 999999999 AND E.HdVersionNo < 999999999
   GROUP BY F.Id, F.Filename, EI.MgVTNo, F.ImportDate, F.FileStatus, F.CanBeProcessed
   ORDER BY ImportDate DESC
    OPEN File_Cursor

    FETCH NEXT FROM File_Cursor INTO @Id, @FileName, @MgVTNo,@StatusText, @ImportDate, @FileStatus, @CanBeProcessed, @OrderCount
    SET @RowCounter = 1

    WHILE @@FETCH_STATUS=0 AND @RowCounter < @RecordsToRetrieve
    BEGIN
        IF @RowCounter >= @BeginNo
        BEGIN
            
            IF @StatusText = 2
            BEGIN
                SET @CompletedPayment = (SELECT count(*) FROM PtPaymentOrder WHERE Status = 4 AND FileImportProcessId = @Id AND HdVersionNo < 999999999)
                IF @CompletedPayment > 0 AND @CompletedPayment < @OrderCount
                    SET @StatusText = 3  -- 'Teilausgeführt' - Already completed payments have been found, therefore overwrite 'Bereit zur Ausführung'
            END

            SET @VisumStatus = (SELECT  (count(C.EbankingIdVisum1) + count(C.EbankingIdVisum2)) / count(C.AccountId) as Visum from CMFileImportProcess as F
            INNER JOIN CMFileConfirmation as C On F.id = C.FileImportProcessId
            WHERE F.id = @Id
            GROUP BY F.Filename)            
            

            SET @ParseErrors = 0
            SELECT @NumOfPayments = NumOfPayments,
                           @NumOfErrorPayments = NumOfErrorPayments,
                           @TotalPaymentAmount = TotalPaymentAmount 
                FROM CountOrderDetail(@Id)

            IF @FileStatus > 2
            BEGIN
                SET @ParseErrors = (SELECT COUNT(*) FROM PtTransMessageIn i 
                                    WHERE i.FileImportProcessId = @Id AND i.HdVersionNo < 999999999 AND i.Status = 7)
                SET  @NumOfPayments = @NumOfPayments + @ParseErrors
            END

           

            INSERT INTO @DtaUploadTab (Id, FileName, MgVTNo,StatusText, ImportDate, FileStatus, NumOfPayments, NumOfErrorPayments, ParseErrors, TotalPaymentAmount, RowNumber, CanBeProcessed, VisumStatus) 
                 VALUES (@Id, @FileName, @MgVTNo, @StatusText,@ImportDate, CASE 
WHEN @FileStatus = 91 AND @NumOfErrorPayments = 0 AND @VisumStatus = 2 THEN 3 
WHEN @FileStatus = 91 AND @NumOfErrorPayments = 0 AND @VisumStatus < 2 THEN 2 
ELSE @FileStatus END,  @NumOfPayments, @NumOfErrorPayments,@ParseErrors, @TotalPaymentAmount, @RowCounter, @CanBeProcessed, @VisumStatus)

        END 
    
        FETCH NEXT FROM File_Cursor INTO @Id, @FileName, @MgVTNo, @StatusText,@ImportDate, @FileStatus, @CanBeProcessed, @OrderCount
        SET @RowCounter = @RowCounter + 1
    END

    CLOSE File_Cursor
    DEALLOCATE File_Cursor

    RETURN
END
