--liquibase formatted sql

--changeset system:create-alter-procedure-VaRefValMarketValue context:any labels:c-any,o-stored-procedure,ot-schema,on-VaRefValMarketValue,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure VaRefValMarketValue
CREATE OR ALTER PROCEDURE dbo.VaRefValMarketValue
--Store Procedure: VaRefValMarketValue

@RunId uniqueidentifier, 
@ValuationDate Datetime,
@Quantity Decimal(10,4)
AS

/*
Declare @RunId  as uniqueidentifier 
Declare @ValuationDate as Datetime
Declare @Quantity as Decimal(10,4)

Set @RunId ='D67FE6A2-65D4-4182-9265-59F83B34171E'
set @ValuationDate = '20071231'
set @Quantity = 1
*/
If @Quantity is NULL or @Quantity = 0 	
	Begin	
		Set  @Quantity  = 1
	End;

With TmpMarketValueCalc (TmpVaRefValId, TmpMarketValue, TmpNominalAmount, TmpNominalCurrency, ContractSize, UnitNo, CashMultiplier, SecurityType, PriceQuoteType) AS
	(
	Select RV.Id, MarketValue =
			Case (Select Top 1 PH.UnitNo From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <=@ValuationDate Order by FromDate DESC)
				When '1' THEN	--NOMINAL
					CASE PRT.FieldMaturityDate
						When 'M' Then
							Case SecurityType
								When '2' Then	
									@Quantity * RV.PricePrCu / 100
								Else
									NULL
							END
						Else
							Case PRT.FieldInterestRate 
								When 'M' Then
									Case SecurityType
										When '2' Then	
											@Quantity * RV.PricePrCu / 100
										Else
											NULL
									END
								Else
									CASE PP.PriceQuoteType
										When '1' THEN	--Price per piece
											@Quantity * RV.PricePrCu * ISNULL(PP.PriceCorrectionFactor,1) / NominalAmount															
										When '4' THEN	--Nominal
											@Quantity * RV.PricePrCu / 100
										When '5' THEN	--Nominal * Factor
											@Quantity * RV.PricePrCu * PP.PriceCorrectionFactor / 100
										Else
											NULL
									END
							END
					END
				When '2' THEN	--PIECE
					Case P.InstrumentTypeNo
						When 9 THEN
							CASE PP.PriceQuoteType 
								When '1' THEN	--Price per piece
									@Quantity * (RV.PricePrCu - ISNULL(PP.NonVerse,0)) * ISNULL(PP.PriceCorrectionFactor,1)
								When '3' THEN	--Price per piece
									@Quantity * (RV.PricePrCu - ISNULL(PP.NonVerse,0)) * ISNULL(PP.PriceCorrectionFactor,1)
								When '4' THEN	--Nominalprice
									@Quantity * NominalAmount * PP.Price / 100
								Else
									NULL
							END
						Else
							CASE PP.PriceQuoteType 
								When '1' THEN	--Price per piece
									@Quantity * (RV.PricePrCu - ISNULL(PP.NonVerse,0)) * ISNULL(PP.PriceCorrectionFactor,1) / case L.PriceRepUnitAmount when 0 then 1 else isnull(L.PriceRepUnitAmount,1) end
								When '3' THEN	--Price per piece
									@Quantity * (RV.PricePrCu - ISNULL(PP.NonVerse,0)) * ISNULL(PP.PriceCorrectionFactor,1) / case L.PriceRepUnitAmount when 0 then 1 else isnull(L.PriceRepUnitAmount,1) end
								When '4' THEN	--Nominalprice
									@Quantity * NominalAmount * PP.Price / 100 / case L.PriceRepUnitAmount when 0 then 1 else isnull(L.PriceRepUnitAmount,1) end
								Else
									NULL
							END
					END
				When '3' THEN
					CASE PP.PriceQuoteType
						When '1' THEN	--Price per piece
							@Quantity * RV.PricePrCu * isNull(CashMultiplier, ContractSize)
						When '4' THEN	--Nominalprice
							@Quantity * NominalAmount * isNull(CashMultiplier, ContractSize)
						Else
							NULL
					END
				Else
					Case P.InstrumentTypeNo
						When 9 THEN
							(
							(isnull(P.NumberPhysicalUnit, 1) * Case P.PhysicalUnitTypeNo when 11 then 1000 else 1 end) 
							/ 
							(case PP.PriceRepUnitAmount when 0 then 1 else isnull(PP.PriceRepUnitAmount,1) end * Case PP.PriceUnit when 11 then 1000 else 1 end)
							)
							* @Quantity * RV.PricePrCu
						Else
							NULL
						END
			END
		, (Select Top 1 PH.NominalAmount From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <=@ValuationDate Order by FromDate DESC) as NominalAmount
		, (Select Top 1 PH.NominalCurrency From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <=@ValuationDate Order by FromDate DESC) AS NominalCurrency
		, (Select Top 1 PH.ContractSize From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <=@ValuationDate Order by FromDate DESC) as ContractSize
		, (Select Top 1 PH.UnitNo From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <=@ValuationDate Order by FromDate DESC) as unitno
		, (Select Top 1 PH.CashMultiplier From PrPublicHist PH Where PH.PublicId = P.ID AND PH.FromDate <=@ValuationDate Order by FromDate DESC) as CashMultiplier
		, SecurityType
		, (Select Top 1 PP.PriceQuoteType From PrPublicPrice PP Where PP.PublicId = P.ID AND PP.PriceDate <=@ValuationDate Order by PP.PriceDate DESC) as priceQuoteType
		


		--, P.NumberPhysicalUnit
		--, P.InstrumentTypeNo
		/*
		, RV.PricePrCu
		, PRT.FieldMaturityDate
		, PRT.FieldInterestRate 
		*/
		From vaRefVal RV
		Inner Join prReference REF on REF.ID = RV.ProdReferenceId
		Left Outer Join prPublicPrice PP on PP.Id = RV.PublicPriceId
		Left Outer Join PrPublicListing L on L.PublicTradingPlaceId = PP.PublicTradingPlaceId
		and L.PublicId = PP.PublicId and PP.HdVersionNo between 1 and 999999998
		--Inner Join PrBase B on B.Id = REF.ProductId
		Inner Join PrPublic P on P.ProductId = REF.ProductId
		Left Outer Join PrPublicRefType PRT ON PRT.RefTypeNo = P.RefTypeNo 
		Where RV.ValRunId = @RunId
		--AND SecurityType not in ('5','4','3') 
	)

Update VaRefVal
Set MarketValuePrCu = TmpMarketValue
From VaRefVal RV
Inner Join TmpMarketValueCalc on TmpMarketValueCalc.TmpVaRefValId = RV.Id

