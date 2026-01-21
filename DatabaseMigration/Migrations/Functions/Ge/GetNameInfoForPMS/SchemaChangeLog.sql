--liquibase formatted sql

--changeset system:create-alter-function-GetNameInfoForPMS context:any labels:c-any,o-function,ot-schema,on-GetNameInfoForPMS,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function GetNameInfoForPMS
CREATE OR ALTER FUNCTION dbo.GetNameInfoForPMS
(
      @PartnerNo decimal (8,0)
)
RETURNS TABLE
As
Return
(
Select a.PartnerNo, case
	when len(a.NamePart + AdditionalName) <= 35 then
		a.NamePart + AdditionalName 
	else
		a.NamePart
	End as NamePart1,
case 	
	when len(a.NamePart + AdditionalName) <= 35 then
		' ' 
	else
		a.AdditionalName
	End as NamePart2 from
(
select c.PartnerNo,FirstName,Name,FullAddress,
isnull(FirstNamePart,'')+ 

case 
	when isnull(FirstNamePart,'') = '' then
		isnull(Name,'')
	else
		' ' + isnull(Name,'')
	End
as NamePart,
isnull(
case 
	when NameCont is not null then
		' ' + NameCont
	when MaidenName is not null and (ChangeNameOrder=1) then
		' ' + MaidenName
	when MaidenName is not null and (ChangeNameOrder=0) then	
		'-' + MaidenName
end,'')
as AdditionalName
from 
(
Select PartnerNo, FirstName,Name,middleName,FullAddress,UseMiddleName,Namecont,ChangeNameOrder,MaidenName,
case
	when UseMiddleName=1 and len(middleName)>0  then
		isnull(FirstName,'') + ' ' + middleName
	Else
		FirstName
	End as FirstNamePart
		
 from PtBase 
inner join PtAddress on PtAddress.PartnerId = PtBase.ID and PtAddress.AddressTypeNo=11
Where PartnerNo = @PartnerNo

) C

) a
)
