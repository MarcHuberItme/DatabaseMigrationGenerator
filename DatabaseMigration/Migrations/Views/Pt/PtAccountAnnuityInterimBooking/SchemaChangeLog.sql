--liquibase formatted sql

--changeset system:create-alter-view-PtAccountAnnuityInterimBooking context:any labels:c-any,o-view,ot-schema,on-PtAccountAnnuityInterimBooking,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtAccountAnnuityInterimBooking
CREATE OR ALTER VIEW dbo.PtAccountAnnuityInterimBooking AS
select * from PtTransItemAccountview where AccountId = (select Id from PtAccountBase 
where AccountNo = (select Value from AsParameter where name = 'AnnuityInterimAccount'))
and HdVersionNo BETWEEN 0 AND 999999998
