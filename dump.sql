-- MySQL dump 10.16  Distrib 10.1.13-MariaDB, for Win32 (AMD64)
--
-- Host: localhost    Database: medical_system
-- ------------------------------------------------------
-- Server version	10.1.13-MariaDB

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `confident_doctor`
--

DROP TABLE IF EXISTS `confident_doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `confident_doctor` (
  `p_id` int(11) NOT NULL,
  `d_id` int(11) NOT NULL,
  `access` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`p_id`,`d_id`),
  KEY `d_id` (`d_id`),
  CONSTRAINT `confident_doctor_ibfk_1` FOREIGN KEY (`d_id`) REFERENCES `doctor` (`d_id`) ON DELETE CASCADE,
  CONSTRAINT `confident_doctor_ibfk_2` FOREIGN KEY (`p_id`) REFERENCES `patient` (`p_id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `confident_doctor`
--

LOCK TABLES `confident_doctor` WRITE;
/*!40000 ALTER TABLE `confident_doctor` DISABLE KEYS */;
INSERT INTO `confident_doctor` VALUES (701006,712410,'skin'),(701006,722810,'broken leg'),(701006,732610,'all'),(901003,833110,'all'),(901003,842812,'tooth'),(901003,853211,'cancer'),(911004,733010,'skeleton'),(911004,742910,'kidney'),(911004,812312,'all'),(911004,853211,'cancer'),(931002,723210,'all'),(931005,632411,'skin'),(931005,722310,'all'),(931005,732611,'all');
/*!40000 ALTER TABLE `confident_doctor` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 trigger insert_new_confident before insert on confident_doctor
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

end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `doctor`
--

DROP TABLE IF EXISTS `doctor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `doctor` (
  `d_id` int(11) NOT NULL,
  `d_name` varchar(20) NOT NULL,
  `expertise` varchar(10) NOT NULL,
  PRIMARY KEY (`d_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `doctor`
--

LOCK TABLES `doctor` WRITE;
/*!40000 ALTER TABLE `doctor` DISABLE KEYS */;
INSERT INTO `doctor` VALUES (632411,'kimiya arab','Dermatolog'),(712410,'sima zarandi','Dermatolog'),(722310,'ali akhavan','Cardiologi'),(722710,'sepideh pahlavan','Gynaecolog'),(722810,'saleh khosravi','Orthopaedi'),(723011,'kazem hedayat','Neurologis'),(723210,'ali janali','Oncologist'),(732610,'ali ahmadi','ENT'),(732611,'zahra namdar','ENT'),(733010,'samir heydari','Neurologis'),(742510,'behrouz ghodrati','Dentist'),(742910,'karim afshar','Urologist'),(792711,'hamide naderi','Gynaecolog'),(812311,'sadegh razavi','Cardiologi'),(812312,'kamran mowlayee','Cardiologi'),(812412,'saleh fayyaz','Dermatolog'),(812811,'farshid bagheri','Orthopaedi'),(833110,'ali mazaheri','nutrition'),(842511,'zeynab sotude','Dentist'),(842812,'sadegh rezvani','Orthopaedi'),(853211,'mahdi samiee','Oncologist'),(853212,'sadjad alaee','Oncologist'),(863012,'reza attaran','Neurologis'),(882712,'shima sadeghi','Gynaecolog');
/*!40000 ALTER TABLE `doctor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `insurance`
--

DROP TABLE IF EXISTS `insurance`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `insurance` (
  `i_name` varchar(10) NOT NULL,
  `address` varchar(50) NOT NULL,
  PRIMARY KEY (`i_name`),
  UNIQUE KEY `i_name` (`i_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `insurance`
--

LOCK TABLES `insurance` WRITE;
/*!40000 ALTER TABLE `insurance` DISABLE KEYS */;
INSERT INTO `insurance` VALUES ('asia','tehran, tehranpars'),('bahman','tehran, pirouzi'),('dana','tehran, gharb'),('hafez','tehran, pasdaran'),('iran','tehran, azadi'),('mellat','tehran, valiasr'),('mihan','tehran, niyavaran'),('novin','tehran, ferdowsi'),('saman','tehran, tajrish');
/*!40000 ALTER TABLE `insurance` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medical_history`
--

DROP TABLE IF EXISTS `medical_history`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `medical_history` (
  `p_id` int(11) DEFAULT NULL,
  `d_id` int(11) DEFAULT NULL,
  `visit_date` date NOT NULL,
  `medicine` varchar(8) NOT NULL,
  `doctor_recog` varchar(50) NOT NULL,
  `description` varchar(50) NOT NULL,
  `sickness_type` varchar(20) NOT NULL,
  KEY `p_id` (`p_id`),
  KEY `d_id` (`d_id`),
  KEY `sickness_type` (`sickness_type`),
  CONSTRAINT `medical_history_ibfk_1` FOREIGN KEY (`p_id`) REFERENCES `patient` (`p_id`),
  CONSTRAINT `medical_history_ibfk_2` FOREIGN KEY (`d_id`) REFERENCES `doctor` (`d_id`),
  CONSTRAINT `medical_history_ibfk_3` FOREIGN KEY (`sickness_type`) REFERENCES `sickness` (`general_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medical_history`
--

LOCK TABLES `medical_history` WRITE;
/*!40000 ALTER TABLE `medical_history` DISABLE KEYS */;
INSERT INTO `medical_history` VALUES (701006,732610,'2016-06-20','gika','use this cream every day','not too bad','skin'),(701006,732610,'2016-06-23','difen','3 times in a day with full stomache and rest','very bad','ENT'),(701006,732610,'2016-06-10','meta','use this cream every night','not bad','skin'),(701006,712410,'2016-06-29','kago','eat mornings','bad','skin'),(901003,833110,'2016-05-20','liten','use after restroom','not too bad','kidney'),(901003,853211,'2016-06-20','sinik','every day injection','not too bad','cancer'),(911004,812312,'2016-06-27','xefon','use this capsule every 2 day','not too bad','cold'),(911004,733010,'2016-06-25','xanax','eat every night','very bad','headache'),(931005,732611,'2016-06-23','difen','use this capsule every 2 day','not too bad','cold'),(701006,722810,'2016-09-19','cold','eat','bad','cold'),(931002,723210,'2016-06-25','tablet','eat','bad','cold');
/*!40000 ALTER TABLE `medical_history` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`127.0.0.1`*/ /*!50003 trigger doctor_insert_mh before insert on medical_history
for each row
begin
	if((new.d_id not in 
		(select d_id from confident_doctor where p_id = new.p_id)) and
			(SUBSTR(user() , 1, position("@" in user()) - 1)) = new.d_id) then
		CALL func_1();
	end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `patient`
--

DROP TABLE IF EXISTS `patient`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `patient` (
  `p_id` int(11) NOT NULL,
  `birth_date` varchar(10) NOT NULL,
  `gender` int(11) NOT NULL,
  `base_ins_name` varchar(10) NOT NULL,
  `supp_ins_name` varchar(10) NOT NULL,
  `edu_degree` varchar(10) NOT NULL,
  `job` varchar(10) NOT NULL,
  `address` varchar(20) NOT NULL,
  `geo_location` varchar(20) NOT NULL,
  `permition` int(11) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`p_id`),
  KEY `base_ins_name` (`base_ins_name`),
  KEY `supp_ins_name` (`supp_ins_name`),
  CONSTRAINT `patient_ibfk_1` FOREIGN KEY (`base_ins_name`) REFERENCES `insurance` (`i_name`) ON DELETE CASCADE,
  CONSTRAINT `patient_ibfk_2` FOREIGN KEY (`supp_ins_name`) REFERENCES `insurance` (`i_name`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `patient`
--

LOCK TABLES `patient` WRITE;
/*!40000 ALTER TABLE `patient` DISABLE KEYS */;
INSERT INTO `patient` VALUES (701006,'1382-11-09',1,'asia','asia','master','driver','ahvaz','south_west',0,'701006','samiyar kaviani'),(901003,'1385-06-09',0,'bahman','asia','diploma','shopper','mashhad','north_east',0,'901003','kamran vafa'),(911004,'1388-10-29',1,'hafez','novin','dphd','professor','tabriz','north_west',0,'911004','sadegh rezvani'),(921001,'1381-01-09',1,'saman','iran','diploma','lumberjack','ghom','center',0,'921001','ali salehi'),(931002,'1389-03-01',0,'saman','saman','diploma','house_wife','zabol','south_east',0,'931002','mahmoud alavi'),(931005,'1384-03-14',1,'mellat','novin','graduate','engineer','isfahan','center',0,'931005','karim ghahraman');
/*!40000 ALTER TABLE `patient` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sickness`
--

DROP TABLE IF EXISTS `sickness`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sickness` (
  `general_type` varchar(20) NOT NULL,
  `Security_level` int(11) NOT NULL,
  PRIMARY KEY (`general_type`),
  UNIQUE KEY `general_type` (`general_type`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sickness`
--

LOCK TABLES `sickness` WRITE;
/*!40000 ALTER TABLE `sickness` DISABLE KEYS */;
INSERT INTO `sickness` VALUES ('back',1),('blood',2),('Brain and neuronal s',2),('broken leg',1),('cancer',2),('cold',0),('ENT',1),('headache',0),('heart',2),('kidney',1),('nutrition',0),('skeleton',2),('skin',0),('tooth',0),('women',1);
/*!40000 ALTER TABLE `sickness` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping routines for database 'medical_system'
--
/*!50003 DROP PROCEDURE IF EXISTS `get_medicine` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_medicine`(in pa_id int)
begin
	select p_id,`name`,base_ins_name,supp_ins_name,d_id,medicine 
	from medical_history natural join patient 
	where p_id = pa_id
	order by visit_date desc limit 1;
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_percentage` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_percentage`(in input text)
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `get_statistics` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `get_statistics`()
begin
select general_type, security_level, medicine, doctor_recog, description, birth_date, 
		gender, base_ins_name, supp_ins_name, edu_degree, job, geo_location 
from medical_history as m natural join patient as p natural join sickness as s 
where( ((p.permition=1) or (s.security_level < 2)) and 
		s.general_type = m.sickness_type and p.p_id = m.p_id );
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `give_back_permition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `give_back_permition`()
begin
	update permition set permition=0 where 
	p_id=(SUBSTR(user() , 1, position("@" in user()) - 1));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `give_permition` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `give_permition`()
begin
	update permition set permition=1 where 
	p_id=(SUBSTR(user() , 1, position("@" in user()) - 1));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_doctor` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_doctor`(
in d_id int,
in d_name varchar(20),
in expertise varchar(10)
)
begin
	/*insert into doctor value
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

end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `insert_new_patient` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `insert_new_patient`(
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
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `see_my_confident_doctors` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `see_my_confident_doctors`()
begin
		select * from confident_doctors
		where ( p_id = (SUBSTR(user() , 1, position("@" in user()) - 1)));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `see_my_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `see_my_info`()
begin
	select *
	from patient
	where (p_id = (SUBSTR(user() , 1, position("@" in user()) - 1)) );
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `see_my_mh` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `see_my_mh`()
begin
		select * from medical_history
		where ( p_id = (SUBSTR(user() , 1, position("@" in user()) - 1)));
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `see_my_patients_info` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `see_my_patients_info`()
begin
	select p_id, `name`,gender, birth_date, base_ins_name, supp_ins_name
	from patient natural join confident_doctor
	where (d_id = (SUBSTR(user() , 1, position("@" in user()) - 1)) );
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `see_my_patients_mh` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8 */ ;
/*!50003 SET character_set_results = utf8 */ ;
/*!50003 SET collation_connection  = utf8_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `see_my_patients_mh`()
begin
		select p_id, `name`, visit_date, medicine, doctor_recog, description, sickness_type
		from patient natural join confident_doctor natural join medical_history
		where (
				d_id = (SUBSTR(user() , 1, position("@" in user()) - 1))
				and 
				(access = sickness_type or access = "all")
		);
end ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2016-06-28  0:38:39
