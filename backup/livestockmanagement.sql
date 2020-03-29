-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               10.4.11-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.0.0.5919
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;


-- Dumping database structure for livestockmanagement
CREATE DATABASE IF NOT EXISTS `livestockmanagement` /*!40100 DEFAULT CHARACTER SET utf8mb4 */;
USE `livestockmanagement`;

-- Dumping structure for table livestockmanagement.contact
CREATE TABLE IF NOT EXISTS `contact` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(50) DEFAULT NULL,
  `city` varchar(50) DEFAULT NULL,
  `postal` varchar(10) DEFAULT NULL,
  `country` varchar(50) DEFAULT 'Canada',
  `province` varchar(50) DEFAULT 'On',
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `note` varchar(250) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=30 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table livestockmanagement.contact: ~7 rows (approximately)
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` (`id`, `name`, `address`, `city`, `postal`, `country`, `province`, `phone`, `email`, `note`, `created_at`) VALUES
	(1, 'Little Bit Western', '372 Algonquin Boulevard W', 'Timmins', 'P4N 2S2', 'Canada', 'On', '705-268-0822', '', 'Feed store. A bit on expensive side. Doesn\'t sell much for Cattle. Mostly things for chicken, hogs and horses.', '2019-04-29 21:31:35'),
	(2, 'Northern Farm', '1496 Caribou Rd W', 'Matheson', 'P0K 1N0', 'Canada ', 'On', '647-864-2435', NULL, 'Our very own farm address', '2019-05-08 11:45:08'),
	(3, 'Railside General Supplies', '3272 Monahan Rd', 'Val Gagne', 'P0K 1W0', 'Canada', 'On', '705-232-6662', NULL, 'Manonite owned feed store, with more or less ok prices', '2020-01-05 07:01:53'),
	(5, 'Northern Veterinary Hospital', '#741, HWY 67', 'Iroquois Falls', 'P0K1G0', 'Canada', 'On', '705-232-7700', NULL, NULL, '2020-01-05 12:08:41'),
	(25, 'Northern Allied', '352 Railway St', 'Timmins', 'P4N 2P6', 'Canada', 'On', '7052645291', '', 'Metal supply company. The only one in Timmins.', '2020-02-18 23:39:43'),
	(26, 'Mark', 'n/a', 'Matheson', 'p0k 1n0', 'Canada', 'On', '705-262-3433', '', 'Neighbour farmer. Wants to buy cattle.', '2020-02-27 10:59:32');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.event
CREATE TABLE IF NOT EXISTS `event` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `ev_type_id` char(36) NOT NULL,
  `livestock_id` char(36) NOT NULL,
  `note` varchar(250) NOT NULL,
  `ev_date` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_event_history_event_type` (`ev_type_id`),
  KEY `FK_event_history_livestock` (`livestock_id`),
  CONSTRAINT `FK_event_history_event_type` FOREIGN KEY (`ev_type_id`) REFERENCES `event_type` (`ev_type_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_livestock` FOREIGN KEY (`livestock_id`) REFERENCES `livestock` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Contains events that occured in the past';

-- Dumping data for table livestockmanagement.event: ~0 rows (approximately)
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.event_type
CREATE TABLE IF NOT EXISTS `event_type` (
  `ev_type_id` char(36) NOT NULL DEFAULT uuid(),
  `ev_type_name` varchar(20) NOT NULL,
  `ev_type_value` varchar(25) NOT NULL,
  `ev_type_desc` varchar(300) DEFAULT NULL,
  `place` tinyint(4) NOT NULL DEFAULT 100,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ev_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Types of events for a farm livestock. Space column used selection order when displayed in the list on website.';

-- Dumping data for table livestockmanagement.event_type: ~12 rows (approximately)
/*!40000 ALTER TABLE `event_type` DISABLE KEYS */;
INSERT INTO `event_type` (`ev_type_id`, `ev_type_name`, `ev_type_value`, `ev_type_desc`, `place`, `created_at`) VALUES
	('09ef9b47-6f9d-11e9-992e-d8cb8ac0caec', 'medicated', 'Medicated', 'Used to report medication use on a livestock', 2, '2019-05-05 21:19:43'),
	('37a81ef3-72d1-11e9-9f5d-d8cb8ac0caec', 'hoof_trim', 'Hoof Trimming', 'Used to report a hoof trimming performed on the animal', 10, '2019-05-09 23:10:51'),
	('5060a862-6f9a-11e9-992e-d8cb8ac0caec', 'birth_date', 'Birth Date', 'Used to associate an animal’s birth date with its unique approved tag number.', 11, '2019-05-05 21:00:17'),
	('5067e8aa-6f9a-11e9-992e-d8cb8ac0caec', 'cross_reference', 'Cross Reference', 'Used to associate a newly applied approved tag number on a previously tagged animal where the lost tag number is known.', 6, '2019-05-05 21:00:17'),
	('62349b96-2f35-11ea-ac21-d8cb8ac0caec', 'weight', 'Weight', 'Used to report the weight of livestock.', 1, '2020-01-04 16:01:31'),
	('869c59ed-6f9b-11e9-992e-d8cb8ac0caec', 'replaced', 'Replaced', 'Used to associate a newly applied approved tag number on a previously tagged animal where the lost tag number is not known.', 7, '2019-05-05 21:08:58'),
	('86a29041-6f9b-11e9-992e-d8cb8ac0caec', 'move_in', 'Move In', 'Report the identification of an approved tag applied to an individual animal, or report a group of animals based on species, that have been received at a defined location on a defined day.', 4, '2019-05-05 21:08:58'),
	('86aa2637-6f9b-11e9-992e-d8cb8ac0caec', 'move_out', 'Move Out', 'Report the identification of an approved tag applied to an individual animal, or report a group of animals based on species, that have departed from a defined location on a defined day.', 5, '2019-05-05 21:08:58'),
	('86b48a38-6f9b-11e9-992e-d8cb8ac0caec', 'sighted', 'Sighted', 'Used to report the identification of an approved tag applied to an animal that has been observed at a defined location on a defined day. (e.g., livestock operation, veterinary clinic, etc.)', 8, '2019-05-05 21:08:58'),
	('86db3a93-6f9b-11e9-992e-d8cb8ac0caec', 'retired', 'Retired', 'Used to report the identification of an approved tag applied to an animal that has died or was slaughtered.', 9, '2019-05-05 21:08:58'),
	('86e328da-6f9b-11e9-992e-d8cb8ac0caec', 'disposed', 'Disposed', 'Used to report the identification of an approved tag applied to an animal, or an animal based on carcass details, that has died and has been disposed of by a producer or dead stock operator.', 12, '2019-05-05 21:08:58'),
	('f26cb0aa-2f34-11ea-ac21-d8cb8ac0caec', 'castration', 'Castration/Banding', 'Used to report of castration or banding of livestock', 3, '2020-01-04 15:58:24');
/*!40000 ALTER TABLE `event_type` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.feed_inventory
CREATE TABLE IF NOT EXISTS `feed_inventory` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feed_id` int(11) NOT NULL,
  `feed_lb` decimal(10,2) NOT NULL,
  `feed_date` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_feed_inventory_feed_type` (`feed_id`),
  CONSTRAINT `FK_feed_inventory_feed_type` FOREIGN KEY (`feed_id`) REFERENCES `feed_type` (`id`) ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Feed inventory that is currently on the farm. Includes prices and quantity.';

-- Dumping data for table livestockmanagement.feed_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `feed_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `feed_inventory` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.feed_type
CREATE TABLE IF NOT EXISTS `feed_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feed_name` varchar(50) NOT NULL,
  `feed_desc` varchar(250) DEFAULT NULL,
  `cp` tinyint(4) NOT NULL DEFAULT 0,
  `tdn` tinyint(4) NOT NULL DEFAULT 0,
  `dm` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Types of animal feeds';

-- Dumping data for table livestockmanagement.feed_type: ~0 rows (approximately)
/*!40000 ALTER TABLE `feed_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `feed_type` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.livestock
CREATE TABLE IF NOT EXISTS `livestock` (
  `id` char(32) NOT NULL DEFAULT uuid(),
  `long_tag` varchar(50) DEFAULT NULL,
  `tag` varchar(50) DEFAULT NULL,
  `livestock_type` varchar(50) DEFAULT '',
  `mother_id` char(16) DEFAULT NULL,
  `father_id` char(16) DEFAULT NULL,
  `mother_tag` varchar(50) DEFAULT NULL,
  `father_tag` varchar(50) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='flock details';

-- Dumping data for table livestockmanagement.livestock: ~11 rows (approximately)
/*!40000 ALTER TABLE `livestock` DISABLE KEYS */;
INSERT INTO `livestock` (`id`, `long_tag`, `tag`, `livestock_type`, `mother_id`, `father_id`, `mother_tag`, `father_tag`, `is_active`, `created_at`, `updated_at`) VALUES
	('ef21b44f-66fc-11', '124000501336702', '501336702', '4', NULL, NULL, NULL, NULL, 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b5d5-66fc-11', '124000501336861', '501336861', '4', NULL, NULL, NULL, NULL, 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b60c-66fc-11', '124000501336879', '501336879', '4', NULL, NULL, NULL, NULL, 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b63e-66fc-11', '124000501336995', '501336995', '4', NULL, NULL, NULL, NULL, 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b663-66fc-11', '124000501336998', '501336998', '4', NULL, NULL, NULL, NULL, 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b689-66fc-11', '124000501337008', '501337008', '4', NULL, NULL, NULL, NULL, 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b6b2-66fc-11', '124000501337060', '501337060', '4', NULL, NULL, NULL, NULL, 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b6d8-66fc-11', '124000501337083', '501337083', '4', NULL, NULL, NULL, NULL, 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b6fc-66fc-11', '124000501337104', '501337104', '4', NULL, NULL, NULL, NULL, 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b71f-66fc-11', '124000501337133', '501337133', '4', NULL, NULL, NULL, NULL, 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b745-66fc-11', '124000501337053', '501337053', '4', NULL, NULL, NULL, NULL, 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33');
/*!40000 ALTER TABLE `livestock` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.livestock_group
CREATE TABLE IF NOT EXISTS `livestock_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(150) NOT NULL,
  `group_desc` varchar(250) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='contains groups of animals grouped together for the purpose of feeding or breading';

-- Dumping data for table livestockmanagement.livestock_group: ~0 rows (approximately)
/*!40000 ALTER TABLE `livestock_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `livestock_group` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.livestock_to_group
CREATE TABLE IF NOT EXISTS `livestock_to_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `livestock_id` char(16) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_livestock_to_group_livestock` (`livestock_id`),
  KEY `FK_livestock_to_group_livestock_group` (`group_id`),
  CONSTRAINT `FK_livestock_to_group_livestock` FOREIGN KEY (`livestock_id`) REFERENCES `livestock` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_livestock_to_group_livestock_group` FOREIGN KEY (`group_id`) REFERENCES `livestock_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='reference table that connects created groups to existing livestock';

-- Dumping data for table livestockmanagement.livestock_to_group: ~0 rows (approximately)
/*!40000 ALTER TABLE `livestock_to_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `livestock_to_group` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.livestock_type
CREATE TABLE IF NOT EXISTS `livestock_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type_name` varchar(50) NOT NULL,
  `type_desc` varchar(250) DEFAULT NULL,
  `type_male` varchar(50) NOT NULL,
  `type_female` varchar(50) NOT NULL,
  `type_child` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COMMENT='contains animal types present on the farm';

-- Dumping data for table livestockmanagement.livestock_type: ~5 rows (approximately)
/*!40000 ALTER TABLE `livestock_type` DISABLE KEYS */;
INSERT INTO `livestock_type` (`id`, `type_name`, `type_desc`, `type_male`, `type_female`, `type_child`, `created_at`) VALUES
	(1, 'beef', NULL, 'steer', 'heifer', 'calf', '2019-12-26 10:44:09'),
	(2, 'cattle', NULL, 'bull', 'cow', 'calf', '2019-12-26 10:44:54'),
	(3, 'chicken', NULL, 'rooster', 'chick', 'chick', '2019-12-26 10:45:49'),
	(4, 'sheep', NULL, 'ram', 'ewe', 'lamb', '2019-12-26 10:46:18'),
	(5, 'goat', NULL, 'buck', 'doe', 'buckling', '2019-12-26 10:46:51');
/*!40000 ALTER TABLE `livestock_type` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.medication
CREATE TABLE IF NOT EXISTS `medication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `desc` varchar(550) DEFAULT NULL,
  `instruction` varchar(2000) DEFAULT NULL,
  `img` varchar(150) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COMMENT='list of medication';

-- Dumping data for table livestockmanagement.medication: ~6 rows (approximately)
/*!40000 ALTER TABLE `medication` DISABLE KEYS */;
INSERT INTO `medication` (`id`, `name`, `desc`, `instruction`, `img`, `created_at`) VALUES
	(1, 'Tasvax 8', 'For the vaccination of cattle and sheep against diseases caused by Cl. chauvoei (black leg), Cl. haemolyticum (bacillary hemoglobinuria), Cl. novyi Type B (black disease or infectious necrotic hepatitis), Cl. perfringens Type B (lamb dysentery), Type C (hemorrhagic enterotoxemia), type D (pulpy kidney), Cl. septicum (malignant edema) and Cl. tetani (tetanus).', 'Cattle: In order that a balanced response to vaccination is obtained, a primary course of two injections of 4 mL each should be given with an interval of 6 weeks between injections. To maintain a constant high level of immunity, booster injections should be administered at intervals of 6 months, or when outbreaks are seasonal, at least 2 weeks before the anticipated outbreak. Calves vaccinated under 3 months of age should be revaccinated at 4-6 months of age. Calves vaccinated at 3 months of age or older should be revaccinated 6 weeks later. Inject subcutaneously with strict aseptic precautions.', 'https://langleyanimalclinic.ca/wp-content/uploads/2019/07/Tasvax-8.jpg', '2019-05-09 23:02:13'),
	(2, 'Noromectin', 'Each mL contains 0.8 mg of ivermectin.\r\n\r\nTreated animals must not be slaughtered for use in food for at least 14 days after the latest treatment with this drug.', 'Dosage and Administration\r\nNoromectin should be given as a single dose treatment. Administer orally at a dose of 2.5 mL of Noromectin per 10 kg of bodyweight, with any standard drenching equipment which provides a consistent dose volume. Repeat treatment may be necessary when re-exposure to parasite infection occurs.\r\n\r\nNoromectin Drench for Sheep Caution\r\nCoughing, which usually lasts for only a few minutes, may occur in a small percentage of sheep immediately after treatment; this passing response is of no consequence.', 'https://images-na.ssl-images-amazon.com/images/I/81cX3tCC0tL._AC_SY879_.jpg', '2019-05-09 23:04:31'),
	(3, 'Hoof Trim', 'Trimming hoof to cattle or sheep', 'n/a', 'https://encrypted-tbn0.gstatic.com/images?q=tbn%3AANd9GcS7Yos7zq_0RtsXizsweGLrvFzVJmcSn7QDiQ335Hpd95z7ojYA', '2019-05-09 23:17:41'),
	(4, 'Tetanus Toxoid', 'Anti-toxing vaccination. Takes 2-3 weeks to take effect.', 'Inject intromascularly 1cc/ml. Repeat vaccination in 3-4 weeks again', 'https://www.valleyvet.com/swatches/40277_L_vvs_000.jpg', '2020-01-04 22:52:43'),
	(5, 'Ivomec', 'Ivomec Pour-On for Cattle dewormer. Adminsiter 1cc for every 10kg (22lb).', 'Apply along the top line from the withers to the tail head at the rate of 1 mL per 10 kg (22 lb).', 'https://media.tractorsupply.com/is/image/TractorSupplyCompany/2207462?$456$', '2020-02-27 10:11:31'),
	(6, 'Bovi-Shield Gold 5', 'Bovi-Shield GOLD 5 is for vaccination of healthy cattle as an aid in preventing infectious bovine rhinotracheitis caused by infectious bovine rhinotracheitis (IBR) virus, bovine viral diarrhea caused by bovine virus diarrhea (BVD) virus Types 1 and 2, and disease caused by parainfluenza-3 (PI-3) virus and bovine respiratory syncytial (BRS) virus.', 'Administer 2 mL subcutaneously or intramuscularly. In accordance with Beef Quality Assurance guidelines, this product should be administered SC in the neck region.', 'https://cdn11.bigcommerce.com/s-kjner/images/stencil/1280x1280/products/2083/1162/BOVISHIELD_GOLD_5__55950.1382708635.jpg?c=2', '2020-03-08 21:44:04');
/*!40000 ALTER TABLE `medication` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.planning_project
CREATE TABLE IF NOT EXISTS `planning_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(250) CHARACTER SET utf8 NOT NULL,
  `project_price` decimal(10,0) NOT NULL DEFAULT 0,
  `project_price_actual` decimal(10,0) NOT NULL DEFAULT 0,
  `is_start` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=52 DEFAULT CHARSET=utf8mb4 COMMENT='financial information for project planning';

-- Dumping data for table livestockmanagement.planning_project: ~3 rows (approximately)
/*!40000 ALTER TABLE `planning_project` DISABLE KEYS */;
INSERT INTO `planning_project` (`id`, `project_name`, `project_price`, `project_price_actual`, `is_start`, `created_at`) VALUES
	(2, 'Fence Charger', -1200, -1300, 0, '2020-03-22 16:04:18'),
	(30, 'Ground rods, ground clamps and split bolt connectors', -100, -125, 0, '2020-03-24 21:15:48'),
	(46, 'Starting project budget', -4640, -4640, 1, '2020-03-20 00:00:00');
/*!40000 ALTER TABLE `planning_project` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.transaction
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `trans_cat_id` int(11) NOT NULL,
  `trans_type_id` int(11) NOT NULL,
  `trans_ammount` decimal(19,2) NOT NULL,
  `trans_currency` varchar(10) NOT NULL DEFAULT 'CAD',
  `trans_desc` varchar(250) DEFAULT NULL,
  `addr_id` int(11) NOT NULL,
  `trans_date` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_transaction_transaction_category` (`trans_cat_id`),
  KEY `FK_transaction_transaction_type` (`trans_type_id`),
  KEY `FK_transaction_address_book` (`addr_id`),
  CONSTRAINT `FK_transaction_address_book` FOREIGN KEY (`addr_id`) REFERENCES `contact` (`id`),
  CONSTRAINT `FK_transaction_transaction_category` FOREIGN KEY (`trans_cat_id`) REFERENCES `transaction_category` (`id`),
  CONSTRAINT `FK_transaction_transaction_type` FOREIGN KEY (`trans_type_id`) REFERENCES `transaction_type` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='record of all transactions';

-- Dumping data for table livestockmanagement.transaction: ~4 rows (approximately)
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` (`id`, `trans_cat_id`, `trans_type_id`, `trans_ammount`, `trans_currency`, `trans_desc`, `addr_id`, `trans_date`, `created_at`, `updated_at`) VALUES
	('0333a75f-71a9-11e9-bfc5-d8cb8ac0caec', 1, 1, 49.72, 'CAD', NULL, 1, '2019-05-06 16:47:00', '2019-05-08 11:50:32', '2019-05-08 11:50:32'),
	('66d91789-6aea-11', 1, 1, 24.86, 'CAD', NULL, 1, '2019-04-29 16:31:58', '2019-04-29 21:34:58', '2019-05-01 13:28:31'),
	('965a0a99-6c36-11', 1, 1, 49.72, 'CAD', NULL, 1, '2019-04-30 16:52:34', '2019-05-01 13:28:11', '2019-05-01 13:29:02'),
	('dc2d7067-6da7-11e9-9b6b-d8cb8ac0caec', 5, 1, 3625.00, 'CAD', NULL, 1, '2019-01-05 09:31:50', '2019-05-03 09:31:50', '2019-05-03 09:35:03');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.transaction_category
CREATE TABLE IF NOT EXISTS `transaction_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_cat_name` varchar(150) NOT NULL,
  `trans_cat_subname` varchar(150) NOT NULL,
  `trans_cat_desc` varchar(250) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COMMENT='Table contains all income and expence types of the farm';

-- Dumping data for table livestockmanagement.transaction_category: ~9 rows (approximately)
/*!40000 ALTER TABLE `transaction_category` DISABLE KEYS */;
INSERT INTO `transaction_category` (`id`, `trans_cat_name`, `trans_cat_subname`, `trans_cat_desc`, `created_at`) VALUES
	(1, 'Feed', 'Hay', NULL, '2019-04-29 21:32:30'),
	(2, 'Grain', 'Corn', NULL, '2019-04-29 21:33:09'),
	(3, 'Grain', 'Barley', NULL, '2019-04-29 21:33:27'),
	(4, 'Grain', 'Oats', NULL, '2019-04-29 21:33:45'),
	(5, 'Livestock', 'Sheep', NULL, '2019-05-03 09:30:51'),
	(6, 'Livestock', 'Chicken', NULL, '2019-05-03 09:33:28'),
	(7, 'Livestock', 'Goats', NULL, '2019-05-03 09:33:43'),
	(8, 'Livestock', 'Beef', NULL, '2019-05-03 09:33:59'),
	(9, 'Medication', 'Tasvax-8', NULL, '2019-05-03 09:34:18');
/*!40000 ALTER TABLE `transaction_category` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.transaction_type
CREATE TABLE IF NOT EXISTS `transaction_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `trans_type_name` varchar(50) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_transaction_history_transaction_type` (`trans_type_name`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COMMENT='contains all records for expences and farm income';

-- Dumping data for table livestockmanagement.transaction_type: ~2 rows (approximately)
/*!40000 ALTER TABLE `transaction_type` DISABLE KEYS */;
INSERT INTO `transaction_type` (`id`, `trans_type_name`, `created_at`) VALUES
	(1, 'expense', '2019-04-29 21:09:58'),
	(2, 'income', '2019-04-29 21:10:06');
/*!40000 ALTER TABLE `transaction_type` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` char(32) NOT NULL,
  `username` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='cattle management members.';

-- Dumping data for table livestockmanagement.user: ~0 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `is_active`, `created_at`) VALUES
	('5e0d0d6c10096', 'farmer', '$2y$10$YxQsfaEVGMokSlb9QuKkUOkYxyLEOpM9XiuMFhrJifnTzjv9lnmze', 'dimasalt@gmail.com', 1, '2020-01-01 16:30:34');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.user_detail
CREATE TABLE IF NOT EXISTS `user_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` char(32) NOT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_user_detail_user` (`user_id`),
  CONSTRAINT `FK_user_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table livestockmanagement.user_detail: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_detail` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.user_logins
CREATE TABLE IF NOT EXISTS `user_logins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` char(36) NOT NULL,
  `token` varchar(50) NOT NULL,
  `user_agent` varchar(50) NOT NULL,
  `user_ip` varchar(50) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK__user` (`user_id`),
  CONSTRAINT `FK__user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='contains user login information';

-- Dumping data for table livestockmanagement.user_logins: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_logins` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_logins` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.user_role
CREATE TABLE IF NOT EXISTS `user_role` (
  `id` char(32) NOT NULL DEFAULT uuid_short(),
  `role` varchar(10) NOT NULL,
  `role_desc` varchar(150) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='member roles in the cattle management system.';

-- Dumping data for table livestockmanagement.user_role: ~2 rows (approximately)
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` (`id`, `role`, `role_desc`, `created_at`) VALUES
	('98534618084409345', 'admin', NULL, '2020-01-04 15:24:44'),
	('98534618084409346', 'user', NULL, '2020-01-04 15:24:53');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;

-- Dumping structure for table livestockmanagement.user_to_role
CREATE TABLE IF NOT EXISTS `user_to_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` char(32) NOT NULL,
  `role_id` char(32) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_user_to_role_user` (`user_id`),
  KEY `FK_user_to_role_user_role` (`role_id`),
  CONSTRAINT `FK_user_to_role_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user_to_role_user_role` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Cattle Management system users and their role connections';

-- Dumping data for table livestockmanagement.user_to_role: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_to_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_to_role` ENABLE KEYS */;

-- Dumping structure for procedure livestockmanagement.contactAdd
DELIMITER //
CREATE PROCEDURE `contactAdd`(
	IN `contact_name` VARCHAR(50),
	IN `address` VARCHAR(50),
	IN `city` VARCHAR(50),
	IN `postal` VARCHAR(50),
	IN `country` VARCHAR(50),
	IN `province` VARCHAR(50),
	IN `phone` VARCHAR(50),
	IN `email` VARCHAR(50),
	IN `note` VARCHAR(250)
)
BEGIN

	INSERT INTO 
		contact (`name`, address, city, postal, country, province, phone, email, note)
	VALUES (contact_name, address, city, postal, country, province, phone, email, note);

END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.contactDeleteOne
DELIMITER //
CREATE PROCEDURE `contactDeleteOne`(
	IN `contact_id` INT
)
BEGIN

	DELETE 
	FROM contact 
	WHERE contact.id = contact_id;
	
END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.contactGetOne
DELIMITER //
CREATE PROCEDURE `contactGetOne`(
	IN `contact_id` INT
)
BEGIN

	select contact.id, 
			contact.name, 
			contact.address, 
			contact.city, 
			contact.postal, 
			contact.province, 
			contact.country, 
			contact.phone, 
			contact.email, 
			contact.note
	FROM contact
	WHERE contact.id = contact_id;

END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.contactsGetAll
DELIMITER //
CREATE PROCEDURE `contactsGetAll`()
    COMMENT 'get various contacts information'
BEGIN

	select contact.id, 
			contact.name, 
			contact.address, 
			contact.city, 
			contact.postal, 
			contact.province, 
			contact.country, 
			contact.phone, 
			contact.email, 
			contact.note
	FROM contact
	ORDER BY contact.name ASC;

END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.contactUpdate
DELIMITER //
CREATE PROCEDURE `contactUpdate`(
	IN `id` INT,
	IN `contact_name` VARCHAR(100),
	IN `address` VARCHAR(50),
	IN `city` VARCHAR(50),
	IN `postal` VARCHAR(10),
	IN `country` VARCHAR(50),
	IN `province` VARCHAR(50),
	IN `phone` VARCHAR(50),
	IN `email` VARCHAR(50),
	IN `note` VARCHAR(250)


)
BEGIN

	UPDATE contact 
	SET contact.name = contact_name, 
		 contact.address = address, 
		 contact.city = city,
		 contact.postal = postal,
		 contact.country = country,
		 contact.province = province,
		 contact.phone = phone,
		 contact.email = email,
		 contact.note = note
	WHERE contact.id = id;
	
END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.eventAddType
DELIMITER //
CREATE PROCEDURE `eventAddType`(
	IN `ev_type_name` VARCHAR(20),
	IN `ev_type_value` VARCHAR(25),
	IN `ev_type_desc` VARCHAR(300)
)
    COMMENT 'allows to add event type'
BEGIN
	
	INSERT INTO event_type 
		 (
				ev_type_id,
				ev_type_name,
				ev_type_value,
				ev_type_desc			
		 )
		 VALUES
		 (
		 		UUID(),
		 		ev_type_name,
		 		ev_type_value,
		 		ev_type_desc
		 );

END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.livestockGetAll
DELIMITER //
CREATE PROCEDURE `livestockGetAll`(
	IN `current_page` INT,
	IN `records` INT,
	IN `is_active` INT

)
BEGIN

	DECLARE offset_rows INT DEFAULT (current_page -1) * records;	
	
	DECLARE total INT DEFAULT 0;
	DECLARE total_pages INT DEFAULT 0;
	
	SET total = (SELECT count(livestock.livestock_id) FROM livestock WHERE livestock.is_active >= is_active);		 
   SET total_pages = total / records;

		 	
	IF total % records > 0 THEN
		SET total_pages = total_pages + 1;
	END IF;
	
	 
	SELECT 
		livestock_id, 
		long_tag, 
		tag, 
		livestock_sex,
		total_pages
	FROM 
		livestock 
	WHERE livestock.is_active >= is_active
	LIMIT offset_rows, records;

END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.livestockGetTypeAll
DELIMITER //
CREATE PROCEDURE `livestockGetTypeAll`()
    COMMENT 'get flock types'
BEGIN

	SELECT livestock_type.type_id, livestock_type.type_male, livestock_type.type_female, livestock_type.type_name
	FROM livestock_type;

END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.medicationDeleteOne
DELIMITER //
CREATE PROCEDURE `medicationDeleteOne`(
	IN `id` INT
)
BEGIN
	
	DELETE FROM medication
	WHERE medication.id = id;
	
END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.medicationGetAll
DELIMITER //
CREATE PROCEDURE `medicationGetAll`()
BEGIN
	
	SELECT medication.id, medication.name, medication.desc, medication.instruction, medication.img
	FROM medication;
	
END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.medicationGetOne
DELIMITER //
CREATE PROCEDURE `medicationGetOne`(
	IN `id` INT
)
BEGIN
	
	SELECT medication.id, medication.name, medication.desc, medication.instruction, medication.img
	FROM medication
	WHERE medication.id = id;
	
END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.medicationUpdate
DELIMITER //
CREATE PROCEDURE `medicationUpdate`(
	IN `id` INT,
	IN `med_name` VARCHAR(50),
	IN `med_desc` VARCHAR(550),
	IN `med_instruction` VARCHAR(2000)
)
BEGIN

	UPDATE medication
	SET 
		medication.name = med_name, 
		medication.`desc` = med_desc,
		medication.instruction = med_instruction
	WHERE medication.id = id;	

END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.projectAdd
DELIMITER //
CREATE PROCEDURE `projectAdd`(
	IN `project_name` VARCHAR(250),
	IN `project_price` DECIMAL(10,0),
	IN `project_price_actual` DECIMAL(10,0),
	IN `is_start` TINYINT,
	IN `created_at` DATETIME
)
BEGIN

	-- Removes starting budget point if that's what we're adding
	IF is_start = 1 THEN
		DELETE FROM planning_project
		WHERE planning_project.is_start = 1;	
	END IF;
	

	-- inserts new project item
	INSERT INTO planning_project
		(
			planning_project.project_name, 
			planning_project.project_price, 
			planning_project.project_price_actual, 
			planning_project.is_start,
			planning_project.created_at
		)
	VALUES
		(
			project_name, 
			project_price, 
			project_price_actual, 
			is_start,
			created_at
		);

END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.projectDelOne
DELIMITER //
CREATE PROCEDURE `projectDelOne`(
	IN `id` INT
)
    COMMENT 'removes one item from project list'
BEGIN

	DELETE FROM planning_project
	WHERE planning_project.id = id;

END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.projectGetAll
DELIMITER //
CREATE PROCEDURE `projectGetAll`()
    COMMENT 'Gets project list with their predicted and actual financial information'
BEGIN

	SELECT 
		planning_project.id,
		planning_project.project_name,
		planning_project.project_price,
		planning_project.project_price_actual,
		planning_project.is_start,
		planning_project.created_at		
				
	FROM 
		planning_project;

END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.transactionCreate
DELIMITER //
CREATE PROCEDURE `transactionCreate`(
	IN `trans_cat_id` INT,
	IN `trans_type_id` INT,
	IN `trans_ammount` INT,
	IN `trans_currency` DECIMAL(19,2),
	IN `addr_id` INT,
	IN `trans_date` DATETIME


)
    COMMENT 'Inserts new transactions into database'
BEGIN

	INSERT INTO transaction_history 
			(
				transaction_history.trans_id, 
				transaction_history.trans_cat_id, 
				transaction_history.trans_type_id, 
				transaction_history.trans_ammount, 
				transaction_history.trans_currency, 
				transaction_history.addr_id, 
				transaction_history.trans_date
			)
	VALUES
		  (
		  		UUID(), 
				trans_cat_id, 
				trans_type_id  ,
				trans_ammount,
				trans_currency,
				addr_id,
				trans_date
		  );
	
END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.transactionsGetAll
DELIMITER //
CREATE PROCEDURE `transactionsGetAll`()
BEGIN

	SELECT trans.trans_id, 
			transaction_category.trans_cat_subname, 
			transaction_type.trans_type_name, 
			trans.trans_ammount, 
			trans.trans_currency,
			trans.trans_date
	From trans
	inner join transaction_category on trans.trans_cat_id = transaction_category.trans_cat_id
	inner join transaction_type on trans.trans_type_id = transaction_type.trans_type_id
	ORDER BY trans.trans_date;

END//
DELIMITER ;

-- Dumping structure for procedure livestockmanagement.userCreate
DELIMITER //
CREATE PROCEDURE `userCreate`(
	IN `user_id` CHAR(16),
	IN `username` VARCHAR(15),
	IN `email` VARCHAR(50),
	IN `password` VARCHAR(36)
)
BEGIN

	Insert into user(user.id, user.username, user.email, user.password, user.is_active) 
	values(user_id, username, email, password, 1);
	
END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IF(@OLD_FOREIGN_KEY_CHECKS IS NULL, 1, @OLD_FOREIGN_KEY_CHECKS) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
