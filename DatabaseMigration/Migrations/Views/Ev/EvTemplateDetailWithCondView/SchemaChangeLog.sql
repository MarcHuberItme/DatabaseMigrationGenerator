--liquibase formatted sql

--changeset system:create-alter-view-EvTemplateDetailWithCondView context:any labels:c-any,o-view,ot-schema,on-EvTemplateDetailWithCondView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view EvTemplateDetailWithCondView
CREATE OR ALTER VIEW dbo.EvTemplateDetailWithCondView AS
SELECT		ETD.*,
		EQM_D.QuantityFieldCondNo		AS  DebitQuantFieldCondNo,
		EQM_C.QuantityFieldCondNo		AS CreditQuantFieldCondNo,
		EAM_D.AmountFieldCondNo		AS  DebitAmountFieldCondNo,
		EAM_C.AmountFieldCondNo		AS CreditAmountFieldCondNo,
		EAM_D.PercentageValFieldCondNo	AS  DebitPercValFieldCondNo,
		EAM_C.PercentageValFieldCondNo	AS CreditPercValFieldCondNo 
FROM		EvTemplateDetail ETD 
LEFT OUTER JOIN	EvQuantMeth EQM_D ON ETD.DebitQuantityMethNo = EQM_D.QuantMethNo 
LEFT OUTER JOIN EvQuantMeth EQM_C ON ETD.CreditQuantityMethNo = EQM_C.QuantMethNo 
LEFT OUTER JOIN EvAmountMeth EAM_D ON ETD.DebitAmountMethNo = EAM_D.AmountMethNo 
LEFT OUTER JOIN EvAmountMeth EAM_C ON ETD.CreditAmountMethNo = EAM_C.AmountMethNo 

