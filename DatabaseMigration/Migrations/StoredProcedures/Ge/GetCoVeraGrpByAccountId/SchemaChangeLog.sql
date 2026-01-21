--liquibase formatted sql

--changeset system:create-alter-procedure-GetCoVeraGrpByAccountId context:any labels:c-any,o-stored-procedure,ot-schema,on-GetCoVeraGrpByAccountId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetCoVeraGrpByAccountId
CREATE OR ALTER PROCEDURE dbo.GetCoVeraGrpByAccountId
@ValidTo datetime,
@ValidFrom datetime,

@VeraStat tinyint,
@ColWorkingType tinyint,
@AccountId uniqueidentifier

As

Select G.Veragrp, G.Veradate, G.ReportDate, IsNull(ReportDate, G.Veradate) As QueryDate
From CoVeraDet D Join CoVeraGrp G On D.Veragrp=G.Veragrp
Where D.WhereDoWeCameFrom = 0 And G.VeraStat = @VeraStat
And D.AccountId = @AccountId And D.ColWorkingType = @ColWorkingType
And IsNull(ReportDate, G.Veradate) < = @ValidTo And IsNull(ReportDate, G.Veradate) >= @ValidFrom
