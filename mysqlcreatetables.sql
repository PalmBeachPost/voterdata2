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
	email VARCHAR(45), 
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
partition Summ values in ("Sum"),
partition Suw values in ("Suw"),
partition Tay values in ("Tay"),
partition Uni values in ("Uni"),
partition Vol values in ("Vol"),
partition Wak values in ("Wak"),
partition Wal values in ("Wal"),
partition Was values in ("Was")
);

-- load data local infile 'c:\\temp\\florida.csv' into table votersfl fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;

load data local infile 'c:\\data\\voters\\state.csv' into table voters fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;
-- 1521601 warnings, maybe mostly on birth_date?


-- load data local infile 'c:\\data\\voters\\slice.csv' into table votersfl fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;

alter table voters add index (id), add index (res_city), add index (res_zip), add index `fluffynames` (last_name, first_name);

drop table if exists voterslocal;

create table voterslocal like voters;

insert into voterslocal select * from voters where voters.county in ("Stl", "Pal", "Mrt", "Bro");

-- drop table if exists temp;
-- create table temp AS SELECT case_no from lookup where potonly="Y" and myyear in (2008, 2009, 2010, 2011, 2012);

-- SELECT case_no from lookup where potonly="Y" and myyear in (2008, 2009, 2010, 2011, 2012);

/*
drop table if exists temp;

create table temp AS
select mail_country, count(*) from votersfl
group by 1 order by 2 desc;



drop table if exists temp;
create table temp like votersfl;

load data local infile 'c:\\data\\voters\\bigfile.csv' into table temp fields terminated by "," enclosed by '"' escaped by '"' lines terminated by "\r\n" ignore 1 lines;


*/


-- Max: select maximum(id) from voters;
-- 122844558
-- 100000003 min
-- 104000000

use voters;
drop table if exists voterhistory;
create table voterhistory (
	county varchar(3),
	id int,
	electiondate date,
	electiontype varchar(3),
	historycode varchar(1)
);

alter table voterhistory add index (id);
alter table voterhistory partition by range (id) (
	partition p02 values less than (102000000),
	partition p04 values less than (104000000),
	partition p06 values less than (106000000),
	partition p08 values less than (108000000),
	partition p10 values less than (110000000),
	partition p12 values less than (112000000),
	partition p14 values less than (114000000),
	partition p16 values less than (116000000),
	partition p18 values less than (118000000),
	partition p20 values less than (120000000),
	partition p22 values less than (122000000),
	partition p24 values less than (124000000),
	partition p26 values less than (126000000),
	partition p28 values less than (128000000),
	partition p30 values less than (130000000),
	partition premainder values less than (2147483647)
);



load data local infile 'c:\\data\\voters\\fullhistory.csv' into table voterhistory
fields terminated by "," enclosed by '"' escaped by '"'
lines terminated by "\r\n"
ignore 1 lines;




