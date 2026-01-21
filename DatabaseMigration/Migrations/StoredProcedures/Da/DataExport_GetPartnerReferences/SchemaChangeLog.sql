--liquibase formatted sql

--changeset system:create-alter-procedure-DataExport_GetPartnerReferences context:any labels:c-any,o-stored-procedure,ot-schema,on-DataExport_GetPartnerReferences,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure DataExport_GetPartnerReferences
CREATE OR ALTER PROCEDURE dbo.DataExport_GetPartnerReferences
    @PartnerId uniqueidentifier AS
Declare @PartnerNo_1 As varchar(20)
Declare @PartnerNo_2 As varchar(20)
Declare @Anrede_1 As varchar(10)
Declare @Anrede_2 As varchar(10)
Declare @Name1_1 As varchar(50)
Declare @Name2_1 As varchar(50)
Declare @Name1_2 As varchar(50)
Declare @Name2_2 As varchar(50)

Declare @PartnerNoEdited As varchar(20)
Declare @Name nvarchar(50)
Declare @FirstName nvarchar(50)
Declare @MiddleName nvarchar(50)
Declare @MaidenName nvarchar(50)
Declare @UseMiddleName bit
Declare @ChangeNameOrder bit
Declare @SexStatusNo int
Declare @Anrede As varchar(10)

Declare @LoopCounter As int
Declare @Name1 As varchar(50)
Declare @Name2 As varchar(50)


-- Get the two references

DECLARE RefCursor CURSOR FAST_FORWARD
FOR SELECT  PartnerNoEdited, Name, FirstName, MiddleName, MaidenName, UseMiddleName, ChangeNameOrder, SexStatusNo
FROM PtBase b
   Join PtRelationSlave s on s.PartnerId = b.Id
   Join PtRelationMaster m on m.Id = s.masterId
WHERE m.PartnerId = @PartnerId
   And m.RelationTypeNo = 10
ORDER BY PartnerNo
   
OPEN RefCursor
SET @LoopCounter = 1
FETCH NEXT FROM RefCursor into @PartnerNoEdited, @Name, @FirstName, @MiddleName, @MaidenName, @UseMiddleName, @ChangeNameOrder, @SexStatusNo
WHILE @@FETCH_STATUS = 0
BEGIN
    SELECT @Name1 = dbo.DataExport_Buildname(@Name,@MaidenName,@ChangeNameOrder)
    SELECT @Name2 = dbo.DataExport_BuildFirstName(@FirstName, @MiddleName, @UseMiddleName)

    SET @Anrede = CASE @SexStatusNo
       WHEN 1 THEN 'Frau'
       WHEN 2 THEN 'Herr'
       ELSE ''
    END 
        
    IF @LoopCounter = 1
    BEGIN
        SET @Name1_1 = @Name1
        SET @Name2_1 = @Name2
        SET @Anrede_1 = @Anrede
        SET @PartnerNo_1 = @PartnerNoEdited
    END
    ELSE
    IF @LoopCounter = 2
    BEGIN
        SET @Name1_2 = @Name1
        SET @Name2_2 = @Name2
        SET @Anrede_2 = @Anrede
        SET @PartnerNo_2 = @PartnerNoEdited
    END
    SET  @LoopCounter = @LoopCounter + 1

    FETCH NEXT FROM RefCursor into @PartnerNoEdited, @Name, @FirstName, @MiddleName, @MaidenName, @UseMiddleName, @ChangeNameOrder, @SexStatusNo
END

CLOSE RefCursor
DEALLOCATE RefCursor

SELECT @PartnerNo_1 As 'verweisAufPartner1.PartnerNummer',
   @PartnerNo_2 As 'verweisAufPartner2.PartnerNummer',

   @Anrede_1 As 'verweisAufPartner[1].anrede',
   @Name1_1 As 'verweisAufPartner[1].name1',
   @Name2_1 As 'verweisAufPartner[1].name2',
   @PartnerNo_1 As 'verweisAufPartner[1].partnerNummer',

   @Anrede_2 As 'verweisAufPartner[2].anrede',
   @Name1_2 As 'verweisAufPartner[2].name1',
   @Name2_2 As 'verweisAufPartner[2].name2',
   @PartnerNo_2 As 'verweisAufPartner[2].partnerNummer'
