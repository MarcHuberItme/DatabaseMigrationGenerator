--liquibase formatted sql

--changeset system:create-alter-procedure-DeleteFrozenData context:any labels:c-any,o-stored-procedure,ot-schema,on-DeleteFrozenData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DeleteFrozenData
CREATE OR ALTER PROCEDURE dbo.DeleteFrozenData

@ReportDate datetime

AS
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AcFrozenPartner_DeleteCascade]'))
DROP TRIGGER [dbo].[AcFrozenPartner_DeleteCascade]
  
IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AcFrozenAccount_DeleteCascade]'))
DROP TRIGGER [dbo].[AcFrozenAccount_DeleteCascade]

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AcFrozenAccountCompAlm_DeleteCascade]'))
DROP TRIGGER [dbo].[AcFrozenAccountCompAlm_DeleteCascade]

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AcFrozenAccountComponent_DeleteCascade]'))
DROP TRIGGER [dbo].[AcFrozenAccountComponent_DeleteCascade]

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AcFrozenSecurityBalance_DeleteCascade]'))
DROP TRIGGER [dbo].[AcFrozenSecurityBalance_DeleteCascade]

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AcFaCompCalculation_DeleteCascade]'))
DROP TRIGGER [dbo].[AcFaCompCalculation_DeleteCascade]

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AcFrozenTransItemSupplement_DeleteCascade]'))
DROP TRIGGER [dbo].[AcFrozenTransItemSupplement_DeleteCascade]

IF  EXISTS (SELECT * FROM sys.triggers WHERE object_id = OBJECT_ID(N'[dbo].[AcFrozenCollateral_DeleteCascade]'))
DROP TRIGGER [dbo].[AcFrozenCollateral_DeleteCascade]


DELETE FROM AcFrozenPartner WHERE ReportDate = @ReportDate
DELETE FROM AcFrozenAccount WHERE ReportDate = @ReportDate
DELETE FROM AcFrozenAccountCompAlm WHERE ReportDate = @ReportDate
DELETE FROM AcFrozenAccountComponent WHERE ReportDate = @ReportDate
DELETE FROM AcFrozenSecurityBalance WHERE ReportDate = @ReportDate
DELETE FROM AcFaCompCalculation WHERE ReportDate = @ReportDate
DELETE FROM AcFrozenTransItemSupplement WHERE ReportDate = @ReportDate
DELETE FROM AcFrozenCollateral WHERE ReportDate = @ReportDate

