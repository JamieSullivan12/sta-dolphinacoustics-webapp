-- MariaDB dump 10.19-11.3.2-MariaDB, for debian-linux-gnu (x86_64)
--
-- Host: localhost    Database: test_database
-- ------------------------------------------------------
-- Server version	11.3.2-MariaDB-1:11.3.2+maria~ubu2204

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `data_source`
--

DROP TABLE IF EXISTS `data_source`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `data_source` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `name` varchar(255) NOT NULL,
  `phone_number1` varchar(20) DEFAULT NULL,
  `phone_number2` varchar(20) DEFAULT NULL,
  `email1` varchar(255) NOT NULL,
  `email2` varchar(255) DEFAULT NULL,
  `address` text DEFAULT NULL,
  `notes` text DEFAULT NULL,
  `type` enum('person','organisation') DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`,`email1`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `data_source`
--

LOCK TABLES `data_source` WRITE;
/*!40000 ALTER TABLE `data_source` DISABLE KEYS */;
INSERT INTO `data_source` VALUES
('b57ea826-26a2-11ef-9e2c-00155d747785','John Doe','','','johndoe@icloud.com','','','','person');
/*!40000 ALTER TABLE `data_source` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `encounter`
--

DROP TABLE IF EXISTS `encounter`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `encounter` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `encounter_name` varchar(100) NOT NULL,
  `location` varchar(100) NOT NULL,
  `species_id` uuid NOT NULL,
  `origin` varchar(100) DEFAULT NULL,
  `longitude` varchar(20) DEFAULT NULL,
  `latitude` varchar(20) DEFAULT NULL,
  `notes` varchar(1000) DEFAULT NULL,
  `date_received` date DEFAULT NULL,
  `data_source_id` uuid DEFAULT NULL,
  `recording_platform_id` uuid DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `encounter_name` (`encounter_name`,`location`),
  KEY `species_id` (`species_id`),
  KEY `data_source_id` (`data_source_id`),
  KEY `recording_platform_id` (`recording_platform_id`),
  CONSTRAINT `encounter_ibfk_1` FOREIGN KEY (`species_id`) REFERENCES `species` (`id`),
  CONSTRAINT `encounter_ibfk_2` FOREIGN KEY (`data_source_id`) REFERENCES `data_source` (`id`),
  CONSTRAINT `encounter_ibfk_3` FOREIGN KEY (`recording_platform_id`) REFERENCES `recording_platform` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `encounter`
--

LOCK TABLES `encounter` WRITE;
/*!40000 ALTER TABLE `encounter` DISABLE KEYS */;
INSERT INTO `encounter` VALUES
('927f282b-5430-49b8-886f-b8236efa6dee','s125','Hawaii','c9e03621-0333-46c1-9c2c-429d5c5a6b25',NULL,'4','2',NULL,NULL,NULL,NULL);
/*!40000 ALTER TABLE `encounter` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `file`
--

DROP TABLE IF EXISTS `file`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `file` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `path` text NOT NULL,
  `filename` varchar(255) NOT NULL,
  `extension` varchar(10) NOT NULL,
  `uploaded_date` datetime DEFAULT NULL,
  `uploaded_by` varchar(100) DEFAULT NULL,
  `duration` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Table structure for table `recording`
--

DROP TABLE IF EXISTS `recording`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recording` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `start_time` datetime NOT NULL,
  `duration` int(11) DEFAULT NULL,
  `recording_file_id` uuid DEFAULT NULL,
  `selection_table_file_id` uuid DEFAULT NULL,
  `encounter_id` uuid NOT NULL,
  `ignore_selection_table_warnings` tinyint(1) NOT NULL DEFAULT 0,
  `user_id` uuid DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_time_encounter_id` (`start_time`,`encounter_id`),
  KEY `fk_encounter_id` (`encounter_id`),
  KEY `fk_recording_file_id` (`recording_file_id`),
  KEY `fk_selection_table_file_id` (`selection_table_file_id`),
  KEY `fk_user_id` (`user_id`),
  CONSTRAINT `fk_encounter_id` FOREIGN KEY (`encounter_id`) REFERENCES `encounter` (`id`),
  CONSTRAINT `fk_recording_file_id` FOREIGN KEY (`recording_file_id`) REFERENCES `file` (`id`),
  CONSTRAINT `fk_selection_table_file_id` FOREIGN KEY (`selection_table_file_id`) REFERENCES `file` (`id`),
  CONSTRAINT `fk_user_id` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`)
) WITH SYSTEM VERSIONING ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb3 */ ;
/*!50003 SET character_set_results = utf8mb3 */ ;
/*!50003 SET collation_connection  = utf8mb3_general_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'STRICT_TRANS_TABLES,ERROR_FOR_DIVISION_BY_ZERO,NO_AUTO_CREATE_USER,NO_ENGINE_SUBSTITUTION' */ ;
-- Trigger for INSERT operation
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER recording_insert_audit_trigger
AFTER INSERT ON recording
FOR EACH ROW
BEGIN
  INSERT INTO recording_audit (created_at, updated_at, action, record_id, start_time_new, duration_new, recording_file_id_new, selection_table_file_id_new, encounter_id_new, user_id_new)
  VALUES (UTC_TIMESTAMP(), UTC_TIMESTAMP(), 'INSERT', NEW.id, NEW.start_time, NEW.duration, NEW.recording_file_id, NEW.selection_table_file_id, NEW.encounter_id, NEW.user_id);
END */;;
DELIMITER ;

-- Trigger for UPDATE operation
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER recording_update_audit_trigger
AFTER UPDATE ON recording
FOR EACH ROW
BEGIN
  IF NEW.start_time <> OLD.start_time OR NEW.duration <> OLD.duration OR NEW.recording_file_id <> OLD.recording_file_id OR NEW.selection_table_file_id <> OLD.selection_table_file_id OR NEW.encounter_id <> OLD.encounter_id OR NEW.user_id <> OLD.user_id THEN
    INSERT INTO recording_audit (created_at, updated_at, action, record_id, start_time_new, duration_new, recording_file_id_new, selection_table_file_id_new, encounter_id_new, user_id_new, start_time_new, duration_new, recording_file_id_new, selection_table_file_id_new, encounter_id_new, user_id_new)
    VALUES (UTC_TIMESTAMP(), UTC_TIMESTAMP(), 'UPDATE', NEW.id, OLD.start_time, OLD.duration, OLD.recording_file_id, OLD.selection_table_file_id, OLD.encounter_id, OLD.user_id, NEW.start_time, NEW.duration, NEW.recording_file_id, NEW.selection_table_file_id, NEW.encounter_id, NEW.user_id);
  END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `recording_audit`
--

DROP TABLE IF EXISTS `recording_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recording_audit` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `action` varchar(50) NOT NULL,
  `record_id` uuid NOT NULL,
  `start_time_new` datetime DEFAULT NULL,
  `duration_new` int(11) DEFAULT NULL,
  `recording_file_id_new` uuid DEFAULT NULL,
  `selection_table_file_id_new` uuid DEFAULT NULL,
  `encounter_id_new` uuid DEFAULT NULL,
  `user_id_new` uuid DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_record_id` (`record_id`),
  CONSTRAINT `fk_record_id` FOREIGN KEY (`record_id`) REFERENCES `recording` (`id`),
  KEY `fk_encounter_id_new` (`encounter_id_new`),
  KEY `fk_recording_file_id_new` (`recording_file_id_new`),
  KEY `fk_selection_table_file_id_new` (`selection_table_file_id_new`),
  KEY `fk_user_id_new` (`user_id_new`),
  CONSTRAINT `fk_encounter_id_new` FOREIGN KEY (`encounter_id_new`) REFERENCES `encounter` (`id`),
  CONSTRAINT `fk_recording_file_id_new` FOREIGN KEY (`recording_file_id_new`) REFERENCES `file` (`id`),
  CONSTRAINT `fk_selection_table_file_id_new` FOREIGN KEY (`selection_table_file_id_new`) REFERENCES `file` (`id`),
  CONSTRAINT `fk_user_id_new` FOREIGN KEY (`user_id_new`) REFERENCES `user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

CREATE TABLE audit (
    id INT PRIMARY KEY,
    created_at DATETIME,
    updated_at DATETIME,
    action VARCHAR(50)
);

--
-- Table structure for table `recording_platform`
--

DROP TABLE IF EXISTS `recording_platform`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `recording_platform` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `name` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `unique_name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `recording_platform`
--

LOCK TABLES `recording_platform` WRITE;
/*!40000 ALTER TABLE `recording_platform` DISABLE KEYS */;
INSERT INTO `recording_platform` VALUES
('abcb35ce-26a2-11ef-9e2c-00155d747785','Hydrophone array'),
('4d89dceb-2831-11ef-894c-00155d7478d9','Recording Station');
/*!40000 ALTER TABLE `recording_platform` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `role`
--

DROP TABLE IF EXISTS `role`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `role` (
  `id` int(11) NOT NULL,
  `name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `role`
--

LOCK TABLES `role` WRITE;
/*!40000 ALTER TABLE `role` DISABLE KEYS */;
INSERT INTO `role` VALUES
(2,'Database Administrator'),
(3,'General User'),
(1,'System Administrator'),
(4,'View Only');
/*!40000 ALTER TABLE `role` ENABLE KEYS */;
UNLOCK TABLES;



--
-- Table structure for table `selection`
--

DROP TABLE IF EXISTS `selection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `selection` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `selection_number` int(11) NOT NULL,
  `selection_file_id` uuid NOT NULL,
  `recording_id` uuid NOT NULL,
  `contour_file_id` uuid DEFAULT NULL,
  `freq_max` float DEFAULT NULL,
  `freq_min` float DEFAULT NULL,
  `duration` float DEFAULT NULL,
  `freq_begin` float DEFAULT NULL,
  `freq_end` float DEFAULT NULL,
  `freq_range` float DEFAULT NULL,
  `dc_mean` float DEFAULT NULL,
  `dc_standarddeviation` float DEFAULT NULL,
  `freq_mean` float DEFAULT NULL,
  `freq_standarddeviation` float DEFAULT NULL,
  `freq_median` float DEFAULT NULL,
  `freq_center` float DEFAULT NULL,
  `freq_relbw` float DEFAULT NULL,
  `freq_maxminration` float DEFAULT NULL,
  `freq_begendratio` float DEFAULT NULL,
  `freq_quarter1` float DEFAULT NULL,
  `freq_quarter2` float DEFAULT NULL,
  `freq_quarter3` float DEFAULT NULL,
  `freq_spread` float DEFAULT NULL,
  `dc_quarter1mean` float DEFAULT NULL,
  `dc_quarter2mean` float DEFAULT NULL,
  `dc_quarter3mean` float DEFAULT NULL,
  `dc_quarter4mean` float DEFAULT NULL,
  `freq_cofm` float DEFAULT NULL,
  `freq_stepup` int(4) DEFAULT NULL,
  `freq_stepdown` int(4) DEFAULT NULL,
  `freq_numsteps` int(4) DEFAULT NULL,
  `freq_slopemean` float DEFAULT NULL,
  `freq_absslopemean` float DEFAULT NULL,
  `freq_posslopemean` float DEFAULT NULL,
  `freq_negslopemean` float DEFAULT NULL,
  `freq_sloperatio` float DEFAULT NULL,
  `freq_begsweep` int(4) DEFAULT NULL,
  `freq_begup` int(4) DEFAULT NULL,
  `freq_begdown` int(4) DEFAULT NULL,
  `freq_endsweep` int(4) DEFAULT NULL,
  `freq_endup` int(4) DEFAULT NULL,
  `freq_enddown` int(4) DEFAULT NULL,
  `num_sweepsupdown` int(4) DEFAULT NULL,
  `num_sweepsdownup` int(4) DEFAULT NULL,
  `num_sweepsupflat` int(4) DEFAULT NULL,
  `num_sweepsdownflat` int(4) DEFAULT NULL,
  `num_sweepsflatup` int(4) DEFAULT NULL,
  `num_sweepsflatdown` int(4) DEFAULT NULL,
  `freq_sweepuppercent` float DEFAULT NULL,
  `freq_sweepdownpercent` float DEFAULT NULL,
  `freq_sweepflatpercent` float DEFAULT NULL,
  `num_inflections` int(4) DEFAULT NULL,
  `inflection_maxdelta` float DEFAULT NULL,
  `inflection_mindelta` float DEFAULT NULL,
  `inflection_maxmindelta` float DEFAULT NULL,
  `inflection_meandelta` float DEFAULT NULL,
  `inflection_standarddeviationdelta` float DEFAULT NULL,
  `inflection_duration` float DEFAULT NULL,
  `step_duration` float DEFAULT NULL,
  `freq_peak` float DEFAULT NULL,
  `bw3db` float DEFAULT NULL,
  `bw3dblow` float DEFAULT NULL,
  `bw3dbhigh` float DEFAULT NULL,
  `bw10db` float DEFAULT NULL,
  `bw10dblow` float DEFAULT NULL,
  `bw10dbhigh` float DEFAULT NULL,
  `rms_signal` float DEFAULT NULL,
  `rms_noise` float DEFAULT NULL,
  `snr` float DEFAULT NULL,
  `num_crossings` int(4) DEFAULT NULL,
  `sweep_rate` float DEFAULT NULL,
  `mean_timezc` float DEFAULT NULL,
  `median_timezc` float DEFAULT NULL,
  `variance_timezc` float DEFAULT NULL,
  `whale_train` float DEFAULT NULL,
  `cross_referenced` tinyint(1) NOT NULL DEFAULT 0,
  `contoured` varchar(10) DEFAULT NULL,
  `ignore_warnings` tinyint(1) NOT NULL DEFAULT 0,
  PRIMARY KEY (`id`),
  UNIQUE KEY `selection_number` (`selection_number`,`recording_id`),
  KEY `recording_id` (`recording_id`),
  KEY `fk_selection_file_id` (`selection_file_id`),
  KEY `fk_contour_file_id` (`contour_file_id`),
  CONSTRAINT `fk_contour_file_id` FOREIGN KEY (`contour_file_id`) REFERENCES `file` (`id`),
  CONSTRAINT `fk_selection_file_id` FOREIGN KEY (`selection_file_id`) REFERENCES `file` (`id`),
  CONSTRAINT `selection_ibfk_1` FOREIGN KEY (`recording_id`) REFERENCES `recording` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;


--
-- Table structure for table `species`
--

DROP TABLE IF EXISTS `species`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `species` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `species_name` varchar(100) NOT NULL,
  `genus_name` varchar(100) DEFAULT NULL,
  `common_name` varchar(100) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `species_name` (`species_name`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COLLATE=latin1_swedish_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `species`
--

LOCK TABLES `species` WRITE;
/*!40000 ALTER TABLE `species` DISABLE KEYS */;
INSERT INTO `species` VALUES
('c9e03621-0333-46c1-9c2c-429d5c5a6b25','Steno','Steno','Rough Toothed Dolphin'),
('1d90bd2f-d813-4581-a8c0-b42a9e88b8b7','Pseudorca craissidens','Pseudorca','False killer whale');
/*!40000 ALTER TABLE `species` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user`
--

DROP TABLE IF EXISTS `user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user` (
  `id` uuid NOT NULL DEFAULT uuid(),
  `email` varchar(100) DEFAULT NULL,
  `password` varchar(100) DEFAULT NULL,
  `name` varchar(1000) DEFAULT NULL,
  `role_id` int(11) NOT NULL,
  `is_active` tinyint(1) DEFAULT 1,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`),
  KEY `role_id` (`role_id`),
  CONSTRAINT `user_ibfk_1` FOREIGN KEY (`role_id`) REFERENCES `role` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_uca1400_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user`
--
LOCK TABLES `user` WRITE;
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` VALUES ('b9e03621-3286-46c1-9c2c-429d5c5a6b25','js521@st-andrews.ac.uk','test123','Jamie',1,1);
/*!40000 ALTER TABLE `user` ENABLE KEYS */;
UNLOCK TABLES;

/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-06-12 10:26:08