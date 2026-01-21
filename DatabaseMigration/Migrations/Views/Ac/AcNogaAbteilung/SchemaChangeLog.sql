--liquibase formatted sql

--changeset system:create-alter-view-AcNogaAbteilung context:any labels:c-any,o-view,ot-schema,on-AcNogaAbteilung,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcNogaAbteilung
CREATE OR ALTER VIEW dbo.AcNogaAbteilung AS
Select HdVersionNo, NogaAbteilung, NogaCode, TextLong
From PtBusinessType 
Where NogaAbteilung= NogaCode
And HdVersionNo Between 1 And 999999998
