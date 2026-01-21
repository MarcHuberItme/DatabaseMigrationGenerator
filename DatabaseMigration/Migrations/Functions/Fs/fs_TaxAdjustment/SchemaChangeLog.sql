--liquibase formatted sql

--changeset system:create-alter-function-fs_TaxAdjustment context:any labels:c-any,o-function,ot-schema,on-fs_TaxAdjustment,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create function fs_TaxAdjustment
CREATE OR ALTER FUNCTION dbo.fs_TaxAdjustment
(@bln bit,@Amount money,@Correction money,@Adjustment money)
RETURNS Money
AS
Begin
	 Return(Case when (@bln = 1) then @Correction
	                      when (@bln = 0) then  @Amount + @Correction + @Adjustment
	             End) 
end 
	

	

	
