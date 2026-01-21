--liquibase formatted sql

--changeset system:create-alter-procedure-CheckTableForBlocking context:any labels:c-any,o-stored-procedure,ot-schema,on-CheckTableForBlocking,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create stored procedure CheckTableForBlocking
CREATE OR ALTER PROCEDURE dbo.CheckTableForBlocking
@strTableName	AS	varchar(32),
@strTableRecId	AS	uniqueidentifier ,
@strFKFieldName	AS	varchar(32),
@IsBlocked	AS	bit	OUTPUT,
@strNewRecID 	AS	uniqueidentifier OUTPUT

AS
if(@strTableName = 'PtAgrPki')
begin
	if(@strFKFIeldName = 'Id')	
	begin
		SET @strNewRecID=@strTableRecId
		EXECUTE CheckBlockInfo 'PtAgrPki', @strTableRecId, @IsBlocked  = @IsBlocked OUTPUT		
	end
	
	else

	if(@strFKFIeldName = 'ContactPersonId')	
	begin
		Select @strNewRecID=ContactPersonId from PtAgrPki where Id = @strTableRecId AND HdVersionNo between 1 and 999999998
		EXECUTE CheckBlockInfo 'PtContactPerson', @strNewRecID, @IsBlocked  = @IsBlocked OUTPUT		
	end
	
	else
			
	if(@strFKFIeldName = 'PartnerId')	
	begin
		Select @strNewRecID=PartnerId from PtAgrPki where Id = @strTableRecId AND HdVersionNo between 1 and 999999998
		EXECUTE CheckBlockInfo 'PtBase', @strNewRecID, @IsBlocked  = @IsBlocked OUTPUT		
	end

	else
		print 'Unknown Field Name' + @strFKFIeldName
			
end

else

if(@strTableName = 'PtAgrSecureList')
begin
	if(@strFKFIeldName = 'Id')	
	begin
		SET @strNewRecID=@strTableRecId
		EXECUTE CheckBlockInfo 'PtAgrSecureList', @strTableRecId, @IsBlocked  = @IsBlocked OUTPUT				
	end
	
	else
	if(@strFKFIeldName = 'ContactPersonId')	
	begin
		Select @strNewRecID=ContactPersonId from PtAgrSecureList where Id = @strTableRecId AND HdVersionNo between 1 and 999999998
		EXECUTE CheckBlockInfo 'PtContactPerson', @strNewRecID, @IsBlocked  = @IsBlocked OUTPUT		
	end
	
	if(@strFKFIeldName = 'PartnerId')	
	begin
		Select @strNewRecID=PartnerId from PtAgrSecureList where Id = @strTableRecId AND HdVersionNo between 1 and 999999998
		EXECUTE CheckBlockInfo 'PtBase', @strNewRecID, @IsBlocked  = @IsBlocked OUTPUT		
	end
	
	else
		print 'Unknown Field Name' + @strFKFIeldName
	
end

else

if(@strTableName = 'PtAgrCardBase')
begin
	if(@strFKFIeldName = 'Id')	
	begin
		SET @strNewRecID=@strTableRecId
		EXECUTE CheckBlockInfo 'PtAgrCardBase', @strTableRecId, @IsBlocked  = @IsBlocked OUTPUT				
	end
	
	else
			
	if(@strFKFIeldName = 'ContactPersonId')	
	begin
		Select @strNewRecID=ContactPersonId from PtAgrCardBase where Id = @strTableRecId AND HdVersionNo between 1 and 999999998
		EXECUTE CheckBlockInfo 'PtContactPerson', @strNewRecID, @IsBlocked  = @IsBlocked OUTPUT		
	end

	else

	if(@strFKFIeldName = 'PartnerId')	
	begin
		Select @strNewRecID=PartnerId from PtAgrCardBase where Id = @strTableRecId AND HdVersionNo between 1 and 999999998
		EXECUTE CheckBlockInfo 'PtBase', @strNewRecID, @IsBlocked  = @IsBlocked OUTPUT		
	end

	else
		print 'Unknown Field Name' + @strFKFIeldName
			
end

else

if(@strTableName = 'PtAgrEBanking')
begin
	if(@strFKFIeldName = 'Id')	
	begin
		SET @strNewRecID=@strTableRecId
		EXECUTE CheckBlockInfo 'PtAgrEBanking', @strTableRecId, @IsBlocked  = @IsBlocked OUTPUT				
	end

	else
	
	if(@strFKFIeldName = 'ContactPersonId')	
	begin
		Select @strNewRecID=ContactPersonId from PtAgrEBanking where Id = @strTableRecId AND HdVersionNo between 1 and 999999998
		EXECUTE CheckBlockInfo 'PtContactPerson', @strNewRecID, @IsBlocked  = @IsBlocked OUTPUT		
	end

	else
	
	if(@strFKFIeldName = 'PartnerId')	
	begin
		Select @strNewRecID=PartnerId from PtAgrEBanking where Id = @strTableRecId AND HdVersionNo between 1 and 999999998
		EXECUTE CheckBlockInfo 'PtBase', @strNewRecID, @IsBlocked  = @IsBlocked OUTPUT		
	end
	
	else
		print 'Unknown Field Name' + @strFKFIeldName	
end

else


if(@strTableName = 'PtPosition')
begin
	if(@strFKFIeldName = 'Id')	
	begin
		SET @strNewRecID=@strTableRecId
		EXECUTE CheckBlockInfo 'PtPosition', @strTableRecId, @IsBlocked  = @IsBlocked OUTPUT
	end
	
	else
		
	if(@strFKFIeldName = 'ProdReferenceId')
	begin
		Select @strNewRecID=ProdReferenceId from PtPosition where Id = @strTableRecId AND HdVersionNo between 1 and 999999998
		EXECUTE CheckBlockInfo 'PrReference', @strNewRecID, @IsBlocked  = @IsBlocked 
	end
end
