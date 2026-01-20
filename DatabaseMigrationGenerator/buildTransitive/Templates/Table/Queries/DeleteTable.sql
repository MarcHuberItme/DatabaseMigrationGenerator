--liquibase formatted sql
 
--changeset mhy:20251208-1500-DropAcAmountType context:any labels:c-any,o-table,ot-schema,on-AcAmountType,fin-00000 splitStatements:false
--comment: Template for drop table
 
IF OBJECT_ID('dbo.AcBalanceSource', 'U') IS NOT NULL
    BEGIN
        ALTER TABLE dbo.AcBalanceSource
            DROP CONSTRAINT IF EXISTS FK_AcBalanceSource_AcAmountType_AmountType;
    END;
 
IF OBJECT_ID('dbo.AcBalanceSourceArchive', 'U') IS NOT NULL
    BEGIN
        ALTER TABLE dbo.AcBalanceSourceArchive
            DROP CONSTRAINT IF EXISTS FK_AcBalanceSourceArchive_AcAmountType_AmountType;
    END;
     
DROP TABLE IF EXISTS dbo.AcAmountType;
 
DELETE
FROM MdField
WHERE TableName = 'AcAmountType';
 
DELETE
FROM MdTableDataDef
WHERE TableName = 'AcAmountType';
 
DROP PROCEDURE IF EXISTS dbo.AcAmountType_GetDetail;
 
DROP PROCEDURE IF EXISTS dbo.AcAmountType_GetList;