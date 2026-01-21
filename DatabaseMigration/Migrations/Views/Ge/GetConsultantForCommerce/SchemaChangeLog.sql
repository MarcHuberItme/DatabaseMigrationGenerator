--liquibase formatted sql

--changeset system:create-alter-view-GetConsultantForCommerce context:any labels:c-any,o-view,ot-schema,on-GetConsultantForCommerce,fin-13659 runOnChange:true splitStatements:false stripComments:false endDelimiter:GO
--comment: Create view GetConsultantForCommerce
CREATE OR ALTER VIEW dbo.GetConsultantForCommerce AS
SELECT 	pb.Id As PartnerId, pb.mgsachb, pb.ConsultantTeamName, 
        IsNull(cons.UserName, 'HBL_NT\mca') As UserName, 
        CASE 
            WHEN cons.UserName IS NULL THEN 'Caspar Markus' 
            ELSE cons.UserFullName 
        END As UserFullName,
        cons.Abteilung, 
        cons.Benutzergruppe,
        cons.Description
        
FROM 	PtBase pb
   LEFT OUTER JOIN 

   (SELECT au.username as UserName, au.fullname as UserFullName, au.department as Abteilung,
	aug.usergroupname as Benutzergruppe, aug.description
	
    FROM  AsUserGroup aug 
       Join AsUserGroupMember augm on aug.usergroupname = augm.usergroupname 
       Join AsRoleAssignment ara on ara.usergroupmemberid = augm.id 
       Join AsUser au on au.id = augm.userid 
	
    WHERE ara.RoleName = 'Kommerz-Bearbeitung Firmen 1'
       and aug.hdversionno between 1 and 999999998
       and augm.hdversionno between 1 and 999999998
       and au.hdversionno between 1 and 999999998
       and ara.hdversionno between 1 and 999999998) As Cons

    on Cast(pb.ConsultantTeamName As Varchar(3)) = cons.Benutzergruppe
    



