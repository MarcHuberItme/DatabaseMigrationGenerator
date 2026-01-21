--liquibase formatted sql

--changeset system:create-alter-procedure-GetExtMetaData context:any labels:c-any,o-stored-procedure,ot-schema,on-GetExtMetaData,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure GetExtMetaData
CREATE OR ALTER PROCEDURE dbo.GetExtMetaData
    @TableName varchar(30),
    @LanguageNo tinyint AS
    SELECT m.TableName, m.TableType, m.DefArchive, m.VisumLevel, 
        m.VisumNumber, m.HasAsText, m.CacheLevel, m.IsNavigationRoot, t.TextShort, t.TextLong
        FROM MdTable AS m WITH (READCOMMITTED) LEFT OUTER JOIN AsText AS t 
            ON m.Id = t.MasterId 
            AND t.LanguageNo = @LanguageNo 
        WHERE m.TableName = @TableName
           AND m.HdVersionNo > 0 AND m.HdVersionNo < 999999999

    SELECT FieldName, DataType, IsNotNull, IsUnique, Prec, Scale, MinValue, 
            MaxValue, DefaultValue, MultiLine, RefTable, RefField, HasDetailBtn, 
            VisNumber, DefSizeX, DefSizeY, DefPosX, DefPosY, TabOrder,
            DefColumnPos, DefColumnWidth, NoUpdatePos, IsOnlyForMig, IsNoUpdate, IsIdentity
        FROM MdField WITH (NOLOCK)
        WHERE TableName = @TableName
           AND HdVersionNo > 0 AND HdVersionNo < 999999999

    SELECT m.FlagPos, t.TextShort, t.TextLong
        FROM MdStatusFlag As m WITH (NOLOCK) Left Outer Join AsText As t
            ON m.Id = t.MasterId 
            AND t.LanguageNo = @LanguageNo 
        WHERE m.TableName = @TableName
           AND m.HdVersionNo > 0 AND m.HdVersionNo < 999999999
            
    SELECT m.FlagPos, m.FlagValue, t.TextShort, t.TextLong 
        FROM MdStatusFlagValue As m WITH (NOLOCK) Left Outer Join AsText As t
            ON m.Id = t.MasterId 
            AND t.LanguageNo = @LanguageNo 
        WHERE m.TableName = @TableName
           AND m.HdVersionNo > 0 AND m.HdVersionNo < 999999999
