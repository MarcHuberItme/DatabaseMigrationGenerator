--liquibase formatted sql

--changeset system:create-alter-function-ECH0196SecurityTypeMapping context:any labels:c-any,o-function,ot-schema,on-ECH0196SecurityTypeMapping,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function ECH0196SecurityTypeMapping
CREATE OR ALTER FUNCTION dbo.ECH0196SecurityTypeMapping
(@SecurityTypeNo varchar(8))
RETURNs TABLE
AS
RETURN
(
 Select S.SecurityType As OriginSecurityType, X.TextLong,
	Case When S.SecurityType In ('0','2','L','Q','V') Then 'BOND'
		When S.SecurityType In ('R','T','U','W') Then 'COINBULL'
		When S.SecurityType In ('B','X') Then 'CURRNOTE'	
		When S.SecurityType In ('4','6','M') Then 'DEVT'
		When S.SecurityType In ('7','C','S') Then 'FUND'
		When S.SecurityType In ('8') Then 'LIBOSWAP'
		When S.SecurityType In ('A','P','Z') Then 'OPTION'
		When S.SecurityType In ('3','5','9','E','F','I','J','K','N','Y') Then 'OTHER'
		When S.SecurityType In ('1','D','G') Then 'SHARE' End As securityCategory,
	Case When S.SecurityType In ('0','2','L','Q','V') Then 'BOND.BOND'
		--When S.SecurityType In (0) Then 'BOND.OPTION'
		--When S.SecurityType In (0) Then 'BOND.CONVERTIBLE'	
		When S.SecurityType In ('R','T','U','W') Then 'COINBULL.COINGOLD'
		--When S.SecurityType In (0) Then 'COINBULL.GOLD'
		--When S.SecurityType In (0) Then 'COINBULL.PALLADIUM'
		--When S.SecurityType In (0) Then 'COINBULL.PLATINUM'
		--When S.SecurityType In (0) Then 'COINBULL.SILVER'
		When S.SecurityType In ('B','X') Then 'CURRNOTE.CURRENCY'
		--When S.SecurityType In (0) Then 'CURRNOTE.CURRYEAR'
		When S.SecurityType In ('4','6','M') Then 'DEVT.COMBINEDPRODUCT'
		--When S.SecurityType In (0) Then 'DEVT.FUNDSIMILARASSET' 
		--When S.SecurityType In (0) Then 'DEVT.INDEXBASKET' 
		When S.SecurityType In ('7','C','S') Then 'FUND.ACCUMULATION' 
		--When S.SecurityType In (0) Then 'FUND.DISTRIBUTION' 
		--When S.SecurityType In (0) Then 'FUND.REALESTATE' 
		When S.SecurityType In ('8') Then 'LIBOSWAP.LIBOR'
		--When S.SecurityType In (0) Then 'LIBOSWAP.SWAP' 
		When S.SecurityType In ('A','P','Z') Then 'OPTION.CALL'
		--When S.SecurityType In (0) Then 'OPTION.PHANTOM' 	
		--When S.SecurityType In (0) Then 'OPTION.PUT' 	
		When S.SecurityType In ('1','D','G') Then 'SHARE.BEARERCERT' 
		--When S.SecurityType In (0) Then 'SHARE.BONUS' 	
		--When S.SecurityType In (0) Then 'SHARE.COMMON' 	
		--When S.SecurityType In (0) Then 'SHARE.COOP' 	
		--When S.SecurityType In (0) Then 'SHARE.LIMITED' 	
		--When S.SecurityType In (0) Then 'SHARE.NOMINAL' 	
		--When S.SecurityType In (0) Then 'SHARE.PARTCERT' 	
		--When S.SecurityType In (0) Then 'SHARE.PREFERRED' 	
		--When S.SecurityType In (0) Then 'SHARE.TRANSFERABLE' 
		Else 'NA' End As securityType
 From PrPublicSecurityType S Join AsText X On X.MasterId=S.Id And X.LanguageNo=1 
 Where S.SecurityType=@SecurityTypeNo
) 
