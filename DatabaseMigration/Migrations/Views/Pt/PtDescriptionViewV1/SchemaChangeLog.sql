--liquibase formatted sql

--changeset system:create-alter-view-PtDescriptionViewV1 context:any labels:c-any,o-view,ot-schema,on-PtDescriptionViewV1,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view PtDescriptionViewV1
CREATE OR ALTER VIEW dbo.PtDescriptionViewV1 AS
Select 
a.Id, 
a.HdPendingChanges,
a.HdPendingSubChanges, 
a.HdVersionNo,
a.Partnerno,
a.PartnernoEdited,
a.DateOfBirth,
A.firstname,
a.name,
a.namecont,
a.legalstatusno,
A.SexStatusNo,
A.TerminationDate,
case 
	when	b.ForLegalPartner = 1 and a.legalstatusno not in (20 ,33)
		then 
		/* Juristische Person , kein Konkubinat, keine Ergbemeinschaft */
		a.Name   + isnull(' '+a.namecont,'') + IsNull (', mit Sitz in ' + D.Zip + ' ' + D.Town + ', ' + d.street + ' ' + D.houseno,'')
	when	a.legalstatusno in (33,35,36,2) and (sexstatusno > 2) and (2 = (select count(*) from 
			coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno and relationroleno is not null))
		then 
		/* Konkubinat mit Joint Account mit genau zwei Partnern*/
			case
				/* gleiche Adresse ? */
				when
					( (select
						D9.Zip + ' ' + D9.Town	+ IsNull(rtrim(d9.street) + ' ' + d9.houseno,'')
					 from PtAddress as D9 where d9.PartnerId = (select top (1) memberid from 
           					coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno and relationroleno is not null order by partnerno asc)
					 And D9.AddressTypeNo = 11)
					 = 
					(select 
						D8.Zip + ' ' + D8.Town	+ IsNull(rtrim(d8.street) + ' ' + d8.houseno,'')
					from PtAddress as D8 where d8.PartnerId = (select top (1) memberid from 
           					coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno and relationroleno is not null order by partnerno desc)
					 And D8.AddressTypeNo = 11))
					then
					/* haben gleiche Adresse */
					/* gleicher Nachname ? */
						case
							when
								((select
									A1.Name
								 from ptbase as A1 where A1.id = (select top (1) memberid from 
		           					coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno and
									relationroleno is not null order by partnerno asc) )
								 = 
								(select 
									a2.name
								from ptbase as a2 where a2.Id = (select top (1) memberid from 
           							coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno and 
									relationroleno is not null order by partnerno desc  )))
							then
							/* gleiche Name man zuerst */
								(select
 								A1.Name  + isnull(' '+a1.namecont,'') + ' ' + A1.FirstName + isnull(' '+a1.title,'')  + ' und '
								 from ptbase as A1 where A1.id = (select top (1) memberid from 
		           					coengcliview where relationtypeno = 10 and 
									masterpartnerno = a.Partnerno and relationroleno is not null order by sexstatusno desc,partnerno desc)) 
		           					+  
								(select
 								A2.FirstName + isnull(' '+a2.title,'')  + ', in '
								 from ptbase as A2 where A2.id = (select top (1) memberid from 
		           					coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno 
									and relationroleno is not null order by sexstatusno asc, partnerno asc)) 
								 + 
								(select
								D9.Zip + ' ' + D9.Town	+ IsNull(', ' + rtrim(d9.street) + ' ' + d9.houseno,'')
								 from PtAddress as D9 where d9.PartnerId = (select top (1) memberid from 
           								coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno 
										and relationroleno is not null order by sexstatusno asc, partnerno asc)
					 				And D9.AddressTypeNo = 11)
							else
							/* ungleicher Name mit gleicher Adresse*/
								(select
       							A1.Name  + isnull(' '+a1.namecont,'') + ' ' + A1.FirstName  + isnull(' '+a1.title,'')  + ' und ' 
								 from ptbase as A1 where A1.id = (select top (1) memberid from 
		           					coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno 
									and relationroleno is not null order by sexstatusno desc,partnerno desc) )
		           					+  
								(select
									A2.Name  +isnull(' '+a2.namecont,'') + ' ' + A2.FirstName  + isnull(' '+a2.title,'')  + ', in '
								 from ptbase as A2 where A2.id = (select top (1) memberid from 
		           					coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno 
									and relationroleno is not null order by sexstatusno asc, partnerno asc) )
								 + 
								  (select
								D9.Zip + ' ' + D9.Town	+ IsNull(', ' + rtrim(d9.street) + ' ' + d9.houseno,'')
								 from PtAddress as D9 where d9.PartnerId = (select TOP (1) memberid from 
           								coengcliview where relationtypeno = 10 and
										 masterpartnerno = a.Partnerno and relationroleno is not null order by sexstatusno asc, partnerno asc)
					 				And D9.AddressTypeNo = 11 )
									
						end	

				else
				/* ungleiche Adresse, Name egal, Man zuerst */
	
								(select
 								A1.Name  + isnull(' '+a1.namecont,'') + ' ' + A1.FirstName  + isnull(' '+a1.title,'')  + ', in '
								 from ptbase as A1 where A1.id = (select top (1) memberid from 
		           					coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno
									 and relationroleno is not null order by sexstatusno desc,partnerno desc)) 
															 +
										
								 (select
								D9.Zip + ' ' + D9.Town	+ IsNull(', ' + rtrim(d9.street) + ' ' + d9.houseno,'') + ' und ' 
								 from PtAddress as D9 where D9.AddressTypeNo = 11 and d9.PartnerId = 
								 (select top (1) memberid from 
           								coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno 
										and relationroleno is not null order by sexstatusno desc,partnerno desc))
		           				
								+
								(select
							
 								A2.Name  + isnull(' '+a2.namecont,'') + ' ' + A2.FirstName  + isnull(' '+a2.title,'')  + ', in '
								 from ptbase as A2 where A2.id = (select top (1) memberid from 
		           					coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno 
									and relationroleno is not null order by sexstatusno asc, partnerno asc) )

								 + 
							
								  (select
								D8.Zip + ' ' + D8.Town	+ IsNull(', ' + rtrim(d8.street) + ' ' + d8.houseno,'')
								 from PtAddress as D8 where D8.AddressTypeNo = 11 and d8.PartnerId = 
								 (select top (1) memberid from 
           								coengcliview where relationtypeno = 10 and masterpartnerno = a.Partnerno 
										and relationroleno is not null order by sexstatusno asc, partnerno asc))
			end
	else 
		/*    'andere' Natürliche Person oder Anonym (nicht gebraucht) oder Ehe / eingetragene Partnerschaft (SexStatusNo > 2) 
			oder Erbengemeinschaft Legalstatusno = 20* oder gesamthand Konkubinat*/
	case  
		when 	sexStatusno in (3,4)
			then  
			/* Organisation oder VV Kunde */
        		IsNull(D.ReportAdrLine,IsNull(A.FirstName + ' ','') + IsNull(A.Name,'') + isnull(' '+a.namecont,'') + ' ' + IsNull(D.Town,''))  
		when 	sexStatusno in (5)    
			then  
			/* Ehepaar */
        		IsNull(D.ReportAdrLine,IsNull(A.Name + ' ','') + isnull(a.namecont+' ','') + IsNull(A.FirstName,'') + IsNull(', in ' + D.Zip + ' ' + D.Town,'')) 
         		+ IsNull(', ' + rtrim(d.street) + ' ' + d.houseno,'')
		else      
		/* Man oder Frau  kein Geburtstag und kein Heimatort*/
		        a.Name + isnull(' '+a.namecont,'') + ' ' + IsNull(a.FirstName,'') + isnull(' '+a.title,'')  +
				/* IsNull(', geb. ' + convert (nchar (10),a.DateOfBirth,104)
    			    ,'') + ISNULL(',von ' + (select top (1)
      				  AsSwissTownView.Town from pthomeplace,AsSwissTownView where 
    			    pthomeplace.PartnerId = a.Id and AsSwissTownView.SwissTownNo = pthomeplace.SwissTownNo and
     			   (DateOfHomeplace IS NULL OR DateOfHomeplace <= GETDATE())),'')
     		    + */
			IsNull(', in ' + D.Zip + ' ' + D.Town + ', ' + rtrim(d.street) + ' ' + d.houseno,'')
    end  
end 
as PtDescriptionLong,
/* aus orginal aus PTDescriptionView*/
    a.PartnerNoEdited + ' ' + IsNull(D.ReportAdrLine,IsNull(A.FirstName + ' ','') + IsNull(A.Name,'') + ' ' + IsNull(D.Town,''))  
as PtDescription
From ptbase as a 
Left join ptlegalstatus as b
   on b. legalstatusno = a.legalstatusno
LEFT OUTER JOIN PtAddress as D
   ON A.Id = d.PartnerId And D.AddressTypeNo = 11

