--liquibase formatted sql

--changeset system:create-alter-view-PtAccountOwnerView context:any labels:c-any,o-view,ot-schema,on-PtAccountOwnerView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountOwnerView
CREATE OR ALTER VIEW dbo.PtAccountOwnerView AS
   Select VA.*, 
   VA.AccountNoEdited + ' /' + A.ReducedAddress As OwnerDesc11
   From PtAccountInfoView VA Join PtAddress A On VA.PartnerId=A.PartnerId And A.AddressTypeNo=11 
	   And A.HdVersionNo<999999999
