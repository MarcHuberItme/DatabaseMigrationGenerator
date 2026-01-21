--liquibase formatted sql

--changeset system:create-alter-view-AsProcessActivityViewTab5 context:any labels:c-any,o-view,ot-schema,on-AsProcessActivityViewTab5,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AsProcessActivityViewTab5
CREATE OR ALTER VIEW dbo.AsProcessActivityViewTab5 AS
SELECT Top 1 TypeIsDistributable, 
AllowedTotalNoOfType, 
AllowedTypePerStationNo
from AsProcessActivity

