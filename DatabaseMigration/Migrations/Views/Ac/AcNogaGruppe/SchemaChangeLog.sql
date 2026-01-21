--liquibase formatted sql

--changeset system:create-alter-view-AcNogaGruppe context:any labels:c-any,o-view,ot-schema,on-AcNogaGruppe,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view AcNogaGruppe
CREATE OR ALTER VIEW dbo.AcNogaGruppe AS
Select HdVersionNo, NogaGruppe, NogaCode, TextLong
From PtBusinessType 
Where NogaGruppe = NogaCode
And HdVersionNo Between 1 And 999999998
