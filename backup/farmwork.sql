-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               10.5.6-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             11.2.0.6213
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table farmwork.contact
CREATE TABLE IF NOT EXISTS `contact` (
  `id` char(36) NOT NULL DEFAULT uuid(),
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
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table farmwork.contact: ~7 rows (approximately)
/*!40000 ALTER TABLE `contact` DISABLE KEYS */;
INSERT INTO `contact` (`id`, `name`, `address`, `city`, `postal`, `country`, `province`, `phone`, `email`, `note`, `created_at`) VALUES
	('81a77d42-a76d-11eb-80d2-d8cb8ac0caec', 'Little Bit Western', '372 Algonquin Boulevard W', 'Timmins', 'P4N 2S2', 'Canada', 'On', '705-268-0822', '', 'Feed store. A bit on expensive side. Doesn\'t sell much for Cattle. Mostly things for chicken, hogs and horses.', '2019-04-29 21:31:35'),
	('81a77fe9-a76d-11eb-80d2-d8cb8ac0caec', 'Northern Allied', '352 Railway St', 'Timmins', 'P4N 2P6', 'Canada', 'On', '7052645291', '', 'Metal supply company. The only one in Timmins.', '2020-02-18 23:39:43'),
	('81a781a5-a76d-11eb-80d2-d8cb8ac0caec', 'Mark', 'n/a', 'Matheson', 'p0k 1n0', 'Canada', 'On', '705-262-3433', '', '<p>Neighbour farmer. Wants to buy cattle. May not keep the word.</p>', '2020-02-27 10:59:32'),
	('81a78279-a76d-11eb-80d2-d8cb8ac0caec', 'Railside General Supplies', '3272 Monahan Rd', 'Val Gagne', 'P0K 1W0', 'Canada', 'On', '705-232-6662', NULL, 'Manonite owned feed store, with more or less ok prices', '2020-01-05 07:01:53'),
	('81a78332-a76d-11eb-80d2-d8cb8ac0caec', 'Samuel M.', '', '', '', 'Canada', 'On', '705-232-2380', '', '<p>Manonite. Sells lumber and posts for fencing or/and construction.</p>', '2020-04-08 17:19:45'),
	('81a783e7-a76d-11eb-80d2-d8cb8ac0caec', 'Cleason Marting', 'Country Ln', 'Val Gagne', '', 'Canada', 'On', '705-232-2039', '', '<p>Manonite. Sells bolts, pins and other metal hardware. The place is the first house on Hwy 11/Country Ln.</p>', '2020-04-08 17:23:04'),
	('81a784ae-a76d-11eb-80d2-d8cb8ac0caec', 'Northern Veterinary Hospital', '#741, HWY 67', 'Iroquois Falls', 'P0K1G0', 'Canada', 'On', '705-232-7700', NULL, NULL, '2020-01-05 12:08:41');
/*!40000 ALTER TABLE `contact` ENABLE KEYS */;

-- Dumping structure for table farmwork.event
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

-- Dumping data for table farmwork.event: ~0 rows (approximately)
/*!40000 ALTER TABLE `event` DISABLE KEYS */;
/*!40000 ALTER TABLE `event` ENABLE KEYS */;

-- Dumping structure for table farmwork.event_type
CREATE TABLE IF NOT EXISTS `event_type` (
  `ev_type_id` char(36) NOT NULL DEFAULT uuid(),
  `ev_type_name` varchar(20) NOT NULL,
  `ev_type_value` varchar(25) NOT NULL,
  `ev_type_desc` varchar(300) DEFAULT NULL,
  `place` tinyint(4) NOT NULL DEFAULT 100,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ev_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Types of events for a farm livestock. Space column used selection order when displayed in the list on website.';

-- Dumping data for table farmwork.event_type: ~12 rows (approximately)
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

-- Dumping structure for table farmwork.feed_inventory
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

-- Dumping data for table farmwork.feed_inventory: ~0 rows (approximately)
/*!40000 ALTER TABLE `feed_inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `feed_inventory` ENABLE KEYS */;

-- Dumping structure for table farmwork.feed_type
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

-- Dumping data for table farmwork.feed_type: ~0 rows (approximately)
/*!40000 ALTER TABLE `feed_type` DISABLE KEYS */;
/*!40000 ALTER TABLE `feed_type` ENABLE KEYS */;

-- Dumping structure for table farmwork.livestock
CREATE TABLE IF NOT EXISTS `livestock` (
  `id` char(32) NOT NULL DEFAULT uuid(),
  `long_tag` varchar(50) DEFAULT NULL,
  `livestock_type` varchar(50) DEFAULT '',
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='flock details';

-- Dumping data for table farmwork.livestock: ~11 rows (approximately)
/*!40000 ALTER TABLE `livestock` DISABLE KEYS */;
INSERT INTO `livestock` (`id`, `long_tag`, `livestock_type`, `is_active`, `created_at`, `updated_at`) VALUES
	('ef21b44f-66fc-11', '124000501336702', '4', 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b5d5-66fc-11', '124000501336861', '4', 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b60c-66fc-11', '124000501336879', '4', 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b63e-66fc-11', '124000501336995', '4', 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b663-66fc-11', '124000501336998', '4', 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b689-66fc-11', '124000501337008', '4', 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b6b2-66fc-11', '124000501337060', '4', 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b6d8-66fc-11', '124000501337083', '4', 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b6fc-66fc-11', '124000501337104', '4', 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b71f-66fc-11', '124000501337133', '4', 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33'),
	('ef21b745-66fc-11', '124000501337053', '4', 0, '2019-04-20 23:05:24', '2019-12-26 10:47:33');
/*!40000 ALTER TABLE `livestock` ENABLE KEYS */;

-- Dumping structure for table farmwork.livestock_group
CREATE TABLE IF NOT EXISTS `livestock_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(150) NOT NULL,
  `group_desc` varchar(250) DEFAULT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='contains groups of animals grouped together for the purpose of feeding or breading';

-- Dumping data for table farmwork.livestock_group: ~0 rows (approximately)
/*!40000 ALTER TABLE `livestock_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `livestock_group` ENABLE KEYS */;

-- Dumping structure for table farmwork.livestock_to_group
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

-- Dumping data for table farmwork.livestock_to_group: ~0 rows (approximately)
/*!40000 ALTER TABLE `livestock_to_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `livestock_to_group` ENABLE KEYS */;

-- Dumping structure for table farmwork.livestock_type
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

-- Dumping data for table farmwork.livestock_type: ~5 rows (approximately)
/*!40000 ALTER TABLE `livestock_type` DISABLE KEYS */;
INSERT INTO `livestock_type` (`id`, `type_name`, `type_desc`, `type_male`, `type_female`, `type_child`, `created_at`) VALUES
	(1, 'beef', NULL, 'steer', 'heifer', 'calf', '2019-12-26 10:44:09'),
	(2, 'cattle', NULL, 'bull', 'cow', 'calf', '2019-12-26 10:44:54'),
	(3, 'chicken', NULL, 'rooster', 'chick', 'chick', '2019-12-26 10:45:49'),
	(4, 'sheep', NULL, 'ram', 'ewe', 'lamb', '2019-12-26 10:46:18'),
	(5, 'goat', NULL, 'buck', 'doe', 'buckling', '2019-12-26 10:46:51');
/*!40000 ALTER TABLE `livestock_type` ENABLE KEYS */;

-- Dumping structure for table farmwork.medication
CREATE TABLE IF NOT EXISTS `medication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `desc` varchar(550) DEFAULT NULL,
  `instruction` varchar(2000) DEFAULT NULL,
  `img` varchar(150) DEFAULT NULL,
  `price` decimal(10,2) DEFAULT NULL,
  `on_hand_doses` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COMMENT='list of medication';

-- Dumping data for table farmwork.medication: ~5 rows (approximately)
/*!40000 ALTER TABLE `medication` DISABLE KEYS */;
INSERT INTO `medication` (`id`, `name`, `desc`, `instruction`, `img`, `price`, `on_hand_doses`, `created_at`) VALUES
	(1, 'Tasvax 8', 'For the vaccination of cattle and sheep against diseases caused by Cl. chauvoei (black leg), Cl. haemolyticum (bacillary hemoglobinuria), Cl. novyi Type B (black disease or infectious necrotic hepatitis), Cl. perfringens Type B (lamb dysentery), Type C (hemorrhagic enterotoxemia), type D (pulpy kidney), Cl. septicum (malignant edema) and Cl. tetani (tetanus).', 'Cattle: In order that a balanced response to vaccination is obtained, a primary course of two injections of 4 mL each should be given with an interval of 6 weeks between injections. To maintain a constant high level of immunity, booster injections should be administered at intervals of 6 months, or when outbreaks are seasonal, at least 2 weeks before the anticipated outbreak. Calves vaccinated under 3 months of age should be revaccinated at 4-6 months of age. Calves vaccinated at 3 months of age or older should be revaccinated 6 weeks later. Inject subcutaneously with strict aseptic precautions.', '/uploads/medication/Tasvax 8.jpg', NULL, 10, '2019-05-09 23:02:13'),
	(2, 'Noromectin', 'Each mL contains 0.8 mg of ivermectin.\r\n\r\nTreated animals must not be slaughtered for use in food for at least 14 days after the latest treatment with this drug.', 'Dosage and Administration\r\nNoromectin should be given as a single dose treatment. Administer orally at a dose of 2.5 mL of Noromectin per 10 kg of bodyweight, with any standard drenching equipment which provides a consistent dose volume. Repeat treatment may be necessary when re-exposure to parasite infection occurs.\r\n\r\nNoromectin Drench for Sheep Caution\r\nCoughing, which usually lasts for only a few minutes, may occur in a small percentage of sheep immediately after treatment; this passing response is of no consequence.', 'https://images-na.ssl-images-amazon.com/images/I/81cX3tCC0tL._AC_SY879_.jpg', NULL, 0, '2019-05-09 23:04:31'),
	(4, 'Tetanus Toxoid', 'Anti-toxing vaccination. Takes 2-3 weeks to take effect.', 'Inject intromascularly 1cc/ml. Repeat vaccination in 3-4 weeks again', 'https://www.valleyvet.com/swatches/40277_L_vvs_000.jpg', NULL, 0, '2020-01-04 22:52:43'),
	(5, 'Ivomec', 'IVOMEC Pour-On for Cattle is a clear, blue colored liquid containing 5 mg of ivermectin per mL (0.5% w/v). IVOMEC Pour-On for Cattle is formulated to deliver the recommended dose level of 500 µg of ivermectin per kg of body weight in cattle when applied along the top line from the withers to the tail head at the rate of 1 mL per 10 kg.', 'Apply along the top line from the withers to the tail head at the rate of 1 mL per 10 kg (22 lb).', 'https://media.tractorsupply.com/is/image/TractorSupplyCompany/2207462?$456$', NULL, 0, '2020-02-27 10:11:31'),
	(6, 'Bovi-Shield Gold 5', 'Bovi-Shield GOLD 5 is for vaccination of healthy cattle as an aid in preventing infectious bovine rhinotracheitis caused by infectious bovine rhinotracheitis (IBR) virus, bovine viral diarrhea caused by bovine virus diarrhea (BVD) virus Types 1 and 2, and disease caused by parainfluenza-3 (PI-3) virus and bovine respiratory syncytial (BRS) virus.', 'In accordance with Beef Quality Assurance guidelines, this product should be adminsitered 2 mL subcutaneously in the neck region.', '/uploads/medication/Bovi_Shield_Gold_5.jpg', NULL, 0, '2020-03-08 21:44:04');
/*!40000 ALTER TABLE `medication` ENABLE KEYS */;

-- Dumping structure for table farmwork.planning_project
CREATE TABLE IF NOT EXISTS `planning_project` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `project_name` varchar(250) CHARACTER SET utf8 NOT NULL,
  `project_price` decimal(10,0) NOT NULL DEFAULT 0,
  `project_price_actual` decimal(10,0) NOT NULL DEFAULT 0,
  `is_start` tinyint(4) NOT NULL DEFAULT 0,
  `is_done` tinyint(4) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=126 DEFAULT CHARSET=utf8mb4 COMMENT='financial information for project planning';

-- Dumping data for table farmwork.planning_project: ~0 rows (approximately)
/*!40000 ALTER TABLE `planning_project` DISABLE KEYS */;
/*!40000 ALTER TABLE `planning_project` ENABLE KEYS */;

-- Dumping structure for table farmwork.transaction
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `trans_name` varchar(100) NOT NULL,
  `trans_desc` varchar(250) DEFAULT NULL,
  `trans_ammount` decimal(19,2) NOT NULL,
  `trans_tax` decimal(19,2) NOT NULL DEFAULT 0.00,
  `trans_currency` varchar(10) NOT NULL DEFAULT 'CAD',
  `trans_address` varchar(250) DEFAULT NULL,
  `trans_image` varchar(150) DEFAULT NULL,
  `trans_date` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='record of all transactions';

-- Dumping data for table farmwork.transaction: ~7 rows (approximately)
/*!40000 ALTER TABLE `transaction` DISABLE KEYS */;
INSERT INTO `transaction` (`id`, `trans_name`, `trans_desc`, `trans_ammount`, `trans_tax`, `trans_currency`, `trans_address`, `trans_image`, `trans_date`, `created_at`, `updated_at`) VALUES
	('6f412e9c-a776-11eb-80d2-d8cb8ac0caec', 'hay, corn and soybean meal', NULL, -49.72, 0.00, 'CAD', '1', '', '2019-05-06 16:47:00', '2019-05-08 11:50:32', '2020-12-26 11:21:22'),
	('6f589f1c-a776-11eb-80d2-d8cb8ac0caec', 'hay, corn and soybean meal', NULL, -49.72, 0.00, 'CAD', '1', '', '2019-05-06 16:47:00', '2019-05-08 11:50:32', '2020-12-26 11:21:22'),
	('6f71b3fa-a776-11eb-80d2-d8cb8ac0caec', 'hay, corn and soybean meal', NULL, -49.72, 0.00, 'CAD', '1', '', '2019-05-06 16:47:00', '2019-05-08 11:50:32', '2020-12-26 11:21:22'),
	('6f8a0f5a-a776-11eb-80d2-d8cb8ac0caec', 'hay, corn and soybean meal', NULL, -49.72, 0.00, 'CAD', '1', '', '2019-05-06 16:47:00', '2019-05-08 11:50:32', '2020-12-26 11:21:22'),
	('70780839-a776-11eb-80d2-d8cb8ac0caec', 'hay, corn and soybean meal', NULL, -49.72, 0.00, 'CAD', '1', '', '2019-05-06 16:47:00', '2019-05-08 11:50:32', '2020-12-26 11:21:22'),
	('dc2d7067-6da7-11e9-9b6b-d8cb8ac0caec', 'calves purchase', NULL, -3625.00, 0.00, 'CAD', '1', '', '2019-01-05 09:31:50', '2019-05-03 09:31:50', '2020-12-26 13:24:05'),
	('f36d0a47-a770-11eb-80d2-d8cb8ac0caec', 'hay, corn and soybean meal', NULL, -49.72, 0.00, 'CAD', '1', '', '2019-05-06 16:47:00', '2019-05-08 11:50:32', '2020-12-26 11:21:22');
/*!40000 ALTER TABLE `transaction` ENABLE KEYS */;

-- Dumping structure for table farmwork.transaction_category
CREATE TABLE IF NOT EXISTS `transaction_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `category_name` varchar(150) NOT NULL,
  `category_description` varchar(250) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=47 DEFAULT CHARSET=utf8mb4 COMMENT='Table contains all income and expence types of the farm';

-- Dumping data for table farmwork.transaction_category: ~31 rows (approximately)
/*!40000 ALTER TABLE `transaction_category` DISABLE KEYS */;
INSERT INTO `transaction_category` (`id`, `parent_id`, `category_name`, `category_description`, `created_at`) VALUES
	(1, 0, 'Feed', 'Feed, supplements, straw, and bedding', '2019-04-29 21:32:30'),
	(5, 0, 'Livestock', 'Livestock types (cattle, chicken, horse, sheep, goats etc...)', '2019-05-03 09:30:51'),
	(9, 0, 'Veterinary', 'Veterinary fees, medicine, and breeding fees.', '2019-05-03 09:34:18'),
	(10, 1, 'Hay', '', '2020-11-11 09:25:54'),
	(11, 1, 'Corn', NULL, '2020-11-11 09:26:13'),
	(12, 1, 'Barley', NULL, '2020-11-11 09:26:23'),
	(13, 1, 'Oats', NULL, '2020-11-11 09:26:35'),
	(14, 5, 'Cattle', NULL, '2020-11-11 09:27:15'),
	(15, 5, 'Poultry', NULL, '2020-11-11 09:27:26'),
	(19, 9, 'Tasvax-8', NULL, '2020-11-11 09:28:30'),
	(20, 9, 'Bovi-Shield Gold 5', NULL, '2020-11-11 09:28:55'),
	(21, 1, 'Cracked Corn', NULL, '2020-11-11 09:29:15'),
	(22, 0, 'Equipment', 'Farming equipment purchases or sales', '2020-12-14 12:23:00'),
	(23, 22, 'Tractor', '', '2020-12-14 12:23:21'),
	(24, 5, 'Livestock and Animals', '', '2021-03-07 09:47:40'),
	(26, 0, 'Other', 'Please specify', '2021-03-07 09:49:15'),
	(27, 22, 'Small tools', '', '2021-03-07 09:50:58'),
	(28, 22, 'Gasoline and diesel fuel', '', '2021-03-07 09:51:22'),
	(30, 22, 'Repairs', '', '2021-03-07 09:53:19'),
	(31, 22, 'Oil', '', '2021-03-07 09:54:37'),
	(32, 0, 'Farm', 'Farm expences', '2021-03-07 10:06:09'),
	(33, 32, 'Electricity', '', '2021-03-07 10:06:20'),
	(34, 32, 'Property Tax', '', '2021-03-07 10:06:29'),
	(35, 0, 'Property', 'Property expences', '2021-03-07 10:08:31'),
	(36, 35, 'Electricity', '', '2021-03-07 10:10:47'),
	(37, 35, 'Property Tax', '', '2021-03-07 10:10:55'),
	(38, 32, 'Mortgage interest', '', '2021-03-07 10:40:37'),
	(39, 32, 'Maintenance', '', '2021-03-07 10:41:04'),
	(40, 32, 'Insurance', '', '2021-03-07 10:41:28'),
	(41, 1, 'Milk Replacer', '', '2021-03-14 22:37:01'),
	(45, 0, 'Vehicle', 'Car used for business expenses, such as cattle transportation and feed pickup.', '2021-04-13 14:07:25'),
	(46, 45, 'Gasoline', '', '2021-04-13 14:07:35');
/*!40000 ALTER TABLE `transaction_category` ENABLE KEYS */;

-- Dumping structure for table farmwork.transaction_item
CREATE TABLE IF NOT EXISTS `transaction_item` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `transaction_id` char(36) NOT NULL,
  `item_name` varchar(150) NOT NULL,
  `item_desc` varchar(250) NOT NULL,
  `transaction_category` varchar(150) NOT NULL,
  `transaction_subcategory` varchar(150) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_transaction_item_transaction` (`transaction_id`) USING BTREE,
  CONSTRAINT `FK_transaction_item_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='A table that holds all transaction items.';

-- Dumping data for table farmwork.transaction_item: ~0 rows (approximately)
/*!40000 ALTER TABLE `transaction_item` DISABLE KEYS */;
/*!40000 ALTER TABLE `transaction_item` ENABLE KEYS */;

-- Dumping structure for table farmwork.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `username` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='cattle management members.';

-- Dumping data for table farmwork.user: ~0 rows (approximately)
/*!40000 ALTER TABLE `user` DISABLE KEYS */;
INSERT INTO `user` (`id`, `username`, `password`, `email`, `is_active`, `created_at`) VALUES
	('5e0d0d6c10096', 'farmer', '$2y$10$YxQsfaEVGMokSlb9QuKkUOkYxyLEOpM9XiuMFhrJifnTzjv9lnmze', 'dimasalt@gmail.com', 1, '2020-01-01 16:30:34');
/*!40000 ALTER TABLE `user` ENABLE KEYS */;

-- Dumping structure for table farmwork.user_detail
CREATE TABLE IF NOT EXISTS `user_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` char(36) NOT NULL,
  `fname` varchar(50) DEFAULT NULL,
  `lname` varchar(50) DEFAULT NULL,
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_user_detail_user` (`user_id`),
  CONSTRAINT `FK_user_detail_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4;

-- Dumping data for table farmwork.user_detail: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_detail` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_detail` ENABLE KEYS */;

-- Dumping structure for table farmwork.user_logins
CREATE TABLE IF NOT EXISTS `user_logins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` char(36) NOT NULL,
  `token` varchar(50) NOT NULL,
  `user_agent` varchar(50) NOT NULL,
  `user_ip` varchar(50) NOT NULL,
  `modified_at` timestamp NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  `created_at` timestamp NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_user_logins_user` (`user_id`),
  CONSTRAINT `FK_user_logins_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='contains user login information';

-- Dumping data for table farmwork.user_logins: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_logins` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_logins` ENABLE KEYS */;

-- Dumping structure for table farmwork.user_role
CREATE TABLE IF NOT EXISTS `user_role` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `role` varchar(10) NOT NULL,
  `role_desc` varchar(150) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='member roles in the cattle management system.';

-- Dumping data for table farmwork.user_role: ~2 rows (approximately)
/*!40000 ALTER TABLE `user_role` DISABLE KEYS */;
INSERT INTO `user_role` (`id`, `role`, `role_desc`, `created_at`) VALUES
	('98534618084409345', 'admin', NULL, '2020-01-04 15:24:44'),
	('98534618084409346', 'user', NULL, '2020-01-04 15:24:53');
/*!40000 ALTER TABLE `user_role` ENABLE KEYS */;

-- Dumping structure for table farmwork.user_to_role
CREATE TABLE IF NOT EXISTS `user_to_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `user_id` char(36) NOT NULL,
  `role_id` char(36) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_user_to_role_user` (`user_id`),
  KEY `FK_user_to_role_user_role` (`role_id`),
  CONSTRAINT `FK_user_to_role_user` FOREIGN KEY (`user_id`) REFERENCES `user` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_user_to_role_user_role` FOREIGN KEY (`role_id`) REFERENCES `user_role` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COMMENT='Cattle Management system users and their role connections';

-- Dumping data for table farmwork.user_to_role: ~0 rows (approximately)
/*!40000 ALTER TABLE `user_to_role` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_to_role` ENABLE KEYS */;

-- Dumping structure for table farmwork.vehicle_log_book
CREATE TABLE IF NOT EXISTS `vehicle_log_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year_start_odometer` int(11) NOT NULL,
  `year_end_odometer` int(11) DEFAULT NULL,
  `vehicle_desc` varchar(150) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4;

-- Dumping data for table farmwork.vehicle_log_book: ~2 rows (approximately)
/*!40000 ALTER TABLE `vehicle_log_book` DISABLE KEYS */;
INSERT INTO `vehicle_log_book` (`id`, `year_start_odometer`, `year_end_odometer`, `vehicle_desc`, `created_at`) VALUES
	(1, 175153, 0, '2013 Chevroler Silverado 1500', '2021-01-01 10:57:35');
/*!40000 ALTER TABLE `vehicle_log_book` ENABLE KEYS */;

-- Dumping structure for table farmwork.vehicle_log_book_item
CREATE TABLE IF NOT EXISTS `vehicle_log_book_item` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `vehicle_log_book_id` int(11) NOT NULL,
  `destination` varchar(250) NOT NULL,
  `address` varchar(250) NOT NULL DEFAULT '',
  `purpose` varchar(150) NOT NULL,
  `travel_distance` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `travel_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_vehicle_log_book_item_vehicle_log_book` (`vehicle_log_book_id`),
  CONSTRAINT `FK_vehicle_log_book_item_vehicle_log_book` FOREIGN KEY (`vehicle_log_book_id`) REFERENCES `vehicle_log_book` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COMMENT='vehicle log book to keep track on a business related travel';

-- Dumping data for table farmwork.vehicle_log_book_item: ~6 rows (approximately)
/*!40000 ALTER TABLE `vehicle_log_book_item` DISABLE KEYS */;
INSERT INTO `vehicle_log_book_item` (`id`, `vehicle_log_book_id`, `destination`, `address`, `purpose`, `travel_distance`, `created_at`, `travel_date`) VALUES
	(1, 1, 'Temiskaming Livestock Exchange Ltd', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'Beef calves purchase', 320, '2021-03-08 00:00:00', '2021-03-08 00:00:00'),
	(2, 1, 'Temiskaming Livestock Exchange Ltd', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'Beef calves purchase', 320, '2021-03-16 00:00:00', '2021-03-15 00:00:00'),
	(4, 1, 'Temiskaming Livestock Exchange Ltd', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'Beef calves purchase', 320, '2021-03-22 00:00:00', '2021-03-22 00:00:00'),
	(5, 1, 'Temiskaming Livestock Exchange Ltd', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'Beef calves purchase', 320, '2021-03-29 00:00:00', '2021-03-29 00:00:00'),
	(6, 1, 'Temiskaming Livestock Exchange Ltd', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'Beef calves purchase', 320, '2021-04-05 00:00:00', '2021-04-05 00:00:00'),
	(17, 1, 'Temiskaming Livestock Exchange Ltd', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'Beef calves purchase', 320, '2021-04-13 11:21:45', '2021-04-12 00:00:00'),
	(18, 1, 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'Cattle feed purchase ', 280, '2021-04-20 10:03:22', '2021-04-19 00:00:00');
/*!40000 ALTER TABLE `vehicle_log_book_item` ENABLE KEYS */;

-- Dumping structure for procedure farmwork.contactAdd
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

-- Dumping structure for procedure farmwork.contactDeleteOne
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

-- Dumping structure for procedure farmwork.contactGetOne
DELIMITER //
CREATE PROCEDURE `contactGetOne`(
	IN `contact_id` CHAR(36)
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

-- Dumping structure for procedure farmwork.contactsGetAll
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

-- Dumping structure for procedure farmwork.contactUpdate
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

-- Dumping structure for procedure farmwork.eventAddType
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

-- Dumping structure for procedure farmwork.livestockGetAll
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

-- Dumping structure for procedure farmwork.livestockGetTypeAll
DELIMITER //
CREATE PROCEDURE `livestockGetTypeAll`()
    COMMENT 'get flock types'
BEGIN

	SELECT livestock_type.type_id, livestock_type.type_male, livestock_type.type_female, livestock_type.type_name
	FROM livestock_type;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.medicationAdd
DELIMITER //
CREATE PROCEDURE `medicationAdd`(
	IN `med_name` VARCHAR(50),
	IN `description` VARCHAR(550),
	IN `instruction` VARCHAR(2000),
	IN `price` DECIMAL(10,2),
	IN `on_hand` INT
)
    COMMENT 'inserts new medication item'
BEGIN
		
	-- inserts new medication item
	INSERT INTO medication
		(
			medication.name,
			medication.`desc`,
			medication.instruction,
			medication.price,
			medication.on_hand_doses
		)
	VALUES
		(
			med_name,
			description, 
			instruction,
			price,
			on_hand
		);
		
		
		-- select last inserted record
		-- SELECT * 
		-- FROM 
		--  	medication
		-- WHERE 
		-- 	medication.id = LAST_INSERT_ID();
		
		-- get last insert id
		SELECT LAST_INSERT_ID();
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.medicationDeleteOne
DELIMITER //
CREATE PROCEDURE `medicationDeleteOne`(
	IN `id` INT
)
BEGIN
	
	DELETE FROM medication
	WHERE medication.id = id;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.medicationGetAll
DELIMITER //
CREATE PROCEDURE `medicationGetAll`(
	IN `search_term` VARCHAR(50)
)
BEGIN

	-- Check the length of search string and adjust if needed
	IF LENGTH(search_term) < 2 THEN
		SET search_term = "%";
	ELSE
		SET search_term = CONCAT('%', search_term, '%') ;
	END IF;
	
	-- Run the select query itself
	SELECT 
		medication.id, 
		medication.name, 
		medication.desc, 
		medication.instruction, 
		medication.img,
		medication.price,
		medication.on_hand_doses
	FROM medication
	WHERE (medication.name LIKE search_term)
	ORDER BY medication.name ASC;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.medicationGetOne
DELIMITER //
CREATE PROCEDURE `medicationGetOne`(
	IN `id` INT
)
BEGIN
	
	SELECT medication.id, 
		medication.name, 
		medication.desc, 
		medication.instruction, 
		medication.img,
		medication.price,
		medication.on_hand_doses
	FROM medication
	WHERE medication.id = id;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.medicationUpdate
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

-- Dumping structure for procedure farmwork.projectAdd
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

-- Dumping structure for procedure farmwork.projectDelOne
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

-- Dumping structure for procedure farmwork.projectGetAll
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
		planning_project.is_done,
		DATE(planning_project.created_at) AS created_at						
	FROM 
		planning_project
	ORDER BY created_at ASC; 	

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.projectUpdateOne
DELIMITER //
CREATE PROCEDURE `projectUpdateOne`(
	IN `id` INT,
	IN `project_name` VARCHAR(250),
	IN `project_price` DECIMAL(10,0),
	IN `project_price_actual` DECIMAL(10,0),
	IN `created_at` DATETIME
)
BEGIN

	UPDATE planning_project
	SET	
		planning_project.project_name = project_name,
		planning_project.project_price = project_price,
		planning_project.project_price_actual = project_price_actual,
		planning_project.created_at = created_at		
	WHERE planning_project.id = id;	

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.projectUpdateStatus
DELIMITER //
CREATE PROCEDURE `projectUpdateStatus`(
	IN `id` INT,
	IN `is_done` TINYINT
)
BEGIN

	UPDATE planning_project
	SET 
		planning_project.is_done = is_done	
	WHERE 
		planning_project.id = id;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionCatDelete
DELIMITER //
CREATE PROCEDURE `transactionCatDelete`(
	IN `id` INT
)
    COMMENT 'removes category or sub category'
BEGIN
		
		-- remove category by id (if main category)
		DELETE FROM transaction_category 
		WHERE transaction_category.id = id;
		
		-- remove all sub categories
		DELETE FROM transaction_category 
		WHERE transaction_category.parent_id = id;
		
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionCatGetAll
DELIMITER //
CREATE PROCEDURE `transactionCatGetAll`()
BEGIN
	
	SELECT 
		transaction_category.id,
		transaction_category.parent_id,
		transaction_category.category_name,
		transaction_category.category_description
	FROM transaction_category 
	WHERE transaction_category.parent_id = 0
	GROUP BY transaction_category.category_name
	ORDER BY transaction_category.category_name ASC;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionCatGetAllSubs
DELIMITER //
CREATE PROCEDURE `transactionCatGetAllSubs`(
	IN `parent_id` INT
)
BEGIN

	SELECT 
		transaction_category.id,
		transaction_category.parent_id,
		transaction_category.category_name,
		transaction_category.category_description
	FROM transaction_category
	WHERE transaction_category.parent_id = parent_id
	ORDER BY transaction_category.category_name ASC;

-- 	SELECT 
-- 		transaction_subcategory.id,
-- 		transaction_subcategory.category_id,
-- 		transaction_subcategory.category_sub_name,
-- 		transaction_subcategory.category_sub_description
-- 	FROM 
-- 		transaction_subcategory
-- 	WHERE 
-- 		transaction_subcategory.category_id = id
-- 	ORDER by
-- 		transaction_subcategory.category_sub_name ASC;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionCatSave
DELIMITER //
CREATE PROCEDURE `transactionCatSave`(
	IN `id` INT,
	IN `parent_id` INT,
	IN `category_name` VARCHAR(150),
	IN `category_description` VARCHAR(250)
)
    COMMENT 'procedure to update, insert or save transaction category or sub category record'
BEGIN

	-- if new category
	IF id = 0 THEN
			
			INSERT INTO transaction_category(parent_id, category_name, category_description)
			VALUES (parent_id, category_name, category_description);				
		
	-- if update category	
	ELSEIF id != 0 THEN
		
		UPDATE transaction_category
		SET 
			transaction_category.parent_id = parent_id, 
			transaction_category.category_name = category_name, 
			transaction_category.category_description = category_description
		WHERE transaction_category.id = id;			
		
	END IF;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionCreate
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

-- Dumping structure for procedure farmwork.transactionDelMain
DELIMITER //
CREATE PROCEDURE `transactionDelMain`(
	IN `id` CHAR(36)
)
BEGIN

	DELETE 
	FROM transaction 
	WHERE transaction.id = id;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionsGetAll
DELIMITER //
CREATE PROCEDURE `transactionsGetAll`(
	IN `search_term` VARCHAR(50),
	IN `page_num` INT,
	IN `records_take` INT
)
BEGIN

	-- prepare search term
	IF LENGTH(search_term) < 2 THEN
		SET search_term = "%";
	ELSE
		SET search_term = CONCAT('%', search_term, '%') ;
	END IF;

	SELECT 
		transaction.id,
		transaction.trans_name,
		transaction.trans_desc,
		transaction.trans_ammount,
		transaction.trans_tax,
		transaction.trans_currency,
		transaction.trans_address,
		transaction.trans_date
	FROM 
		transaction
	WHERE 		
			transaction.trans_name LIKE search_term
			OR transaction.trans_desc LIKE search_term
			OR transaction.trans_address LIKE search_term
	ORDER BY transaction.trans_date DESC;
		

-- 	SELECT transaction.id, 
-- 			transaction_category.trans_cat_subname, 
-- 			transaction_category.trans_cat_name,
-- 			transaction_type.trans_type_name, 
-- 			transaction.trans_ammount, 
-- 			transaction.trans_currency,
-- 			transaction.trans_date
-- 	From transaction
-- 	inner join transaction_category on transaction.trans_cat_id = transaction_category.id
-- 	inner join transaction_type on transaction.trans_type_id = transaction_type.id
-- 	ORDER BY transaction.trans_date DESC;
-- 
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.userCreate
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

-- Dumping structure for procedure farmwork.vehicleAddOrEditOdometer
DELIMITER //
CREATE PROCEDURE `vehicleAddOrEditOdometer`(
	IN `id` INT,
	IN `year_start_odometer` INT,
	IN `year_end_odometer` INT,
	IN `vehicle_desc` VARCHAR(150),
	IN `created_at` VARCHAR(50)
)
BEGIN

IF id = 0 THEN

	INSERT INTO vehicle_log_book
	(
		year_start_odometer,
		year_end_odometer, 
		vehicle_desc, 
		created_at
	)
	VALUES 
	(
		year_start_odometer,
		year_end_odometer,
		vehicle_desc,
		created_at
	);
	
ELSEIF id > 0 THEN

	UPDATE 
		vehicle_log_book
	SET 
		vehicle_log_book.year_start_odometer = year_start_odometer,
		vehicle_log_book.year_end_odometer = year_end_odometer,
		vehicle_log_book.vehicle_desc = vehicle_desc
	WHERE vehicle_log_book.id = id;
	
END IF;
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.vehicleAddTravelRecord
DELIMITER //
CREATE PROCEDURE `vehicleAddTravelRecord`(
	IN `vehicle_log_book_id` INT,
	IN `destination` VARCHAR(250),
	IN `address` VARCHAR(250),
	IN `purpose` VARCHAR(150),
	IN `travel_distance` INT,
	IN `travel_date` DATETIME
)
BEGIN

	INSERT 
		INTO vehicle_log_book_item
		(
			vehicle_log_book_item.vehicle_log_book_id,
			vehicle_log_book_item.destination,
			vehicle_log_book_item.address,
			vehicle_log_book_item.purpose,
			vehicle_log_book_item.travel_distance,
			vehicle_log_book_item.travel_date
		)
	VALUES
		(
			vehicle_log_book_id,
			destination,
			address,
			purpose,
			travel_distance,
			travel_date	
		);

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.vehicleDelOdometer
DELIMITER //
CREATE PROCEDURE `vehicleDelOdometer`(
	IN `id` INT
)
BEGIN

	DELETE FROM vehicle_log_book
	WHERE vehicle_log_book.id = id;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.vehicleDelTravelRecord
DELIMITER //
CREATE PROCEDURE `vehicleDelTravelRecord`(
	IN `id` INT
)
BEGIN

	DELETE FROM vehicle_log_book_item
	WHERE vehicle_log_book_item.id = id;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.vehicleGetOdometer
DELIMITER //
CREATE PROCEDURE `vehicleGetOdometer`(
	IN `select_year` VARCHAR(50)
)
BEGIN

	SELECT 
		vehicle_log_book.id,
		vehicle_log_book.year_start_odometer,
		vehicle_log_book.year_end_odometer,
		vehicle_log_book.vehicle_desc,
		YEAR(vehicle_log_book.created_at) AS 'created_at'
	FROM vehicle_log_book
	WHERE YEAR(vehicle_log_book.created_at) = select_year
	LIMIT 1;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.vehicleGetTravelRecords
DELIMITER //
CREATE PROCEDURE `vehicleGetTravelRecords`(
	IN `year_id` INT
)
BEGIN

SELECT 
	vehicle_log_book_item.id,
	vehicle_log_book_item.destination,
	vehicle_log_book_item.address,
	vehicle_log_book_item.purpose,
	vehicle_log_book_item.travel_distance,
	vehicle_log_book_item.travel_date
FROM vehicle_log_book_item
WHERE vehicle_log_book_item.vehicle_log_book_id = year_id
ORDER BY vehicle_log_book_item.travel_date DESC;

END//
DELIMITER ;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
