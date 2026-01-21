--liquibase formatted sql

--changeset system:create-alter-view-AcMainLedger context:any labels:c-any,o-view,ot-schema,on-AcMainLedger,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcMainLedger
CREATE OR ALTER VIEW dbo.AcMainLedger AS
SELECT     PtAccountBase.AccountNo, PtAccountBase.AccountNoText, PtAccountBase.AccountNoEdited, PtAccountBase.AccountNoIbanForm, 
           PtAccountBase.CustomerReference, PtAccountBase.OpeningDate, PtAccountBase.MotiveToOpenNo
FROM       PtAccountBase INNER JOIN
           PrReference ON PtAccountBase.Id = PrReference.AccountId INNER JOIN
           PrPrivate ON PrReference.ProductId = PrPrivate.ProductId INNER JOIN PrOperationType ON 
           PrPrivate.OperationTypeId = PrOperationType.Id
WHERE     (PrOperationType.TypeNo = 20)
