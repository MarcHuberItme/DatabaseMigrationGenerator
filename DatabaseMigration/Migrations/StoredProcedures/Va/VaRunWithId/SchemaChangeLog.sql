--liquibase formatted sql

--changeset system:create-alter-procedure-VaRunWithId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaRunWithId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaRunWithId
CREATE OR ALTER PROCEDURE dbo.VaRunWithId
--StoreProcedute: VaRunWithId

@RunId uniqueidentifier
AS

Select * from VaRun Where Id = @RunId

