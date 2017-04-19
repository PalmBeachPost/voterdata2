use voters;
drop table if exists voterhistory;
create table voterhistory (
	county varchar(3),
	id int,
	electiondate date,
	electiontype varchar(3),
	historycode varchar(1)
);


alter table voterhistory partition by range(id) (
partition p100 values less than (100000000), partition p100b values less than (100500000),
partition p101 values less than (101000000), partition p101b values less than (101500000),
partition p102 values less than (102000000), partition p102b values less than (102500000),
partition p103 values less than (103000000), partition p103b values less than (103500000),
partition p104 values less than (104000000), partition p104b values less than (104500000),
partition p105 values less than (105000000), partition p105b values less than (105500000),
partition p106 values less than (106000000), partition p106b values less than (106500000),
partition p107 values less than (107000000), partition p107b values less than (107500000),
partition p108 values less than (108000000), partition p108b values less than (108500000),
partition p109 values less than (109000000), partition p109b values less than (109500000),
partition p110 values less than (110000000), partition p110b values less than (110500000),
partition p111 values less than (111000000), partition p111b values less than (111500000),
partition p112 values less than (112000000), partition p112b values less than (112500000),
partition p113 values less than (113000000), partition p113b values less than (113500000),
partition p114 values less than (114000000), partition p114b values less than (114500000),
partition p115 values less than (115000000), partition p115b values less than (115500000),
partition p116 values less than (116000000), partition p116b values less than (116500000),
partition p117 values less than (117000000), partition p117b values less than (117500000),
partition p118 values less than (118000000), partition p118b values less than (118500000),
partition p119 values less than (119000000), partition p119b values less than (119500000),
partition p120 values less than (120000000), partition p120b values less than (120500000),
partition p121 values less than (121000000), partition p121b values less than (121500000),
partition p122 values less than (122000000), partition p122b values less than (122500000),
partition p123 values less than (123000000), partition p123b values less than (123500000),
partition p124 values less than (124000000), partition p124b values less than (124500000),
partition p125 values less than (125000000), partition p125b values less than (125500000),
partition p126 values less than (126000000), partition p126b values less than (126500000),
partition p127 values less than (127000000), partition p127b values less than (127500000),
partition p128 values less than (128000000), partition p128b values less than (128500000),
partition p129 values less than (129000000), partition p129b values less than (129500000),
partition p130 values less than (130000000), partition p130b values less than (130500000),
partition p131 values less than (131000000), partition p131b values less than (131500000),
partition p132 values less than (132000000), partition p132b values less than (132500000),
partition p133 values less than (133000000), partition p133b values less than (133500000),
partition p134 values less than (134000000), partition p134b values less than (134500000),
partition premainder values less than (2147483647) );


load data local infile 'c:\\data\\voters\\fullhistory.csv' into table voterhistory
fields terminated by "," enclosed by '"' escaped by '"'
lines terminated by "\r\n"
ignore 1 lines;



drop table if exists luhistorycode;
create table luhistorycode (historycode varchar(1), text varchar(40));
insert into luhistorycode (historycode, text) VALUES 
("F","Provisional Ballot – Early Vote"),
("Z","Provisional Ballot – Vote at Poll"),
("A","Voted Absentee"),
("B", "Absentee Ballot NOT Counted"),
("E","Voted Early"),                                                                                         
("N","Did Not Vote (May not be filled in)"),
("P", "Provisional Ballot Not Counted"),                                                                     
("Y","Voted at Polls"),
(NULL, "Did Not Vote");                                                                                      



drop table if exists voterhistorytally;

create table voterhistorytally as
select ID, count(*) as NumberOfElections, group_concat(distinct(county)) as Counties
from voterhistory
group by 1;




-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
-- ---------------------------------------------------------------
-- ----------------------------------------------------------------- ---------------------------------------------------------------


use voters;

drop table if exists voters;

CREATE TABLE voters (
	county VARCHAR(3) NOT NULL, 
	id INTEGER NOT NULL, 
	last_name VARCHAR(33), 
	name_suffix VARCHAR(4), 
	first_name VARCHAR(28) NOT NULL, 
	middle_name VARCHAR(26), 
	res_address_suppress varchar(5), 
	res_address_line1 VARCHAR(50) NOT NULL, 
	res_address_line2 VARCHAR(50), 
	res_city VARCHAR(40) NOT NULL, 
	res_state VARCHAR(4), 
	res_zip VARCHAR(9) NOT NULL, 
	mail_address_line1 VARCHAR(50), 
	mail_address_line2 VARCHAR(50), 
	mail_address_line3 VARCHAR(50), 
	mail_city VARCHAR(40), 
	mail_state VARCHAR(4), 
	mail_zip VARCHAR(15), 
	mail_country VARCHAR(25), 
	gender VARCHAR(4), 
	race VARCHAR(6) NOT NULL, 
	birth_date DATE NOT NULL, 
	reg_date DATE NOT NULL, 
	party VARCHAR(3) NOT NULL, 
	precinct varchar(10), 
	precinct_group varchar(10), 
	`precinct_Split` varchar(10), 
	`precinct_Suffix` varchar(10), 
	status VARCHAR(3) NOT NULL, 
	`congressional_District` INTEGER NOT NULL, 
	`house_District` INTEGER NOT NULL, 
	`senate_District` INTEGER NOT NULL, 
	county_district INTEGER NOT NULL, 
	`school_District` INTEGER NOT NULL, 
	`area_Code` VARCHAR(4), 
	`phone_Number` VARCHAR(7), 
	dummy VARCHAR(4), 
	email VARCHAR(65), 
	CHECK (res_address_suppress IN (0, 1))
	)
	partition by list columns(county) (
partition Ala values in ("Ala"),
partition Bak values in ("Bak"),
partition Bay values in ("Bay"),
partition Bra values in ("Bra"),
partition Bre values in ("Bre"),
partition Bro values in ("Bro"),
partition Cal values in ("Cal"),
partition Cha values in ("Cha"),
partition Cit values in ("Cit"),
partition Cla values in ("Cla"),
partition Cll values in ("Cll"),
partition Clm values in ("Clm"),
partition Dad values in ("Dad"),
partition Des values in ("Des"),
partition Dix values in ("Dix"),
partition Duv values in ("Duv"),
partition Esc values in ("Esc"),
partition Fla values in ("Fla"),
partition Fra values in ("Fra"),
partition Gad values in ("Gad"),
partition Gil values in ("Gil"),
partition Gla values in ("Gla"),
partition Gul values in ("Gul"),
partition Ham values in ("Ham"),
partition Har values in ("Har"),
partition Hen values in ("Hen"),
partition Her values in ("Her"),
partition Hig values in ("Hig"),
partition Hil values in ("Hil"),
partition Hol values in ("Hol"),
partition Ind values in ("Ind"),
partition Jac values in ("Jac"),
partition Jef values in ("Jef"),
partition Laf values in ("Laf"),
partition Lak values in ("Lak"),
partition Lee values in ("Lee"),
partition Leo values in ("Leo"),
partition Lev values in ("Lev"),
partition Lib values in ("Lib"),
partition Mad values in ("Mad"),
partition Man values in ("Man"),
partition Mon values in ("Mon"),
partition Mrn values in ("Mrn"),
partition Mrt values in ("Mrt"),
partition Nas values in ("Nas"),
partition Oka values in ("Oka"),
partition Oke values in ("Oke"),
partition Ora values in ("Ora"),
partition Osc values in ("Osc"),
partition Pal values in ("Pal"),
partition Pas values in ("Pas"),
partition Pin values in ("Pin"),
partition Pol values in ("Pol"),
partition Put values in ("Put"),
partition San values in ("San"),
partition Sar values in ("Sar"),
partition Sem values in ("Sem"),
partition Stj values in ("Stj"),
partition Stl values in ("Stl"),
partition Sumter values in ("Sum"),
partition Suw values in ("Suw"),
partition Tay values in ("Tay"),
partition Uni values in ("Uni"),
partition Vol values in ("Vol"),
partition Wak values in ("Wak"),
partition Wal values in ("Wal"),
partition Was values in ("Was")
);


load data local infile 'c:\\data\\voters\\bigfile.csv' into table voters fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;

alter table voters add index (id), add index (res_city), add index (res_zip), add index `fluffynames` (last_name, first_name);

drop table if exists voterslocal;

create table voterslocal like voters;

insert into voterslocal select * from voters where voters.county in ("Stl", "Pal", "Mrt", "Bro");


drop table if exists regdateyearmo;
create table regdateyearmo as
select date_format(reg_date, "%Y-%m") as YearMo,
date_format(reg_date, "%Y") as YearOf,
date_format(reg_date, "%m") as MonthOf,
count(*) as NewlyRegistered,
sum(if(race="White", 1,0)) as Whites,
sum(if(race="Black", 1,0)) as Blacks,
sum(if(race="Hisp.", 1,0)) as Hispanics,
sum(if(party="Rep", 1,0)) as Republicans,
sum(if(party="Dem", 1,0)) as Democrats,
sum(if(party="Npa", 1,0)) as NPAs,
sum(if(party="Rep" and race="Hisp.", 1,0)) as HispReps,
sum(if(party="Dem" and race="Hisp.", 1,0)) as HispDems,
sum(if(gender="M", 1,0)) as Males,
sum(if(gender="F", 1,0)) as Females
from voters
group by 1 order by 1;

-- Monthly rank? Sort by month, then number of newly registered voters descending. Then:
-- =IF(C2=C1, K1+1, 1)

/*
select date_format(reg_date, "%Y-%m"),
count(*) as NewlyRegistered,
sum(if(race="White", 1,0)) as Whites,
sum(if(race="Black", 1,0)) as Blacks,
sum(if(race="Hisp.", 1,0)) as Hispanics,
sum(if(party="Rep", 1,0)) as Republicans,
sum(if(party="Dem", 1,0)) as Democrats,
sum(if(party="Npa", 1,0)) as NPAs
from `voters-201604`
group by 1 order by 1;

*/




-- Born in 1916:
-- drop table if exists b1916;# MySQL returned an empty result set (i.e. zero rows). create table b1916 AS select * from voters where year(birth_date)=1916 AND county="Pal";# 813 rows affected. 



/*
drop table if exists dmf;
create table dmf (
	ssn varchar(9),
	last_name varchar(20),
	suffix varchar(20),
	first_name varchar(15),
	middle_name varchar(15),
	vpcode varchar(1),
	death_month varchar(2),
	death_day varchar(2),
	death_year varchar(4),
	death_date varchar(12),
	birth_month varchar(2),
	birth_day varchar(2),
	birth_year varchar(4),
	dob varchar(12),
	state varchar(2),
	last_ZIP varchar(5),
	lump_zip varchar(6),
	flag varchar(3) 
);

-- alter table dmf add index fluffybunny (last_name, first_name, dob);


load data local infile "N:\\Publishing\\Audience\\Research\ Material\\Content\ Databases\\THE DEPARTED\\DMF1\\dmf_1.csv" into table dmf fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;	

load data local infile "N:\\Publishing\\Audience\\Research\ Material\\Content\ Databases\\THE DEPARTED\\DMF1\\dmf_2.csv" into table dmf fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;	
load data local infile "N:\\Publishing\\Audience\\Research\ Material\\Content\ Databases\\THE DEPARTED\\DMF1\\dmf_3.csv" into table dmf fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;	
load data local infile "N:\\Publishing\\Audience\\Research\ Material\\Content\ Databases\\THE DEPARTED\\DMF1\\dmf_4.csv" into table dmf fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;	
load data local infile "N:\\Publishing\\Audience\\Research\ Material\\Content\ Databases\\THE DEPARTED\\DMF1\\dmf_5.csv" into table dmf fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;	
load data local infile "N:\\Publishing\\Audience\\Research\ Material\\Content\ Databases\\THE DEPARTED\\DMF1\\dmf_6.csv" into table dmf fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;	
load data local infile "N:\\Publishing\\Audience\\Research\ Material\\Content\ Databases\\THE DEPARTED\\DMF1\\dmf_7.csv" into table dmf fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;	
load data local infile "N:\\Publishing\\Audience\\Research\ Material\\Content\ Databases\\THE DEPARTED\\DMF1\\dmf_8.csv" into table dmf fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;	
load data local infile "N:\\Publishing\\Audience\\Research\ Material\\Content\ Databases\\THE DEPARTED\\DMF1\\dmf_9.csv" into table dmf fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;	
load data local infile "N:\\Publishing\\Audience\\Research\ Material\\Content\ Databases\\THE DEPARTED\\DMF1\\dmf_10.csv" into table dmf fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;	

	
	
	
	
	load data local infile 'c:\\data\\voters\\state.csv' into table voters fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;
	
	
	
	
	
	SSN	Character	9	Social Security number
LNAME	Character	20	Last name
SUFFIX	Character	4	Name suffix
FNAME	Character	15	First name
MNAME	Character	15	Middle name
VPCODE	Character	1	Verify or Proof code
			V = (VERIFIED) REPORT VERIFIED WITH A FAMILY MEMBER OR SOMEONE ACTING ON BEHALF OF THE FAMILY
			P = (PROOF) DEATH CERTIFICATE OBSERVED
			"(SSA warns, though, that you still need to verify this yourself)"
DEATHMON	Character    	2	Month of death
DEATHDAY	Character    	2	Day of death
DEATHYEAR	Character    	4	Year of death
DEATHDATE	Date	8	NICAR-created field with date of death
BIRTHMON	Character	2	Month of birth
BIRTHDAY	Character	2	Day of birth
BIRTHYEAR	Character	4	Year of birth
DOB	Date	8	NICAR-created field with date of birth
STATE	Character	2	State (up through 2010)
LASTZIP	Character	5	Last residence ZIP Code (up to 11/2011)
LUMPZIP	Character	6	Lump sum payment ZIP Code (up to 11/2011)
flag	character	1	Record excluded from the most recent version if flag = "x"

	
*/

/*
drop table if exists newlynpaids;
create table newlynpaids as
select voters.id from voters, `voters-201505`
where voters.id=`voters-201505`.id
AND voters.party="Npa" and `voters-201505`.party<>"Npa";

SO SLOW


drop table if exists tempnew;
create table tempnew as select ID from voters where party="Npa";
drop table if exists tempold;
create table tempold as select ID from `voters-201505` where party <>"Npa";
drop table if exists newlynpaids;

-- Will this be faster? Should select from smaller table, no? Would expect more party folks... 
-- create table newlynpaids AS select tempnew.id from tempnew, tempold where tempnew.id NOT in (select id from tempold);
drop table if exists newlynpaids;
-- create table newlynpaids AS select tempold.id from tempold where tempold.id in (select id from tempnew);
-- select count(*) from newlynpaids;
-- Still so damn slow.

drop table if exists newlynpaids;
create table newlynpaids AS select tempold.id as oldid from tempold inner join tempnew  on tempnew.id=tempold.id;


drop table if exists tempnew;
drop table if exists tempold;








*/	
	
    
/*

*/

	
drop table if exists votersnew;
create table votersnew as select * from voters where reg_date >= "2016-01-01";

    
    
    
	


