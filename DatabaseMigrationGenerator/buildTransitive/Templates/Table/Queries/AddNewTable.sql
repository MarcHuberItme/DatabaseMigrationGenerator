--liquibase formatted sql

--changeset mhy:20251208-1022-AcAmountType context:any labels:c-any,o-table,ot-schema,on-AcAmountType,fin-00000
--comment: Template for a new table

CREATE TABLE dbo.AcAmountType (
    Id                  UNIQUEIDENTIFIER CONSTRAINT DF_AcAmountType_Id DEFAULT (NEWSEQUENTIALID()) ROWGUIDCOL NOT NULL,
    HdCreateDate        DATETIME CONSTRAINT DF_AcAmountType_HdCreateDate DEFAULT (GETDATE()) NOT NULL,
    HdCreator           VARCHAR(20) NULL,
    HdChangeDate        DATETIME CONSTRAINT DF_AcAmountType_HdChangeDate DEFAULT (GETDATE()) NOT NULL,
    HdChangeUser        VARCHAR(20) NULL,
    HdEditStamp         UNIQUEIDENTIFIER CONSTRAINT DF_AcAmountType_HdEditStamp DEFAULT (NEWSEQUENTIALID()) NOT NULL,
    HdVersionNo         INT CONSTRAINT DF_AcAmountType_HdVersionNo DEFAULT ((0)) NOT NULL,
    HdProcessId         UNIQUEIDENTIFIER NULL,
    HdStatusFlag        VARCHAR(20) NULL,
    HdNoUpdateFlag      VARCHAR(20) NULL,
    HdPendingChanges    TINYINT CONSTRAINT DF_AcAmountType_HdPendingChanges DEFAULT ((0)) NOT NULL,
    HdPendingSubChanges SMALLINT CONSTRAINT DF_AcAmountType_HdPendingSubChanges DEFAULT ((0)) NOT NULL,
    HdTriggerControl    TINYINT NULL,
    AmountType          SMALLINT NOT NULL,
    CONSTRAINT PK_AcAmountType PRIMARY KEY CLUSTERED (Id) ON [FsData_A],
    CONSTRAINT IU_AcAmountType_AmountType UNIQUE NONCLUSTERED (AmountType) ON [FsIndex]
);