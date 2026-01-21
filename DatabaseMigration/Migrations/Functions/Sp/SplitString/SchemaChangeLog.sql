--liquibase formatted sql

--changeset system:create-alter-function-SplitString context:any labels:c-any,o-function,ot-schema,on-SplitString,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function SplitString
CREATE OR ALTER FUNCTION dbo.SplitString
(
      @String VARCHAR(MAX),  -- Variable for string
      @delimiter VARCHAR(50) -- Delimiter in the string 
)


RETURNS @Table TABLE(        --Return type of the function
Splitcolumn VARCHAR(MAX),
Position  int identity(1,1)

) 

BEGIN
     Declare @Xml AS XML  
	
-- Replace the delimiter to the opeing and closing tag 
--to make it an xml document

     SET @Xml = cast(('<A>'+replace(@String,@delimiter,'</A><A>')+'</A>') AS XML)  

--Query this xml document via xquery to split rows 

--and insert it into table to return.


     INSERT INTO @Table SELECT A.value('.', 'varchar(max)') as [Column] FROM @Xml.nodes('A') AS FN(A)  

RETURN

END
