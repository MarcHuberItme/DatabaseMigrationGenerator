--liquibase formatted sql

--changeset system:create-alter-view-AcNogaKlasse context:any labels:c-any,o-view,ot-schema,on-AcNogaKlasse,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcNogaKlasse
CREATE OR ALTER VIEW dbo.AcNogaKlasse AS
Select HdVersionNo ,NogaKlasse, NogaCode, TextLong
From PtBusinessType 
Where NogaKlasse = NogaCode
And HdVersionNo Between 1 And 999999998
