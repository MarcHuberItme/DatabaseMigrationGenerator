--liquibase formatted sql

--changeset system:create-alter-procedure-VaPortfolioWithRunId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaPortfolioWithRunId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaPortfolioWithRunId
CREATE OR ALTER PROCEDURE dbo.VaPortfolioWithRunId
--Store Procedure: VaPortfolioWithRunId
@RunId uniqueidentifier AS

--Test:
/*
Declare @RunId AS uniqueidentifier
Set @RunId = '{2B51F3AA-4A52-476A-AE73-6AE5A86A5AFA}'
*/
--Variablen:
Declare @PartnerId AS uniqueidentifier
Declare @PortfolioId AS uniqueidentifier
Declare @ValuationDate AS Datetime

Set @PartnerId = (Select PartnerId From VaRun Where Id = @RunId)
Set @PortfolioId = (Select PortfolioId From VaRun Where Id = @RunId)
Set @ValuationDate = (Select ValuationDate From VaRun Where ID = @RunId)

--1. Lösche überflüssige Portfolios zum bereinigen von bestehenden Läufen
Print 'Delete VaPortfolio'
Delete VaPortfolio
From VaPortfolio POR
Inner Join PtPortfolio PP on  POR.PortfolioId = PP.Id
Inner Join VaRun R on R.Id = POR.ValRunId
Where R.ID = @RunId
AND (PP.TerminationDate < R.ValuationDate
OR PP.OpeningDate > R.ValuationDate)

--2. Einfügen aller gemäss VaRun benötigter Portfolios
If @PortfolioId is null
	If  @PartnerId Is Null
		Begin
			Print 'Insert into VaPortfolio ALL'
			Insert into VaPortfolio
			(PortfolioId, ValuationCurrency, ValRunId)	
			Select P.Id, P.Currency ,@RunId
			from ptPortfolio P
			Where convert(datetime,P.OpeningDate,112) <=  @ValuationDate + ' 23:59:59:999'
			AND (P.TerminationDate is NULL OR P.TerminationDate >=  @ValuationDate)
			AND P.ID Not in (Select PortfolioId From VaPortfolio Where ValRunID = @RunId)
			--AND P.PortfolioTypeNo not in (5050,5051)
		End
	Else
		Begin
			Print 'Insert into VaPortfolio Partner'
			Insert into VaPortfolio
			(PortfolioId, ValuationCurrency, ValRunId)
			Select P.Id, P.Currency, @RunId
			from ptPortfolio P
			Inner Join VaRun R on P.PartnerId = R.PartnerId
			Where R.Id = @RunId
			AND P.ID Not in (Select PortfolioId From VaPortfolio Where ValRunID = @RunId)
		END	
Else
	Begin
		Print 'Insert into VaPortfolio Portfolio'
		Insert into VaPortfolio
		(PortfolioId, ValuationCurrency, ValRunId)
		Select P.Id, P.Currency, @RunId
		from ptPortfolio P
		Inner Join VaRun R on P.Id = R.PortfolioId
		Where R.Id = @RunId
		AND P.ID Not in (Select PortfolioId From VaPortfolio Where ValRunID = @RunId)
	End

--3. Aktualisiere die Währung
Print 'Update VaPortfolio'
Update VaPortfolio
Set ValuationCurrency = Currency
From PtPortfolio
Inner Join VaPortfolio on VaPortfolio.PortfolioId = ptPortfolio.id 
Where VaPortfolio.ValuationCurrency <> PtPortfolio.Currency
AND VaPortfolio.ValRunID = @RunId




