--liquibase formatted sql

--changeset system:create-alter-view-PtAccountCollateralView context:any labels:c-any,o-view,ot-schema,on-PtAccountCollateralView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountCollateralView
CREATE OR ALTER VIEW dbo.PtAccountCollateralView AS
SELECT TOP 100 PERCENT
V.Id, V.HdPendingChanges, V.HdPendingSubChanges, V.HdVersionNo, 
V.AccountNo, V.AccountNoEdited, V.CustomerReference, V.Currency, 
V.ProductNo, V.ProductId,
V.PartnerNo, V.FirstName, V.Name,
V.Street, V.HouseNo, V.Zip, V.Town, 
V.PortfolioNo, 
Cast(Case When RT.Id Is Null Then 'NA' When AAA.ProductNo Is Not Null Then 'True' Else 'False' End as varchar(5)) As AsProduct3AGroup, AccountNoEdited + IsNull(' /'+ V.Name + ' ' + V.FirstName + ', ' + V.Town + ' ' + V.Zip,'') As OwnerDesc
From PtAccountView V Left Outer Join AsGroupLabel RT On RT.Name='RetirementSavings'
Left Outer Join (
	Select GL.Name As GroupName, C.ProductNo, X.TextShort
	From AsGroupTypeLabel TL Inner Join AsGroupType GT On TL.GroupTypeID=GT.ID And GT.TableName='PrPrivate' 
	Inner Join AsGroup G On G.GroupTypeID=GT.ID And G.IsDefault=0 
	Inner Join AsGroupLabel GL On G.ID=GL.GroupID And GL.Name='RetirementSavings'
	Inner Join AsGroupMember M On M.GroupTypeID=GT.ID And M.GroupID=G.ID
	Inner Join PrPrivate C On M.TargetRowID =C.ID 
	Join AsText X On X.MasterId=C.Id And X.LanguageNo=2
	Where TL.Name='CollateralProductGrouping' 
		And TL.HdVersionNo<999999999 And GT.HdVersionNo<999999999 
		And G.HdVersionNo<999999999 And GL.HdVersionNo<999999999 
		And M.HdVersionNo<999999999 And C.HdVersionNo<999999999 ) AAA On V.ProductNo=AAA.ProductNo
