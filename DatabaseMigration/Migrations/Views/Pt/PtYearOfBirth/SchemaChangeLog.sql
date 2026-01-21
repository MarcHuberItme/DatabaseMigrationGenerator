--liquibase formatted sql

--changeset system:create-alter-view-PtYearOfBirth context:any labels:c-any,o-view,ot-schema,on-PtYearOfBirth,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtYearOfBirth
CREATE OR ALTER VIEW dbo.PtYearOfBirth AS
Select Distinct Year(DateOfBirth) YearOfBirth 
From PtBase
Where DateOfBirth is not null
And HdVersionNo Between 1 And 999999998
