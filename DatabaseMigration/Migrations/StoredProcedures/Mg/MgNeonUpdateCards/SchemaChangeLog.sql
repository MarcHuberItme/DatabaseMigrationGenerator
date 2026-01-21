--liquibase formatted sql

--changeset system:create-alter-procedure-MgNeonUpdateCards context:any labels:c-any,o-stored-procedure,ot-schema,on-MgNeonUpdateCards,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure MgNeonUpdateCards
CREATE OR ALTER PROCEDURE dbo.MgNeonUpdateCards
@Test bit = 1
as

declare @totalRecordCount int

begin tran

update
	c
set
	c.CardStatus = 6,
	c.TransactionType = 0
from
	PtAgrCardBase b inner join
	PtAgrCard c on c.CardId = b.Id
where 1=1
	and b.CardType > 200
	and c.CardStatus = 0
	and c.TransactionType = 12

set @totalRecordCount = @@ROWCOUNT

--todo output results
print 'Total records updated: ' + cast(@totalRecordCount as varchar)

if @Test = 1
begin
	rollback tran
end
else
begin
	commit tran
end

