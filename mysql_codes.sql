-- create database medical_system;
use medical_system;

Create table Sickness 
(
general_type varchar(20) not null unique,
Security_level int not null, -- 0 low, 1 medium, 2 high
Primary key (general_type)
);


Create table doctor 
(
d_id int, -- 6 digit
d_name varchar(20) not null,
expertise varchar(10) not null,
primary key (d_id)
);


create table insurance 
(
i_name varchar(10) unique not null,
address varchar(50) not null,
primary key (i_name)
);


create table patient 
(
p_id int, -- 6 digit
birth_date varchar(10) not null,
gender int not null, -- 1 for men, 0 for women
base_ins_name varchar(10) not null,
supp_ins_name varchar(10) not null,
edu_degree varchar(10) not null,
job varchar(10) not null,
address varchar(20) not null,
geo_location varchar(20) not null,
primary key (p_id),
foreign key (base_ins_name) references insurance(i_name) on delete cascade,
foreign key (supp_ins_name) references insurance(i_name) on delete cascade
);


create table medical_history 
(
h_id int,
p_id int,
d_id int,
visit_date date not null,
medicine varchar(8) not null,
doctor_recog varchar(50) not null,
description varchar(50) not null,
sickness_type varchar(20) not null,
foreign key (p_id) references patient(p_id),
foreign key (d_id) references doctor(d_id),
foreign key (sickness_type) references sickness(general_type)
);

-- remove a column h_id
alter table medical_history drop column h_id; 

create table confident_doctor 
(
p_id int,
d_id int,
primary key (p_id, d_id),
foreign key (d_id) references doctor(d_id) on delete cascade,
foreign key (p_id) references patient(p_id) on delete cascade
);

alter table confident_doctor add access varchar(255);

-- some data to insert into our database//

-- insurance insertion//
insert into insurance value 
("iran", "tehran, azadi"), 
("asia", "tehran, tehranpars"), 
("mellat","tehran, valiasr"), 
("novin", "tehran, ferdowsi"), 
("dana", "tehran, gharb"), 
("saman", "tehran, tajrish"), 
("mihan","tehran, niyavaran"), 
("hafez", "tehran, pasdaran"), 
("bahman", "tehran, pirouzi");

-- sickness insertion//
insert into sickness value 
("heart", 2), 
("cold", 0), 
("ENT", 1), 
("tooth", 0), 
("Brain and neuronal system", 2), 
("nutrition", 0), 
("back", 1), 
("skeleton", 2),
("blood", 2),
("kidney", 1),
("broken leg", 1),
("headache", 0),
("cancer", 2), 
("women", 1), 
("skin", 0);

-- alter a new column to patient for permition
alter table patient add permition int; -- 1 and 0

-- all the permition is zero at first
update patient set permition=0;

-- alter a new column to patient for password, by default it is p_id
alter table patient add `password` varchar(255);
update patient set password=p_id;

alter table patient add `name` varchar(255) not null;



-- stored procedure to insert new patient
delimiter $$

drop procedure if exists insert_new_patient $$

create definer=`root`@`localhost` procedure insert_new_patient 
(
in p_id int,
in `name` varchar(255),
in birth_date varchar(10),
in gender int,
in base_ins_name varchar(10),
in sup_ins_name varchar(10),
in edu_degree varchar(10),
in job varchar(10),
in address varchar(20),
in geo_location varchar(20),
in permition int,
in `password` varchar(255)
)
begin
	insert into patient value
	(p_id, birth_date, gender, base_ins_name, sup_ins_name, 
	edu_degree, job, address, geo_location, permition, `password`,`name`);
	
	set @create_user = CONCAT("
		CREATE USER '",p_id,"'@localhost IDENTIFIED BY '",`password`,"'"
		);
	PREPARE stmt FROM @create_user; EXECUTE stmt; DEALLOCATE PREPARE stmt;

	SET @grant_query = CONCAT('
    grant insert on medical_system.confident_doctor to "',p_id,'"@"localhost"');
	PREPARE stmt FROM @grant_query; EXECUTE stmt; DEALLOCATE PREPARE stmt;

	SET @grant_query = CONCAT('
    grant execute on procedure medical_system.see_my_info to "',p_id,'"@"localhost"');
	PREPARE stmt FROM @grant_query; EXECUTE stmt; DEALLOCATE PREPARE stmt;

	SET @grant_query = CONCAT('
    grant execute on procedure medical_system.see_my_confident_doctors to "',p_id,'"@"localhost"');
	PREPARE stmt FROM @grant_query; EXECUTE stmt; DEALLOCATE PREPARE stmt;

	SET @grant_query = CONCAT('
    grant execute on procedure medical_system.see_my_mh to "',p_id,'"@"localhost"');
	PREPARE stmt FROM @grant_query; EXECUTE stmt; DEALLOCATE PREPARE stmt;

	SET @grant_query = CONCAT('
    grant execute on procedure medical_system.give_permition to "',p_id,'"@"localhost"');
	PREPARE stmt FROM @grant_query; EXECUTE stmt; DEALLOCATE PREPARE stmt;
	
	SET @grant_query = CONCAT('
    grant execute on procedure medical_system.give_back_permition to "',p_id,'"@"localhost"');
	PREPARE stmt FROM @grant_query; EXECUTE stmt; DEALLOCATE PREPARE stmt;
end;$$
delimiter ;

-- some call to insert new patient
call insert_new_patient(
921001 ,"ali salehi", '1381-01-09', 1, "saman", "iran", "diploma",
 "lumberjack", "ghom","center", 0, "921001"
);
call insert_new_patient(
931002, "mahmoud alavi",'1389-03-01', 0, "saman", "saman", "diploma", 
"house_wife", "zabol","south_east", 0, "931002");
call insert_new_patient(
901003, "kamran vafa",'1385-06-09', 0, "bahman", "asia", "diploma", 
"shopper", "mashhad","north_east", 0, "901003");
call insert_new_patient
(911004,"sadegh rezvani", '1388-10-29', 1, "hafez", "novin", "dphd", 
"professor", "tabriz","north_west", 0, "911004");
call insert_new_patient
(931005, "karim ghahraman",'1384-03-14', 1, "mellat", "novin", "graduate", 
"engineer", "isfahan","center", 0, "931005");
call insert_new_patient
(701006, "samiyar kaviani",'1382-11-09', 1, "asia", "asia", "master", 
"driver", "ahvaz","south_west", 0, "701006");

-- procedure for give permition for patients
delimiter $$

drop procedure if exists give_permition $$
create definer=`root`@`localhost` procedure give_permition()
begin
	update permition set permition=1 where 
	p_id=(SUBSTR(user() , 1, position("@" in user()) - 1));
end$$
delimiter ;

-- procedure for give back permition for patients
delimiter $$

drop procedure if exists give_back_permition $$
create definer=`root`@`localhost` procedure give_back_permition()
begin
	update permition set permition=0 where 
	p_id=(SUBSTR(user() , 1, position("@" in user()) - 1));
end$$
delimiter ;


-- procedure for patients to see their patient info
delimiter $$

drop procedure if exists see_my_info $$
create definer=`root`@`localhost` procedure see_my_info()
begin
	select *
	from patient
	where (p_id = (SUBSTR(user() , 1, position("@" in user()) - 1)) );
end$$
delimiter ;


-- procedure for patients to see their own medical history
delimiter $$

drop procedure if exists see_my_mh $$
create definer=`root`@`localhost` procedure see_my_mh()
begin
		select * from medical_history
		where ( p_id = (SUBSTR(user() , 1, position("@" in user()) - 1)));
end$$
delimiter ;


-- procedure for patients to see their own confident_doctors
delimiter $$

drop procedure if exists see_my_confident_doctors $$
create definer=`root`@`localhost` procedure see_my_confident_doctors()
begin
		select * from confident_doctors
		where ( p_id = (SUBSTR(user() , 1, position("@" in user()) - 1)));
end$$
delimiter ;

-- stored procedure to insert new doctor
delimiter $$

drop procedure if exists insert_new_doctor $$

create definer=`root`@`localhost` procedure insert_new_doctor 
(
in d_id int,
in d_name varchar(20),
in expertise varchar(10)
)
begin
	insert into doctor value
	(d_id, d_name, expertise);
	
	set @create_user = CONCAT("
		CREATE USER '",d_id,"'@localhost IDENTIFIED BY '",d_id,"'"
		);
	PREPARE stmt FROM @create_user; EXECUTE stmt; DEALLOCATE PREPARE stmt;
	
	SET @grant_query = CONCAT('
    grant insert on medical_system.medical_history to "',d_id,'"@"localhost"');
	PREPARE stmt FROM @grant_query; EXECUTE stmt; DEALLOCATE PREPARE stmt;
	
	SET @grant_query = CONCAT('
    grant insert on medical_system.confident_doctor to "',d_id,'"@"localhost"');
	PREPARE stmt FROM @grant_query; EXECUTE stmt; DEALLOCATE PREPARE stmt;
	
	SET @grant_query = CONCAT('
    grant execute on procedure medical_system.see_my_patients_info to "',d_id,'"@"localhost"');
	PREPARE stmt FROM @grant_query; EXECUTE stmt; DEALLOCATE PREPARE stmt;
*/
	SET @grant_query = CONCAT('
    grant execute on procedure medical_system.see_my_patients_mh to "',d_id,'"@"localhost"');
	PREPARE stmt FROM @grant_query; EXECUTE stmt; DEALLOCATE PREPARE stmt;

end;$$
delimiter ;

-- some call to insert new doctors
call insert_new_doctor
(722310, "ali akhavan", "Cardiologist");-- 23 for Cardiologist(ghalb)
call insert_new_doctor
(812311, "sadegh razavi", "Cardiologist");
call insert_new_doctor
(812312, "kamran mowlayee", "Cardiologist");
call insert_new_doctor
(712410, "sima zarandi", "Dermatologist"); -- 24 for Dermatologist(poost)
call insert_new_doctor
(632411, "kimiya arab", "Dermatologist");
call insert_new_doctor
(812412, "saleh fayyaz", "Dermatologist");
call insert_new_doctor
(742510, "behrouz ghodrati", "Dentist"); -- 25 for Dentist
call insert_new_doctor
(842511, "zeynab sotude", "Dentist");
call insert_new_doctor
(732610, "ali ahmadi", "ENT"); -- 26 for ENT
call insert_new_doctor
(732611, "zahra namdar", "ENT");
call insert_new_doctor
(722710, "sepideh pahlavan", "Gynaecologist"); -- 27 for Gynaecologist(zanan)
call insert_new_doctor
(792711, "hamide naderi", "Gynaecologist");
call insert_new_doctor
(882712, "shima sadeghi", "Gynaecologist");
call insert_new_doctor
(722810, "saleh khosravi", "Orthopaedist"); -- 28 for Orthopaedist
call insert_new_doctor
(812811, "farshid bagheri", "Orthopaedist"); 
call insert_new_doctor
(842812, "sadegh rezvani", "Orthopaedist");
call insert_new_doctor
(742910, "karim afshar", "Urologist"); -- 29 for Urologist
call insert_new_doctor
(733010, "samir heydari", "Neurologist"); -- 30 for Neurologist
call insert_new_doctor
(723011, "kazem hedayat", "Neurologist");
call insert_new_doctor
(863012, "reza attaran", "Neurologist");
call insert_new_doctor
(833110, "ali mazaheri", "nutrition"); -- 31 for nutrition
call insert_new_doctor
(723210, "ali janali", "Oncologist"); -- 32 for Oncologist(cancer)
call insert_new_doctor
(853211, "mahdi samiee", "Oncologist");
call insert_new_doctor
(853212, "sadjad alaee", "Oncologist");


-- procedure for doctors to see their patient info
delimiter $$

drop procedure if exists see_my_patients_info $$
create definer=`root`@`localhost` procedure see_my_patients_info()
begin
	select p_id, `name`,gender, birth_date, base_ins_name, supp_ins_name
	from patient natural join confident_doctor
	where (d_id = (SUBSTR(user() , 1, position("@" in user()) - 1)) );
end$$
delimiter ;


-- procedure for doctors to see their patient medical history  not true
delimiter $$

drop procedure if exists see_my_patients_mh $$
create definer=`root`@`localhost` procedure see_my_patients_mh()
begin
		select p_id, `name`, visit_date, medicine, doctor_recog, description, sickness_type
		from patient natural join confident_doctor natural join medical_history
		where (
				d_id = (SUBSTR(user() , 1, position("@" in user()) - 1))
				and 
				(access = sickness_type or access = "all")
		);
end$$
delimiter ;




-- triggers before insert new medical history
delimiter $$

drop trigger if exists doctor_insert_mh $$
create trigger doctor_insert_mh before insert on medical_history
for each row
begin
	if((new.d_id not in 
		(select d_id from confident_doctor where p_id = new.p_id)) and
			(SUBSTR(user() , 1, position("@" in user()) - 1)) = new.d_id) then
		CALL func_1();
	end if;
end$$
delimiter ;


-- trigger for updating permition  not true
delimiter $$

drop trigger if exists update_permition $$

create trigger update_permition before update on patient
for each row
begin
	if((SUBSTR(user() , 1, position("@" in user()) - 1)) != old.p_id) then
		CALL func_1();
	end if;
end;$$
delimiter ;


-- trigger for inserting new confident_doctor
delimiter $$

drop trigger if exists insert_new_confident $$

create trigger insert_new_confident before insert on confident_doctor
for each row
begin
if (((select count(p_id) from confident_doctor where p_id=new.p_id)>=1)
		and (SUBSTR(user() , 1, position("@" in user()) - 1)) in 
		(select p_id from patient)) then
  CALL func_1();
elseif( (SUBSTR(user(), 1, position("@" in user()) - 1)) not in 
			(select d_id from confident_doctor where p_id=new.p_id) 
		and (SUBSTR(user(), 1, position("@" in user()) - 1)) in 
			(select d_id from doctor)) then
  CALL func_1();
end if;

end;$$
delimiter ;


-- store procedure to see medical history statistics for ministry
delimiter $$

drop procedure if exists get_statistics $$

create definer=`root`@`localhost` procedure get_statistics()
begin
select general_type, security_level, medicine, doctor_recog, description, birth_date, 
		gender, base_ins_name, supp_ins_name, edu_degree, job, geo_location 
from medical_history as m natural join patient as p natural join sickness as s 
where( ((p.permition=1) or (s.security_level < 2)) and 
		s.general_type = m.sickness_type and p.p_id = m.p_id );
end;$$
delimiter ;


-- store procedure to see medicine for drugstore
delimiter $$

drop procedure if exists get_medicine $$

create definer=`root`@`localhost` procedure get_medicine(in pa_id int)
begin
	select p_id,`name`,base_ins_name,supp_ins_name,d_id,medicine 
	from medical_history natural join patient 
	where p_id = pa_id
	order by visit_date desc limit 1;
end;$$
delimiter ;

-- store procedure to see percentage for researcher
delimiter $$

drop procedure if exists get_percentage $$

create definer=`root`@`localhost` procedure get_percentage(in input text)
begin
	if(input='gender') then
		select sickness_type ,gender,t*100/c as precentage from(
			select sickness_type,gender,c,count(gender) as t
			from medical_history natural join patient natural join (
				select sickness_type,count(sickness_type) as c
				from medical_history
				group by sickness_type) as m
			group by sickness_type,gender) as r;
	 elseif (input='job')then
		select sickness_type ,job,t*100/c as precentage from(
			select sickness_type,job,c,count(job) as t
			from medical_history natural join patient natural join (
				select sickness_type,count(sickness_type) as c
				from medical_history
				group by sickness_type) as m
			group by sickness_type,job) as r;
	elseif (input='address') then
		select sickness_type ,address,t*100/c as precentage from(
			select sickness_type,address,c,count(address) as t
			from medical_history natural join patient natural join (
				select sickness_type,count(sickness_type) as c
				from medical_history
				group by sickness_type) as m
			group by sickness_type,address) as r;
	 elseif(input='geo')then
		select sickness_type ,geo_location,t*100/c as precentage from(
			select sickness_type,geo_location,c,count(geo_location) as t
			from medical_history natural join patient natural join (
				select sickness_type,count(sickness_type) as c
				from medical_history
				group by sickness_type) as m
			group by sickness_type,geo_location) as r;
	end if;
end;$$
delimiter ;


-- users of program

-- I)drugstore
create user 'drugstore'@'localhost' identified by 'drugstore';
GRANT EXECUTE ON PROCEDURE medical_system.get_medicine TO 'drugstore'@'localhost';

-- II)ministry
create user 'ministry'@'localhost' identified by 'ministry';
GRANT EXECUTE ON PROCEDURE medical_system.get_statistics TO 'ministry'@'localhost';

-- III)researcher
create user 'researcher'@'localhost' identified by 'researcher';
GRANT EXECUTE ON PROCEDURE medical_system.get_percentage TO 'researcher'@'localhost';
