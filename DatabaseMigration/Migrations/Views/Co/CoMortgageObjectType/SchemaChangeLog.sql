--liquibase formatted sql

--changeset system:create-alter-view-CoMortgageObjectType context:any labels:c-any,o-view,ot-schema,on-CoMortgageObjectType,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view CoMortgageObjectType
CREATE OR ALTER VIEW dbo.CoMortgageObjectType AS
Select AccountList.AccountId, AccountList.AccountNo, 
--AccountList.ValueTotal, 
AccountList.ValueHoCu As ValueTotal,
AccountList.CustomerReference, AccountList.ProductNo, AccountList.ReportDate,
NominalList.NominalTotal, ObjectDetails.Nominal, 
--CAST(AccountList.ValueTotal * IsNull(ObjectDetails.Nominal,1) / IsNull(NominalList.NominalTotal,1) As Money) As Value,
CAST(AccountList.ValueHoCu * IsNull(ObjectDetails.Nominal,1) / IsNull(NominalList.NominalTotal,1) As Money) As Value,
ObjectDetails.PremisesId, ObjectDetails.PremisesType, ObjectDetails.UseTypeNo, ObjectDetails.IsAgriculture, 
ObjectDetails.IsLiving, ObjectDetails.LendingLimit, ObjectDetails.BuildingId, ObjectDetails.BuildingTypeNo, 
ObjectDetails.BuildingSubTypeNo, ObjectDetails.IsHoliday, ObjectDetails.IsMultifunctional, ObjectDetails.CoPremResultMan,
Pro.GroupName as TypeOfLoan,
--Case 
-- When AccountList.ProductNo in (3001,3002,3003,3004,3005,3006,3007,3008,3009,3010) Then 1
-- When AccountList.ProductNo in (3040,3041,3042,3043,3044) Then 2 Else 99 End As TypeOfLoan,
Case When ObjectDetails.CoPremResultMan = 20 Then 2		--CoPremResultMan
	When ObjectDetails.CoPremResultMan = 30 Then 12
	When ObjectDetails.CoPremResultMan = 40 Then 5
	When ObjectDetails.CoPremResultMan = 50 Then 4
	When ObjectDetails.CoPremResultMan IN (60,75) Then 6
	When ObjectDetails.CoPremResultMan = 70 Then 10
	When ObjectDetails.CoPremResultMan = 80 Then 9
	When ObjectDetails.CoPremResultMan = 90 Then 8
	When ObjectDetails.CoPremResultMan = 95 Then 11
	When ObjectDetails.IsAgriculture = 1 Then 8			-- Landwirtschaft
	When ObjectDetails.IsHoliday = 1  Then 12			-- Ferienhaus
	Else Case IsNull(ObjectDetails.PremisesType,99)		--PremisesType
		When 1 Then 1  -- EFH
		When 2 Then 3  -- StwE
		When 3 Then 2  -- MFH
		When 4 Then 3  -- StwE
		When 5 Then 4  -- gem. Wohnbau
		When 6 Then 8  -- Landwirtschaft
		When 7 Then 11 -- Bauland
		When 9 Then Case ObjectDetails.BuildingTypeNo	--8 (Gewerbe/Ind./Büro/Verkauf) --> BuildingTypeNo
			When 1 Then 1  -- EFH
			When 2 Then 2  -- MFH
			When 3 Then 3  -- StwE
			When 4 Then 3  -- StwE
			When 6 Then 4  -- gem. Wohnbau
			When 7 Then 8  -- Landwirtschaft
			When 10 Then 9 -- Hotel / Restaurant
			When 14 Then 2 -- MFH
			When 5 Then Case ObjectDetails.BuildingSubTypeNo	--5 (Gewerbe/Ind./Büro/Verkauf) --> BuildingSubTypeNo
				When 1 Then 5   -- Büro, Geschäft, Verkauf
				When 2 Then 6   -- gew. Bauten
				When 3 Then 10  -- Industrie / Grossgewerbe
				When 4 Then 6   -- gew.Bauten
				Else 6          -- gew. Bauten
				End
			Else 49 -- übrige
			End
		When 11 Then Case ObjectDetails.BuildingTypeNo	--11 (übrige Objekte) --> BuildingTypeNo
			When 4 Then 13	-- STWE übrige
			When 6 Then 4	-- gemischter Wohnbau
			When 10 Then 9	-- Hotel / Restaurant
			Else 49			-- übrige
			End
		When 99 Then 99 -- Grundpfand fehlt
		Else 49 -- übrige
		End
	End As Objektart, 
Pro.GroupName, Pro.ProductNo As GroupProductNo	--msn for test
From ( Select GL.Name As GroupName, C.ProductNo, TL.Name 
	From AsGroupTypeLabel TL Inner Join AsGroupType GT On TL.GroupTypeID=GT.ID And GT.TableName='PrPrivate'  
	Inner Join AsGroup G On G.GroupTypeID=GT.ID And G.IsDefault=0 And G.HdVersionNo<999999999  
	Inner Join AsGroupLabel GL On G.ID=GL.GroupID And GL.HdVersionNo<999999999
	Inner Join AsGroupMember M On M.GroupTypeID=GT.ID And M.GroupID=G.ID And M.HdVersionNo<999999999  
	Inner Join PrPrivate C On M.TargetRowID =C.ID And C.HdVersionNo<999999999 
	Where TL.HdVersionNo<999999999 And GT.HdVersionNo<999999999 
	  And TL.Name='ObjectReport'  
	--Order By GL.Name, C.ProductNo
) Pro 
--Inner Join ( Select acc.AccountId, acc.AccountNo, acc.productNo, acc.ValueHoCu As ValueTotal, acc.CustomerReference, acc.ReportDate
--	From AcFrozenAccount acc
--	Where (acc.ProductNo Between 3001 And 3010 OR acc.ProductNo Between 3040 And 3044)
--) As AccountList On Pro.ProductNo=AccountList.ProductNo
Inner Join AcFrozenAccount AccountList On Pro.ProductNo=AccountList.ProductNo
Left Outer Join ( Select ba.AccountId,  Sum(IsNull(ba.MaxAllocAmount,ob.ObligAmount)) As NominalTotal
	From CoBaseass ba Join CoBase co on co.Id = ba.CollateralId And co.InactFlag = 0 And ba.HdVersionNo < 999999999 And co.HdVersionNo < 999999999
	Join ReObligation ob on ob.Id = co.ObligationId And ob.HdVersionNo < 999999999
	Where ba.Inactflag = 0 And co.CollType = 7000 
	Group By  ba.AccountId
) As NominalList ON AccountList.AccountId = NominalList.AccountId And NominalTotal <> 0   -- Avoid DivByZero
Left Outer Join 
(	Select ba.AccountId,  IsNull(ba.MaxAllocAmount,ob.ObligAmount) As Nominal, 
		pre.PremisesId, pre.PremisesType, pre.UseTypeNo, pre.IsAgriculture, pre.IsLiving, pre.LendingLimit, pre.CoPremResultMan, 
		bld.BuildingTypeNo, bld.BuildingSubTypeNo, bld.IsHoliday, bld.IsMultifunctional, bld.IsLuxus, bld.IsSocialBuilding,	bld.BuildingId
	From CoBaseass ba Join CoBase co on co.Id = ba.CollateralId And ba.HdVersionNo < 999999999 And co.HdVersionNo < 999999999
	  And ba.Inactflag = 0 And co.InactFlag = 0
	Join ReObligation ob on ob.Id = co.ObligationId And ob.HdVersionNo < 999999999
	Outer Apply ( Select TOP 1 re.Id PremisesId, re.PremisesType, re.IsAgriculture, re.IsIndustry, re.IsLiving, val.LendingLimit, 
			obre.CoPremResultMan, re.UseTypeNo
		From ReObligPremisesRelation obre Join RePremises re on re.Id = obre.PremisesId
		Left Outer Join ReValuation val on  val.PremisesId = re.id 
			And val.Id = (Select TOP (1) id
				From ReValuation AS ReValuation_1
				Where (PremisesId = re.id) And (HdVersionNo < 999999999) And (ValuationStatusCode = 3)
				Order By ValuationDate DESC)
		Where obre.ObligationId = ob.id	And obre.HdVersionNo < 999999999 And re.HdversionNo < 999999999
		Order By val.LendingLimit Desc ) pre 
	Outer Apply ( Select TOP 1 b.Id BuildingId, b.IsHoliday, b.IsLuxus, b.IsMultifunctional, b.IsSocialBuilding, b.BuildingTypeNo, b.BuildingSubTypeNo
		 From ReBuilding b
		 Where b.PremisesId = pre.PremisesId And b.HdVersionNo < 999999999
		 Order By b.IsMain desc
		 ) Bld
	Where co.CollType = 7000

) As ObjectDetails ON AccountList.AccountId = ObjectDetails.AccountId
