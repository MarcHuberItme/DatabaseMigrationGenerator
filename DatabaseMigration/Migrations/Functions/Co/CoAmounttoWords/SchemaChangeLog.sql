--liquibase formatted sql

--changeset system:create-alter-function-CoAmounttoWords context:any labels:c-any,o-function,ot-schema,on-CoAmounttoWords,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function CoAmounttoWords
CREATE OR ALTER FUNCTION dbo.CoAmounttoWords
(
    @Numberin AS money
) RETURNS VARCHAR(1024)
AS
BEGIN
    DECLARE @NumberInWords VARCHAR(1024)
    DECLARE @Workstring VARCHAR(32)
    declare @worknumber as money    
    declare @number as money
    DECLARE @Below10 TABLE (ID INT IDENTITY(0,1), Word VARCHAR(32)) 
    INSERT @Below10 (Word) VALUES ('Null')
    INSERT @Below10 (Word) VALUES ('Eins')
    INSERT @Below10 (Word) VALUES ( 'Zwei' )
    INSERT @Below10 (Word) VALUES ( 'Drei')
    INSERT @Below10 (Word) VALUES ( 'Vier' )
    INSERT @Below10 (Word) VALUES ( 'Fünf' )
    INSERT @Below10 (Word) VALUES ( 'Sechs' )
    INSERT @Below10 (Word) VALUES ( 'Sieben' )
    INSERT @Below10 (Word) VALUES ( 'Acht')
    INSERT @Below10 (Word) VALUES ( 'Neun')
    set @numberin = ISNULL(@numberin,0)
    if @numberin < 0 
		begin
			 set @numberin = 0 - @numberin 
		end
    set @number = ROUND(@numberin, 0, 1)
	set @NumberInWords  = ''
    set @workstring = '' 	
    while (1 = 1)
    begin
        if @workstring <> ''  
           begin
			if @NumberInWords <> ''
    			begin
    				set @NumberInWords  = @workstring + '-' + @NumberInWords
    			end
    		else
    			begin
    				set @NumberInWords  = @workstring
    			end
    		set @workstring = '' 	
    	   end
    	if @number < 10
    		begin
    		    SELECT @workstring= Word FROM @Below10 WHERE ID=@Number
    		    break
    		end
    	set @worknumber = @number % 10
        SELECT @workstring= Word FROM @Below10 WHERE ID=@worknumber
        set @number = (@number - @worknumber) / 10
    end	
    if @workstring <> ''  
       begin
		if @NumberInWords <> ''
			begin
    			set @NumberInWords  = @workstring + '-' + @NumberInWords
    		end
    	else
    		begin
    			set @NumberInWords  = @workstring
    		end
    	set @workstring = '' 	
       end
	/* do the decimal digits */
/* first digit after decimal point */
    set @number = ROUND(@numberin, 0, 1)
	set @workstring = '' 	    
	set @worknumber = @numberin - @number
	set @worknumber = ROUND(@worknumber, 1, 1) * 10
    SELECT @workstring= Word FROM @Below10 WHERE ID=@worknumber
	set @NumberInWords  = @NumberInWords + ' und Rappen '  + @workstring
/* second digit after decimal point */
    set @number = ROUND(@numberin, 1, 1)
	set @workstring = '' 	    
	set @worknumber = @numberin - @number
	set @worknumber = ROUND(@worknumber, 2, 1)  * 100  
    SELECT @workstring= Word FROM @Below10 WHERE ID=@worknumber
	set @NumberInWords  = @NumberInWords + '-'   + @workstring
	RETURN (@NumberInWords)
END
