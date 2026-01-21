--liquibase formatted sql

--changeset system:create-alter-view-ReBasePremisesView context:any labels:c-any,o-view,ot-schema,on-ReBasePremisesView,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view ReBasePremisesView
CREATE OR ALTER VIEW dbo.ReBasePremisesView AS
SELECT 	RB.Id,
	RB.HdCreateDate, 
	RB.HdEditStamp,
	RB.HdStatusFlag, 
	RB.HdPendingChanges, 
	RB.HdPendingSubChanges, 
	RB.HdVersionNo,
	RB.HdProcessId,
	RB.BaseTypeNo,
	RB.Zip,
	RB.Town,
	RB.Street,
	RB.HouseNo,
	RB.CountryCode,
	RB.TerminationDate As TerminationDateBase,
	RO.PartnerId,
	RO.PartnerNo,
	RO.Name As PartnerName,
	RO.FirstName As PartnerFirstName,
	RO.ValidFrom,
	RO.ValidTo,
	RP.Id As PremisesId,
	RP.PremisesType,
	RP.GBNo,
	RP.GBNoAdd,
	RP.GBPlanNo,
                ISNULL(RP.GBRegisterType, 'GB') + ': ' + ISNULL(RP.GBNo, 0)  + ' ' + ISNULL(RP.GBNoAdd, 0) + ' ' + ISNULL(RP.GBPlanNo, 0) 
                 AS GbDescription,
	 RP.TerminationDate As TerminationDatePremises,
                 RB.SwissTownNo,
                 RB.SwissTownPartNo, RB.Id As ReBaseId
FROM ReBase As RB
LEFT OUTER JOIN ReOwnerView As RO ON RB.Id = RO.RebaseId AND RO.HdVersionNo < 999999999
LEFT OUTER JOIN RePremises As RP ON RB.Id = RP.ReBaseId AND RP.HdVersionNo < 999999999 

