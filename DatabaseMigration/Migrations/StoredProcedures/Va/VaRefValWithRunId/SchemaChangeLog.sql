--liquibase formatted sql

--changeset system:create-alter-procedure-VaRefValWithRunId context:any labels:c-any,o-stored-procedure,ot-schema,on-VaRefValWithRunId,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaRefValWithRunId
CREATE OR ALTER PROCEDURE dbo.VaRefValWithRunId
--Store Procedure VaRefValWithRunId
@RunId uniqueidentifier, 
@DateDiff Integer
AS

Declare @ValuationDate As SmallDateTime

/*
Declare @DateDiff as integer
Declare @RunId AS uniqueidentifier
Set @RunId = '{CBF9D936-1DF4-4887-8DC1-93862ED87276}'
Set @DateDiff = 1
*/

Set @ValuationDate = (Select ValuationDate From VaRun Where ID = @RunId)

If @DateDiff is null 
	BEGIN 
		Set @DateDiff = -1
	END
If 	@DateDiff > 0 	
	BEGIN
		Set @DateDiff = @DateDiff - ( 2 * @DateDiff )
	END


--3. Update der RefVal Einträge (nur fungible Instrumente): 
begin tran

CREATE TABLE #temptable (TmpPriceId uniqueidentifier, TmpCurrency char(3), TmpPrice float, TmpDateLogical smalldatetime, TmpPriceDate smalldatetime, TmpPriceQuoteType int, TmpDelay decimal(10,4), TmpREFId uniqueidentifier, TmpStaticType smallint, TmpOrderStatusNoSx smallint);

INSERT INTO #temptable
(TmpPriceId , TmpCurrency , TmpPrice , TmpDateLogical , TmpPriceDate , TmpPriceQuoteType , TmpDelay , TmpREFId , TmpStaticType, TmpOrderStatusNoSx)

		SELECT PP.ID, PP.Currency, PP.Price, PP.LogicalPriceDate, PP.PriceDate, PP.PriceQuoteType,  
			CAST( DATEDIFF ( d , isnull(PP.PriceDate,PP.LogicalPriceDate) , CAST(@ValuationDate As DateTime) ) +

			Case PP.PublicTradingPlaceId        
			WHEN IsNull((Select Top 1 PH.MajorTradingPlaceId From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <= @ValuationDate Order by FromDate DESC)  , PP.PublicTradingPlaceId) THEN 0        
			ELSE PPP.TradingPlace   
			END +    
			
			CASE PP.Currency
			WHEN isnull((Select Top 1 ISNULL(PH.ExposureCurrency,IsNull(PH.NominalCurrency,'CHF')) From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <= @ValuationDate Order by FromDate DESC)  , PP.Currency) THEN 0          
			ELSE PPP.Currency   
			END 
			+ PPTP.Delay
			+ IsNull(PPST.Delay,0)
			As DECIMAL(10,4)) 
			As Delay

			, RV.Id
			, isnull(PP.PriceStaticTypeNo,2)
			, Isnull(L.OrderStatusNoSx,10)

		FROM VaRefVal RV With (Tablockx)
		Inner Join PrReference REF on REF.ID = RV.ProdReferenceId
		Inner Join PrPublic P on P.ProductId = REF.ProductId
		Inner Join PrPublicPrice PP on PP.PublicId = P.Id AND PP.HdVersionNo Between 1 AND 999999998
		Inner Join PrPublicTradingPlace PTP on PTP.Id = PP.PublicTradingPlaceId AND PTP.HdVersionNo Between 1 AND 999999998  
		Left Outer Join PrPublicListing L on L.PublicId = P.Id and L.PublicTradingPlaceId = PP.PublicTradingPlaceId and L.HdVersionNo between 1 and 999999998
		Inner Join prPublicPriceType PPT on PPT.PriceTypeNo = PP.PriceTypeNo AND PPT.HdVersionNo Between 1 AND 999999998   
		Inner Join prPublicSecurityType PST on P.SecurityType = PST.SecurityType
		Inner Join prPublicPricePenalty PPP on PPP.PenaltySetNo = PST.PenaltySetNo
		Inner Join prPublicPriceTypePenalty PPTP on PPT.PriceTypeNo = PPTP.PriceTypeNo AND PPTP.PenaltySetNo =  PPP.PenaltySetNo  AND PPTP.HdVersionNo Between 1 AND 999999998
		Left Outer Join prPublicPriceStaticType PPST on PPST.PriceStaticTypeNo = PP.PriceStaticTypeNo
		WHERE RV.ValRunId = @RunId 
		AND PP.LogicalPriceDate <= @ValuationDate
		AND PP.LogicalPriceDate > Dateadd(WW,@DateDiff,@ValuationDate)
		AND PP.Price is not Null
		AND PP.StatisticTypeNo IN(12, 43)
		AND PPTP.Delay is not Null
		AND P.RefTypeNo not in (3,4)
		AND P.SecurityType <> '2'
		AND RV.NotActual = 1
		OR  PP.PriceStaticTypeNo is not null
		OPTION (MAXDOP 2);

	CREATE INDEX Temptable_Index
	ON dbo.#temptable
	(TmpOrderStatusNoSx ASC,TmpStaticType, TmpDelay ASC, TmpPriceDate DESC, TmpDateLogical DESC)
	CREATE INDEX Temptable_Index2
	ON dbo.#temptable
	(TmpREFId, TmpPriceId)

	Update VaRefVal
	Set PriceCurrency = TmpCurrency
		,PricePrCu = TmpPrice
		,PublicPriceId = TmpPriceId
		,PriceDate = IsNull(TmpPriceDate, TmpDateLogical)
		,PriceQuoteType = TmpPriceQuoteType
		,Delay = TmpDelay
		,NotActual = 0
	FROM VaRefVal RV 
	Inner Join #temptable TP on TmpREFId = RV.Id	
	Where TmpPriceId = (Select  TOP 1 TmpPriceId  From #temptable Where TmpREFId =  RV.ID 
			   Order by TmpOrderStatusNoSx ASC, TmpStaticType, TmpDelay ASC, TmpPriceDate DESC, TmpDateLogical DESC)
	AND RV.ValRunID = @RunId
	AND RV.NotActual = 1
	OPTION (MAXDOP 2);

DROP TABLE #temptable;
Commit;


--Update der RefVal Eintrge (Kassenobligationen): 
begin tran;
CREATE TABLE #temptable1 (TmpCurrency char(3),TmpRVId uniqueidentifier);

INSERT INTO #temptable1
(TmpCurrency, TmpRVId)
		Select 
		(Select Top 1 PH.NominalCurrency From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <= @ValuationDate Order by FromDate DESC)
		, RV.ID
		FROM PrReference REF With (tablockx)
		Inner Join VaRefVal RV on REF.ID = RV.ProdReferenceId
		Inner Join PrPublic P on P.ProductId = REF.ProductId
		Inner Join PrPublicRefType PRT ON PRT.RefTypeNo =  P.RefTypeNo
		WHERE RV.ValRunId = @RunId
		AND RV.NotActual = 1
		AND P.SecurityType = '2'
		And (PRT.FieldMaturityDate = 'M') 
		And REF.ID in 
		(
			Select PQ.ProdReferenceID 
			From VaPosQuant PQ
			Where PQ.Quantity <> 0 
			AND PQ.VaRunId = @RunId
		)
		OPTION (MAXDOP 2);

	CREATE INDEX Temptable1_Index
	ON dbo.#temptable1
	(TmpRVId)

	Update VaRefVal
		Set PriceCurrency = TmpCurrency 
		,   PricePrCu = 100
        ,   PriceQuoteType =  4
		,   NotActual = 0
	From VaRefVal RV
	Inner Join #temptable1 on TmpRVId = RV.Id
	Where NotActual = 1
	OPTION (MAXDOP 2);

	DROP TABLE #temptable1;
	commit

