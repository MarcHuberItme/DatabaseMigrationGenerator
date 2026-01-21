--liquibase formatted sql

--changeset system:create-alter-procedure-AsNavigationStruct_GetByMaster context:any labels:c-any,o-stored-procedure,ot-schema,on-AsNavigationStruct_GetByMaster,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure AsNavigationStruct_GetByMaster
CREATE OR ALTER PROCEDURE dbo.AsNavigationStruct_GetByMaster
    @MasterId  UNIQUEIDENTIFIER, 
    @LanguageNo TINYINT
AS
SELECT N.*,
       TextShort = CASE WHEN TT.TextShort IS NOT NULL THEN TT.TextShort
                        WHEN FT.TextShort Is NOT NULL THEN FT.TextShort 
                        ELSE 'Not available' 
                   END,
       TextShortFolderName = CASE WHEN NFT.TextShort IS NOT NULL THEN NFT.TextShort
                        WHEN N.FolderName Is NOT NULL THEN N.FolderName 
                        ELSE '' 
                   END
    FROM AsNavigationStructure AS N
        LEFT OUTER JOIN MdTable AS M ON N.TableName = M.TableName
            LEFT OUTER JOIN AsText As TT ON TT.MasterId = M.Id
                AND TT.LanguageNo = @LanguageNo
        LEFT OUTER JOIN AsNavigationForm As F ON N.FormName = F.FormName
            LEFT OUTER JOIN AsText As FT ON FT.MasterId = F.Id        
                AND FT.LanguageNo = @LanguageNo   
        LEFT OUTER JOIN AsNavigationFolder As NF ON N.FolderName = NF.FolderName
            LEFT OUTER JOIN AsText As NFT ON NFT.MasterId = NF.Id        
                AND NFT.LanguageNo = @LanguageNo   
    WHERE N.NavigationStructureId = @MasterId 
