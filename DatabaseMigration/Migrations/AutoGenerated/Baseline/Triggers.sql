--liquibase formatted sql

--changeset system:baseline-create-alter-trigger-AsBICIndex_UpdateInsert context:any labels:c-any,o-table,ot-schema,on-AsBICIndex,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger AsBICIndex_UpdateInsert on table AsBICIndex
CREATE OR ALTER TRIGGER AsBICIndex_UpdateInsert
   ON AsBICIndex FOR INSERT, UPDATE AS
SET NOCOUNT ON

IF UPDATE (InstitutionName) or UPDATE (BranchInformation)
BEGIN
	UPDATE abi SET abi.Name1 = SUBSTRING(abi.InstitutionName, 1, 35) 
		, abi.Name2 = SUBSTRING(abi.InstitutionName, 36, 35)
		, abi.Name3 = SUBSTRING(abi.InstitutionName, 71, 35)
		, abi.BranchInformation1 = SUBSTRING(abi.BranchInformation, 1, 35)
		, abi.BranchInformation2 = SUBSTRING(abi.BranchInformation, 36, 35)
	FROM AsBICIndex abi 
	INNER JOIN inserted ins ON abi.Id = ins.Id
END

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-AsError_CascadeDelete context:any labels:c-any,o-table,ot-schema,on-AsError,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger AsError_CascadeDelete on table AsError
CREATE OR ALTER TRIGGER AsError_CascadeDelete
   ON AsError FOR DELETE AS
SET NOCOUNT ON
DELETE AsErrorDetail
          FROM AsErrorDetail, deleted
          WHERE AsErrorDetail.ErrorID = deleted.ID
GO

--changeset system:baseline-create-alter-trigger-AsGroupType_InsertDefaultGroup context:any labels:c-any,o-table,ot-schema,on-AsGroupType,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger AsGroupType_InsertDefaultGroup on table AsGroupType
CREATE OR ALTER TRIGGER AsGroupType_InsertDefaultGroup
   ON AsGroupType FOR INSERT AS

      SET NOCOUNT ON

      DECLARE @GroupId UniqueIdentifier
      DECLARE @GroupTypeId UniqueIdentifier
      DECLARE @IsRestricted Bit
      DECLARE @LanguageNo TinyInt
      Select @GroupTypeId=(Id),@IsRestricted=(IsRestricted) FROM Inserted

      IF @IsRestricted = 1
         BEGIN
            SET @GroupId = NewId()
            INSERT INTO AsGroup (Id,IsDefault,HdVersionNo,GroupTypeId) 
               VALUES (@GroupId,1,1,@GroupTypeId)
            
            DECLARE TableCurs CURSOR FOR
               SELECT LanguageNo FROM AsLanguage
               WHERE HdVersionNo > 0
            OPEN TableCurs
            FETCH NEXT FROM TableCurs INTO @LanguageNo
            WHILE (@@FETCH_STATUS=0)
               BEGIN
                  INSERT INTO AsText
                     (MasterId,MasterTableName,TextShort,LanguageNo)
                     VALUES (@GroupId,'AsGroup','Rest',@LanguageNo)
                  FETCH NEXT FROM TableCurs INTO @LanguageNo
               END
            CLOSE TableCurs
            DEALLOCATE TableCurs
         END
GO

--changeset system:baseline-create-alter-trigger-AsInterfaceConv_CheckConversionRules context:any labels:c-any,o-table,ot-schema,on-AsInterfaceConv,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger AsInterfaceConv_CheckConversionRules on table AsInterfaceConv
CREATE OR ALTER TRIGGER AsInterfaceConv_CheckConversionRules
   ON AsInterfaceConv FOR INSERT, UPDATE AS
BEGIN
   SET NOCOUNT ON
      IF UPDATE (InternalCode) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM AsInterfaceConv INNER JOIN 
                         AsInterfaceTable ON AsInterfaceTable.Id = AsInterfaceConv.InterfaceTableId INNER JOIN
                         AsInterface ON AsInterface.Id = AsInterfaceTable.InterfaceId
              WHERE AsInterfaceConv.InterfaceTableId IN 
              		(Select InterfaceTableId FROM inserted) AND
			AsInterfaceConv.HdVersionNo < 999999999 AND
                        (AsInterface.InterfaceTypeNo = 2 OR AsInterface.InterfaceTypeNo = 3)              		
              GROUP BY AsInterfaceConv.InterfaceTableId, InternalCode HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('InternalCode must be unique', 16, 1)
                 Rollback Transaction
                 Return
           END
      END

      IF UPDATE (ExternalCode) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM AsInterfaceConv INNER JOIN 
                         AsInterfaceTable ON AsInterfaceTable.Id = AsInterfaceConv.InterfaceTableId INNER JOIN
                         AsInterface ON AsInterface.Id = AsInterfaceTable.InterfaceId
              WHERE AsInterfaceConv.InterfaceTableId IN 
              		(Select InterfaceTableId FROM inserted) AND
			AsInterfaceConv.HdVersionNo < 999999999 AND
                        (AsInterface.InterfaceTypeNo = 1 OR AsInterface.InterfaceTypeNo = 3)              		
              GROUP BY AsInterfaceConv.InterfaceTableId, ExternalCode HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('ExternalCode must be unique', 16, 1)
                 Rollback Transaction
                 Return
           END
      END
END
GO

--changeset system:baseline-create-alter-trigger-AsNavigationIndex_RootTable context:any labels:c-any,o-table,ot-schema,on-AsNavigationIndex,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger AsNavigationIndex_RootTable on table AsNavigationIndex
CREATE OR ALTER TRIGGER AsNavigationIndex_RootTable
   ON AsNavigationIndex FOR INSERT AS
   SET NOCOUNT ON
      Declare @Id Uniqueidentifier

      If Exists (select * from inserted 
      where inserted.TableName = inserted.ParentTableName)
           Begin
              set @Id = (select Id from inserted)
              Update AsNavigationIndex set ParentTableName = 'ROOT'
              where Id = @Id
           End
GO

--changeset system:baseline-create-alter-trigger-AsUserGroupMember_SetDefault context:any labels:c-any,o-table,ot-schema,on-AsUserGroupMember,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger AsUserGroupMember_SetDefault on table AsUserGroupMember
CREATE OR ALTER TRIGGER AsUserGroupMember_SetDefault
   ON AsUserGroupMember FOR INSERT, UPDATE AS

SET NOCOUNT ON

DECLARE @IsDefault bit
DECLARE @UserGroupName varchar(32)
DECLARE @InsertedId uniqueidentifier
DECLARE @Id uniqueidentifier

Select @InsertedId=(Id),@IsDefault=(IsDefault),@UserGroupName=(UserGroupName) FROM Inserted

IF @IsDefault = 1
   BEGIN
      SET @Id = (SELECT Id FROM AsUserGroupMember WHERE Id <>
      @InsertedId AND IsDefault = 1 AND UserGroupName = @UserGroupName)
      IF @Id IS NOT NULL
         BEGIN
            UPDATE AsUserGroupMember SET IsDefault = 0 WHERE Id = @Id
         END
   END
GO

--changeset system:baseline-create-alter-trigger-EvDetailTax_UpdateHasEuInterestTax_Ins context:any labels:c-any,o-table,ot-schema,on-EvDetailTax,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger EvDetailTax_UpdateHasEuInterestTax_Ins on table EvDetailTax
CREATE OR ALTER TRIGGER EvDetailTax_UpdateHasEuInterestTax_Ins
   ON EvDetailTax FOR INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON
    IF UPDATE (ManEuInterestTaxCode) 
    BEGIN
        UPDATE  EvVariant
        SET	        HasEuInterestTax  = CAST((SELECT  COUNT(*) 
	 		                     FROM     EvDetailTax DTX 
			                     JOIN	     EvDetail DET ON DET.Id = DTX.EventDetailId
                                                                     JOIN        EvTaxRegulation TRG ON TRG.TaxRegulationCode = DTX.ManEuInterestTaxCode 
			                     WHERE  DET.EventVariantId = EvVariant.Id 
			                     AND	     TRG.IsNoTax = 0 ) AS BIT)
        WHERE    Id IN (SELECT  DET2.EventVariantId
	                    FROM 	   EvDetail DET2 
	                    JOIN       inserted INS ON DET2.Id = INS.EventDetailId )

        UPDATE   AsNavigationIndex 
        SET          ChildConditionKey = REPLACE(ChildConditionKey, 'HasEuInterestTax=0', 
                                                                           'HasEuInterestTax=1') 
        WHERE    TableId IN (SELECT VAR.Id
	                            FROM     EvVariant VAR
	                            JOIN        EvDetail DET ON VAR.Id = DET.EventVariantId
	                            JOIN        inserted INS ON DET.Id = INS.EventDetailId
                                            WHERE  VAR.HasEuInterestTax=1)

        UPDATE   AsNavigationIndex 
        SET          ChildConditionKey = REPLACE(ChildConditionKey, 'HasEuInterestTax=1', 
                                                                           'HasEuInterestTax=0') 
        WHERE    TableId IN (SELECT VAR.Id
	                            FROM     EvVariant VAR
	                            JOIN        EvDetail DET ON VAR.Id = DET.EventVariantId
	                            JOIN        inserted INS ON DET.Id = INS.EventDetailId
                                            WHERE  VAR.HasEuInterestTax=0)
    END
END
GO

--changeset system:baseline-create-alter-trigger-EvSelectControl_Insert context:any labels:c-any,o-table,ot-schema,on-EvSelectControl,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger EvSelectControl_Insert on table EvSelectControl
CREATE OR ALTER TRIGGER EvSelectControl_Insert
   ON EvSelectControl FOR INSERT AS
BEGIN
   SET NOCOUNT ON
           IF (SELECT Count(*)
                FROM EvSelectControl) > 1
           BEGIN
                 RAISERROR('For EvSelectControl only one record is allowed', 16, 1)
                 Rollback Transaction
                 Return
           END
END
GO

--changeset system:baseline-create-alter-trigger-IfTransItem_Insert context:any labels:c-any,o-table,ot-schema,on-IfTransItem,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger IfTransItem_Insert on table IfTransItem
CREATE OR ALTER TRIGGER IfTransItem_Insert
   ON IfTransItem FOR INSERT AS
BEGIN
	SET NOCOUNT ON
	DECLARE	@Id	UNIQUEIDENTIFIER
	DECLARE	@Date	DATETIME
	SET @Id = (SELECT Id FROM inserted)
	SET @Date = (SELECT TransDate FROM inserted)
	IF (SELECT RealDate FROM inserted) IS NULL
		UPDATE	PtTransItem SET RealDate = @Date
		WHERE	Id = @Id
END
GO

--changeset system:baseline-create-alter-trigger-MgValor_CheckFinstarValNrForBackMigr context:any labels:c-any,o-table,ot-schema,on-MgValor,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger MgValor_CheckFinstarValNrForBackMigr on table MgValor
CREATE OR ALTER TRIGGER MgValor_CheckFinstarValNrForBackMigr
   ON MgValor FOR INSERT, UPDATE AS
BEGIN
   SET NOCOUNT ON
      IF UPDATE (FinstarValNr) OR
          UPDATE (MappingForBackMigr)
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM MgValor
              WHERE FinstarValNr IN 
              		(Select FinstarValNr FROM inserted
              		 WHERE  FinstarValNr IS NOT NULL) AND
              MappingForBackMigr = 1
              GROUP BY FinstarValNr HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('FinstarValNr must be unique for back migration (MappingForBackMigr = 1)', 16, 1)
                 Rollback Transaction
                 Return
           END
      END
END
GO

--changeset system:baseline-create-alter-trigger-MxAccountBase_UpdatePortfolioId context:any labels:c-any,o-table,ot-schema,on-MxAccountBase,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger MxAccountBase_UpdatePortfolioId on table MxAccountBase
CREATE OR ALTER TRIGGER MxAccountBase_UpdatePortfolioId
   ON MxAccountBase FOR UPDATE AS
   BEGIN   
   SET NOCOUNT ON
      IF UPDATE (PortfolioId) 
      BEGIN
         IF (SELECT COUNT(*) 
             FROM PtCorrAccount ca 
             JOIN inserted on inserted.Id = ca.AccountId
             JOIN deleted on deleted.Id = ca.AccountId
             WHERE ca.PortfolioIdCorr IS NOT NULL
                AND inserted.PortfolioId <> deleted.PortfolioId
                AND ca.HdPendingChanges > 0) > 0
             RAISERROR('Can not change portfolio because PtCorrAccount contains unconfirmed changes',16,1)   

         UPDATE PtCorrAccount SET PortfolioIdCorr = inserted.PortfolioId
            FROM PtCorrAccount ca JOIN inserted ON ca.AccountId = inserted.Id
            WHERE PortfolioIdCorr IS NOT NULL

         UPDATE PtPosition SET PortfolioId = inserted.PortfolioId
            FROM PtPosition pos 
            JOIN PrReference ref ON pos.ProdReferenceId = ref.Id
            JOIN inserted ON ref.AccountId = inserted.id       
           
      END
   END
GO

--changeset system:baseline-create-alter-trigger-PrPrivate_DeletePrBase context:any labels:c-any,o-table,ot-schema,on-PrPrivate,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPrivate_DeletePrBase on table PrPrivate
CREATE OR ALTER TRIGGER PrPrivate_DeletePrBase
   ON PrPrivate FOR DELETE AS
BEGIN
   SET NOCOUNT ON
   DELETE PrBase
      FROM PrBase,deleted  WHERE PrBase.Id = deleted.ProductId
END
GO

--changeset system:baseline-create-alter-trigger-PrPrivate_InsteadOfInsert context:any labels:c-any,o-table,ot-schema,on-PrPrivate,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPrivate_InsteadOfInsert on table PrPrivate
CREATE OR ALTER TRIGGER PrPrivate_InsteadOfInsert
   ON PrPrivate INSTEAD OF INSERT AS
BEGIN
      SET NOCOUNT ON
      INSERT INTO PrBase(Id,HdCreator,HdVersionNo,HdTriggerControl)
         SELECT ProductId, HdCreator,1,1 FROM inserted
      INSERT INTO PrPrivate
         SELECT * FROM inserted
END
GO

--changeset system:baseline-create-alter-trigger-PrPublic_CheckVdfInstrumentSymbol context:any labels:c-any,o-table,ot-schema,on-PrPublic,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPublic_CheckVdfInstrumentSymbol on table PrPublic
CREATE OR ALTER TRIGGER PrPublic_CheckVdfInstrumentSymbol
   ON PrPublic FOR INSERT, UPDATE AS
BEGIN
   SET NOCOUNT ON
      IF UPDATE (VdfInstrumentSymbol) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PrPublic
              WHERE VdfInstrumentSymbol IN 
              		(Select VdfInstrumentSymbol FROM inserted
              		 WHERE  VdfInstrumentSymbol IS NOT NULL)
              GROUP BY VdfInstrumentSymbol HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('VdfInstrumentSymbol must be unique', 16, 1)
                 Rollback Transaction
                 Return
           END
      END
END
GO

--changeset system:baseline-create-alter-trigger-PrPublic_DeletePrBase context:any labels:c-any,o-table,ot-schema,on-PrPublic,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPublic_DeletePrBase on table PrPublic
CREATE OR ALTER TRIGGER PrPublic_DeletePrBase
   ON PrPublic FOR DELETE AS
BEGIN
   SET NOCOUNT ON
   DELETE PrBase
      FROM PrBase,deleted  WHERE PrBase.Id = deleted.ProductId
END
GO

--changeset system:baseline-create-alter-trigger-PrPublic_InsteadOfInsert context:any labels:c-any,o-table,ot-schema,on-PrPublic,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPublic_InsteadOfInsert on table PrPublic
CREATE OR ALTER TRIGGER PrPublic_InsteadOfInsert
   ON PrPublic INSTEAD OF INSERT AS
BEGIN
      SET NOCOUNT ON
      INSERT INTO PrBase(Id,HdCreator,HdVersionNo,HdTriggerControl)
         SELECT ProductId, HdCreator,1,1 FROM inserted
      INSERT INTO PrPublic
         SELECT * FROM inserted
      INSERT INTO PrPublicHist
      (HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, 
       HdVersionNo, PublicId, FromDate, InstrumentStatusNo, 
       MajorTradingPlaceId, NominalCurrency, ExposureCurrency, 
       NominalAmount, Verse, UnitNo,
       ContractSize, CashMultiplier, ToffVersion, MaintenanceStatusNo, 
       CollateralRate)
      SELECT HdCreateDate, HdCreator, HdChangeDate, HdChangeUser, 
       HdVersionNo, Id, '19000101', InstrumentStatusNo, 
       MajorTradingPlaceId, NominalCurrency, ExposureCurrency, 
       NominalAmount, Verse, UnitNo,
       ContractSize, CashMultiplier, ToffVersion, MaintenanceStatusNo,
       IsNull(CollateralRateManual, CollateralRateCalculated)
      FROM inserted
END
GO

--changeset system:baseline-create-alter-trigger-PrPublic_UpdateHasInstr_Del context:any labels:c-any,o-table,ot-schema,on-PrPublic,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPublic_UpdateHasInstr_Del on table PrPublic
CREATE OR ALTER TRIGGER PrPublic_UpdateHasInstr_Del
   ON PrPublic FOR DELETE AS
BEGIN
   SET NOCOUNT ON
   UPDATE  PtBase 
   SET HasInstruments = CAST((SELECT COUNT(*) FROM PrPublic 
                                        WHERE  IssuerId = PtBase.Id) AS BIT)
   WHERE Id IN (SELECT IssuerId from deleted)
   UPDATE AsNavigationIndex 
   SET ChildConditionKey = REPLACE(ChildConditionKey, 'HasInstruments=1', 
                                                             'HasInstruments=0') 
   WHERE TableId IN (SELECT IssuerId FROM deleted DEL JOIN 
                                     PtBase PTA ON DEL.IssuerId = PTA.ID
                                     WHERE PTA.HasInstruments = 0)
END
GO

--changeset system:baseline-create-alter-trigger-PrPublic_UpdateHasInstr_Ins context:any labels:c-any,o-table,ot-schema,on-PrPublic,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPublic_UpdateHasInstr_Ins on table PrPublic
CREATE OR ALTER TRIGGER PrPublic_UpdateHasInstr_Ins
   ON PrPublic FOR INSERT AS
BEGIN
   SET NOCOUNT ON
   UPDATE  PtBase 
   SET HasInstruments = CAST((SELECT COUNT(*) FROM PrPublic 
                                        WHERE  IssuerId = PtBase.Id) AS BIT)
   WHERE Id IN (SELECT IssuerId from inserted)
   UPDATE AsNavigationIndex 
   SET ChildConditionKey = REPLACE(ChildConditionKey, 'HasInstruments=0', 
                                                             'HasInstruments=1') 
   WHERE TableId IN (SELECT IssuerId FROM inserted)
END
GO

--changeset system:baseline-create-alter-trigger-PrPublic_UpdateHasInstr_Upd context:any labels:c-any,o-table,ot-schema,on-PrPublic,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPublic_UpdateHasInstr_Upd on table PrPublic
CREATE OR ALTER TRIGGER PrPublic_UpdateHasInstr_Upd
   ON PrPublic FOR UPDATE AS
BEGIN
   SET NOCOUNT ON
      IF UPDATE (IssuerId) 
      BEGIN
          UPDATE  PtBase 
          SET HasInstruments = CAST((SELECT COUNT(*) FROM PrPublic 
                                               WHERE  IssuerId = PtBase.Id) AS BIT)
          WHERE Id IN (SELECT IssuerId from inserted) OR 
                         Id IN (Select IssuerId from deleted)
          UPDATE AsNavigationIndex 
          SET ChildConditionKey = REPLACE(ChildConditionKey, 'HasInstruments=0', 
                                                                    'HasInstruments=1') 
          WHERE TableId IN (SELECT IssuerId FROM inserted)
          UPDATE AsNavigationIndex 
          SET ChildConditionKey = REPLACE(ChildConditionKey, 'HasInstruments=1', 
                                                                    'HasInstruments=0') 
          WHERE TableId IN (SELECT IssuerId FROM deleted DEL JOIN 
                                           PtBase PTA ON DEL.IssuerId = PTA.ID
                                           WHERE PTA.HasInstruments = 0)
      END
END
GO

--changeset system:baseline-create-alter-trigger-PrPublic_UpdatePrPublicHist context:any labels:c-any,o-table,ot-schema,on-PrPublic,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPublic_UpdatePrPublicHist on table PrPublic
CREATE OR ALTER TRIGGER PrPublic_UpdatePrPublicHist
   ON PrPublic FOR UPDATE AS
DECLARE @ToDay DATETIME
BEGIN
      SET NOCOUNT ON
      IF UPDATE (InstrumentStatusNo) OR
          UPDATE (MajorTradingPlaceId) OR
          UPDATE (NominalCurrency) OR
          UPDATE (ExposureCurrency) OR
          UPDATE (NominalAmount) OR
          UPDATE (Verse) OR
          UPDATE (UnitNo) OR
          UPDATE (ContractSize) OR
          UPDATE (CashMultiplier) OR
          UPDATE (ToffVersion) OR
          UPDATE (MaintenanceStatusNo) OR
          UPDATE (CollateralRateManual) OR
          UPDATE (CollateralRateCalculated) OR
          UPDATE (FinfraGObjectTaxRep) OR
          UPDATE (FinfraGApplicTaxRep)
      BEGIN
            SET  @ToDay = convert(datetime,(convert(char,getDate(),112)))
            IF EXISTS(SELECT *  FROM PrPublicHist INNER JOIN 
	        inserted ON PrPublicHist.PublicId = inserted.Id 
            WHERE PrPublicHist.FromDate = @ToDay)
            BEGIN
                  DELETE FROM PrPublicHist
	  WHERE PrPublicHist.FromDate = @ToDay AND
	  EXISTS
	  (SELECT * FROM inserted
                    WHERE PrPublicHist.PublicId = inserted.Id)
            END
            INSERT INTO PrPublicHist
            (HdCreator, HdChangeUser, HdVersionNo, PublicId, FromDate,
             InstrumentStatusNo, MajorTradingPlaceId,
             NominalCurrency, ExposureCurrency, NominalAmount, Verse, UnitNo,
             ContractSize, CashMultiplier, ToffVersion, MaintenanceStatusNo, CollateralRate)
            SELECT HdChangeUser, HdChangeUser, 1, Id, @ToDay,
             InstrumentStatusNo, MajorTradingPlaceId, 
             NominalCurrency, ExposureCurrency, NominalAmount, Verse, UnitNo,
             ContractSize, CashMultiplier, ToffVersion, MaintenanceStatusNo,
             IsNull(CollateralRateManual, CollateralRateCalculated)
            FROM inserted
      END
END
GO

--changeset system:baseline-create-alter-trigger-PrPublicEvent_References context:any labels:c-any,o-table,ot-schema,on-PrPublicEvent,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPublicEvent_References on table PrPublicEvent
CREATE OR ALTER TRIGGER PrPublicEvent_References
   ON PrPublicEvent FOR INSERT, UPDATE AS
BEGIN
   SET NOCOUNT ON  
      IF UPDATE (PublicCfId) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PrPublicEvent
              WHERE PublicCfId IN 
              		(Select PublicCfId FROM inserted
              		 WHERE  PublicCfId IS NOT NULL)
              GROUP BY PublicCfId HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('A cash flow can only one time assigned to an event', 16, 1)
                 Rollback Transaction
                 Return
           END
      END

      IF UPDATE (PublicCfSetId) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PrPublicEvent
              WHERE PublicCfSetId IN 
              		(Select PublicCfSetId FROM inserted
              		 WHERE  PublicCfSetId IS NOT NULL)
              GROUP BY PublicCfSetId HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('A cash flow set can only one time assigned to an event', 16, 1)
                 Rollback Transaction
                 Return
           END
      END

      IF UPDATE (PublicTransformId) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PrPublicEvent
              WHERE PublicTransformId IN 
              		(Select PublicTransformId FROM inserted
              		 WHERE  PublicTransformId IS NOT NULL)
              GROUP BY PublicTransformId HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('A transformation can only one time assigned to an event', 16, 1)
                 Rollback Transaction
                 Return
           END
      END

      IF UPDATE (PublicOfficialMeetingId) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PrPublicEvent
              WHERE PublicOfficialMeetingId IN 
              		(Select PublicOfficialMeetingId FROM inserted
              		 WHERE  PublicOfficialMeetingId IS NOT NULL)
              GROUP BY PublicOfficialMeetingId HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('A official meeting can only one time assigned to an event', 16, 1)
                 Rollback Transaction
                 Return
           END
      END
END
GO

--changeset system:baseline-create-alter-trigger-PrPublicIssue_CheckVdfIdentification context:any labels:c-any,o-table,ot-schema,on-PrPublicIssue,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPublicIssue_CheckVdfIdentification on table PrPublicIssue
CREATE OR ALTER TRIGGER PrPublicIssue_CheckVdfIdentification
   ON PrPublicIssue FOR INSERT, UPDATE AS
BEGIN
   SET NOCOUNT ON
      IF UPDATE (VdfIdentification)  OR UPDATE(PublicId)
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PrPublicIssue
              WHERE PublicId IN 
              		(Select PublicId FROM inserted
              		 WHERE  PublicId IS NOT NULL AND VdfIdentification IS NOT NULL)
              GROUP BY PublicId, VdfIdentification HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('PublicId, VdfIdentification must be unique', 16, 1)
                 Rollback Transaction
                 Return
           END
      END
END
GO

--changeset system:baseline-create-alter-trigger-PrPublicStopList_CheckVdfIdentification context:any labels:c-any,o-table,ot-schema,on-PrPublicStopList,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPublicStopList_CheckVdfIdentification on table PrPublicStopList
CREATE OR ALTER TRIGGER PrPublicStopList_CheckVdfIdentification
   ON PrPublicStopList FOR INSERT, UPDATE AS
BEGIN
   SET NOCOUNT ON
      IF UPDATE (VdfIdentification) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PrPublicStopList
              WHERE VdfIdentification IN 
              		(Select VdfIdentification FROM inserted
              		 WHERE  VdfIdentification IS NOT NULL)
              GROUP BY VdfIdentification HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('VdfIdentification must be unique', 16, 1)
                 Rollback Transaction
                 Return
           END
      END
END
GO

--changeset system:baseline-create-alter-trigger-PrPublicTradingPlace_CheckVdfSymbol context:any labels:c-any,o-table,ot-schema,on-PrPublicTradingPlace,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrPublicTradingPlace_CheckVdfSymbol on table PrPublicTradingPlace
CREATE OR ALTER TRIGGER PrPublicTradingPlace_CheckVdfSymbol
   ON PrPublicTradingPlace FOR INSERT, UPDATE AS
BEGIN
   SET NOCOUNT ON
      IF UPDATE (VdfInstituteSymbol) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PrPublicTradingPlace
              WHERE VdfInstituteSymbol IN 
              		(Select VdfInstituteSymbol FROM inserted
              		 WHERE  VdfInstituteSymbol IS NOT NULL)
              GROUP BY VdfInstituteSymbol HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('VdfInstituteSymbol must be unique', 16, 1)
                 Rollback Transaction
                 Return
           END
      END

      IF UPDATE (SelPrioInt) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PrPublicTradingPlace 
              WHERE SelPrioInt IN 
              		(Select SelPrioInt FROM inserted
              		 WHERE  SelPrioInt IS NOT NULL AND
              		   	       SelPrioInt <> 0)
              GROUP BY SelPrioInt HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('SelPrioInt must be unique', 16, 1)
                 Rollback Transaction
                 Return
           END
      END

      IF UPDATE (SelPrioEb) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PrPublicTradingPlace 
              WHERE SelPrioEb IN 
              		(Select SelPrioEb FROM inserted
              		 WHERE  SelPrioEb IS NOT NULL AND
              		   	       SelPrioEb <> 0)
              GROUP BY SelPrioEb HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('SelPrioEb must be unique', 16, 1)
                 Rollback Transaction
                 Return
           END
      END
END
GO

--changeset system:baseline-create-alter-trigger-PrReference_CheckMgVrxKey context:any labels:c-any,o-table,ot-schema,on-PrReference,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PrReference_CheckMgVrxKey on table PrReference
CREATE OR ALTER TRIGGER PrReference_CheckMgVrxKey
   ON PrReference FOR INSERT, UPDATE AS
BEGIN
   SET NOCOUNT ON
      IF UPDATE (MgVrxKey) OR
          UPDATE (MgVrxKeyDepot) OR
          UPDATE (Currency) OR
          UPDATE (IsShortToff)
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PrReference
              WHERE MgVrxKey IN 
              		(Select MgVrxKey FROM inserted
              		 WHERE  MgVrxKey IS NOT NULL)
              GROUP BY MgVrxKey, MgVrxKeyDepot, Currency, IsShortToff HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('PrRef_DuplicateMigKeys: MgVrxKeyDepot & MgVrxKey & Currency & IsShortToff must be unique', 16, 1)
                 Rollback Transaction
                 Return
           END
      END
END
GO

--changeset system:baseline-create-alter-trigger-PsReportFile_Archive context:any labels:c-any,o-table,ot-schema,on-PsReportFile,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PsReportFile_Archive on table PsReportFile
CREATE OR ALTER TRIGGER PsReportFile_Archive
   ON PsReportFile INSTEAD OF UPDATE AS
BEGIN
   SET NOCOUNT ON
       INSERT INTO PsReportFileHistory
           (HdVersionNo
           ,HdStatusFlag
           ,HdNoUpdateFlag
           ,ReportFileId
           ,ReportId
           ,LanguageNo
           ,InputParameters
           ,CheckOutUser
           ,CheckOutDate
           ,HasDocNoBarCode
           ,HasQualityCode
           ,HasBranchLabels
           ,ReportFile
           ,CheckInUser
           ,CheckInDate
           ,CheckInComment)
       SELECT 
           deleted.HdVersionNo
           ,deleted.HdStatusFlag
           ,deleted.HdNoUpdateFlag
           ,deleted.Id
           ,deleted.ReportId
           ,deleted.LanguageNo
           ,deleted.InputParameters
           ,deleted.CheckOutUser
           ,deleted.CheckOutDate
           ,deleted.HasDocNoBarCode
           ,deleted.HasQualityCode
           ,deleted.HasBranchLabels
           ,deleted.ReportFile
           ,deleted.CheckInUser
           ,deleted.CheckInDate
           ,deleted.CheckInComment
       FROM deleted join inserted on deleted.Id = inserted.Id
           WHERE inserted.CheckInDate <> deleted.CheckInDate 
                     or (deleted.CheckInDate IS NULL and inserted.CheckInDate IS NOT NULL)

    UPDATE PsReportFile
           SET Id = inserted.Id,
           HdCreateDate = inserted.HdCreateDate,
           HdCreator = inserted.HdCreator,
           HdChangeDate = inserted.HdChangeDate,
           HdChangeUser = inserted.HdChangeUser,
           HdEditStamp = inserted.HdEditStamp,
           HdVersionNo = inserted.HdVersionNo,
           HdProcessId = inserted.HdProcessId,
           HdStatusFlag = inserted.HdStatusFlag,
           HdNoUpdateFlag = inserted.HdNoUpdateFlag,
           HdPendingChanges = inserted.HdPendingChanges,
           HdPendingSubChanges = inserted.HdPendingSubChanges, 
           HdTriggerControl = inserted.HdTriggerControl, 
           ReportId = inserted.ReportId, 
           LanguageNo = inserted.LanguageNo, 
           InputParameters = inserted.InputParameters, 
           CheckOutUser = inserted.CheckOutUser, 
           CheckOutDate = inserted.CheckOutDate, 
           HasDocNoBarCode = inserted.HasDocNoBarCode, 
           HasQualityCode = inserted.HasQualityCode, 
           HasBranchLabels = inserted.HasBranchLabels, 
           ReportFile = inserted.ReportFile, 
           CheckInUser = inserted.CheckInUser, 
           CheckInDate = inserted.CheckInDate, 
           CheckInComment = inserted.CheckInComment
        FROM PsReportFile JOIN inserted
        ON PsReportFIle.Id = inserted.ID     
END
GO

--changeset system:baseline-create-alter-trigger-PtAccountBase_UpdatePortfolioId context:any labels:c-any,o-table,ot-schema,on-PtAccountBase,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtAccountBase_UpdatePortfolioId on table PtAccountBase
CREATE OR ALTER TRIGGER PtAccountBase_UpdatePortfolioId
   ON PtAccountBase FOR UPDATE AS
   BEGIN   
   SET NOCOUNT ON
      IF UPDATE (PortfolioId) 
      BEGIN
         IF (SELECT COUNT(*) 
             FROM PtCorrAccount ca 
             JOIN inserted on inserted.Id = ca.AccountId
             JOIN deleted on deleted.Id = ca.AccountId
             WHERE ca.PortfolioIdCorr IS NOT NULL
                AND inserted.PortfolioId <> deleted.PortfolioId
                AND ca.HdPendingChanges > 0) > 0
             RAISERROR('Can not change portfolio because PtCorrAccount contains unconfirmed changes',16,1)   

         UPDATE PtCorrAccount SET PortfolioIdCorr = inserted.PortfolioId
            FROM PtCorrAccount ca JOIN inserted ON ca.AccountId = inserted.Id
            WHERE PortfolioIdCorr IS NOT NULL

         UPDATE PtPosition SET PortfolioId = inserted.PortfolioId
            FROM PtPosition pos 
            JOIN PrReference ref ON pos.ProdReferenceId = ref.Id
            JOIN inserted ON ref.AccountId = inserted.id       
           
      END
   END
GO

--changeset system:baseline-create-alter-trigger-PtAccountComponent_CheckCoverage context:any labels:c-any,o-table,ot-schema,on-PtAccountComponent,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtAccountComponent_CheckCoverage on table PtAccountComponent
CREATE OR ALTER TRIGGER PtAccountComponent_CheckCoverage
   ON PtAccountComponent FOR INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON
        IF UPDATE (MgVBNR)
        BEGIN
            IF EXISTS( SELECT * FROM PtAccountComponent AS C INNER JOIN
                inserted ON C.PrivateCompTypeId = inserted.PrivateCompTypeId
                AND C.AccountBaseId = inserted.AccountBaseId
                AND C.MgVBNR = inserted.MgVBNR
                AND C.MgVBSUBKTNR = inserted.MgVBSUBKTNR
                AND C.Id <> inserted.Id
                AND C.IsOldComponent = 0
                WHERE C.MgVBNR IS NOT NULL)
            BEGIN
                RAISERROR('AccountId,MgVBNR,PrivateCompTypeId must be unique', 16, 1)
            END
        END
END 
GO

--changeset system:baseline-create-alter-trigger-PtAgrCard_DelChangeRecord context:any labels:c-any,o-table,ot-schema,on-PtAgrCard,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtAgrCard_DelChangeRecord on table PtAgrCard
CREATE OR ALTER TRIGGER PtAgrCard_DelChangeRecord
   ON PtAgrCard FOR DELETE AS
SET NOCOUNT ON
DELETE
	wi
FROM
	deleted d inner join
	PtAgrCard c on c.CardId = d.CardId and c.SerialNo = d.SerialNo and c.CardStatus <> 0 inner join
	BpJobWorkItem wi on wi.RefId = c.Id
	
WHERE 1=1
	AND d.CardStatus = 0
	AND wi.RefTable = 'PtAgrCard'
	AND wi.Param LIKE '%' + CONVERT(varchar(max), d.Id) + '%'
	AND wi.RunCount = 0
	AND wi.Status = 0
GO

--changeset system:baseline-create-alter-trigger-PtBase_CheckVdfSymbol context:any labels:c-any,o-table,ot-schema,on-PtBase,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtBase_CheckVdfSymbol on table PtBase
CREATE OR ALTER TRIGGER PtBase_CheckVdfSymbol
   ON PtBase FOR INSERT, UPDATE AS
BEGIN
   SET NOCOUNT ON
      IF UPDATE (VdfInstituteSymbol) 
      BEGIN
           IF EXISTS (SELECT COUNT(*)
              FROM PtBase
              WHERE VdfInstituteSymbol IN 
              		(Select VdfInstituteSymbol FROM inserted
              		 WHERE  VdfInstituteSymbol IS NOT NULL)
              GROUP BY VdfInstituteSymbol HAVING COUNT(*) > 1)
           BEGIN
                 RAISERROR('VdfInstituteSymbol must be unique', 16, 1)
                 Rollback Transaction
                 Return
           END
      END
END
GO

--changeset system:baseline-create-alter-trigger-PtFiscalCountry_SetPrimaryCountry context:any labels:c-any,o-table,ot-schema,on-PtFiscalCountry,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtFiscalCountry_SetPrimaryCountry on table PtFiscalCountry
CREATE OR ALTER TRIGGER PtFiscalCountry_SetPrimaryCountry
   ON PtFiscalCountry FOR INSERT, UPDATE AS

SET NOCOUNT ON

DECLARE @IsPrimaryCountry bit
DECLARE @PartnerId uniqueidentifier
DECLARE @InsertedId uniqueidentifier
DECLARE @Id uniqueidentifier

Select @InsertedId=(Id),@IsPrimaryCountry=(IsPrimaryCountry),@PartnerId=(PartnerId) FROM Inserted

IF @IsPrimaryCountry = 1
   BEGIN
      SET @Id = (SELECT Id FROM PtFiscalCountry WHERE Id <>
      @InsertedId AND IsPrimaryCountry = 1 AND PartnerId = @PartnerId)
      IF @Id IS NOT NULL
         BEGIN
            UPDATE PtFiscalCountry SET IsPrimaryCountry = 0 WHERE Id = @Id
         END
   END
GO

--changeset system:baseline-create-alter-trigger-PtFiscalDomicile_SetPrimaryDomicile context:any labels:c-any,o-table,ot-schema,on-PtFiscalDomicile,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtFiscalDomicile_SetPrimaryDomicile on table PtFiscalDomicile
CREATE OR ALTER TRIGGER PtFiscalDomicile_SetPrimaryDomicile
   ON PtFiscalDomicile FOR INSERT, UPDATE AS

SET NOCOUNT ON

DECLARE @IsPrimaryDomicile bit
DECLARE @PartnerId uniqueidentifier
DECLARE @InsertedId uniqueidentifier
DECLARE @Id uniqueidentifier

Select @InsertedId=(Id),@IsPrimaryDomicile=(IsPrimaryDomicile),@PartnerId=(PartnerId) FROM Inserted

IF @IsPrimaryDomicile = 1
   BEGIN
      SET @Id = (SELECT Id FROM PtFiscalDomicile WHERE Id <>
      @InsertedId AND IsPrimaryDomicile = 1 AND PartnerId = @PartnerId)
      IF @Id IS NOT NULL
         BEGIN
            UPDATE PtFiscalDomicile SET IsPrimaryDomicile = 0 WHERE Id = @Id
         END
   END
GO

--changeset system:baseline-create-alter-trigger-PtPaymentOrder_GenerateOrderNo context:any labels:c-any,o-table,ot-schema,on-PtPaymentOrder,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtPaymentOrder_GenerateOrderNo on table PtPaymentOrder
CREATE OR ALTER TRIGGER PtPaymentOrder_GenerateOrderNo
   ON PtPaymentOrder FOR INSERT AS
DECLARE @OrderId uniqueidentifier

DECLARE order_cursor CURSOR
   FOR SELECT Id FROM inserted where OrderNo is null order by HdCreateDate
OPEN order_cursor
set nocount on
FETCH NEXT FROM order_cursor into @OrderId
WHILE @@Fetch_status=0
begin
	update AsSequence Set SequenceNo = SequenceNo + 1 where SequenceName = 'PaymentOrderNo' 
	update PtPaymentOrder Set OrderNo = (select  SequenceNo from AsSequence where SequenceName = 'PaymentOrderNo' ) where Id = @OrderId
	FETCH NEXT FROM order_cursor into @OrderId
end
CLOSE order_cursor
DEALLOCATE order_cursor
GO

--changeset system:baseline-create-alter-trigger-PtPayReturnRequestDetailIn_ context:any labels:c-any,o-table,ot-schema,on-PtPayReturnRequestDetailIn,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtPayReturnRequestDetailIn_ on table PtPayReturnRequestDetailIn
CREATE OR ALTER TRIGGER PtPayReturnRequestDetailIn_
   ON PtPayReturnRequestDetailIn FOR INSERT AS
DECLARE @RequestNo int
DECLARE @RequestId uniqueidentifier



DECLARE order_cursor CURSOR
   FOR SELECT Id FROM inserted where RequestNo is null order by HdCreateDate
OPEN order_cursor
set nocount on
FETCH NEXT FROM order_cursor into @RequestId
WHILE @@Fetch_status=0
begin
	select @RequestNo = SequenceNo from AsSequence where SequenceName = 'SicReturnRequestNo' 
	Set @RequestNo = @RequestNo + 1
	update PtPayReturnRequestDetailIn Set RequestNo = @RequestNo where Id = @RequestId
	update AsSequence Set SequenceNo = @RequestNo where SequenceName = 'SicReturnRequestNo' 
	
	FETCH NEXT FROM order_cursor into @RequestId
end
CLOSE order_cursor
DEALLOCATE order_cursor
GO

--changeset system:baseline-create-alter-trigger-PtRating_MakeFunctionEntries context:any labels:c-any,o-table,ot-schema,on-PtRating,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtRating_MakeFunctionEntries on table PtRating
CREATE OR ALTER TRIGGER PtRating_MakeFunctionEntries
   ON PtRating FOR INSERT AS
BEGIN
SET NOCOUNT ON

INSERT INTO PtRatingImFunction
    (Id, 
    HdVersionNo, 
    HdChangeDate, 
    HdCreator, 
    RatingId, 
    FunctionId) 
SELECT 
    NEWID(), 
    1, 
    GETDATE(), 
    inserted.HdCreator, 
    inserted.Id, 
    ImF.Id 
FROM inserted, AsRatingImFunction AS ImF 
WHERE ImF.ModelNo = inserted.ModelNo AND ImF.HdVersionNo BETWEEN 1 AND 999999998

END
GO

--changeset system:baseline-create-alter-trigger-PtRating_SetInternRatingCode context:any labels:c-any,o-table,ot-schema,on-PtRating,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtRating_SetInternRatingCode on table PtRating
CREATE OR ALTER TRIGGER PtRating_SetInternRatingCode
   ON PtRating FOR INSERT, UPDATE AS

declare @InternRatingCodeNo int

set nocount on

set @InternRatingCodeNo = (select top 1 C.InternRatingCodeNo
                           from PtRating As P
                           left outer join inserted
                             on P.Id = inserted.Id
                           left outer join AsRatingCode As C
                             on P.RatingCodeId = C.Id
                           left outer join AsRatingAgency As A
                             on P.RatingAgencyId = A.Id
                           where P.PartnerId = inserted.PartnerId
                           order by A.Priority ASC, P.RatingDate DESC)


update PtBase
  set PtBase.InternRatingCodeNo = @InternRatingCodeNo
  from PtRating, inserted
  where PtBase.Id = inserted.PartnerId
  and (   PtBase.InternRatingCodeNo <> @InternRatingCodeNo
       or PtBase.InternRatingCodeNo is NULL)
GO

--changeset system:baseline-create-alter-trigger-PtRatingImFunction_MakeCriteriaEntries context:any labels:c-any,o-table,ot-schema,on-PtRatingImFunction,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtRatingImFunction_MakeCriteriaEntries on table PtRatingImFunction
CREATE OR ALTER TRIGGER PtRatingImFunction_MakeCriteriaEntries
   ON PtRatingImFunction FOR INSERT AS
BEGIN
SET NOCOUNT ON

INSERT INTO PtRatingImCriteria
    (Id, 
    HdVersionNo, 
    HdChangeDate, 
    HdCreator, 
    FunctionId, 
    CriteriaId)
SELECT 
    NEWID(), 
    1, 
    GETDATE(), 
    inserted.HdCreator, 
    inserted.Id, 
    ImC.Id 
FROM inserted, AsRatingImCriteria AS ImC 
WHERE ImC.FunctionId = inserted.FunctionId AND ImC.HdVersionNo BETWEEN 1 AND 999999998

END
GO

--changeset system:baseline-create-alter-trigger-PtStandingOrder_Insert context:any labels:c-any,o-table,ot-schema,on-PtStandingOrder,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtStandingOrder_Insert on table PtStandingOrder
CREATE OR ALTER TRIGGER PtStandingOrder_Insert
   ON PtStandingOrder FOR INSERT AS
SET NOCOUNT ON


SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-PtStandingOrder_Update context:any labels:c-any,o-table,ot-schema,on-PtStandingOrder,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtStandingOrder_Update on table PtStandingOrder
CREATE OR ALTER TRIGGER PtStandingOrder_Update
   ON PtStandingOrder FOR UPDATE AS

SET NOCOUNT ON



SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-PtTransItem_Insert context:any labels:c-any,o-table,ot-schema,on-PtTransItem,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtTransItem_Insert on table PtTransItem
CREATE OR ALTER TRIGGER PtTransItem_Insert
   ON PtTransItem FOR INSERT AS
BEGIN
	SET NOCOUNT ON
	DECLARE	@Id	UNIQUEIDENTIFIER
	DECLARE	@Date	DATETIME
	SET @Id = (SELECT Id FROM inserted)
	SET @Date = (SELECT TransDate FROM inserted)
	IF (SELECT RealDate FROM inserted) IS NULL
		UPDATE	PtTransItem SET RealDate = @Date
		WHERE	Id = @Id
END
GO

--changeset system:baseline-create-alter-trigger-PtTransItemBuffer_Insert context:any labels:c-any,o-table,ot-schema,on-PtTransItemBuffer,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtTransItemBuffer_Insert on table PtTransItemBuffer
CREATE OR ALTER TRIGGER PtTransItemBuffer_Insert
   ON PtTransItemBuffer FOR INSERT AS
BEGIN
	SET NOCOUNT ON
	DECLARE	@Id	UNIQUEIDENTIFIER
	DECLARE	@Date	DATETIME
	SET @Id = (SELECT Id FROM inserted)
	SET @Date = (SELECT TransDate FROM inserted)
	IF (SELECT RealDate FROM inserted) IS NULL
		UPDATE	PtTransItem SET RealDate = @Date
		WHERE	Id = @Id
END
GO

--changeset system:baseline-create-alter-trigger-PtTransMessageCharge_SetTransDate context:any labels:c-any,o-table,ot-schema,on-PtTransMessageCharge,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtTransMessageCharge_SetTransDate on table PtTransMessageCharge
CREATE OR ALTER TRIGGER PtTransMessageCharge_SetTransDate
   ON PtTransMessageCharge FOR INSERT AS

SET NOCOUNT ON

Update PtTransMessageCharge Set PtTransMessageCharge.TransDate = PtTransMessageCharge.ValueDate
from PtTransMessageCharge
inner join inserted on PtTransMessageCharge.Id = inserted.Id 
Where inserted.TransDate is null

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-PtTransSxParams_UpdateTestStatusNo context:any labels:c-any,o-table,ot-schema,on-PtTransSxParams,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtTransSxParams_UpdateTestStatusNo on table PtTransSxParams
CREATE OR ALTER TRIGGER PtTransSxParams_UpdateTestStatusNo
   ON PtTransSxParams FOR UPDATE AS
BEGIN
   SET NOCOUNT ON
      IF UPDATE (OwnCommission) or 
          UPDATE (BrokerageCommission) or 
          UPDATE (SWXVirtXFee) or 
          UPDATE (EurexFee) or 
          UPDATE (UKStampDuty) or 
          UPDATE (FedTurnoverTax) 
      BEGIN
          UPDATE  PtTransSxParamsResults 
          SET TestStatusNo = 5
          WHERE TransSxParamsId IN (SELECT Id from inserted)
      END
END
GO

--changeset system:baseline-create-alter-trigger-PtTransSxParamsResults_UpdateTestStatusNo context:any labels:c-any,o-table,ot-schema,on-PtTransSxParamsResults,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger PtTransSxParamsResults_UpdateTestStatusNo on table PtTransSxParamsResults
CREATE OR ALTER TRIGGER PtTransSxParamsResults_UpdateTestStatusNo
   ON PtTransSxParamsResults FOR UPDATE AS
BEGIN
   SET NOCOUNT ON
      IF UPDATE (TestStatusNo) 
      BEGIN
          UPDATE  PtTransSxParams 
          SET ResultsStatusNo = (SELECT MAX(TestStatusNo) from PtTransSxParamsResults WHERE TransSxParamsId IN (SELECT TransSxParamsId from inserted) and HdVersionNo between 1 and 999999998) 
          WHERE Id IN (SELECT TransSxParamsId from inserted)
      END
END
GO

--changeset system:baseline-create-alter-trigger-ReLand_SetReBuildingAreaM2 context:any labels:c-any,o-table,ot-schema,on-ReLand,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger ReLand_SetReBuildingAreaM2 on table ReLand
CREATE OR ALTER TRIGGER ReLand_SetReBuildingAreaM2
   ON ReLand FOR INSERT, UPDATE, DELETE AS
BEGIN
   SET NOCOUNT ON
   BEGIN
      IF (SELECT COUNT(*) 
          FROM deleted
          WHERE deleted.HdCreateDate IS NOT NULL) > 0
      BEGIN
         UPDATE ReBuilding SET LandAreaM2 = (SELECT SUM(ReLand.AreaM2)
         FROM ReLand WHERE ReLand.BuildingId = B.Id
         AND ReLand.HdVersionNo < 999999999)
         FROM ReBuilding B JOIN deleted ON B.Id = deleted.BuildingId
         WHERE deleted.BuildingId IS NOT NULL
         AND B.HdVersionNo < 999999999
         AND B.HdCreateDate <> (SELECT MIN(B2.HdCreateDate)
                                FROM ReBuilding B2
                                WHERE B2.HdVersionNo < 999999999
                                AND B2.PremisesId = B.PremisesId)
         UPDATE ReBuilding SET LandAreaM2 = (SELECT SUM(ReLand.AreaM2)
         FROM ReLand WHERE ((ReLand.BuildingId = B.Id) OR ((ReLand.BuildingId IS NULL) AND (ReLand.PremisesId = B.PremisesId))) 
         AND ReLand.HdVersionNo < 999999999)
         FROM ReBuilding B JOIN deleted ON B.PremisesId = deleted.PremisesId
         WHERE B.HdVersionNo < 999999999
         AND B.HdCreateDate = (SELECT MIN(B2.HdCreateDate)
                               FROM ReBuilding B2
                               WHERE B2.HdVersionNo < 999999999
                               AND B2.PremisesId = B.PremisesId)
         UPDATE RePremises SET AreaM2 = (SELECT SUM(ReLand.AreaM2)
         FROM ReLand WHERE ReLand.PremisesId = B.Id
         AND ReLand.HdVersionNo < 999999999)
         FROM RePremises B JOIN deleted ON B.Id = deleted.PremisesId
         WHERE B.HdVersionNo < 999999999
      END
      IF (SELECT COUNT(*) 
          FROM inserted
          WHERE inserted.HdCreateDate IS NOT NULL) > 0
      BEGIN
         UPDATE ReBuilding SET LandAreaM2 = (SELECT SUM(ReLand.AreaM2)
         FROM ReLand WHERE ReLand.BuildingId = B.Id
         AND ReLand.HdVersionNo < 999999999)
         FROM ReBuilding B JOIN inserted ON B.Id = inserted.BuildingId
         WHERE inserted.BuildingId IS NOT NULL
         AND B.HdVersionNo < 999999999
         AND B.HdCreateDate <> (SELECT MIN(B2.HdCreateDate)
                               FROM ReBuilding B2
                               WHERE B2.HdVersionNo < 999999999
                               AND B2.PremisesId = B.PremisesId)
         UPDATE ReBuilding SET LandAreaM2 = (SELECT SUM(ReLand.AreaM2)
         FROM ReLand WHERE ((ReLand.BuildingId = B.Id) OR ((ReLand.BuildingId IS NULL) AND (ReLand.PremisesId = B.PremisesId)))
         AND ReLand.HdVersionNo < 999999999)
         FROM ReBuilding B JOIN inserted ON B.PremisesId = inserted.PremisesId
         WHERE B.HdVersionNo < 999999999
         AND B.HdCreateDate = (SELECT MIN(B2.HdCreateDate)
                               FROM ReBuilding B2
                               WHERE B2.HdVersionNo < 999999999
                               AND B2.PremisesId = B.PremisesId)
         UPDATE RePremises SET AreaM2 = (SELECT SUM(ReLand.AreaM2)
         FROM ReLand WHERE ReLand.PremisesId = B.Id
         AND ReLand.HdVersionNo < 999999999)
         FROM RePremises B JOIN inserted ON B.Id = inserted.PremisesId
         WHERE B.HdVersionNo < 999999999
      END
   END
END
GO

--changeset system:baseline-create-alter-trigger-ReObligation_History context:any labels:c-any,o-table,ot-schema,on-ReObligation,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger ReObligation_History on table ReObligation
CREATE OR ALTER TRIGGER ReObligation_History
   ON ReObligation FOR UPDATE AS

SET NOCOUNT ON

SELECT rpr.Id , rph.PledgeRegisterId , MAX( ropr.HdCreator ) as HdCreator , MAX( ropr.HdChangeUser ) AS HdChangeUser 
   , SUM( ropr.ObligAmountChargeable ) AS ObligationAmount , CONVERT(CHAR(10) , GETDATE() , 112) AS DateHistory
   , rpr.HdVersionNo , rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB
   , rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
INTO #t1
   FROM RePledgeRegister rpr 
   LEFT OUTER JOIN RePledgeHistory rph ON rpr.Id = rph.PledgeRegisterId AND rph.DateHistory = CONVERT(CHAR(10) , GETDATE() , 112) 
   INNER JOIN ReBase rb ON rpr.ReBaseId = rb.Id AND rb.HdVersionNo BETWEEN 1 AND 999999998
   INNER JOIN RePremises rp ON rb.Id = rp.reBaseId 
   INNER JOIN ReObligPremisesRelation ropr ON rp.Id = ropr.PremisesId 
   INNER JOIN ReObligation ro ON ropr.ObligationId = ro.Id AND ro.PfBFlag = 1
   WHERE ( ropr.PremisesId = ropr.PremisesOrigId OR ropr.PremisesOrigId IS NULL ) 
      AND ropr.HdVersionNo BETWEEN 1 AND 999999998 AND  rpr.HdVersionNo BETWEEN 1 AND 999999998
      AND rpr.Id IN ( SELECT rpr.Id FROM inserted ins 
	   INNER JOIN deleted del ON ins.Id = del.Id AND ins.PfBFlag <> del.PfBFlag
	   INNER JOIN ReObligPremisesRelation ropr ON del.Id = ropr.ObligationId
	   INNER JOIN RePremises rp ON ropr.PremisesId = rp.Id AND rp.HdVersionNo BETWEEN 1 AND 999999998
	   INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id AND rb.HdVersionNo BETWEEN 1 AND 999999998
	   INNER JOIN RePledgeRegister rpr ON rb.Id = rpr.ReBaseId AND  rpr.HdVersionNo BETWEEN 1 AND 999999998 )
   GROUP BY rpr.Id , rph.PledgeRegisterId , rpr.HdVersionNo , rpr.ValueDate 
   	, rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB , rpr.PledgeRegisterNo 
   	, rpr.PledgeRegisterPartNo , rpr.PledgeTypeId , rpr.PledgeAmount 
      , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted

SELECT rpra.PledgeRegisterId , SUM(rpra.DebitAmount) AS DebitAmount 
INTO #t2
   FROM #t1 
   INNER JOIN RePledgeRegisterAccount rpra ON #t1.Id = rpra.PledgeRegisterId 
   WHERE #t1.PledgeRegisterId IS NULL AND rpra.HdVersionNo BETWEEN 1 AND 999999998
   GROUP BY rpra.PledgeRegisterId

INSERT INTO RePledgeHistory ( PledgeRegisterId , HdCreator , HdChangeUser , HdVersionNo , DateHistory 
      , BcNumber , PledgeRegisterNo , PledgeRegisterPartNo , PledgeTypeId , StatusNo  
      , StatusNoPfB, ValueDate , DebitAmount , PledgeAmount , PledgeAmountAdjusted  
      , ValueAmount , ValueAmountAdjusted , ObligationAmount 
	) SELECT #t1.Id, #t1.HdCreator , #t1.HdChangeUser , #t1.HdVersionNo , #t1.DateHistory , #t1.BcNumber  
      , #t1.PledgeRegisterNo , #t1.PledgeRegisterPartNo , #t1.PledgeTypeId , #t1.StatusNo  
      , #t1.StatusNoPfB , #t1.ValueDate , #t2.DebitAmount , #t1.PledgeAmount , #t1.PledgeAmountAdjusted
		, #t1.ValueAmount , #t1.ValueAmountAdjusted , #t1.ObligationAmount 
		FROM  #t1
      INNER JOIN #t2 ON #t1.Id = #t2.PledgeRegisterId   
		WHERE #t1.PledgeRegisterId IS NULL

UPDATE RePledgeHistory 
   SET ObligationAmount = #t1.ObligationAmount
        , HdChangeUser = #t1.HdChangeUser 
        , HdChangeDate = GETDATE()
   FROM RePledgeHistory rpph 
   INNER JOIN #t1 ON #t1.Id = rpph.PledgeRegisterId AND #t1.DateHistory = rpph.DateHistory
   WHERE #t1.PledgeRegisterId IS NOT NULL

DROP TABLE #t1
DROP TABLE #t2

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-ReObligPremisesRelation_HistoryIns context:any labels:c-any,o-table,ot-schema,on-ReObligPremisesRelation,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger ReObligPremisesRelation_HistoryIns on table ReObligPremisesRelation
CREATE OR ALTER TRIGGER ReObligPremisesRelation_HistoryIns
   ON ReObligPremisesRelation FOR INSERT AS

SET NOCOUNT ON

SELECT rpr.Id , rph.PledgeRegisterId , MAX( ins.HdCreator ) as HdCreator , MAX( ins.HdChangeUser ) AS HdChangeUser 
   , SUM( ropr.ObligAmountChargeable ) AS ObligationAmount , CONVERT(CHAR(10) , GETDATE() , 112) AS DateHistory
   , rpr.HdVersionNo , rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB
   , rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
INTO #t1
   FROM inserted ins 
   INNER JOIN RePremises rp ON ins.PremisesId = rp.Id AND rp.HdVersionNo BETWEEN 1 AND 999999998
   INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id AND rb.HdVersionNo BETWEEN 1 AND 999999998
   INNER JOIN RePledgeRegister rpr ON rb.Id = rpr.ReBaseId AND  rpr.HdVersionNo BETWEEN 1 AND 999999998
   LEFT OUTER JOIN RePledgeHistory rph ON rpr.Id = rph.PledgeRegisterId 
		AND rph.DateHistory = CONVERT(CHAR(10) , GETDATE() , 112) 
   INNER JOIN RePremises rp1 ON rb.Id = rp1.reBaseId 
   INNER JOIN ReObligPremisesRelation ropr ON rp1.Id = ropr.PremisesId 
   INNER JOIN ReObligation ro ON ropr.ObligationId = ro.Id AND ro.PfBFlag = 1
   WHERE ( ropr.PremisesId = ropr.PremisesOrigId OR ropr.PremisesOrigId IS NULL ) 
		AND ins.PremisesId IS NOT NULL
      AND ropr.HdVersionNo BETWEEN 1 AND 999999998 
   GROUP BY rpr.Id , rph.PledgeRegisterId , rpr.HdVersionNo
   	, rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB 
   	, rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
      , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted

SELECT rpra.PledgeRegisterId , SUM(rpra.DebitAmount) AS DebitAmount 
INTO #t2
   FROM #t1 
   INNER JOIN RePledgeRegisterAccount rpra ON #t1.Id = rpra.PledgeRegisterId 
   WHERE #t1.PledgeRegisterId IS NULL AND rpra.HdVersionNo BETWEEN 1 AND 999999998
   GROUP BY rpra.PledgeRegisterId

INSERT INTO RePledgeHistory ( PledgeRegisterId , HdCreator , HdChangeUser , HdVersionNo , DateHistory 
      , BcNumber , PledgeRegisterNo , PledgeRegisterPartNo , PledgeTypeId  
      , StatusNo , StatusNoPfB , ValueDate , DebitAmount , PledgeAmount , PledgeAmountAdjusted  
      , ValueAmount , ValueAmountAdjusted , ObligationAmount 
	) SELECT #t1.Id, #t1.HdCreator , #t1.HdChangeUser , #t1.HdVersionNo , #t1.DateHistory 
      , #t1.BcNumber , #t1.PledgeRegisterNo , #t1.PledgeRegisterPartNo , #t1.PledgeTypeId  
      , #t1.StatusNo , #t1.StatusNoPfB , #t1.ValueDate , #t2.DebitAmount , #t1.PledgeAmount 
		, #t1.PledgeAmountAdjusted , #t1.ValueAmount , #t1.ValueAmountAdjusted , #t1.ObligationAmount 
		FROM  #t1
      INNER JOIN #t2 ON #t1.Id = #t2.PledgeRegisterId   
		WHERE #t1.PledgeRegisterId IS NULL

UPDATE RePledgeHistory 
   SET ObligationAmount = #t1.ObligationAmount
        , HdChangeUser = #t1.HdChangeUser 
        , HdChangeDate = GETDATE()
   FROM RePledgeHistory rph 
   INNER JOIN #t1 ON #t1.Id = rph.PledgeRegisterId AND #t1.DateHistory = rph.DateHistory
   WHERE #t1.PledgeRegisterId IS NOT NULL

DROP TABLE #t1
DROP TABLE #t2

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-ReObligPremisesRelation_HistoryUpd context:any labels:c-any,o-table,ot-schema,on-ReObligPremisesRelation,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger ReObligPremisesRelation_HistoryUpd on table ReObligPremisesRelation
CREATE OR ALTER TRIGGER ReObligPremisesRelation_HistoryUpd
   ON ReObligPremisesRelation FOR UPDATE AS
SET NOCOUNT ON

SELECT rpr.Id , rph.PledgeRegisterId , MAX( ins.HdCreator ) as HdCreator , MAX( ins.HdChangeUser ) AS HdChangeUser 
   , SUM( ropr.ObligAmountChargeable ) AS ObligationAmount , CONVERT(CHAR(10) , GETDATE() , 112) AS DateHistory
   , rpr.HdVersionNo	, rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB
   , rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
INTO #t1
   FROM inserted ins 
   INNER JOIN deleted del ON ins.Id = del.Id 
		AND ( ins.ObligAmountChargeable <> del.ObligAmountChargeable OR ins.HdVersionNo <> del.HdVersionNo )
   INNER JOIN RePremises rp ON del.PremisesId = rp.Id AND rp.HdVersionNo BETWEEN 1 AND 999999998
   INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id AND rb.HdVersionNo BETWEEN 1 AND 999999998
   INNER JOIN RePledgeRegister rpr ON rb.Id = rpr.ReBaseId AND  rpr.HdVersionNo BETWEEN 1 AND 999999998
   LEFT OUTER JOIN RePledgeHistory rph ON rpr.Id = rph.PledgeRegisterId AND rph.DateHistory = CONVERT(CHAR(10) , GETDATE() , 112) 
   INNER JOIN RePremises rp1 ON rb.Id = rp1.reBaseId 
   INNER JOIN ReObligPremisesRelation ropr ON rp1.Id = ropr.PremisesId 
   INNER JOIN ReObligation ro ON ropr.ObligationId = ro.Id AND ro.PfBFlag = 1
   WHERE ( ropr.PremisesId = ropr.PremisesOrigId OR ropr.PremisesOrigId IS NULL ) 
      AND ropr.HdVersionNo BETWEEN 1 AND 999999998 
   GROUP BY rpr.Id , rph.PledgeRegisterId , rpr.HdVersionNo , rpr.ValueDate 
   	, rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB , rpr.PledgeRegisterNo 
   	, rpr.PledgeRegisterPartNo , rpr.PledgeTypeId , rpr.PledgeAmount 
      , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted

SELECT rpra.PledgeRegisterId , SUM(rpra.DebitAmount) AS DebitAmount 
INTO #t2
   FROM #t1 
   INNER JOIN RePledgeRegisterAccount rpra ON #t1.Id = rpra.PledgeRegisterId 
   WHERE #t1.PledgeRegisterId IS NULL AND rpra.HdVersionNo BETWEEN 1 AND 999999998
   GROUP BY rpra.PledgeRegisterId

INSERT INTO RePledgeHistory ( PledgeRegisterId , HdCreator , HdChangeUser , HdVersionNo , DateHistory 
      , BcNumber , PledgeRegisterNo , PledgeRegisterPartNo , PledgeTypeId , StatusNo  
      , StatusNoPfB, ValueDate , DebitAmount , PledgeAmount , PledgeAmountAdjusted  
      , ValueAmount , ValueAmountAdjusted , ObligationAmount 
	) SELECT #t1.Id, #t1.HdCreator , #t1.HdChangeUser , #t1.HdVersionNo , #t1.DateHistory , #t1.BcNumber  
      , #t1.PledgeRegisterNo , #t1.PledgeRegisterPartNo , #t1.PledgeTypeId , #t1.StatusNo  
      , #t1.StatusNoPfB , #t1.ValueDate , #t2.DebitAmount , #t1.PledgeAmount , #t1.PledgeAmountAdjusted
		, #t1.ValueAmount , #t1.ValueAmountAdjusted , #t1.ObligationAmount 
		FROM  #t1
      INNER JOIN #t2 ON #t1.Id = #t2.PledgeRegisterId   
		WHERE #t1.PledgeRegisterId IS NULL

UPDATE RePledgeHistory 
   SET ObligationAmount = #t1.ObligationAmount
        , HdChangeUser = #t1.HdChangeUser 
        , HdChangeDate = GETDATE()
   FROM RePledgeHistory rph 
   INNER JOIN #t1 ON #t1.Id = rph.PledgeRegisterId AND #t1.DateHistory = rph.DateHistory
   WHERE #t1.PledgeRegisterId IS NOT NULL

DROP TABLE #t1
DROP TABLE #t2

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-ReObligPremisesRelation_PfBHistory context:any labels:c-any,o-table,ot-schema,on-ReObligPremisesRelation,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger ReObligPremisesRelation_PfBHistory on table ReObligPremisesRelation
CREATE OR ALTER TRIGGER ReObligPremisesRelation_PfBHistory
   ON ReObligPremisesRelation FOR INSERT, UPDATE AS

SET NOCOUNT ON

SELECT rpr.Id , rpph.PledgeRegisterId , MAX( ins.HdCreator ) as HdCreator , MAX( ins.HdChangeUser ) AS HdChangeUser 
   , SUM( ropr.ObligAmountChargeable ) AS ObligationAmount , CONVERT(CHAR(10) , GETDATE() , 112) AS DateHistory
   , rpr.HdVersionNo	, rpr.ValueDate , rpr.PfBNo , rpr.BCNumber , rpr.StatusNo
   , rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
INTO #t1
   FROM inserted ins 
   INNER JOIN deleted del ON ins.Id = del.Id AND ( ins.ObligAmountChargeable <> del.ObligAmountChargeable OR ins.HdVersionNo <> del.HdVersionNo )
   INNER JOIN RePremises rp ON del.PremisesId = rp.Id 
   INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id
   INNER JOIN RePledgeRegister rpr ON rb.Id = rpr.ReBaseId 
   LEFT OUTER JOIN RePfbPledgeHistory rpph ON rpr.Id = rpph.PledgeRegisterId and rpph.DateHistory = CONVERT(CHAR(10) , GETDATE() , 112) 
   INNER JOIN RePremises rp1 ON rb.Id = rp1.reBaseId 
   INNER JOIN ReObligPremisesRelation ropr ON rp1.Id = ropr.PremisesId 
   INNER JOIN ReObligation ro ON ropr.ObligationId = ro.Id AND ro.PFBFlag = 1
   WHERE ropr.PremisesId = ropr.PremisesOrigId 
      AND ropr.HdVersionNo BETWEEN 1 AND 999999998 AND rp.HdVersionNo BETWEEN 1 AND 999999998
      AND rb.HdVersionNo BETWEEN 1 AND 999999998 AND  rpr.HdVersionNo BETWEEN 1 AND 999999998
   GROUP BY rpr.Id , rpph.PledgeRegisterId , rpr.HdVersionNo
   	, rpr.ValueDate , rpr.PfBNo , rpr.BCNumber , rpr.StatusNo
   	, rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
      , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted

SELECT rpra.PledgeRegisterId , SUM(rpra.DebitAmount) AS DebitAmount 
INTO #t2
   FROM #t1 
   INNER JOIN RePledgeRegisterAccount rpra ON #t1.Id = rpra.PledgeRegisterId 
   WHERE #t1.PledgeRegisterId IS NULL AND rpra.HdVersionNo BETWEEN 1 AND 999999998
   GROUP BY rpra.PledgeRegisterId

INSERT INTO RePfbPledgeHistory ( PledgeRegisterId , HdCreator , HdChangeUser , HdVersionNo , DateHistory 
      , BcNumber , PfBNo, PledgeRegisterNo , PledgeRegisterPartNo , PledgeTypeId  
      , StatusNo , ValueDate , DebitAmount , PledgeAmount , PledgeAmountAdjusted  
      , ValueAmount , ValueAmountAdjusted , ObligationAmount 
	) SELECT #t1.Id, #t1.HdCreator , #t1.HdChangeUser , #t1.HdVersionNo , #t1.DateHistory 
      , #t1.BcNumber , #t1.PfBNo, #t1.PledgeRegisterNo , #t1.PledgeRegisterPartNo , #t1.PledgeTypeId  
      , #t1.StatusNo , #t1.ValueDate , #t2.DebitAmount , #t1.PledgeAmount , #t1.PledgeAmountAdjusted
		, #t1.ValueAmount , #t1.ValueAmountAdjusted , #t1.ObligationAmount 
		FROM  #t1
      INNER JOIN #t2 ON #t1.Id = #t2.PledgeRegisterId   
		WHERE #t1.PledgeRegisterId IS NULL

UPDATE RePfbPledgeHistory 
   SET ObligationAmount = #t1.ObligationAmount
        , HdChangeUser = #t1.HdChangeUser 
        , HdChangeDate = GETDATE()
   FROM RePfbPledgeHistory rpph 
   INNER JOIN #t1 ON #t1.Id = rpph.PledgeRegisterId AND #t1.DateHistory = rpph.DateHistory
   WHERE #t1.PledgeRegisterId IS NOT NULL

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-RePledgeRegister_CalcOrderField context:any labels:c-any,o-table,ot-schema,on-RePledgeRegister,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger RePledgeRegister_CalcOrderField on table RePledgeRegister
CREATE OR ALTER TRIGGER RePledgeRegister_CalcOrderField
   ON RePledgeRegister FOR INSERT, UPDATE AS
SET NOCOUNT ON
UPDATE RePledgeRegister
    SET PledgeOrderField = Cast(IsNull(i.PledgeRegisterPartNo,0) As bigint) * Power(10,6) + i.PledgeRegisterNo
    FROM RePledgeRegister r, Inserted i
    WHERE r.Id = I.Id
       AND (r.PledgeOrderField Is NULL OR r.PledgeOrderField != i.PledgeOrderField)
GO

--changeset system:baseline-create-alter-trigger-RePledgeRegister_InsUpdHistory context:any labels:c-any,o-table,ot-schema,on-RePledgeRegister,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger RePledgeRegister_InsUpdHistory on table RePledgeRegister
CREATE OR ALTER TRIGGER RePledgeRegister_InsUpdHistory
   ON RePledgeRegister FOR INSERT, UPDATE AS
SET NOCOUNT ON

SELECT rpr.Id , rpr.hdversionNo , rph.PledgeRegisterId , MAX( ins.HdCreator ) AS HdCreator , CONVERT(CHAR(10) , GETDATE() , 112) as DateHistory
      , MAX( ins.HdChangeUser ) AS HdChangeUser , SUM(rpra.DebitAmount) AS DebitAmount 
INTO #RePledgeRegisterTemp1
   FROM RePledgeRegisterAccount rpra
   RIGHT OUTER JOIN RePledgeRegister rpr ON rpr.Id = rpra.PledgeRegisterId AND  (rpra.HdVersionNo BETWEEN 1 AND 999999998) 
   INNER JOIN inserted ins ON ins.Id = rpr.Id
   INNER JOIN deleted del ON del.Id = ins.Id AND ( 
         del.HdVersionNo <> ins.HdVersionNo OR del.ValueAmountAdjusted <> ins.ValueAmountAdjusted
      OR del.ValueDate <> ins.ValueDate OR del.BCNumber <> ins.BCNumber 
      OR del.StatusNo <> ins.StatusNo OR del.StatusNoPfB <> ins.StatusNoPfB 
      OR del.PledgeRegisterNo <> ins.PledgeRegisterNo OR del.PledgeRegisterPartNo <> ins.PledgeRegisterPartNo
      OR del.PledgeTypeId <> ins.PledgeTypeId OR del.PledgeAmount <> ins.PledgeAmount
      OR del.PledgeAmountAdjusted <> ins.PledgeAmountAdjusted OR del.ValueAmount <> ins.ValueAmount
      )
   LEFT OUTER JOIN RePledgeHistory rph ON rpr.Id = rph.PledgeRegisterId 
         AND rph.DateHistory = CONVERT(CHAR(10), GETDATE() , 112)  
GROUP BY rpr.Id ,  rpr.hdversionNo, rph.PledgeRegisterId

SELECT * INTO #RePledgeRegisterTemp2 
FROM (
SELECT rpr.Id , SUM( ropr.ObligAmountChargeable ) AS ObligationAmount 
	   , rpr.HdVersionNo , rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB
	   , rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
	   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
FROM ReObligPremisesRelation ropr
Inner JOIN ReObligation ro ON ropr.ObligationId = ro.Id AND ro.PfBFlag = 1
INNER JOIN RePremises rp ON ropr.PremisesId = rp.Id AND rp.HdVersionNo BETWEEN 1 AND 999999998
INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id AND rb.HdVersionNo BETWEEN 1 AND 999999998  
INNER JOIN RePledgeRegister rpr ON rb.Id = rpr.ReBaseId AND rpr.ReBaseId IS NOT NULL
INNER JOIN #RePledgeRegisterTemp1 ON #RePledgeRegisterTemp1.Id = rpr.Id
WHERE ( ropr.PremisesId = ropr.PremisesOrigId OR ropr.PremisesOrigId IS NULL ) AND ropr.HdVersionNo BETWEEN 1 AND 999999998 
GROUP BY rpr.Id , rpr.HdVersionNo , rpr.ValueDate , rpr.BCNumber , rpr.StatusNo
	, rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId , rpr.StatusNoPfB
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
UNION
SELECT rpr.Id , 0 AS ObligationAmount 
	, rpr.HdVersionNo , rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB
   , rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted 
FROM RePledgeRegister rpr 
	INNER JOIN #RePledgeRegisterTemp1 ON #RePledgeRegisterTemp1.Id = rpr.Id
WHERE rpr.HdVersionNo BETWEEN 1 AND 999999998 AND rpr.Id NOT IN ( 
		SELECT pr.Id  
		FROM ReObligPremisesRelation ropr 
			INNER JOIN RePremises rp ON ropr.PremisesId = rp.Id AND rp.HdVersionNo BETWEEN 1 AND 999999998 
			INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id AND rb.HdVersionNo BETWEEN 1 AND 999999998 
			INNER JOIN RePledgeRegister pr ON rb.Id = pr.ReBaseId AND pr.ReBaseId IS NOT NULL 
				AND pr.HdVersionNo BETWEEN 1 AND 999999998 
		WHERE ropr.HdVersionNo BETWEEN 1 AND 999999998  ) 
) AS ta1

INSERT INTO RePledgeHistory ( PledgeRegisterId, HdCreator , HdChangeUser , HdVersionNo  
      , DateHistory , BcNumber , PledgeRegisterNo , PledgeRegisterPartNo , PledgeTypeId  
      , StatusNo , StatusNoPfB , ValueDate , DebitAmount , PledgeAmount , PledgeAmountAdjusted  
      , ValueAmount , ValueAmountAdjusted , ObligationAmount 
	) SELECT #RePledgeRegisterTemp1.Id, #RePledgeRegisterTemp1.HdCreator , #RePledgeRegisterTemp1.HdChangeUser , #RePledgeRegisterTemp2.HdVersionNo , #RePledgeRegisterTemp1.DateHistory 
      , #RePledgeRegisterTemp2.BcNumber , #RePledgeRegisterTemp2.PledgeRegisterNo , #RePledgeRegisterTemp2.PledgeRegisterPartNo , #RePledgeRegisterTemp2.PledgeTypeId  
      , #RePledgeRegisterTemp2.StatusNo , #RePledgeRegisterTemp2.StatusNoPfB , #RePledgeRegisterTemp2.ValueDate , #RePledgeRegisterTemp1.DebitAmount , #RePledgeRegisterTemp2.PledgeAmount 
		, #RePledgeRegisterTemp2.PledgeAmountAdjusted , #RePledgeRegisterTemp2.ValueAmount , #RePledgeRegisterTemp2.ValueAmountAdjusted , #RePledgeRegisterTemp2.ObligationAmount 
		FROM  #RePledgeRegisterTemp2  
      Inner JOIN #RePledgeRegisterTemp1 ON #RePledgeRegisterTemp1.Id = #RePledgeRegisterTemp2.Id 
		WHERE #RePledgeRegisterTemp1.PledgeRegisterId IS NULL

UPDATE RePledgeHistory 
SET HdChangeUser = #RePledgeRegisterTemp1.HdChangeUser
  , HdChangeDate = GETDATE()
  , HdVersionNo = #RePledgeRegisterTemp2.HdVersionNo 
  , BcNumber = #RePledgeRegisterTemp2.BcNumber 
  , PledgeRegisterNo = #RePledgeRegisterTemp2.PledgeRegisterNo
  , PledgeRegisterPartNo = #RePledgeRegisterTemp2.PledgeRegisterPartNo
  , PledgeTypeId  = #RePledgeRegisterTemp2.PledgeTypeId
  , StatusNo = #RePledgeRegisterTemp2.StatusNo
  , StatusNoPfB = #RePledgeRegisterTemp2.StatusNoPfB
  , ValueDate = #RePledgeRegisterTemp2.ValueDate
  , PledgeAmount = #RePledgeRegisterTemp2.PledgeAmount
  , PledgeAmountAdjusted = #RePledgeRegisterTemp2.PledgeAmountAdjusted 
  , ValueAmount = #RePledgeRegisterTemp2.ValueAmount
  , ValueAmountAdjusted = #RePledgeRegisterTemp2.ValueAmountAdjusted
  , ObligationAmount = #RePledgeRegisterTemp2.ObligationAmount 
  ,	DebitAmount = #RePledgeRegisterTemp1.DebitAmount
FROM RePledgeHistory rpph 
INNER JOIN #RePledgeRegisterTemp2 ON #RePledgeRegisterTemp2.Id = rpph.PledgeRegisterId 
INNER JOIN #RePledgeRegisterTemp1 ON #RePledgeRegisterTemp1.Id = #RePledgeRegisterTemp2.Id 
		WHERE #RePledgeRegisterTemp1.PledgeRegisterId IS NOT NULL AND #RePledgeRegisterTemp1.DateHistory = rpph.DateHistory

UPDATE RePledgeHistory 
SET HdChangeUser = #RePledgeRegisterTemp1.HdChangeUser
  , HdChangeDate = GETDATE()
  , HdVersionNo =  #RePledgeRegisterTemp1.HdVersionNo
From RePledgeHistory
INNER JOIN #RePledgeRegisterTemp1 ON #RePledgeRegisterTemp1.Id = RePledgeHistory.PledgeRegisterId AND #RePledgeRegisterTemp1.HdVersionNo = 999999999 AND RePledgeHistory.HdVersionNo <> 999999999
INNER JOIN ( SELECT rph.PledgeRegisterId , MAX( rph.DateHistory ) AS DateHistory FROM RePledgeHistory rph WHERE CONVERT(Char(10), rph.DateHistory, 112) <= GetDate() GROUP BY rph.PledgeRegisterId ) AS ph2 ON RePledgeHistory.PledgeRegisterId = ph2.PledgeRegisterId AND RePledgeHistory.DateHistory = ph2.DateHistory 

Update RePledgeRegisterAccount
SET HdChangeUser = #RePledgeRegisterTemp1.HdChangeUser
  , HdChangeDate = GETDATE()
  , HdVersionNo =  #RePledgeRegisterTemp1.HdVersionNo
From RePledgeRegisterAccount
INNER JOIN #RePledgeRegisterTemp1 ON #RePledgeRegisterTemp1.Id = RePledgeRegisterAccount.PledgeRegisterId AND #RePledgeRegisterTemp1.HdVersionNo = 999999999 AND RePledgeRegisterAccount.HdVersionNo <> 999999999


DROP TABLE #RePledgeRegisterTemp1
DROP TABLE #RePledgeRegisterTemp2

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-RePledgeRegister_PfBHistory context:any labels:c-any,o-table,ot-schema,on-RePledgeRegister,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger RePledgeRegister_PfBHistory on table RePledgeRegister
CREATE OR ALTER TRIGGER RePledgeRegister_PfBHistory
   ON RePledgeRegister FOR INSERT, UPDATE AS
SET NOCOUNT ON

SELECT rpr.Id , rpph.PledgeRegisterId , MAX( ins.HdCreator ) AS HdCreator , CONVERT(CHAR(10) , GETDATE() , 112) as DateHistory
      , MAX( ins.HdChangeUser ) AS HdChangeUser , SUM(rpra.DebitAmount) AS DebitAmount 
INTO #t1
   FROM RePledgeRegisterAccount rpra
   RIGHT OUTER JOIN RePledgeRegister rpr ON rpr.Id = rpra.PledgeRegisterId AND  (rpra.HdVersionNo BETWEEN 1 AND 999999998) 
   INNER JOIN inserted ins ON ins.Id = rpr.Id
   INNER JOIN deleted del ON del.Id = ins.Id AND ( 
         del.HdVersionNo <> ins.HdVersionNo OR del.ValueAmountAdjusted <> ins.ValueAmountAdjusted
      OR del.ValueDate <> ins.ValueDate OR del.PfBNo <> ins.PfBNo
      OR del.BCNumber <> ins.BCNumber OR del.StatusNo <> ins.StatusNo
      OR del.PledgeRegisterNo <> ins.PledgeRegisterNo OR del.PledgeRegisterPartNo <> ins.PledgeRegisterPartNo
      OR del.PledgeTypeId <> ins.PledgeTypeId OR del.PledgeAmount <> ins.PledgeAmount
      OR del.PledgeAmountAdjusted <> ins.PledgeAmountAdjusted OR del.ValueAmount <> ins.ValueAmount
      )
   LEFT OUTER JOIN RePfbPledgeHistory rpph ON rpr.Id = rpph.PledgeRegisterId 
         AND rpph.DateHistory = CONVERT(CHAR(10), GETDATE() , 112)  
GROUP BY rpr.Id , rpph.PledgeRegisterId

SELECT rpr.Id , SUM( ropr.ObligAmountChargeable ) AS ObligationAmount 
   , rpr.HdVersionNo , rpr.ValueDate , rpr.PfBNo , rpr.BCNumber , rpr.StatusNo
	, rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
INTO #t2
   FROM ReObligPremisesRelation ropr
   INNER JOIN ReObligation ro ON ropr.ObligationId = ro.Id AND ro.PFBFlag = 1
   INNER JOIN RePremises rp ON ropr.PremisesId = rp.Id
   INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id
   INNER JOIN RePledgeRegister rpr ON rb.Id = rpr.ReBaseId AND rpr.ReBaseId IS NOT NULL
   INNER JOIN #t1 ON #t1.Id = rpr.Id
WHERE ropr.PremisesId = ropr.PremisesOrigId 
      AND ropr.HdVersionNo BETWEEN 1 AND 999999998 AND rp.HdVersionNo BETWEEN 1 AND 999999998
      AND rb.HdVersionNo BETWEEN 1 AND 999999998  
   GROUP BY rpr.Id , rpr.HdVersionNo , rpr.ValueDate , rpr.PfBNo , rpr.BCNumber , rpr.StatusNo
   	, rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
      , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted

INSERT INTO RePfbPledgeHistory ( PledgeRegisterId, HdCreator , HdChangeUser , HdVersionNo , DateHistory 
      , BcNumber , PfBNo, PledgeRegisterNo , PledgeRegisterPartNo , PledgeTypeId  
      , StatusNo , ValueDate , DebitAmount , PledgeAmount , PledgeAmountAdjusted  
      , ValueAmount , ValueAmountAdjusted , ObligationAmount 
	) SELECT #t1.Id, #t1.HdCreator , #t1.HdChangeUser , #t2.HdVersionNo , #t1.DateHistory 
      , #t2.BcNumber , #t2.PfBNo, #t2.PledgeRegisterNo , #t2.PledgeRegisterPartNo , #t2.PledgeTypeId  
      , #t2.StatusNo , #t2.ValueDate , #t1.DebitAmount , #t2.PledgeAmount , #t2.PledgeAmountAdjusted
		, #t2.ValueAmount , #t2.ValueAmountAdjusted , #t2.ObligationAmount 
		FROM  #t2  
      INNER JOIN #t1 ON #t1.Id = #t2.Id 
WHERE #t1.PledgeRegisterId IS NULL

UPDATE RePfbPledgeHistory 
SET HdChangeUser = #t1.HdChangeUser
  , HdChangeDate = GETDATE()
  , HdVersionNo = #t2.HdVersionNo 
  , BcNumber = #t2.BcNumber 
  , PfBNo = #t2.PfBNo
  , PledgeRegisterNo = #t2.PledgeRegisterNo
  , PledgeRegisterPartNo = #t2.PledgeRegisterPartNo
  , PledgeTypeId  = #t2.PledgeTypeId
  , StatusNo = #t2.StatusNo
  , ValueDate = #t2.ValueDate
  , PledgeAmount = #t2.PledgeAmount
  , PledgeAmountAdjusted = #t2.PledgeAmountAdjusted 
  , ValueAmount = #t2.ValueAmount
  , ValueAmountAdjusted = #t2.ValueAmountAdjusted
  , ObligationAmount = #t2.ObligationAmount 
FROM RePfbPledgeHistory rpph 
INNER JOIN #t2 ON #t2.Id = rpph.PledgeRegisterId 
INNER JOIN #t1 ON #t1.Id = #t2.Id 
WHERE #t1.PledgeRegisterId IS NOT NULL AND #t1.DateHistory = rpph.DateHistory

DROP TABLE #t1
DROP TABLE #t2

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-RePledgeRegisterAccount_CheckAccountId context:any labels:c-any,o-table,ot-schema,on-RePledgeRegisterAccount,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger RePledgeRegisterAccount_CheckAccountId on table RePledgeRegisterAccount
CREATE OR ALTER TRIGGER RePledgeRegisterAccount_CheckAccountId
   ON RePledgeRegisterAccount FOR INSERT, UPDATE AS
BEGIN
    SET NOCOUNT ON
    IF EXISTS (SELECT COUNT(*)
        FROM RePledgeRegisterAccount
        WHERE AccountId IN
            (Select AccountId FROM inserted INS)
        AND HdVersionNo < 999999999
        GROUP BY AccountId HAVING COUNT(*) > 1)
        BEGIN
            RAISERROR('AccountId must be unique', 16, 1)
            Rollback Transaction
        END
    SET NOCOUNT OFF
END
GO

--changeset system:baseline-create-alter-trigger-RePledgeRegisterAccount_HistoryIns context:any labels:c-any,o-table,ot-schema,on-RePledgeRegisterAccount,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger RePledgeRegisterAccount_HistoryIns on table RePledgeRegisterAccount
CREATE OR ALTER TRIGGER RePledgeRegisterAccount_HistoryIns
   ON RePledgeRegisterAccount FOR INSERT AS
SET NOCOUNT ON

SELECT rpr.Id , rph.PledgeRegisterId , MAX( ins.HdCreator ) AS HdCreator , CONVERT(CHAR(10) , GETDATE() , 112) AS DateHistory
      , MAX( ins.HdChangeUser ) AS HdChangeUser , SUM(CASE rpra.HdVersionNo WHEN 999999999 THEN 0 ELSE rpra.DebitAmount END) AS DebitAmount 
INTO #t1
   FROM inserted ins  
   INNER JOIN RePledgeRegister rpr ON rpr.Id =ins.PledgeRegisterId AND ins.PledgeRegisterId IS NOT NULL
   LEFT OUTER JOIN RePledgeHistory rph ON rpr.Id = rph.PledgeRegisterId AND rph.DateHistory = CONVERT(CHAR(10), GETDATE() , 112)
	INNER JOIN RePledgeRegisterAccount rpra ON rpr.Id = rpra.PledgeRegisterId    
GROUP BY rpr.Id , rph.PledgeRegisterId

SELECT * INTO #t2 
FROM (
SELECT rpr.Id , SUM( ropr.ObligAmountChargeable ) AS ObligationAmount 
   , rpr.HdVersionNo , rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB
   , rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
   FROM ReObligPremisesRelation ropr
   INNER JOIN ReObligation ro ON ropr.ObligationId = ro.Id AND ro.PfBFlag = 1
   INNER JOIN RePremises rp ON ropr.PremisesId = rp.Id AND rp.HdVersionNo BETWEEN 1 AND 999999998
   INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id AND rb.HdVersionNo BETWEEN 1 AND 999999998  
   INNER JOIN RePledgeRegister rpr ON rb.Id = rpr.ReBaseId AND rpr.ReBaseId IS NOT NULL
   INNER JOIN #t1 ON #t1.Id = rpr.Id
WHERE ( ropr.PremisesId = ropr.PremisesOrigId OR ropr.PremisesOrigId IS NULL ) AND ropr.HdVersionNo BETWEEN 1 AND 999999998 
   GROUP BY rpr.Id , rpr.HdVersionNo , rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB
   	, rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
      , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
UNION
SELECT rpr.Id , 0 AS ObligationAmount 
	, rpr.HdVersionNo , rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB
   , rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted 
FROM RePledgeRegister rpr 
	INNER JOIN #t1 ON #t1.Id = rpr.Id
WHERE rpr.HdVersionNo BETWEEN 1 AND 999999998 AND rpr.Id NOT IN ( 
		SELECT pr.Id  
		FROM ReObligPremisesRelation ropr 
			INNER JOIN RePremises rp ON ropr.PremisesId = rp.Id AND rp.HdVersionNo BETWEEN 1 AND 999999998 
			INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id AND rb.HdVersionNo BETWEEN 1 AND 999999998 
			INNER JOIN RePledgeRegister pr ON rb.Id = pr.ReBaseId AND pr.ReBaseId IS NOT NULL 
				AND pr.HdVersionNo BETWEEN 1 AND 999999998 
		WHERE ropr.HdVersionNo BETWEEN 1 AND 999999998  ) 
) AS ta1

INSERT INTO RePledgeHistory ( PledgeRegisterId, HdCreator , HdChangeUser , HdVersionNo , DateHistory 
      , BcNumber , PledgeRegisterNo , PledgeRegisterPartNo , PledgeTypeId , StatusNo  
      , StatusNoPfB , ValueDate , DebitAmount , PledgeAmount , PledgeAmountAdjusted  
      , ValueAmount , ValueAmountAdjusted , ObligationAmount 
	) SELECT #t1.id, #t1.HdCreator , #t1.HdChangeUser , #t2.HdVersionNo , #t1.DateHistory , #t2.BcNumber 
      , #t2.PledgeRegisterNo , #t2.PledgeRegisterPartNo , #t2.PledgeTypeId , #t2.StatusNo  
      , #t2.StatusNoPfB , #t2.ValueDate , #t1.DebitAmount , #t2.PledgeAmount , #t2.PledgeAmountAdjusted
		, #t2.ValueAmount , #t2.ValueAmountAdjusted , #t2.ObligationAmount 
		FROM  #t1  
      INNER JOIN #t2 ON #t2.Id = #t1.Id  
		WHERE #t1.PledgeRegisterId IS NULL

UPDATE RePledgeHistory 
SET DebitAmount = #t1.DebitAmount
     , HdChangeUser = #t1.HdChangeUser 
     , HdChangeDate = GETDATE()
FROM RePledgeHistory rph 
INNER JOIN #t1 ON #t1.Id = rph.PledgeRegisterId AND #t1.DateHistory = rph.DateHistory
WHERE #t1.PledgeRegisterId IS NOT NULL

DROP TABLE #t1
DROP TABLE #t2

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-RePledgeRegisterAccount_HistoryUpd context:any labels:c-any,o-table,ot-schema,on-RePledgeRegisterAccount,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger RePledgeRegisterAccount_HistoryUpd on table RePledgeRegisterAccount
CREATE OR ALTER TRIGGER RePledgeRegisterAccount_HistoryUpd
   ON RePledgeRegisterAccount FOR UPDATE AS
SET NOCOUNT ON

SELECT rpr.Id , rph.PledgeRegisterId , MAX( ins.HdCreator ) AS HdCreator , CONVERT(CHAR(10) , GETDATE() , 112) AS DateHistory
      , MAX( ins.HdChangeUser ) AS HdChangeUser , SUM(CASE rpra.HdVersionNo WHEN 999999999 THEN 0 ELSE rpra.DebitAmount END) AS DebitAmount 
INTO #t1
   FROM inserted ins 
   INNER JOIN deleted del ON del.Id = ins.Id AND ( del.DebitAmount <> ins.DebitAmount  OR ins.HdVersionNo = 999999999 OR del.HdVersionNo = 999999999 )
	INNER JOIN RePledgeRegisterAccount rpra ON rpra.Id = del.Id    
	INNER JOIN RePledgeRegister rpr ON rpr.Id = rpra.PledgeRegisterId 
   LEFT OUTER JOIN RePledgeHistory rph ON rpr.Id = rph.PledgeRegisterId AND rph.DateHistory = CONVERT(CHAR(10), GETDATE() , 112)
   GROUP BY rpr.Id , rph.PledgeRegisterId

SELECT * INTO #t2 
FROM (
SELECT rpr.Id , SUM( ropr.ObligAmountChargeable ) AS ObligationAmount 
   , rpr.HdVersionNo , rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB
   , rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
   FROM ReObligPremisesRelation ropr
   INNER JOIN ReObligation ro ON ropr.ObligationId = ro.Id AND ro.PfBFlag = 1
   INNER JOIN RePremises rp ON ropr.PremisesId = rp.Id AND rp.HdVersionNo BETWEEN 1 AND 999999998
   INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id AND rb.HdVersionNo BETWEEN 1 AND 999999998  
   INNER JOIN RePledgeRegister rpr ON rb.Id = rpr.ReBaseId AND rpr.ReBaseId IS NOT NULL
   INNER JOIN #t1 ON #t1.Id = rpr.Id
WHERE ( ropr.PremisesId = ropr.PremisesOrigId OR ropr.PremisesOrigId IS NULL ) AND ropr.HdVersionNo BETWEEN 1 AND 999999998 
   GROUP BY rpr.Id , rpr.HdVersionNo , rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB
   	, rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
      , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
UNION
SELECT rpr.Id , 0 AS ObligationAmount 
   , rpr.HdVersionNo , rpr.ValueDate , rpr.BCNumber , rpr.StatusNo , rpr.StatusNoPfB
   , rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted 
FROM RePledgeRegister rpr 
	INNER JOIN #t1 ON #t1.Id = rpr.Id
WHERE rpr.HdVersionNo BETWEEN 1 AND 999999998 AND rpr.Id NOT IN ( 
   SELECT pr.Id  FROM ReObligPremisesRelation ropr 
INNER JOIN RePremises rp ON ropr.PremisesId = rp.Id AND rp.HdVersionNo BETWEEN 1 AND 999999998 
INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id AND rb.HdVersionNo BETWEEN 1 AND 999999998 
INNER JOIN RePledgeRegister pr ON rb.Id = pr.ReBaseId AND pr.ReBaseId IS NOT NULL 
	AND pr.HdVersionNo BETWEEN 1 AND 999999998 
WHERE ropr.HdVersionNo BETWEEN 1 AND 999999998  ) ) AS ta1

INSERT INTO RePledgeHistory ( PledgeRegisterId, HdCreator , HdChangeUser , HdVersionNo , DateHistory 
  , BcNumber , PledgeRegisterNo , PledgeRegisterPartNo , PledgeTypeId , StatusNo  
  , rpr.StatusNoPfB , ValueDate , DebitAmount , PledgeAmount , PledgeAmountAdjusted  
  , ValueAmount , ValueAmountAdjusted , ObligationAmount 
	) SELECT #t1.id, #t1.HdCreator , #t1.HdChangeUser , #t2.HdVersionNo , #t1.DateHistory 
  , #t2.BcNumber , #t2.PledgeRegisterNo , #t2.PledgeRegisterPartNo , #t2.PledgeTypeId , #t2.StatusNo   
  , #t2.StatusNoPfB , #t2.ValueDate , #t1.DebitAmount , #t2.PledgeAmount , #t2.PledgeAmountAdjusted
  , #t2.ValueAmount , #t2.ValueAmountAdjusted , #t2.ObligationAmount 
FROM  #t1 INNER JOIN #t2 ON #t2.Id = #t1.Id  
WHERE #t1.PledgeRegisterId IS NULL

UPDATE RePledgeHistory 
SET DebitAmount = #t1.DebitAmount
  , HdChangeUser = #t1.HdChangeUser 
  , HdChangeDate = GETDATE()
FROM RePledgeHistory rpph INNER JOIN #t1 ON #t1.Id = rpph.PledgeRegisterId AND #t1.DateHistory = rpph.DateHistory
WHERE #t1.PledgeRegisterId IS NOT NULL

DROP TABLE #t1
DROP TABLE #t2

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-RePledgeRegisterAccount_PfBHistoryIns context:any labels:c-any,o-table,ot-schema,on-RePledgeRegisterAccount,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger RePledgeRegisterAccount_PfBHistoryIns on table RePledgeRegisterAccount
CREATE OR ALTER TRIGGER RePledgeRegisterAccount_PfBHistoryIns
   ON RePledgeRegisterAccount FOR INSERT AS

SET NOCOUNT ON

SELECT rpr.Id , rpph.PledgeRegisterId , MAX( ins.HdCreator ) AS HdCreator , CONVERT(CHAR(10) , GETDATE() , 112) AS DateHistory
      , MAX( ins.HdChangeUser ) AS HdChangeUser , SUM(CASE rpra.HdVersionNo WHEN 999999999 THEN 0 ELSE rpra.DebitAmount END) AS DebitAmount 
INTO #t1
   FROM inserted ins 
   INNER JOIN RePledgeRegister rpr ON rpr.Id = ins.PledgeRegisterId 
   LEFT OUTER JOIN RePfbPledgeHistory rpph ON rpr.Id = rpph.PledgeRegisterId AND rpph.DateHistory = CONVERT(CHAR(10), GETDATE() , 112)
   INNER JOIN RePledgeRegisterAccount rpra ON rpr.Id = rpra.PledgeRegisterId 
   GROUP BY rpr.Id , rpph.PledgeRegisterId


SELECT rpr.Id , SUM( ropr.ObligAmountChargeable ) AS ObligationAmount 
   , rpr.HdVersionNo , rpr.ValueDate , rpr.PfBNo , rpr.BCNumber , rpr.StatusNo
	, rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
INTO #t2
   FROM ReObligPremisesRelation ropr
   INNER JOIN ReObligation ro ON ropr.ObligationId = ro.Id AND ro.PFBFlag = 1
   INNER JOIN RePremises rp ON ropr.PremisesId = rp.Id
   INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id
   INNER JOIN RePledgeRegister rpr ON rb.Id = rpr.ReBaseId AND rpr.ReBaseId IS NOT NULL
   INNER JOIN #t1 ON #t1.Id = rpr.Id 
WHERE ropr.PremisesId = ropr.PremisesOrigId 
      AND ropr.HdVersionNo BETWEEN 1 AND 999999998 AND rp.HdVersionNo BETWEEN 1 AND 999999998
      AND rb.HdVersionNo BETWEEN 1 AND 999999998 AND rpr.HdVersionNo BETWEEN 1 AND 999999998
   GROUP BY rpr.Id , rpr.HdVersionNo , rpr.ValueDate , rpr.PfBNo , rpr.BCNumber , rpr.StatusNo
   	, rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
      , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted


INSERT INTO RePfbPledgeHistory ( PledgeRegisterId, HdCreator , HdChangeUser , HdVersionNo , DateHistory 
      , BcNumber , PfBNo, PledgeRegisterNo , PledgeRegisterPartNo , PledgeTypeId  
      , StatusNo , ValueDate , DebitAmount , PledgeAmount , PledgeAmountAdjusted  
      , ValueAmount , ValueAmountAdjusted , ObligationAmount 
	) SELECT #t1.id, #t1.HdCreator , #t1.HdChangeUser , #t2.HdVersionNo , #t1.DateHistory 
      , #t2.BcNumber , #t2.PfBNo, #t2.PledgeRegisterNo , #t2.PledgeRegisterPartNo , #t2.PledgeTypeId  
      , #t2.StatusNo , #t2.ValueDate , #t1.DebitAmount , #t2.PledgeAmount , #t2.PledgeAmountAdjusted
		, #t2.ValueAmount , #t2.ValueAmountAdjusted , #t2.ObligationAmount 
		FROM  #t1  
      INNER JOIN #t2 ON #t2.Id = #t1.Id  
		WHERE #t1.PledgeRegisterId IS NULL


UPDATE RePfbPledgeHistory 
SET DebitAmount = #t1.DebitAmount
     , HdChangeUser = #t1.HdChangeUser 
     , HdChangeDate = GETDATE()
FROM RePfbPledgeHistory rpph 
INNER JOIN #t1 ON #t1.Id = rpph.PledgeRegisterId AND #t1.DateHistory = rpph.DateHistory
WHERE #t1.PledgeRegisterId IS NOT NULL

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-RePledgeRegisterAccount_PfBHistoryUpd context:any labels:c-any,o-table,ot-schema,on-RePledgeRegisterAccount,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger RePledgeRegisterAccount_PfBHistoryUpd on table RePledgeRegisterAccount
CREATE OR ALTER TRIGGER RePledgeRegisterAccount_PfBHistoryUpd
   ON RePledgeRegisterAccount FOR UPDATE AS

SET NOCOUNT ON

SELECT rpr.Id , rpph.PledgeRegisterId , MAX( ins.HdCreator ) AS HdCreator , CONVERT(CHAR(10) , GETDATE() , 112) AS DateHistory
      , MAX( ins.HdChangeUser ) AS HdChangeUser , SUM(CASE rpra.HdVersionNo WHEN 999999999 THEN 0 ELSE rpra.DebitAmount END) AS DebitAmount 
INTO #t1
   FROM inserted ins 
   INNER JOIN deleted del ON del.Id = ins.Id AND ( del.DebitAmount <> ins.DebitAmount  OR ins.HdVersionNo = 999999999 OR del.HdVersionNo = 999999999 )
   INNER JOIN RePledgeRegister rpr ON rpr.Id = del.PledgeRegisterId 
   LEFT OUTER JOIN RePfbPledgeHistory rpph ON rpr.Id = rpph.PledgeRegisterId AND rpph.DateHistory = CONVERT(CHAR(10), GETDATE() , 112)
   INNER JOIN RePledgeRegisterAccount rpra ON rpr.Id = rpra.PledgeRegisterId 
   GROUP BY rpr.Id , rpph.PledgeRegisterId


SELECT rpr.Id , SUM( ropr.ObligAmountChargeable ) AS ObligationAmount 
   , rpr.HdVersionNo , rpr.ValueDate , rpr.PfBNo , rpr.BCNumber , rpr.StatusNo
	, rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
   , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted
INTO #t2
   FROM ReObligPremisesRelation ropr
   INNER JOIN ReObligation ro ON ropr.ObligationId = ro.Id AND ro.PFBFlag = 1
   INNER JOIN RePremises rp ON ropr.PremisesId = rp.Id
   INNER JOIN ReBase rb ON rp.ReBaseId = rb.Id
   INNER JOIN RePledgeRegister rpr ON rb.Id = rpr.ReBaseId AND rpr.ReBaseId IS NOT NULL
   INNER JOIN #t1 ON #t1.Id = rpr.Id 
WHERE ropr.PremisesId = ropr.PremisesOrigId 
      AND ropr.HdVersionNo BETWEEN 1 AND 999999998 AND rp.HdVersionNo BETWEEN 1 AND 999999998
      AND rb.HdVersionNo BETWEEN 1 AND 999999998 AND rpr.HdVersionNo BETWEEN 1 AND 999999998
   GROUP BY rpr.Id , rpr.HdVersionNo , rpr.ValueDate , rpr.PfBNo , rpr.BCNumber , rpr.StatusNo
   	, rpr.PledgeRegisterNo , rpr.PledgeRegisterPartNo , rpr.PledgeTypeId 
      , rpr.PledgeAmount , rpr.PledgeAmountAdjusted , rpr.ValueAmount , rpr.ValueAmountAdjusted


INSERT INTO RePfbPledgeHistory ( PledgeRegisterId, HdCreator , HdChangeUser , HdVersionNo , DateHistory 
      , BcNumber , PfBNo, PledgeRegisterNo , PledgeRegisterPartNo , PledgeTypeId  
      , StatusNo , ValueDate , DebitAmount , PledgeAmount , PledgeAmountAdjusted  
      , ValueAmount , ValueAmountAdjusted , ObligationAmount 
	) SELECT #t1.id, #t1.HdCreator , #t1.HdChangeUser , #t2.HdVersionNo , #t1.DateHistory 
      , #t2.BcNumber , #t2.PfBNo, #t2.PledgeRegisterNo , #t2.PledgeRegisterPartNo , #t2.PledgeTypeId  
      , #t2.StatusNo , #t2.ValueDate , #t1.DebitAmount , #t2.PledgeAmount , #t2.PledgeAmountAdjusted
		, #t2.ValueAmount , #t2.ValueAmountAdjusted , #t2.ObligationAmount 
		FROM  #t1  
      INNER JOIN #t2 ON #t2.Id = #t1.Id  
		WHERE #t1.PledgeRegisterId IS NULL


UPDATE RePfbPledgeHistory 
SET DebitAmount = #t1.DebitAmount
     , HdChangeUser = #t1.HdChangeUser 
     , HdChangeDate = GETDATE()
FROM RePfbPledgeHistory rpph 
INNER JOIN #t1 ON #t1.Id = rpph.PledgeRegisterId AND #t1.DateHistory = rpph.DateHistory
WHERE #t1.PledgeRegisterId IS NOT NULL

SET NOCOUNT OFF
GO

--changeset system:baseline-create-alter-trigger-RePremisesRelRightToBuild_SetForBuildRight context:any labels:c-any,o-table,ot-schema,on-RePremisesRelRightToBuild,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger RePremisesRelRightToBuild_SetForBuildRight on table RePremisesRelRightToBuild
CREATE OR ALTER TRIGGER RePremisesRelRightToBuild_SetForBuildRight
   ON RePremisesRelRightToBuild FOR INSERT, UPDATE, DELETE AS
BEGIN
   SET NOCOUNT ON
   BEGIN
      IF (SELECT COUNT(*) FROM deleted WHERE deleted.HdCreateDate IS NOT NULL) > 0
      BEGIN
         UPDATE RePremises SET    ForBuildRight = 0
         FROM   RePremises R JOIN deleted ON ((R.Id = deleted.PremisesId) AND (deleted.PremisesIdReceivingRight = 1)) WHERE  R.HdVersionNo < 999999999
         UPDATE RePremises SET    ForBuildRight = 0
         FROM   RePremises R JOIN deleted ON ((R.Id = deleted.PremisesRelationId) AND (deleted.PremisesIdReceivingRight = 0)) WHERE  R.HdVersionNo < 999999999
         UPDATE RePremises SET    ForBuildRight = 1
         FROM   RePremises R JOIN deleted ON ((R.Id = deleted.PremisesId) AND (deleted.PremisesIdReceivingRight = 1)) WHERE  R.HdVersionNo < 999999999
         AND  ((0 < (SELECT count(*) FROM   RePremisesRelRightToBuild RR1
                     WHERE  RR1.HdVersionNo < 999999999
                     AND    RR1.PremisesId = R.Id AND    RR1.PremisesIdReceivingRight = 1))
         OR    (0 < (SELECT count(*) FROM   RePremisesRelRightToBuild RR2
                     WHERE  RR2.HdVersionNo < 999999999
                     AND    RR2.PremisesRelationId = R.Id AND    RR2.PremisesIdReceivingRight = 0)))
         UPDATE RePremises SET    ForBuildRight = 1
         FROM   RePremises R JOIN deleted ON ((R.Id = deleted.PremisesRelationId) AND (deleted.PremisesIdReceivingRight = 0))
         WHERE  R.HdVersionNo < 999999999
         AND  ((0 < (SELECT count(*) FROM   RePremisesRelRightToBuild RR1
                     WHERE  RR1.HdVersionNo < 999999999
                     AND    RR1.PremisesId = R.Id AND    RR1.PremisesIdReceivingRight = 1))
         OR    (0 < (SELECT count(*) FROM   RePremisesRelRightToBuild RR2
                     WHERE  RR2.HdVersionNo < 999999999
                     AND    RR2.PremisesRelationId = R.Id AND    RR2.PremisesIdReceivingRight = 0)))
      END
      IF (SELECT COUNT(*) FROM inserted WHERE inserted.HdCreateDate IS NOT NULL) > 0
      BEGIN
         UPDATE RePremises SET    ForBuildRight = 0
         FROM   RePremises R JOIN inserted ON ((R.Id = inserted.PremisesId) AND (inserted.PremisesIdReceivingRight = 1)) WHERE  R.HdVersionNo < 999999999
         UPDATE RePremises SET    ForBuildRight = 0
         FROM   RePremises R JOIN inserted ON ((R.Id = inserted.PremisesRelationId) AND (inserted.PremisesIdReceivingRight = 0)) WHERE  R.HdVersionNo < 999999999
         UPDATE RePremises SET    ForBuildRight = 1
         FROM   RePremises R JOIN inserted ON ((R.Id = inserted.PremisesId) AND (inserted.PremisesIdReceivingRight = 1)) WHERE  R.HdVersionNo < 999999999
         AND  ((0 < (SELECT count(*) FROM   RePremisesRelRightToBuild RR1
                     WHERE  RR1.HdVersionNo < 999999999
                     AND    RR1.PremisesId = R.Id AND    RR1.PremisesIdReceivingRight = 1))
         OR    (0 < (SELECT count(*) FROM   RePremisesRelRightToBuild RR2
                     WHERE  RR2.HdVersionNo < 999999999
                     AND    RR2.PremisesRelationId = R.Id AND    RR2.PremisesIdReceivingRight = 0)))
         UPDATE RePremises SET    ForBuildRight = 1
         FROM   RePremises R JOIN inserted ON ((R.Id = inserted.PremisesRelationId) AND (inserted.PremisesIdReceivingRight = 0)) WHERE  R.HdVersionNo < 999999999
         AND  ((0 < (SELECT count(*) FROM   RePremisesRelRightToBuild RR1
                     WHERE  RR1.HdVersionNo < 999999999
                     AND    RR1.PremisesId = R.Id AND    RR1.PremisesIdReceivingRight = 1))
         OR    (0 < (SELECT count(*) FROM   RePremisesRelRightToBuild RR2
                     WHERE  RR2.HdVersionNo < 999999999
                     AND    RR2.PremisesRelationId = R.Id AND    RR2.PremisesIdReceivingRight = 0)))
      END
   END
END
GO

--changeset system:baseline-create-alter-trigger-WfNotification_DeleteDetail context:any labels:c-any,o-table,ot-schema,on-WfNotification,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger WfNotification_DeleteDetail on table WfNotification
CREATE OR ALTER TRIGGER WfNotification_DeleteDetail
   ON WfNotification FOR DELETE AS
BEGIN
   SET NOCOUNT ON
      DELETE WfNotificationDetail
      FROM deleted, WfNotificationDetail
      WHERE deleted.NotificationTypeNo = 1 
         AND deleted.NotificationId = WfNotificationDetail.NotificationId
         AND NOT EXISTS ( SELECT * FROM WfNotification
	  WHERE WfNotification.NotificationId = deleted.NotificationId )

      DELETE WfMessage
      FROM deleted, WfMessage
      WHERE deleted.NotificationTypeNo = 2
         AND deleted.MessageId = WfMessage.Id
         AND NOT EXISTS ( SELECT * FROM WfNotification
                  WHERE WfNotification.MessageId = deleted.MessageId )
END
GO

--changeset system:baseline-create-alter-trigger-WfProcess_MakeDeleteLog context:any labels:c-any,o-table,ot-schema,on-WfProcess,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger WfProcess_MakeDeleteLog on table WfProcess
CREATE OR ALTER TRIGGER WfProcess_MakeDeleteLog
   ON WfProcess FOR DELETE AS
BEGIN
   SET NOCOUNT ON
   INSERT INTO WfProcessLog
      (ID,
      HdVersionNo,
      ProcessId,
      MapNo,
      Status,
      VariableInstanceSet,
      DynamicDescription,
      InstantiationType,
      Agent,
      Instantiator,
      CreationDate,
      FinishDate)
   SELECT 
      NewId(),
      1,
      deleted.Id,
      deleted.MapNo,
      CASE deleted.Status
         WHEN 1 THEN 2
         ELSE deleted.Status
      END,
      deleted.VariableInstanceSet,
      deleted.DynamicDescription,
      deleted.InstanciationType,
      deleted.Agent,
      deleted.Instanciator,
      deleted.CreationDate,
      deleted.FinishDate
   FROM deleted
END
GO

--changeset system:baseline-create-alter-trigger-WfProcessProgress_MakeDeleteLog context:any labels:c-any,o-table,ot-schema,on-WfProcessProgress,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger WfProcessProgress_MakeDeleteLog on table WfProcessProgress
CREATE OR ALTER TRIGGER WfProcessProgress_MakeDeleteLog
   ON WfProcessProgress FOR DELETE AS
BEGIN
   SET NOCOUNT ON
   INSERT INTO WfProcessProgressLog
      (ID,
      HdVersionNo,
      HdChangeDate,
      ProcessId,
      MapNo,
      StepNo,
      StepType,
      Status,
      StartDate,
      FinishDate,
      Timeout,
      DynamicItems,
      Agent)
   SELECT 
      NewId(),
      1,
      GETDATE(),
      deleted.ProcessId,
      deleted.MapNo,
      deleted.StepNo,
      deleted.StepType,
      deleted.Status,
      deleted.StartDate,
      deleted.FinishDate,
      deleted.Timeout,
      deleted.DynamicItems,
      deleted.Agent
   FROM deleted
END
GO

--changeset system:baseline-create-alter-trigger-WfProcessProgress_MakeUpdateLog context:any labels:c-any,o-table,ot-schema,on-WfProcessProgress,fin-13659 splitStatements:false endDelimiter:GO
--comment: Initialize baseline trigger WfProcessProgress_MakeUpdateLog on table WfProcessProgress
CREATE OR ALTER TRIGGER WfProcessProgress_MakeUpdateLog
   ON WfProcessProgress FOR UPDATE AS
BEGIN
   SET NOCOUNT ON
   INSERT INTO WfProcessProgressLog
      (ID,
      HdVersionNo,
      HdChangeDate,
      ProcessId,
      MapNo,
      StepNo,
      StepType,
      Status,
      StartDate,
      FinishDate,
      Timeout,
      DynamicItems,
      Agent)
   SELECT 
      NewId(),
      1,
      GETDATE(),
      deleted.ProcessId,
      deleted.MapNo,
      deleted.StepNo,
      deleted.StepType,
      deleted.Status,
      deleted.StartDate,
      deleted.FinishDate,
      deleted.Timeout,
      deleted.DynamicItems,
      deleted.Agent
   FROM deleted JOIN inserted ON  deleted.ID = inserted.ID
   WHERE deleted.Status <> inserted.Status
END
GO

