--liquibase formatted sql

--changeset system:create-alter-procedure-UpdatePaybackPaymentPerYear context:any labels:c-any,o-stored-procedure,ot-schema,on-UpdatePaybackPaymentPerYear,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure UpdatePaybackPaymentPerYear
CREATE OR ALTER PROCEDURE dbo.UpdatePaybackPaymentPerYear
@PaybackId  uniqueidentifier,	
@Year integer	

As	
	
update  PtAccountPayback Set YearToDateAmount 
= (select sum(PPL.PaybackYearToDateAmount) from PtAccountPaybackAccountList PtAcc
   INNER JOIN PtAccountPaybackAccountPayList PPL on PtAcc.HdVersionNo < 999999999 and PtAcc.PaybackId = @PaybackId and PtAcc.Id = PPL.PaybackAccountId
   and PPL.Year = @Year)
where Id = @PaybackId
