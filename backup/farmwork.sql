-- --------------------------------------------------------
-- Host:                         localhost
-- Server version:               10.10.2-MariaDB - mariadb.org binary distribution
-- Server OS:                    Win64
-- HeidiSQL Version:             12.3.0.6589
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

-- Dumping structure for table farmwork.budget
CREATE TABLE IF NOT EXISTS `budget` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `budget_name` varchar(150) NOT NULL,
  `budget_amount` decimal(19,2) NOT NULL,
  `budget_amount_actual` decimal(19,2) NOT NULL,
  `is_done` tinyint(4) NOT NULL DEFAULT 0,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  `budget_date` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=78 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Keeps financial planning and budgeting records';

-- Dumping data for table farmwork.budget: ~10 rows (approximately)
INSERT INTO `budget` (`id`, `parent_id`, `budget_name`, `budget_amount`, `budget_amount_actual`, `is_done`, `is_default`, `budget_date`) VALUES
	(10, 0, 'Gross budget for year 2022', 0.00, 0.00, 0, 1, '2022-01-01 00:00:00'),
	(11, 10, '60 head of cattle gross after taxes', 54000.00, 0.00, 0, 0, '2023-04-30 00:00:00'),
	(12, 10, 'German Shepherd puppies 8', 8000.00, 0.00, 0, 0, '2022-12-31 00:00:00'),
	(13, 10, 'Dmitri Salary after the tax', 27000.00, 0.00, 0, 0, '2022-12-31 00:00:00'),
	(14, 10, 'Ilana Salary after the tax', 12000.00, 0.00, 0, 0, '2022-12-31 00:00:00'),
	(72, 0, 'Equipment expences', 0.00, 0.00, 0, 0, '2022-02-01 00:00:00'),
	(73, 72, 'Bush Hog', -2500.00, 0.00, 0, 0, '2021-11-30 00:00:00'),
	(74, 72, 'Tractor Tiller', -3000.00, 0.00, 0, 0, '2021-11-30 00:00:00'),
	(75, 72, 'Grain Bin 10 tone', -3000.00, 0.00, 0, 0, '2021-11-30 00:00:00'),
	(76, 72, 'Box Blade', -2000.00, 0.00, 0, 0, '2021-11-30 00:00:00'),
	(77, 72, 'Snow Blower', -2000.00, 0.00, 0, 0, '2021-11-30 00:00:00');

-- Dumping structure for table farmwork.contact
CREATE TABLE IF NOT EXISTS `contact` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `name` varchar(100) NOT NULL,
  `address` varchar(150) DEFAULT NULL,
  `phone` varchar(50) DEFAULT NULL,
  `email` varchar(50) DEFAULT NULL,
  `note` varchar(250) DEFAULT NULL,
  `type` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Keeps contacts for contact book and vendors (for transactions and others)\r\n0 - normal contact\r\n1 - vendor\r\n2 - customer';

-- Dumping data for table farmwork.contact: ~26 rows (approximately)
INSERT INTO `contact` (`id`, `name`, `address`, `phone`, `email`, `note`, `type`, `created_at`) VALUES
	('08fbabe8-e808-11eb-8df3-d8cb8ac0caec', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', '705-647-5365', '', 'supplier for bulk feed and other farm items', 1, '2021-07-18 16:37:50'),
	('0b09f1ff-952d-11ed-8ff1-d8cb8ac0caec', 'Rita', '1136 Park Ave, Timmins', '705-465-1014', NULL, 'Buys a package once every 2 months', 2, '2023-01-15 18:33:40'),
	('0e00ff77-952f-11ed-8ff1-d8cb8ac0caec', 'Richard Dechene', '158 Croatia Ave, Schumacher', '705-360-3629', NULL, 'Older couple. First time buyer. Was buying beef from another farm before.', 2, '2023-01-15 18:48:04'),
	('0f0f6a0f-952e-11ed-8ff1-d8cb8ac0caec', 'Anthony', '583 Couture Ave, Timmins', '705-268-2540', NULL, 'Brothers, buys package every 2 months', 2, '2023-01-15 18:40:57'),
	('11d2fef9-e813-11eb-8df3-d8cb8ac0caec', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', '705-647-5415', '', 'Livestock Exchange. Barn sale of livestock.', 1, '2021-07-18 17:56:49'),
	('32db8849-952e-11ed-8ff1-d8cb8ac0caec', 'Dave Cote', '63 Tamarack St, Timmins', '705-363-5225', NULL, 'Buys beef every month. Work Address: Building of Foodland', 2, '2023-01-15 18:41:57'),
	('40233c6c-142e-11ec-808f-d8cb8ac0caec', 'Thornloe Farm Supply Inc', '31 Main St, Thornloe, ON, P0J 1S0', '705-563-2555', '', 'Farm supply store', 1, '2021-09-12 21:01:29'),
	('42e3cf72-1a10-11ec-9d60-d8cb8ac0caec', 'Ontario Stockyards Inc', '3807 ON-89, Cookstown, ON L0L 1L0', '705-458-4000', '', 'Livestock auction. Barn livestock sales.', 1, '2021-09-20 08:42:46'),
	('51021095-952d-11ed-8ff1-d8cb8ac0caec', 'Peter + Elena', '8345 Kamiskotia Rd, Timmins', '705-365-2131', NULL, 'Buys package once a month, likes soup bones', 2, '2023-01-15 18:35:38'),
	('66723273-952e-11ed-8ff1-d8cb8ac0caec', 'Curtis', '130 Camille St, Timmins', '705-262-7763', NULL, 'Wants 15 lb of ground beef in package', 2, '2023-01-15 18:43:23'),
	('6fab9fc6-952d-11ed-8ff1-d8cb8ac0caec', 'Jerry', '51 Lincoln ave, Timmins', '705-360-3671', NULL, 'Buys a package once every 2 months. Doesn\'t like ground beef.', 2, '2023-01-15 18:36:29'),
	('7775b8f5-a8cc-11ec-ac57-d8cb8ac0caec', 'LEIS Landscaping & Country Store', '998063 Hwy 11 North, New Liskeard, Ontario, P0J 1P0', '705-648-1384', 'lw@xplornet.ca', NULL, 1, '2022-03-21 00:07:32'),
	('797e5e64-e83d-11eb-8df3-d8cb8ac0caec', 'Petro-Canada', '4310 Harold Ave, South Porcupine, ON P0N 1H0', '705-235-4797', '', 'One of the local gas stations', 1, '2021-07-18 23:00:22'),
	('81a77d42-a76d-11eb-80d2-d8cb8ac0caec', 'Little Bit Western', '372 Algonquin Boulevard W, Timmins, On, P4N 2S2, Canada', '705-268-0822', NULL, 'Feed store. A bit on expensive side. Doesn\'t sell much for Cattle. Mostly things for chicken, hogs and horses.', 1, '2019-04-29 21:31:35'),
	('81a77fe9-a76d-11eb-80d2-d8cb8ac0caec', 'Northern Allied', '352 Railway St, Timmins, On, P4N 2P6, Canada', '7052645291', NULL, 'Metal supply company. The only one in Timmins.', 1, '2020-02-18 23:39:43'),
	('81a781a5-a76d-11eb-80d2-d8cb8ac0caec', 'Mark', 'Matheson, On, p0k 1n0, Canada', '705-262-3433', NULL, 'Neighbour farmer. Wants to buy cattle. May not keep the word.', 3, '2020-02-27 10:59:32'),
	('81a78279-a76d-11eb-80d2-d8cb8ac0caec', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', '705-232-6662', NULL, 'Manonite owned feed store, with more or less ok prices', 1, '2020-01-05 07:01:53'),
	('81a78332-a76d-11eb-80d2-d8cb8ac0caec', 'Samuel M.', 'On, Canada', '705-232-2380', NULL, 'Manonite. Sells lumber and posts for fencing or/and construction.', 1, '2020-04-08 17:19:45'),
	('81a783e7-a76d-11eb-80d2-d8cb8ac0caec', 'Cleason Marting', 'Country Ln, Val Gagne, On, Canada', '705-232-2039', NULL, 'Manonite. Sells bolts, pins and other metal hardware. The place is the first house on Hwy 11/Country Ln.', 1, '2020-04-08 17:23:04'),
	('81a784ae-a76d-11eb-80d2-d8cb8ac0caec', 'Northern Veterinary Hospital', '#741, HWY 67, Iroquois Falls, On, P0K1G0, Canada', '705-232-7700', NULL, 'Cattle and dog vaccinations', 1, '2020-01-05 12:08:41'),
	('8ace6383-952e-11ed-8ff1-d8cb8ac0caec', 'Melanie', '219 Wende Ave, Timmins', '705-262-9620', NULL, 'Dave gf’s friend', 2, '2023-01-15 18:44:24'),
	('a62e785f-952e-11ed-8ff1-d8cb8ac0caec', 'Rocio', '211 Malette Crescent, Timmins', '705-347-9738', NULL, 'Rita\'s friend', 2, '2023-01-15 18:45:10'),
	('cd60fe10-976e-11ec-bdb9-d8cb8ac0caec', 'A-Mar Meats', 'Red Deer Rd E, Val Gagné, ON P0K 1W0', '705-232-6328', '', 'A local butcher shop', 1, '2022-02-26 20:43:07'),
	('d5928c25-952e-11ed-8ff1-d8cb8ac0caec', 'Arlene', '407 Shub Ave, Timmins', '416-999-4718', NULL, 'Works in Home Depot, husband did not like some of the beef in package', 2, '2023-01-15 18:46:30'),
	('f2ba5e83-952d-11ed-8ff1-d8cb8ac0caec', 'Ernie', '992 Suzane st, Timmins', 'tel 705-268-4137, cel 705-465-3602', NULL, 'Brothers, buys package every 2 months', 2, '2023-01-15 18:40:09'),
	('fbb8e5a9-952e-11ed-8ff1-d8cb8ac0caec', 'Christina', '243 Kellyann Dr, Timmins', '705-221-0934', NULL, 'Ilana\'s native friend', 2, '2023-01-15 18:47:34');

-- Dumping structure for table farmwork.contact_type
CREATE TABLE IF NOT EXISTS `contact_type` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(50) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table farmwork.contact_type: ~2 rows (approximately)
INSERT INTO `contact_type` (`id`, `type`) VALUES
	(1, 'vendor'),
	(2, 'customer'),
	(3, 'contact');

-- Dumping structure for table farmwork.event
CREATE TABLE IF NOT EXISTS `event` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `ev_type_id` char(36) NOT NULL,
  `livestock_id` char(36) NOT NULL,
  `ev_value` varchar(50) NOT NULL DEFAULT '',
  `note` varchar(250) NOT NULL,
  `ev_date` datetime NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_event_event_type` (`ev_type_id`),
  KEY `FK_event_livestock` (`livestock_id`),
  CONSTRAINT `FK_event_event_type` FOREIGN KEY (`ev_type_id`) REFERENCES `event_type` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_event_livestock` FOREIGN KEY (`livestock_id`) REFERENCES `livestock` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Contains events that occured in the past';

-- Dumping data for table farmwork.event: ~0 rows (approximately)

-- Dumping structure for table farmwork.event_type
CREATE TABLE IF NOT EXISTS `event_type` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `ev_type_name` varchar(25) NOT NULL,
  `ev_type_desc` varchar(300) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Types of events for a farm livestock. Space column used selection order when displayed in the list on website.';

-- Dumping data for table farmwork.event_type: ~7 rows (approximately)
INSERT INTO `event_type` (`id`, `ev_type_name`, `ev_type_desc`, `created_at`) VALUES
	('006e21ef-acfc-11eb-a999-d8cb8ac0caec', 'Birth Date', 'Used to associate an animal’s birth date with its unique approved tag number.', '2019-05-05 21:00:17'),
	('0071c376-acfc-11eb-a999-d8cb8ac0caec', 'Weight', 'Used to report the weight of livestock.', '2020-01-04 16:01:31'),
	('00752389-acfc-11eb-a999-d8cb8ac0caec', 'Castration/Banding', 'Used to report of castration or banding of livestock', '2020-01-04 15:58:24'),
	('6f8a3e4a-5797-11ec-97c9-d8cb8ac0caec', 'Purchase', 'Used to report purchase date and price', '2021-12-07 14:54:00'),
	('7cd44d88-5797-11ec-97c9-d8cb8ac0caec', 'Sale', 'Used to report sale price and date', '2021-12-07 14:54:22'),
	('88f7cc5e-acfb-11eb-a999-d8cb8ac0caec', 'Medicated', 'Used to report medication use on a livestock', '2019-05-05 21:19:43'),
	('b1d57a36-acfb-11eb-a999-d8cb8ac0caec', 'Hoof Trimming', 'Used to report a hoof trimming performed on the animal', '2019-05-09 23:10:51');

-- Dumping structure for table farmwork.event_type_bak
CREATE TABLE IF NOT EXISTS `event_type_bak` (
  `ev_type_id` char(36) NOT NULL DEFAULT uuid(),
  `ev_type_name` varchar(20) NOT NULL,
  `ev_type_value` varchar(25) NOT NULL,
  `ev_type_desc` varchar(300) DEFAULT NULL,
  `place` tinyint(4) NOT NULL DEFAULT 100,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`ev_type_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Types of events for a farm livestock. Space column used selection order when displayed in the list on website.';

-- Dumping data for table farmwork.event_type_bak: ~12 rows (approximately)
INSERT INTO `event_type_bak` (`ev_type_id`, `ev_type_name`, `ev_type_value`, `ev_type_desc`, `place`, `created_at`) VALUES
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

-- Dumping structure for table farmwork.feed
CREATE TABLE IF NOT EXISTS `feed` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `feed_name` varchar(150) NOT NULL,
  `feed_desc` varchar(250) DEFAULT NULL,
  `feed_cp` int(11) NOT NULL,
  `feed_tdn` int(11) NOT NULL,
  `feed_type` varchar(25) NOT NULL,
  `feed_price` decimal(19,2) NOT NULL DEFAULT 0.00,
  `feed_price_lb` int(11) DEFAULT NULL,
  `feed_usage` int(11) NOT NULL DEFAULT 100,
  `is_default` tinyint(4) NOT NULL DEFAULT 0,
  `feed_date` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Contains feed information such as CP, TDN and prices';

-- Dumping data for table farmwork.feed: ~5 rows (approximately)
INSERT INTO `feed` (`id`, `feed_name`, `feed_desc`, `feed_cp`, `feed_tdn`, `feed_type`, `feed_price`, `feed_price_lb`, `feed_usage`, `is_default`, `feed_date`) VALUES
	(1, 'Cracked Corn', NULL, 10, 90, 'Grain', 549.00, 2000, 100, 1, '2021-10-26 11:32:41'),
	(2, 'Hay', NULL, 7, 55, 'Hay', 5.00, 60, 100, 1, '2021-11-08 19:48:22'),
	(3, 'Soybean Meal', NULL, 47, 77, 'Protein', 22.00, 60, 100, 1, '2021-11-08 19:48:27'),
	(16, '40% Beef Supplement', '', 40, 0, 'Mineral', 23.00, 55, 18, 0, '2021-12-18 08:40:16');

-- Dumping structure for table farmwork.feed_requirement
CREATE TABLE IF NOT EXISTS `feed_requirement` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `weight` int(11) NOT NULL DEFAULT 0,
  `animal_type` varchar(50) NOT NULL,
  `adg` decimal(19,1) NOT NULL,
  `dm_per_day` decimal(19,1) NOT NULL,
  `cp` decimal(19,1) NOT NULL DEFAULT 0.0,
  `tdn` int(11) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Keeps information on feed requirements for animals in different stages';

-- Dumping data for table farmwork.feed_requirement: ~35 rows (approximately)
INSERT INTO `feed_requirement` (`id`, `weight`, `animal_type`, `adg`, `dm_per_day`, `cp`, `tdn`) VALUES
	(1, 200, 'steer/heifer', 3.0, 5.4, 22.0, 80),
	(2, 300, 'steer/heifer', 1.0, 8.3, 11.5, 58),
	(3, 300, 'steer/heifer', 1.5, 8.6, 13.7, 63),
	(4, 300, 'steer/heifer', 2.0, 8.6, 16.2, 68),
	(5, 300, 'steer/heifer', 2.5, 8.6, 18.7, 73),
	(6, 300, 'steer/heifer', 3.0, 8.3, 22.0, 80),
	(7, 400, 'steer/heifer', 1.0, 10.3, 10.4, 58),
	(8, 400, 'steer/heifer', 1.5, 10.6, 13.3, 63),
	(9, 400, 'steer/heifer', 2.0, 10.7, 14.1, 68),
	(10, 400, 'steer/heifer', 2.5, 10.7, 16.1, 73),
	(11, 400, 'steer/heifer', 3.0, 10.4, 18.7, 80),
	(12, 500, 'steer/heifer', 1.0, 12.2, 9.8, 58),
	(13, 500, 'steer/heifer', 1.5, 12.6, 11.2, 63),
	(14, 500, 'steer/heifer', 2.0, 12.6, 12.9, 68),
	(15, 500, 'steer/heifer', 2.5, 12.6, 14.6, 73),
	(16, 500, 'steer/heifer', 3.0, 12.2, 16.8, 80),
	(17, 600, 'steer/heifer', 1.0, 14.0, 9.3, 58),
	(18, 600, 'steer/heifer', 1.5, 14.4, 10.6, 63),
	(19, 600, 'steer/heifer', 2.0, 14.4, 12.1, 68),
	(20, 600, 'steer/heifer', 2.5, 14.4, 13.5, 73),
	(21, 600, 'steer/heifer', 3.0, 14.0, 15.4, 80),
	(22, 700, 'steer/heifer', 1.0, 15.7, 9.0, 58),
	(23, 700, 'steer/heifer', 1.5, 16.2, 10.1, 63),
	(24, 700, 'steer/heifer', 2.0, 16.3, 11.3, 68),
	(25, 700, 'steer/heifer', 2.5, 16.2, 12.7, 73),
	(26, 700, 'steer/heifer', 3.0, 15.8, 14.4, 80),
	(27, 840, 'steer/heifer', 2.0, 22.1, 8.8, 60),
	(28, 840, 'steer/heifer', 3.0, 21.6, 10.8, 70),
	(29, 840, 'steer/heifer', 3.8, 20.4, 12.8, 80),
	(30, 840, 'steer/heifer', 4.3, 18.8, 14.7, 90),
	(31, 900, 'steer/heifer', 2.0, 23.3, 8.4, 60),
	(32, 900, 'steer/heifer', 3.0, 22.7, 10.2, 70),
	(33, 900, 'steer/heifer', 3.8, 21.5, 12.0, 80),
	(34, 900, 'steer/heifer', 4.3, 19.8, 13.8, 90),
	(35, 960, 'steer/heifer', 2.0, 24.4, 8.1, 60),
	(36, 960, 'steer/heifer', 3.0, 23.9, 9.7, 70),
	(37, 960, 'steer/heifer', 3.8, 22.5, 11.3, 80),
	(38, 960, 'steer/heifer', 4.3, 20.8, 13.0, 90);

-- Dumping structure for table farmwork.livestock
CREATE TABLE IF NOT EXISTS `livestock` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `tag` varchar(50) NOT NULL,
  `livestock_type` varchar(10) NOT NULL DEFAULT '',
  `livestock_subtype` varchar(10) NOT NULL DEFAULT '',
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='flock details';

-- Dumping data for table farmwork.livestock: ~2 rows (approximately)
INSERT INTO `livestock` (`id`, `tag`, `livestock_type`, `livestock_subtype`, `is_active`, `created_at`) VALUES
	('3b8a3e14-acef-11eb-81f8-d8cb8ac0caec', '120473774', 'Cattle', 'steer', 1, '2021-04-12 11:41:25'),
	('ccc4a7d5-ad0d-11eb-a999-d8cb8ac0caec', '120333154', 'Cattle', 'steer', 1, '2021-04-09 11:41:25');

-- Dumping structure for table farmwork.livestock_category
CREATE TABLE IF NOT EXISTS `livestock_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `category_name` varchar(150) NOT NULL,
  `category_description` varchar(250) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=32 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='contains animal types present on the farm';

-- Dumping data for table farmwork.livestock_category: ~21 rows (approximately)
INSERT INTO `livestock_category` (`id`, `parent_id`, `category_name`, `category_description`, `created_at`) VALUES
	(7, 0, 'Cattle', NULL, '2021-11-30 14:34:43'),
	(8, 7, 'steer', NULL, '2021-11-30 14:35:10'),
	(9, 7, 'heifer', NULL, '2021-11-30 14:35:10'),
	(10, 7, 'bull', NULL, '2021-11-30 14:35:53'),
	(11, 7, 'cow', NULL, '2021-11-30 14:36:35'),
	(12, 0, 'Chicken', NULL, '2021-11-30 14:37:42'),
	(13, 12, 'rooster', NULL, '2021-11-30 14:38:00'),
	(14, 12, 'chick', NULL, '2021-11-30 14:38:10'),
	(15, 0, 'Sheep', NULL, '2021-11-30 14:38:36'),
	(16, 15, 'ram', NULL, '2021-11-30 14:38:49'),
	(17, 15, 'ewe', NULL, '2021-11-30 14:38:59'),
	(18, 15, 'lamb', NULL, '2021-11-30 14:39:09'),
	(19, 0, 'Goat', NULL, '2021-11-30 14:39:28'),
	(20, 19, 'buck', NULL, '2021-11-30 14:39:38'),
	(21, 19, 'doe', NULL, '2021-11-30 14:39:52'),
	(22, 19, 'buckling', NULL, '2021-11-30 14:40:03'),
	(23, 0, 'Dog', NULL, '2021-11-30 14:40:09'),
	(24, 23, 'male', NULL, '2021-11-30 14:40:30'),
	(25, 23, 'female', NULL, '2021-11-30 14:40:39'),
	(26, 23, 'male puppy', NULL, '2021-11-30 14:40:54'),
	(27, 23, 'female puppy', NULL, '2021-11-30 14:41:04');

-- Dumping structure for table farmwork.livestock_group
CREATE TABLE IF NOT EXISTS `livestock_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `group_name` varchar(150) NOT NULL,
  `group_desc` varchar(250) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='contains groups of animals grouped together for the purpose of feeding or breading';

-- Dumping data for table farmwork.livestock_group: ~2 rows (approximately)
INSERT INTO `livestock_group` (`id`, `group_name`, `group_desc`, `created_at`) VALUES
	(1, 'July Group First', NULL, '2021-12-14 00:13:33'),
	(2, 'July Group Second', NULL, '2021-12-14 00:14:10'),
	(3, 'August Group', NULL, '2021-12-14 00:14:19');

-- Dumping structure for table farmwork.livestock_to_group
CREATE TABLE IF NOT EXISTS `livestock_to_group` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `livestock_id` char(36) NOT NULL,
  `group_id` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_livestock_to_group_livestock` (`livestock_id`),
  KEY `FK_livestock_to_group_livestock_group` (`group_id`),
  CONSTRAINT `FK_livestock_to_group_livestock` FOREIGN KEY (`livestock_id`) REFERENCES `livestock` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `FK_livestock_to_group_livestock_group` FOREIGN KEY (`group_id`) REFERENCES `livestock_group` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='reference table that connects created groups to existing livestock';

-- Dumping data for table farmwork.livestock_to_group: ~0 rows (approximately)

-- Dumping structure for table farmwork.medication
CREATE TABLE IF NOT EXISTS `medication` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(50) NOT NULL,
  `desc` varchar(550) DEFAULT NULL,
  `instruction` varchar(2000) DEFAULT NULL,
  `img` varchar(150) DEFAULT NULL,
  `price` decimal(19,2) DEFAULT 0.00,
  `on_hand_doses` int(11) NOT NULL DEFAULT 0,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=41 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='list of medication';

-- Dumping data for table farmwork.medication: ~6 rows (approximately)
INSERT INTO `medication` (`id`, `name`, `desc`, `instruction`, `img`, `price`, `on_hand_doses`, `created_at`) VALUES
	(1, 'Tasvax 8', '<p>For the vaccination of cattle and sheep against diseases caused by Cl. chauvoei (black leg), Cl. haemolyticum (bacillary hemoglobinuria), Cl. novyi Type B (black disease or infectious necrotic hepatitis), Cl. perfringens Type B (lamb dysentery), Type C (hemorrhagic enterotoxemia), type D (pulpy kidney), Cl. septicum (malignant edema) and Cl. tetani (tetanus).</p>', '<p>Cattle: In order that a balanced response to vaccination is obtained, a primary course of two injections of 4 mL each should be given with an interval of 6 weeks between injections. To maintain a constant high level of immunity, booster injections should be administered at intervals of 6 months, or when outbreaks are seasonal, at least 2 weeks before the anticipated outbreak. Calves vaccinated under 3 months of age should be revaccinated at 4-6 months of age. Calves vaccinated at 3 months of age or older should be revaccinated 6 weeks later. Inject subcutaneously with strict aseptic precautions.</p>', '/uploads/medication/tasvax-8.jpg', 0.00, 0, '2019-05-09 23:02:13'),
	(2, 'Noromectin', '<p>Each mL contains 0.8 mg of ivermectin. Treated animals must not be slaughtered for use in food for at least 14 days after the latest treatment with this drug.</p>', '<p>Dosage and Administration Noromectin should be given as a single dose treatment. Administer orally at a dose of 2.5 mL of Noromectin per 10 kg of bodyweight, with any standard drenching equipment which provides a consistent dose volume. Repeat treatment may be necessary when re-exposure to parasite infection occurs. Noromectin Drench for Sheep Caution Coughing, which usually lasts for only a few minutes, may occur in a small percentage of sheep immediately after treatment; this passing response is of no consequence.</p>', 'https://images-na.ssl-images-amazon.com/images/I/81cX3tCC0tL._AC_SY879_.jpg', 0.00, 0, '2019-05-09 23:04:31'),
	(4, 'Tetanus Toxoid', 'Anti-toxing vaccination. Takes 2-3 weeks to take effect.', 'Inject intromascularly 1cc/ml. Repeat vaccination in 3-4 weeks again', 'https://www.valleyvet.com/swatches/40277_L_vvs_000.jpg', 0.00, 0, '2020-01-04 22:52:43'),
	(5, 'Ivomec', '<p>IVOMEC Pour-On for Cattle is a clear, blue colored liquid containing 5 mg of ivermectin per mL (0.5% w/v). IVOMEC Pour-On for Cattle is formulated to deliver the recommended dose level of 500 &micro;g of ivermectin per kg of body weight in cattle when applied along the top line from the withers to the tail head at the rate of 1 mL per 10 kg.</p>', '<p>Apply along the top line from the withers to the tail head at the rate of 1 mL per 10 kg (or per 22 lb).</p>', '/uploads/medication/ivomec.jpg', 0.00, 0, '2020-02-27 10:11:31'),
	(6, 'Bovi-Shield Gold 5', 'Bovi-Shield GOLD 5 is for vaccination of healthy cattle as an aid in preventing infectious bovine rhinotracheitis caused by infectious bovine rhinotracheitis (IBR) virus, bovine viral diarrhea caused by bovine virus diarrhea (BVD) virus Types 1 and 2, and disease caused by parainfluenza-3 (PI-3) virus and bovine respiratory syncytial (BRS) virus.', 'In accordance with Beef Quality Assurance guidelines, this product should be adminsitered 2 mL subcutaneously in the neck region.', '/uploads/medication/Bovi_Shield_Gold_5.jpg', 0.00, 0, '2020-03-08 21:44:04');

-- Dumping structure for table farmwork.page_settings
CREATE TABLE IF NOT EXISTS `page_settings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `page_name` varchar(50) NOT NULL,
  `setting_name` varchar(50) NOT NULL,
  `setting_value` varchar(50) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Table contains default page settings thats are being pulled during page load';

-- Dumping data for table farmwork.page_settings: ~2 rows (approximately)
INSERT INTO `page_settings` (`id`, `page_name`, `setting_name`, `setting_value`) VALUES
	(1, 'Accounting Records', 'start_date', '2021-01-01'),
	(2, 'Accounting Records', 'end_date', '2021-12-31'),
	(3, 'Vehicle Log Book', 'booklog_date', '2021-01-01');

-- Dumping structure for table farmwork.transaction
CREATE TABLE IF NOT EXISTS `transaction` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `trans_desc` varchar(250) DEFAULT NULL,
  `vendor_name` varchar(50) DEFAULT NULL,
  `vendor_address` varchar(250) DEFAULT NULL,
  `trans_currency` varchar(10) NOT NULL DEFAULT 'C$',
  `trans_image` varchar(250) DEFAULT NULL,
  `trans_date` datetime NOT NULL DEFAULT current_timestamp(),
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  `updated_at` datetime NOT NULL DEFAULT current_timestamp() ON UPDATE current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='record of all transactions';

-- Dumping data for table farmwork.transaction: ~63 rows (approximately)
INSERT INTO `transaction` (`id`, `trans_desc`, `vendor_name`, `vendor_address`, `trans_currency`, `trans_image`, `trans_date`, `created_at`, `updated_at`) VALUES
	('034c5a18-a7ee-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/05/31/northern_feed_&_supplies-034c5a18-a7ee-11ec-ac57-d8cb8ac0caec.jpeg', '2021-05-31 00:00:00', '2022-03-19 21:35:18', '2022-03-19 21:38:41'),
	('08c81251-a8ce-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/11/15/temiskaming_livestock_exchange_ltd_1992-08c81251-a8ce-11ec-ac57-d8cb8ac0caec.jpeg', '2021-11-15 00:00:00', '2022-03-21 00:18:45', '2022-03-21 00:19:49'),
	('0bb3712f-a8cd-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/05/10/temiskaming_livestock_exchange_ltd_1992-0bb3712f-a8cd-11ec-ac57-d8cb8ac0caec.jpeg', '2021-05-10 00:00:00', '2022-03-21 00:11:40', '2022-03-21 00:13:17'),
	('0e09f154-a8c6-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/04/19/northern_feed_&_supplies-0e09f154-a8c6-11ec-ac57-d8cb8ac0caec.jpeg', '2021-04-19 00:00:00', '2022-03-20 23:21:38', '2022-03-20 23:21:43'),
	('0e9d5187-a7f1-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/07/12/northern_feed_&_supplies-0e9d5187-a7f1-11ec-ac57-d8cb8ac0caec.jpeg', '2021-07-12 00:00:00', '2022-03-19 21:57:05', '2022-03-19 21:57:52'),
	('1134c581-a8cb-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/06/21/railside_general_supplies-1134c581-a8cb-11ec-ac57-d8cb8ac0caec.jpeg', '2021-06-21 00:00:00', '2022-03-20 23:57:31', '2022-03-20 23:59:27'),
	('1385a577-a8c5-11ec-ac57-d8cb8ac0caec', '', 'Thornloe Farm Supply Inc', '31 Main St, Thornloe, ON, P0J 1S0', 'C$', 'uploads/transactions/2021/03/08/thornloe_farm_supply_inc-1385a577-a8c5-11ec-ac57-d8cb8ac0caec.jpeg', '2021-03-08 00:00:00', '2022-03-20 23:14:38', '2022-03-20 23:14:43'),
	('13866f6e-1a11-11ec-9d60-d8cb8ac0caec', 'livestock feed', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/01/02/railside_general_supplies-13866f6e-1a11-11ec-9d60-d8cb8ac0caec.jpg', '2021-01-02 00:00:00', '2021-09-20 08:48:36', '2021-09-20 08:55:27'),
	('15ed7026-a95e-11ec-ac57-d8cb8ac0caec', '', 'Thornloe Farm Supply Inc', '31 Main St, Thornloe, ON, P0J 1S0', 'C$', 'uploads/transactions/2021/04/12/thornloe_farm_supply_inc-15ed7026-a95e-11ec-ac57-d8cb8ac0caec.jpeg', '2021-04-12 00:00:00', '2022-03-21 17:29:49', '2022-03-21 17:31:08'),
	('17be25fa-a958-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/06/28/temiskaming_livestock_exchange_ltd_1992-17be25fa-a958-11ec-ac57-d8cb8ac0caec.jpeg', '2021-06-28 00:00:00', '2022-03-21 16:46:55', '2022-03-21 16:47:46'),
	('1f30779f-a957-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/10/26/railside_general_supplies-1f30779f-a957-11ec-ac57-d8cb8ac0caec.jpeg', '2021-10-26 00:00:00', '2022-03-21 16:39:58', '2022-03-21 16:41:14'),
	('2af1ceb6-a7ed-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/12/21/railside_general_supplies-2af1ceb6-a7ed-11ec-ac57-d8cb8ac0caec.jpeg', '2021-12-23 00:00:00', '2022-03-19 21:29:15', '2022-03-19 21:33:41'),
	('2d6a855a-a95f-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/05/10/railside_general_supplies-2d6a855a-a95f-11ec-ac57-d8cb8ac0caec.jpeg', '2021-05-10 00:00:00', '2022-03-21 17:37:38', '2022-03-21 17:39:40'),
	('316a1d4a-a8c7-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/04/05/northern_feed_&_supplies-316a1d4a-a8c7-11ec-ac57-d8cb8ac0caec.jpeg', '2021-04-05 00:00:00', '2022-03-20 23:29:47', '2022-03-20 23:29:54'),
	('3399c3cd-a7f0-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/07/21/railside_general_supplies-3399c3cd-a7f0-11ec-ac57-d8cb8ac0caec.jpeg', '2021-07-21 00:00:00', '2022-03-19 21:50:58', '2022-03-19 21:51:51'),
	('3bee6669-a7e4-11ec-ac57-d8cb8ac0caec', '', 'Little Bit Western', '372 Algonquin Boulevard W, Timmins, On, P4N 2S2, Canada', 'C$', 'uploads/transactions/2021/03/30/little_bit_western-3bee6669-a7e4-11ec-ac57-d8cb8ac0caec.jpeg', '2021-03-30 00:00:00', '2022-03-19 20:25:18', '2022-03-19 20:26:03'),
	('3d0563cf-a8c8-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/12/21/temiskaming_livestock_exchange_ltd_1992-3d0563cf-a8c8-11ec-ac57-d8cb8ac0caec.jpeg', '2021-12-13 00:00:00', '2022-03-20 23:37:16', '2022-03-20 23:54:36'),
	('4216e532-a95a-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/05/04/railside_general_supplies-4216e532-a95a-11ec-ac57-d8cb8ac0caec.jpeg', '2021-05-04 00:00:00', '2022-03-21 17:02:25', '2022-03-21 17:04:30'),
	('491c2740-a8c2-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/06/22/northern_feed_&_supplies-491c2740-a8c2-11ec-ac57-d8cb8ac0caec.jpeg', '2021-06-22 00:00:00', '2022-03-20 22:54:39', '2022-03-20 22:56:42'),
	('4a4b1f54-a8ce-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/11/09/railside_general_supplies-4a4b1f54-a8ce-11ec-ac57-d8cb8ac0caec.jpeg', '2021-11-09 00:00:00', '2022-03-21 00:20:35', '2022-03-21 00:22:27'),
	('4b5d8657-a8ca-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/05/17/temiskaming_livestock_exchange_ltd_1992-4b5d8657-a8ca-11ec-ac57-d8cb8ac0caec.jpeg', '2021-05-17 00:00:00', '2022-03-20 23:51:59', '2022-03-20 23:53:34'),
	('4bea62a2-a959-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/09/13/northern_feed_&_supplies-4bea62a2-a959-11ec-ac57-d8cb8ac0caec.jpeg', '2021-09-13 00:00:00', '2022-03-21 16:55:32', '2022-03-21 16:56:06'),
	('5391b875-a95d-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/04/05/temiskaming_livestock_exchange_ltd_1992-5391b875-a95d-11ec-ac57-d8cb8ac0caec.jpeg', '2021-04-05 00:00:00', '2022-03-21 17:24:23', '2022-03-21 17:29:03'),
	('609843e2-a8c4-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/07/12/thornloe_farm_supply_inc-609843e2-a8c4-11ec-ac57-d8cb8ac0caec.jpeg', '2021-07-12 00:00:00', '2022-03-20 23:09:37', '2022-03-20 23:10:08'),
	('6d47200b-a958-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/09/27/temiskaming_livestock_exchange_ltd_1992-6d47200b-a958-11ec-ac57-d8cb8ac0caec.jpeg', '2021-09-27 00:00:00', '2022-03-21 16:49:18', '2022-03-21 16:50:12'),
	('6dababaf-a95e-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/09/27/railside_general_supplies-6dababaf-a95e-11ec-ac57-d8cb8ac0caec.jpeg', '2021-09-27 00:00:00', '2022-03-21 17:32:16', '2022-03-21 17:32:45'),
	('6e85c84d-a957-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/10/19/northern_feed_&_supplies-6e85c84d-a957-11ec-ac57-d8cb8ac0caec.jpeg', '2021-10-19 00:00:00', '2022-03-21 16:42:11', '2022-03-21 16:43:29'),
	('723b280e-a959-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/03/22/temiskaming_livestock_exchange_ltd_1992-723b280e-a959-11ec-ac57-d8cb8ac0caec.jpeg', '2021-03-22 00:00:00', '2022-03-21 16:56:36', '2022-03-21 16:57:48'),
	('7a266a10-a8cd-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/06/29/railside_general_supplies-7a266a10-a8cd-11ec-ac57-d8cb8ac0caec.jpeg', '2021-06-29 00:00:00', '2022-03-21 00:14:46', '2022-03-21 00:15:12'),
	('7b1bb52c-1a10-11ec-9d60-d8cb8ac0caec', 'livestock sale', 'Ontario Stockyards Inc', '3807 ON-89, Cookstown, ON L0L 1L0', 'C$', 'uploads/transactions/2021/01/14/ontario_stockyards_inc-7b1bb52c-1a10-11ec-9d60-d8cb8ac0caec.jpg', '2021-01-14 00:00:00', '2021-09-20 08:44:21', '2021-09-20 08:47:36'),
	('7c7b5d56-a7f0-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/08/05/railside_general_supplies-7c7b5d56-a7f0-11ec-ac57-d8cb8ac0caec.jpeg', '2021-08-05 00:00:00', '2022-03-19 21:53:00', '2022-03-19 21:55:56'),
	('7d8a7933-a8c5-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/04/03/railside_general_supplies-7d8a7933-a8c5-11ec-ac57-d8cb8ac0caec.jpeg', '2021-04-03 00:00:00', '2022-03-20 23:17:35', '2022-03-20 23:18:34'),
	('82875753-a7e2-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/12/31/railside_general_supplies-82875753-a7e2-11ec-ac57-d8cb8ac0caec.jpeg', '2021-12-31 00:00:00', '2022-03-19 20:12:57', '2022-03-19 20:18:28'),
	('83da07a6-a8c3-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/08/17/northern_feed_&_supplies-83da07a6-a8c3-11ec-ac57-d8cb8ac0caec.jpeg', '2021-08-17 00:00:00', '2022-03-20 23:03:27', '2022-03-20 23:04:19'),
	('852c2393-a8c7-11ec-ac57-d8cb8ac0caec', '', 'Little Bit Western', '372 Algonquin Boulevard W, Timmins, On, P4N 2S2, Canada', 'C$', 'uploads/transactions/2021/12/22/little_bit_western-852c2393-a8c7-11ec-ac57-d8cb8ac0caec.jpeg', '2021-12-22 00:00:00', '2022-03-20 23:32:07', '2022-03-20 23:32:55'),
	('86e5e6bf-a8c6-11ec-ac57-d8cb8ac0caec', '', 'Little Bit Western', '372 Algonquin Boulevard W, Timmins, On, P4N 2S2, Canada', 'C$', 'uploads/transactions/2021/04/08/little_bit_western-86e5e6bf-a8c6-11ec-ac57-d8cb8ac0caec.jpeg', '2021-04-08 00:00:00', '2022-03-20 23:25:01', '2022-03-20 23:25:08'),
	('8d949ed7-a7e3-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/12/29/railside_general_supplies-8d949ed7-a7e3-11ec-ac57-d8cb8ac0caec.jpeg', '2021-12-29 00:00:00', '2022-03-19 20:20:25', '2022-03-19 20:21:53'),
	('920f7e7a-a95e-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/09/20/railside_general_supplies-920f7e7a-a95e-11ec-ac57-d8cb8ac0caec.jpeg', '2021-09-20 00:00:00', '2022-03-21 17:33:17', '2022-03-21 17:33:45'),
	('9470bd6d-a95f-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/01/02/railside_general_supplies-9470bd6d-a95f-11ec-ac57-d8cb8ac0caec.jpeg', '2021-01-02 00:00:00', '2022-03-21 17:40:30', '2022-03-21 17:41:56'),
	('9c47eefc-a95c-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/04/12/temiskaming_livestock_exchange_ltd_1992-9c47eefc-a95c-11ec-ac57-d8cb8ac0caec.jpeg', '2021-04-12 00:00:00', '2022-03-21 17:19:15', '2022-03-21 17:23:23'),
	('9f526005-a7ef-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/08/23/railside_general_supplies-9f526005-a7ef-11ec-ac57-d8cb8ac0caec.jpeg', '2021-08-23 00:00:00', '2022-03-19 21:46:49', '2022-03-19 21:48:06'),
	('a09f1e4c-a8cd-11ec-ac57-d8cb8ac0caec', '', 'Little Bit Western', '372 Algonquin Boulevard W, Timmins, On, P4N 2S2, Canada', 'C$', 'uploads/transactions/2021/06/17/little_bit_western-a09f1e4c-a8cd-11ec-ac57-d8cb8ac0caec.jpeg', '2021-06-17 00:00:00', '2022-03-21 00:15:50', '2022-03-21 00:16:25'),
	('a23361fc-a958-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/04/27/railside_general_supplies-a23361fc-a958-11ec-ac57-d8cb8ac0caec.jpeg', '2021-04-27 00:00:00', '2022-03-21 16:50:47', '2022-03-21 16:52:20'),
	('a2a91f84-a8ce-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/11/01/temiskaming_livestock_exchange_ltd_1992-a2a91f84-a8ce-11ec-ac57-d8cb8ac0caec.jpeg', '2021-11-01 00:00:00', '2022-03-21 00:23:03', '2022-03-21 00:24:42'),
	('a9959d2e-a7e4-11ec-ac57-d8cb8ac0caec', '', 'Little Bit Western', '372 Algonquin Boulevard W, Timmins, On, P4N 2S2, Canada', 'C$', 'uploads/transactions/2021/03/01/little_bit_western-a9959d2e-a7e4-11ec-ac57-d8cb8ac0caec.jpeg', '2021-03-01 00:00:00', '2022-03-19 20:28:22', '2022-03-19 20:29:18'),
	('b052e4ba-a959-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/03/08/temiskaming_livestock_exchange_ltd_1992-b052e4ba-a959-11ec-ac57-d8cb8ac0caec.jpeg', '2021-03-08 00:00:00', '2022-03-21 16:58:20', '2022-03-21 16:59:47'),
	('b2177d4c-a957-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/10/18/railside_general_supplies-b2177d4c-a957-11ec-ac57-d8cb8ac0caec.jpeg', '2021-10-18 00:00:00', '2022-03-21 16:44:04', '2022-03-21 16:44:43'),
	('b3759a5c-a95e-11ec-ac57-d8cb8ac0caec', '', 'Little Bit Western', '372 Algonquin Boulevard W, Timmins, On, P4N 2S2, Canada', 'C$', 'uploads/transactions/2021/09/24/little_bit_western-b3759a5c-a95e-11ec-ac57-d8cb8ac0caec.jpeg', '2021-09-24 00:00:00', '2022-03-21 17:34:13', '2022-03-21 17:34:45'),
	('b3898a8c-a8c4-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/08/07/northern_feed_&_supplies-b3898a8c-a8c4-11ec-ac57-d8cb8ac0caec.jpeg', '2021-08-07 00:00:00', '2022-03-20 23:11:57', '2022-03-20 23:12:02'),
	('b405c0cd-a7ee-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/05/17/railside_general_supplies-b405c0cd-a7ee-11ec-ac57-d8cb8ac0caec.jpeg', '2021-05-17 00:00:00', '2022-03-19 21:40:14', '2022-03-19 21:45:06'),
	('b9f05c00-a8c5-11ec-ac57-d8cb8ac0caec', '', 'Thornloe Farm Supply Inc', '31 Main St, Thornloe, ON, P0J 1S0', 'C$', 'uploads/transactions/2021/03/22/thornloe_farm_supply_inc-b9f05c00-a8c5-11ec-ac57-d8cb8ac0caec.jpeg', '2021-03-22 00:00:00', '2022-03-20 23:19:17', '2022-03-20 23:20:46'),
	('bc107127-a8c7-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/11/17/railside_general_supplies-bc107127-a8c7-11ec-ac57-d8cb8ac0caec.jpeg', '2021-11-17 00:00:00', '2022-03-20 23:33:39', '2022-03-20 23:35:27'),
	('bc3827b2-a8c6-11ec-ac57-d8cb8ac0caec', '', 'Little Bit Western', '372 Algonquin Boulevard W, Timmins, On, P4N 2S2, Canada', 'C$', 'uploads/transactions/2021/03/16/little_bit_western-bc3827b2-a8c6-11ec-ac57-d8cb8ac0caec.jpeg', '2021-03-16 00:00:00', '2022-03-20 23:26:30', '2022-03-20 23:26:35'),
	('be0943a9-a8cc-11ec-ac57-d8cb8ac0caec', '', 'LEIS Landscaping & Country Store', '998063 Hwy 11 North, New Liskeard, Ontario, P0J 1P0', 'C$', 'uploads/transactions/2021/06/22/leis_landscaping_&_country_store-be0943a9-a8cc-11ec-ac57-d8cb8ac0caec.jpeg', '2021-06-22 00:00:00', '2022-03-21 00:09:30', '2022-03-21 00:10:38'),
	('cf224c7d-a8ca-11ec-ac57-d8cb8ac0caec', 'No receipt. Paid in cash.', 'Private Buyer', '', 'C$', NULL, '2021-10-16 00:00:00', '2022-03-20 23:55:40', '2022-03-20 23:56:21'),
	('d2291662-a8cd-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/11/23/northern_feed_&_supplies-d2291662-a8cd-11ec-ac57-d8cb8ac0caec.jpeg', '2021-11-23 00:00:00', '2022-03-21 00:17:13', '2022-03-21 00:18:05'),
	('d7c49b53-a95e-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/10/12/railside_general_supplies-d7c49b53-a95e-11ec-ac57-d8cb8ac0caec.jpeg', '2021-10-12 00:00:00', '2022-03-21 17:35:14', '2022-03-21 17:35:42'),
	('df3b38e9-a957-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/10/04/railside_general_supplies-df3b38e9-a957-11ec-ac57-d8cb8ac0caec.jpeg', '2021-10-04 00:00:00', '2022-03-21 16:45:20', '2022-03-21 16:46:05'),
	('e29293e3-a7ef-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/08/30/railside_general_supplies-e29293e3-a7ef-11ec-ac57-d8cb8ac0caec.jpeg', '2021-08-30 00:00:00', '2022-03-19 21:48:42', '2022-03-19 21:49:40'),
	('e6cdaa64-a8c8-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/03/29/temiskaming_livestock_exchange_ltd_1992-e6cdaa64-a8c8-11ec-ac57-d8cb8ac0caec.jpeg', '2021-03-29 00:00:00', '2022-03-20 23:42:01', '2022-03-20 23:44:38'),
	('e80add8c-a8c3-11ec-ac57-d8cb8ac0caec', '', 'Thornloe Farm Supply Inc', '31 Main St, Thornloe, ON, P0J 1S0', 'C$', 'uploads/transactions/2021/03/15/thornloe_farm_supply_inc-e80add8c-a8c3-11ec-ac57-d8cb8ac0caec.jpeg', '2021-03-15 00:00:00', '2022-03-20 23:06:15', '2022-03-20 23:07:02'),
	('ee16c2e2-a958-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/05/25/railside_general_supplies-ee16c2e2-a958-11ec-ac57-d8cb8ac0caec.jpeg', '2021-05-25 00:00:00', '2022-03-21 16:52:54', '2022-03-21 16:54:53'),
	('f3b423fc-a7e3-11ec-ac57-d8cb8ac0caec', '', 'Little Bit Western', '372 Algonquin Boulevard W, Timmins, On, P4N 2S2, Canada', 'C$', 'uploads/transactions/2021/03/25/little_bit_western-f3b423fc-a7e3-11ec-ac57-d8cb8ac0caec.jpeg', '2021-03-25 00:00:00', '2022-03-19 20:23:17', '2022-03-19 20:24:14'),
	('fa48549c-a959-11ec-ac57-d8cb8ac0caec', '', 'Temiskaming Livestock Exchange Ltd 1992', '883006 ON-65 RR 3, New Liskeard, ON P0J 1P0', 'C$', 'uploads/transactions/2021/03/15/temiskaming_livestock_exchange_ltd_1992-fa48549c-a959-11ec-ac57-d8cb8ac0caec.jpeg', '2021-03-15 00:00:00', '2022-03-21 17:00:24', '2022-03-21 17:01:36'),
	('fbc10d97-a7e4-11ec-ac57-d8cb8ac0caec', '', 'Railside General Supplies', '3272 Monahan Rd, Val Gagne, On, P0K 1W0, Canada', 'C$', 'uploads/transactions/2021/12/27/railside_general_supplies-fbc10d97-a7e4-11ec-ac57-d8cb8ac0caec.jpeg', '2021-12-27 00:00:00', '2022-03-19 20:30:40', '2022-03-19 20:31:12'),
	('fd563265-a95e-11ec-ac57-d8cb8ac0caec', '', 'Northern Feed & Supplies', '964027 Development Rd, Thornloe, ON P0J 1S0', 'C$', 'uploads/transactions/2021/09/29/northern_feed_&_supplies-fd563265-a95e-11ec-ac57-d8cb8ac0caec.jpeg', '2021-09-29 00:00:00', '2022-03-21 17:36:17', '2022-03-21 17:36:48');

-- Dumping structure for table farmwork.transaction_category
CREATE TABLE IF NOT EXISTS `transaction_category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parent_id` int(11) NOT NULL DEFAULT 0,
  `category_name` varchar(150) NOT NULL,
  `category_description` varchar(250) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=58 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Table contains all income and expence types of the farm';

-- Dumping data for table farmwork.transaction_category: ~38 rows (approximately)
INSERT INTO `transaction_category` (`id`, `parent_id`, `category_name`, `category_description`, `created_at`) VALUES
	(1, 0, 'Feed', 'Feed, supplements, straw, and bedding', '2019-04-29 21:32:30'),
	(5, 0, 'Livestock', 'Livestock types (cattle, chicken, horse, sheep, goats etc...)', '2019-05-03 09:30:51'),
	(9, 0, 'Veterinary', 'Veterinary fees, medicine, and breeding fees.', '2019-05-03 09:34:18'),
	(10, 1, 'Hay', '', '2020-11-11 09:25:54'),
	(11, 1, 'Corn', NULL, '2020-11-11 09:26:13'),
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
	(46, 45, 'Gasoline', '', '2021-04-13 14:07:35'),
	(47, 1, 'Salt', 'Salt for livestock', '2021-07-06 09:38:28'),
	(48, 1, 'Mineral Mix', 'Mineral mix to give animals with mixed feed.', '2021-07-06 09:39:07'),
	(49, 1, 'Calf Starter', '', '2021-07-18 20:26:51'),
	(51, 1, 'Wood Shavings', '', '2021-07-18 20:31:12'),
	(52, 1, 'Straw', '', '2021-07-18 20:31:19'),
	(53, 26, 'Office Supplies', '', '2021-07-18 21:15:57'),
	(55, 9, 'Tube Feeder', '', '2021-09-12 21:17:49'),
	(56, 1, 'Soybean meal', 'Protein supplement for a feed.', '2021-09-20 08:50:46'),
	(57, 1, 'Feed Mix', '', '2022-03-20 23:07:48');

-- Dumping structure for table farmwork.transaction_item
CREATE TABLE IF NOT EXISTS `transaction_item` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `transaction_id` char(36) NOT NULL,
  `item_name` varchar(150) NOT NULL,
  `item_desc` varchar(250) DEFAULT NULL,
  `item_category` varchar(150) NOT NULL,
  `item_subcategory` varchar(150) NOT NULL,
  `amount` decimal(19,2) NOT NULL,
  `hst_tax` decimal(19,2) NOT NULL DEFAULT 0.00,
  `gst_tax` decimal(19,2) NOT NULL DEFAULT 0.00,
  `pst_tax` decimal(19,2) NOT NULL DEFAULT 0.00,
  `is_expence` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`),
  KEY `FK_transaction_item_transaction` (`transaction_id`) USING BTREE,
  CONSTRAINT `FK_transaction_item_transaction` FOREIGN KEY (`transaction_id`) REFERENCES `transaction` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='A table that holds all transaction items.';

-- Dumping data for table farmwork.transaction_item: ~132 rows (approximately)
INSERT INTO `transaction_item` (`id`, `transaction_id`, `item_name`, `item_desc`, `item_category`, `item_subcategory`, `amount`, `hst_tax`, `gst_tax`, `pst_tax`, `is_expence`, `created_at`) VALUES
	('052158d8-a7e3-11ec-ac57-d8cb8ac0caec', '82875753-a7e2-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 1bg', '', 'Feed', 'Mineral Mix', -18.00, 0.00, 0.00, 0.00, 1, '2022-03-19 20:16:36'),
	('06d1af10-a95a-11ec-ac57-d8cb8ac0caec', 'fa48549c-a959-11ec-ac57-d8cb8ac0caec', 'Black Calf - 90 lb', '', 'Livestock', 'Cattle', -279.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:00:45'),
	('0821f768-a95d-11ec-ac57-d8cb8ac0caec', '9c47eefc-a95c-11ec-ac57-d8cb8ac0caec', 'Black Calf - 110 lb', '', 'Livestock', 'Cattle', -385.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:22:16'),
	('0af8dcc7-a7e5-11ec-ac57-d8cb8ac0caec', 'fbc10d97-a7e4-11ec-ac57-d8cb8ac0caec', 'Hay - 8 bales', '', 'Feed', 'Hay', -40.00, 0.00, 0.00, 0.00, 1, '2022-03-19 20:31:05'),
	('0c6e08fe-a95f-11ec-ac57-d8cb8ac0caec', 'fd563265-a95e-11ec-ac57-d8cb8ac0caec', ' Soy and Corn Mix - 1 tone', '', 'Feed', 'Feed Mix', -586.07, 0.00, 0.00, 0.00, 1, '2022-03-21 17:36:42'),
	('0e4b601d-a7ef-11ec-ac57-d8cb8ac0caec', 'b405c0cd-a7ee-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 3bgs', '', 'Feed', 'Calf Starter', -63.00, 0.00, 0.00, 0.00, 1, '2022-03-19 21:42:46'),
	('0e81d063-a959-11ec-ac57-d8cb8ac0caec', 'ee16c2e2-a958-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 3 bgs', '', 'Feed', 'Calf Starter', -67.50, 0.00, 0.00, 0.00, 1, '2022-03-21 16:53:49'),
	('1108e58c-a8c9-11ec-ac57-d8cb8ac0caec', 'e6cdaa64-a8c8-11ec-ac57-d8cb8ac0caec', 'Black Calf - 85 lb', '', 'Livestock', 'Cattle', -289.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:43:11'),
	('12138814-a7e4-11ec-ac57-d8cb8ac0caec', 'f3b423fc-a7e3-11ec-ac57-d8cb8ac0caec', 'Straw - 2 bales', '', 'Feed', 'Straw', -23.50, 0.00, 0.00, 0.00, 1, '2022-03-19 20:24:08'),
	('156b89c5-a95a-11ec-ac57-d8cb8ac0caec', 'fa48549c-a959-11ec-ac57-d8cb8ac0caec', 'Black Calf - 100 lb', '', 'Livestock', 'Cattle', -330.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:01:10'),
	('1945a88c-a95d-11ec-ac57-d8cb8ac0caec', '9c47eefc-a95c-11ec-ac57-d8cb8ac0caec', 'Black Calf - 125 lb', '', 'Livestock', 'Cattle', -475.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:22:45'),
	('1ece34ba-a8cb-11ec-ac57-d8cb8ac0caec', '1134c581-a8cb-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 1 bg', '', 'Feed', 'Milk Replacer', -77.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:57:53'),
	('20aed2ad-a7e3-11ec-ac57-d8cb8ac0caec', '82875753-a7e2-11ec-ac57-d8cb8ac0caec', 'Soybean Meal - 1bg', '', 'Feed', 'Soybean meal', -20.00, 0.00, 0.00, 0.00, 1, '2022-03-19 20:17:23'),
	('20d7b67b-a8ce-11ec-ac57-d8cb8ac0caec', '08c81251-a8ce-11ec-ac57-d8cb8ac0caec', 'Calves - 2 heads', '', 'Livestock', 'Cattle', 1464.69, 0.00, 0.00, 0.00, 0, '2022-03-21 00:19:25'),
	('21cceefc-a95a-11ec-ac57-d8cb8ac0caec', 'fa48549c-a959-11ec-ac57-d8cb8ac0caec', 'Black Calf - 90 lb', '', 'Livestock', 'Cattle', -315.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:01:31'),
	('22b4a324-a959-11ec-ac57-d8cb8ac0caec', 'ee16c2e2-a958-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 1 bg', '', 'Feed', 'Mineral Mix', -19.60, 0.00, 0.00, 0.00, 1, '2022-03-21 16:54:23'),
	('248cd457-a7f1-11ec-ac57-d8cb8ac0caec', '0e9d5187-a7f1-11ec-ac57-d8cb8ac0caec', 'Wood Shavings - 2bgs', '', 'Feed', 'Wood Shavings', -9.90, 0.00, 0.00, 0.00, 1, '2022-03-19 21:57:42'),
	('258f9417-a8cd-11ec-ac57-d8cb8ac0caec', '0bb3712f-a8cd-11ec-ac57-d8cb8ac0caec', 'Black Calf - 115 lb', '', 'Livestock', 'Cattle', -460.00, 0.00, 0.00, 0.00, 1, '2022-03-21 00:12:24'),
	('287936b1-1a11-11ec-9d60-d8cb8ac0caec', '13866f6e-1a11-11ec-9d60-d8cb8ac0caec', 'Cracked Corn 8 bgs', '', 'Feed', 'Cracked Corn', -124.00, 0.00, 0.00, 0.00, 1, '2021-09-20 08:49:11'),
	('2a9651fe-a7ef-11ec-ac57-d8cb8ac0caec', 'b405c0cd-a7ee-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 1bg', '', 'Feed', 'Mineral Mix', -19.60, 0.00, 0.00, 0.00, 1, '2022-03-19 21:43:33'),
	('2ad6d5c0-a95d-11ec-ac57-d8cb8ac0caec', '9c47eefc-a95c-11ec-ac57-d8cb8ac0caec', 'Black Calf - 105 lb', '', 'Livestock', 'Cattle', -409.50, 0.00, 0.00, 0.00, 1, '2022-03-21 17:23:14'),
	('2af3eec7-a7ee-11ec-ac57-d8cb8ac0caec', '034c5a18-a7ee-11ec-ac57-d8cb8ac0caec', 'AVL Ivermectin Pour On - 1 litre', '', 'Veterinary', '', -58.99, 0.00, 0.00, 0.00, 1, '2022-03-19 21:36:24'),
	('2d57b567-a95e-11ec-ac57-d8cb8ac0caec', '15ed7026-a95e-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 3 bgs', '', 'Feed', 'Calf Starter', -71.85, 0.00, 0.00, 0.00, 1, '2022-03-21 17:30:28'),
	('2d670892-a8c5-11ec-ac57-d8cb8ac0caec', '1385a577-a8c5-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 2bgs', '', 'Feed', 'Milk Replacer', -180.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:15:21'),
	('2daedd0c-a959-11ec-ac57-d8cb8ac0caec', 'ee16c2e2-a958-11ec-ac57-d8cb8ac0caec', 'Straw - 3 bales', '', 'Feed', 'Straw', -12.00, 0.00, 0.00, 0.00, 1, '2022-03-21 16:54:41'),
	('2fa750b0-a7e3-11ec-ac57-d8cb8ac0caec', '82875753-a7e2-11ec-ac57-d8cb8ac0caec', 'Hay - 4 bales', '', 'Feed', 'Hay', -20.00, 0.00, 0.00, 0.00, 1, '2022-03-19 20:17:48'),
	('302eeb0f-a8c9-11ec-ac57-d8cb8ac0caec', 'e6cdaa64-a8c8-11ec-ac57-d8cb8ac0caec', 'Black Calf - 80 lb', '', 'Livestock', 'Cattle', -296.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:44:04'),
	('320750f4-a958-11ec-ac57-d8cb8ac0caec', '17be25fa-a958-11ec-ac57-d8cb8ac0caec', 'Black Calf - 520 lb', '', 'Livestock', 'Cattle', 770.08, 0.00, 0.00, 0.00, 0, '2022-03-21 16:47:39'),
	('32757948-a8cb-11ec-ac57-d8cb8ac0caec', '1134c581-a8cb-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 2 bgs', '', 'Feed', 'Mineral Mix', -39.20, 0.00, 0.00, 0.00, 1, '2022-03-20 23:58:26'),
	('32cd4c21-a8cd-11ec-ac57-d8cb8ac0caec', '0bb3712f-a8cd-11ec-ac57-d8cb8ac0caec', 'Black Calf - 125 lb', '', 'Livestock', 'Cattle', -475.00, 0.00, 0.00, 0.00, 1, '2022-03-21 00:12:46'),
	('355a64b5-a8c6-11ec-ac57-d8cb8ac0caec', '0e09f154-a8c6-11ec-ac57-d8cb8ac0caec', 'Soy and Corn Mix - 2 tones', '', 'Feed', 'Feed Mix', -1151.40, 0.00, 0.00, 0.00, 1, '2022-03-20 23:22:44'),
	('3f3a2fe5-a8c9-11ec-ac57-d8cb8ac0caec', 'e6cdaa64-a8c8-11ec-ac57-d8cb8ac0caec', 'Black Calf - 80 lb', '', 'Livestock', 'Cattle', -288.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:44:29'),
	('41e9ffd2-a95e-11ec-ac57-d8cb8ac0caec', '15ed7026-a95e-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 4 bgs', '', 'Feed', 'Milk Replacer', -354.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:31:02'),
	('42518f34-a8cd-11ec-ac57-d8cb8ac0caec', '0bb3712f-a8cd-11ec-ac57-d8cb8ac0caec', 'Black Calf - 110 lb', '', 'Livestock', 'Cattle', -418.00, 0.00, 0.00, 0.00, 1, '2022-03-21 00:13:12'),
	('42e32235-a8c5-11ec-ac57-d8cb8ac0caec', '1385a577-a8c5-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 1bg', '', 'Feed', 'Calf Starter', -22.42, 0.00, 0.00, 0.00, 1, '2022-03-20 23:15:57'),
	('44252fba-a8cb-11ec-ac57-d8cb8ac0caec', '1134c581-a8cb-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 3 bgs', '', 'Feed', 'Calf Starter', -67.50, 0.00, 0.00, 0.00, 1, '2022-03-20 23:58:56'),
	('45e13a6a-a7ed-11ec-ac57-d8cb8ac0caec', '2af1ceb6-a7ed-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 1 bg', '', 'Feed', 'Mineral Mix', -18.00, 0.00, 0.00, 0.00, 1, '2022-03-19 21:30:00'),
	('474bb4b9-a7f0-11ec-ac57-d8cb8ac0caec', '3399c3cd-a7f0-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 4bgs', '', 'Feed', 'Mineral Mix', -78.40, 0.00, 0.00, 0.00, 1, '2022-03-19 21:51:31'),
	('498323e0-a957-11ec-ac57-d8cb8ac0caec', '1f30779f-a957-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 4 bgs', '', 'Feed', 'Mineral Mix', -74.40, 0.00, 0.00, 0.00, 1, '2022-03-21 16:41:09'),
	('4be1e34e-a7ef-11ec-ac57-d8cb8ac0caec', 'b405c0cd-a7ee-11ec-ac57-d8cb8ac0caec', 'Straw - 2 bales', '', 'Feed', 'Straw', -8.00, 0.00, 0.00, 0.00, 1, '2022-03-19 21:44:29'),
	('4c77c0b4-a8c6-11ec-ac57-d8cb8ac0caec', '0e09f154-a8c6-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 3bgs', '', 'Feed', 'Calf Starter', -70.40, 0.00, 0.00, 0.00, 1, '2022-03-20 23:23:23'),
	('4c821428-a7ee-11ec-ac57-d8cb8ac0caec', '034c5a18-a7ee-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 3bg', '', 'Feed', 'Milk Replacer', -238.42, 0.00, 0.00, 0.00, 1, '2022-03-19 21:37:21'),
	('4f592eb3-a7e4-11ec-ac57-d8cb8ac0caec', '3bee6669-a7e4-11ec-ac57-d8cb8ac0caec', 'Straw - 2 bales', '', 'Feed', 'Straw', -23.50, 0.00, 0.00, 0.00, 1, '2022-03-19 20:25:50'),
	('501dd31a-a8c7-11ec-ac57-d8cb8ac0caec', '316a1d4a-a8c7-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 2 bgs', '', 'Feed', 'Milk Replacer', -158.95, 0.00, 0.00, 0.00, 1, '2022-03-20 23:30:38'),
	('51fa0712-a8cb-11ec-ac57-d8cb8ac0caec', '1134c581-a8cb-11ec-ac57-d8cb8ac0caec', 'Straw - 3 bales', '', 'Feed', 'Straw', -12.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:59:19'),
	('57a9d911-a95a-11ec-ac57-d8cb8ac0caec', '4216e532-a95a-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 2 bgs', '', 'Feed', 'Milk Replacer', -146.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:03:01'),
	('59a76889-a95f-11ec-ac57-d8cb8ac0caec', '2d6a855a-a95f-11ec-ac57-d8cb8ac0caec', 'Hay - 5 bales', '', 'Feed', 'Hay', -20.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:38:52'),
	('5a5edf8f-a7ef-11ec-ac57-d8cb8ac0caec', 'b405c0cd-a7ee-11ec-ac57-d8cb8ac0caec', 'Shavings - 2bgs', '', 'Feed', 'Wood Shavings', -12.00, 0.00, 0.00, 0.00, 1, '2022-03-19 21:44:53'),
	('5a7730d7-a8ce-11ec-ac57-d8cb8ac0caec', '4a4b1f54-a8ce-11ec-ac57-d8cb8ac0caec', 'Cracked Corn - 9 bgs', '', 'Feed', 'Cracked Corn', -139.50, 0.00, 0.00, 0.00, 1, '2022-03-21 00:21:02'),
	('5b7b35ad-a959-11ec-ac57-d8cb8ac0caec', '4bea62a2-a959-11ec-ac57-d8cb8ac0caec', 'Soy and Corn Mix - 1 tone', '', 'Feed', 'Feed Mix', -606.90, 0.00, 0.00, 0.00, 1, '2022-03-21 16:55:58'),
	('5cf39821-a8ca-11ec-ac57-d8cb8ac0caec', '4b5d8657-a8ca-11ec-ac57-d8cb8ac0caec', 'Black Calf - 100 lb', '', 'Livestock', 'Cattle', -350.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:52:28'),
	('6245de85-a95d-11ec-ac57-d8cb8ac0caec', '5391b875-a95d-11ec-ac57-d8cb8ac0caec', 'Black Calf - 80 lb', '', 'Livestock', 'Cattle', -288.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:24:47'),
	('635e7c2c-a8c6-11ec-ac57-d8cb8ac0caec', '0e09f154-a8c6-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 4bgs', '', 'Feed', 'Milk Replacer', -317.89, 0.00, 0.00, 0.00, 1, '2022-03-20 23:24:01'),
	('64d9fac8-a95f-11ec-ac57-d8cb8ac0caec', '2d6a855a-a95f-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 1 bg', '', 'Feed', 'Calf Starter', -21.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:39:11'),
	('67b3926d-a7ed-11ec-ac57-d8cb8ac0caec', '2af1ceb6-a7ed-11ec-ac57-d8cb8ac0caec', 'Soybean Meal -1bg', '', 'Feed', 'Soybean meal', -22.00, 0.00, 0.00, 0.00, 1, '2022-03-19 21:30:57'),
	('6965433f-a8c7-11ec-ac57-d8cb8ac0caec', '316a1d4a-a8c7-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 2 bgs', '', 'Feed', 'Calf Starter', -58.25, 0.00, 0.00, 0.00, 1, '2022-03-20 23:31:21'),
	('6a291ddd-a8ce-11ec-ac57-d8cb8ac0caec', '4a4b1f54-a8ce-11ec-ac57-d8cb8ac0caec', 'Soybean Meal - 2 bgs', '', 'Feed', 'Soybean meal', -44.00, 0.00, 0.00, 0.00, 1, '2022-03-21 00:21:28'),
	('6a2aa548-a7ee-11ec-ac57-d8cb8ac0caec', '034c5a18-a7ee-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 2bgs', '', 'Feed', 'Calf Starter', -46.33, 0.00, 0.00, 0.00, 1, '2022-03-19 21:38:10'),
	('6a5da928-a95a-11ec-ac57-d8cb8ac0caec', '4216e532-a95a-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 1 bg', '', 'Feed', 'Calf Starter', -22.50, 0.00, 0.00, 0.00, 1, '2022-03-21 17:03:32'),
	('6e9f9d86-a8c2-11ec-ac57-d8cb8ac0caec', '491c2740-a8c2-11ec-ac57-d8cb8ac0caec', 'Soy and Corn Mix - 1 tone', '', 'Feed', 'Feed Mix', -574.20, 0.00, 0.00, 0.00, 1, '2022-03-20 22:55:42'),
	('712280fc-a8ca-11ec-ac57-d8cb8ac0caec', '4b5d8657-a8ca-11ec-ac57-d8cb8ac0caec', 'Black Calf - 110 lb', '', 'Livestock', 'Cattle', -418.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:53:02'),
	('721f561f-a95d-11ec-ac57-d8cb8ac0caec', '5391b875-a95d-11ec-ac57-d8cb8ac0caec', 'Black Calf - 90 lb', '', 'Livestock', 'Cattle', -333.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:25:14'),
	('72fcbf6d-a95f-11ec-ac57-d8cb8ac0caec', '2d6a855a-a95f-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 3 bgs', '', 'Feed', 'Milk Replacer', -216.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:39:34'),
	('782013e0-1a11-11ec-9d60-d8cb8ac0caec', '13866f6e-1a11-11ec-9d60-d8cb8ac0caec', 'Soybean meal 2 bgs', '', 'Feed', 'Soybean meal', -52.00, 0.00, 0.00, 0.00, 1, '2021-09-20 08:51:25'),
	('7a09cc1c-a95e-11ec-ac57-d8cb8ac0caec', '6dababaf-a95e-11ec-ac57-d8cb8ac0caec', 'Hay - 36 bales', '', 'Feed', 'Hay', -180.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:32:37'),
	('7aa373ad-a95a-11ec-ac57-d8cb8ac0caec', '4216e532-a95a-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 1 bg', '', 'Feed', 'Mineral Mix', -19.60, 0.00, 0.00, 0.00, 1, '2022-03-21 17:04:00'),
	('7b7da2b1-a8ce-11ec-ac57-d8cb8ac0caec', '4a4b1f54-a8ce-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 1 bg', '', 'Feed', 'Mineral Mix', -18.00, 0.00, 0.00, 0.00, 1, '2022-03-21 00:21:57'),
	('7eae6fdc-a958-11ec-ac57-d8cb8ac0caec', '6d47200b-a958-11ec-ac57-d8cb8ac0caec', 'Black Calf - 675 lb', '', 'Livestock', 'Cattle', 1021.77, 0.00, 0.00, 0.00, 0, '2022-03-21 16:49:47'),
	('7f49958d-a8ca-11ec-ac57-d8cb8ac0caec', '4b5d8657-a8ca-11ec-ac57-d8cb8ac0caec', 'Black Calf - 105 lb', '', 'Livestock', 'Cattle', -388.50, 0.00, 0.00, 0.00, 1, '2022-03-20 23:53:26'),
	('8414704d-a95d-11ec-ac57-d8cb8ac0caec', '5391b875-a95d-11ec-ac57-d8cb8ac0caec', 'Black Calf - 110 lb', '', 'Livestock', 'Cattle', -396.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:25:44'),
	('850fd7f9-a8c2-11ec-ac57-d8cb8ac0caec', '491c2740-a8c2-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 1bg', '', 'Feed', 'Mineral Mix', -21.47, 0.00, 0.00, 0.00, 1, '2022-03-20 22:56:20'),
	('85d976c4-a8cd-11ec-ac57-d8cb8ac0caec', '7a266a10-a8cd-11ec-ac57-d8cb8ac0caec', 'Beef Supplement', '', 'Feed', 'Mineral Mix', -98.00, 0.00, 0.00, 0.00, 1, '2022-03-21 00:15:05'),
	('867d2edc-a957-11ec-ac57-d8cb8ac0caec', '6e85c84d-a957-11ec-ac57-d8cb8ac0caec', 'Soy and Corn Mix - 1 tone', '', 'Feed', 'Feed Mix', -548.05, 0.00, 0.00, 0.00, 1, '2022-03-21 16:42:51'),
	('89156511-a8ce-11ec-ac57-d8cb8ac0caec', '4a4b1f54-a8ce-11ec-ac57-d8cb8ac0caec', 'Hay - 60 bales', '', 'Feed', 'Hay', -300.00, 0.00, 0.00, 0.00, 1, '2022-03-21 00:22:20'),
	('897e5b3f-a95a-11ec-ac57-d8cb8ac0caec', '4216e532-a95a-11ec-ac57-d8cb8ac0caec', 'Straw - 3 bales', '', 'Feed', 'Straw', -12.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:04:25'),
	('8b2354a2-a959-11ec-ac57-d8cb8ac0caec', '723b280e-a959-11ec-ac57-d8cb8ac0caec', 'Black Calf - 105 lb', '', 'Livestock', 'Cattle', -367.50, 0.00, 0.00, 0.00, 1, '2022-03-21 16:57:18'),
	('8b2710f2-a8c4-11ec-ac57-d8cb8ac0caec', '609843e2-a8c4-11ec-ac57-d8cb8ac0caec', 'Soy and Corn Mix - 1 tone', '', 'Feed', 'Feed Mix', -566.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:10:49'),
	('8fc007da-a7f0-11ec-ac57-d8cb8ac0caec', '7c7b5d56-a7f0-11ec-ac57-d8cb8ac0caec', 'Cracked Corn - 2bgs', '', 'Feed', 'Cracked Corn', -34.00, 0.00, 0.00, 0.00, 1, '2022-03-19 21:53:32'),
	('99097b9c-a957-11ec-ac57-d8cb8ac0caec', '6e85c84d-a957-11ec-ac57-d8cb8ac0caec', 'Salt', '', 'Feed', 'Salt', -9.24, 0.00, 0.00, 0.00, 1, '2022-03-21 16:43:22'),
	('9a2500ca-a959-11ec-ac57-d8cb8ac0caec', '723b280e-a959-11ec-ac57-d8cb8ac0caec', 'Black Calf - 100 lb', '', 'Livestock', 'Cattle', -340.00, 0.00, 0.00, 0.00, 1, '2022-03-21 16:57:43'),
	('9a60623c-a7ed-11ec-ac57-d8cb8ac0caec', '2af1ceb6-a7ed-11ec-ac57-d8cb8ac0caec', 'Cracked Corn - 5bg', '', 'Feed', 'Cracked Corn', -77.50, 0.00, 0.00, 0.00, 1, '2022-03-19 21:32:22'),
	('9a93bc60-a8c3-11ec-ac57-d8cb8ac0caec', '83da07a6-a8c3-11ec-ac57-d8cb8ac0caec', 'Soy and Corn Mix - 1 tone', '', 'Feed', 'Feed Mix', -606.90, 0.00, 0.00, 0.00, 1, '2022-03-20 23:04:05'),
	('9c429f0d-a8c5-11ec-ac57-d8cb8ac0caec', '7d8a7933-a8c5-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 1bg', '', 'Feed', 'Calf Starter', -22.50, 0.00, 0.00, 0.00, 1, '2022-03-20 23:18:27'),
	('9e87d5ef-a8c7-11ec-ac57-d8cb8ac0caec', '852c2393-a8c7-11ec-ac57-d8cb8ac0caec', 'Cracked Corn - 1 bg', '', 'Feed', 'Cracked Corn', -21.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:32:50'),
	('9fd9873d-a95e-11ec-ac57-d8cb8ac0caec', '920f7e7a-a95e-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 5 bgs', '', 'Feed', 'Mineral Mix', -98.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:33:40'),
	('a149d193-a95d-11ec-ac57-d8cb8ac0caec', '5391b875-a95d-11ec-ac57-d8cb8ac0caec', 'Black Calf - 130 lb', '', 'Livestock', 'Cattle', -442.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:26:33'),
	('a1ac704a-a8c6-11ec-ac57-d8cb8ac0caec', '86e5e6bf-a8c6-11ec-ac57-d8cb8ac0caec', 'Straw - 3 bales', '', 'Feed', 'Straw', -35.25, 0.00, 0.00, 0.00, 1, '2022-03-20 23:25:46'),
	('a3400c67-a95f-11ec-ac57-d8cb8ac0caec', '9470bd6d-a95f-11ec-ac57-d8cb8ac0caec', 'Cracked Corn - 8 bgs', '', 'Feed', 'Cracked Corn', -124.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:40:55'),
	('a3535f3a-a7f0-11ec-ac57-d8cb8ac0caec', '7c7b5d56-a7f0-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 3bgs', '', 'Feed', 'Mineral Mix', -58.80, 0.00, 0.00, 0.00, 1, '2022-03-19 21:54:05'),
	('a4f7a712-a7e3-11ec-ac57-d8cb8ac0caec', '8d949ed7-a7e3-11ec-ac57-d8cb8ac0caec', 'Cracked Corn - 2bg', '', 'Feed', 'Cracked Corn', -31.00, 0.00, 0.00, 0.00, 1, '2022-03-19 20:21:05'),
	('acfc3237-a95c-11ec-ac57-d8cb8ac0caec', '9c47eefc-a95c-11ec-ac57-d8cb8ac0caec', 'Black Calf - 185 lb', '', 'Livestock', 'Cattle', -564.25, 0.00, 0.00, 0.00, 1, '2022-03-21 17:19:43'),
	('ad6de632-1a10-11ec-9d60-d8cb8ac0caec', '7b1bb52c-1a10-11ec-9d60-d8cb8ac0caec', '2 Steers and 2 Heifers. Average weight 614 lb', '', 'Livestock', 'Cattle', 3882.24, 0.00, 0.00, 0.00, 0, '2021-09-20 08:45:45'),
	('afe6a32b-a958-11ec-ac57-d8cb8ac0caec', 'a23361fc-a958-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 3 bgs', '', 'Feed', 'Milk Replacer', -219.00, 0.00, 0.00, 0.00, 1, '2022-03-21 16:51:10'),
	('b01d7f9c-a8cd-11ec-ac57-d8cb8ac0caec', 'a09f1e4c-a8cd-11ec-ac57-d8cb8ac0caec', 'Straw - 2 bales', '', 'Feed', 'Straw', -23.50, 0.00, 0.00, 0.00, 1, '2022-03-21 00:16:16'),
	('b2a3b3d6-a8c8-11ec-ac57-d8cb8ac0caec', '3d0563cf-a8c8-11ec-ac57-d8cb8ac0caec', 'Calves - 4 heads', '', 'Livestock', 'Cattle', 1236.54, 0.00, 0.00, 0.00, 0, '2022-03-20 23:40:33'),
	('b46a94f2-1a11-11ec-9d60-d8cb8ac0caec', '13866f6e-1a11-11ec-9d60-d8cb8ac0caec', '40% Beef Supplement - 1bg ', '', 'Feed', 'Mineral Mix', -18.00, 0.00, 0.00, 0.00, 1, '2021-09-20 08:53:06'),
	('b58fbda9-a95f-11ec-ac57-d8cb8ac0caec', '9470bd6d-a95f-11ec-ac57-d8cb8ac0caec', 'Soybean Meal - 2 bgs', '', 'Feed', 'Soybean meal', -52.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:41:26'),
	('b8f195cc-a95d-11ec-ac57-d8cb8ac0caec', '5391b875-a95d-11ec-ac57-d8cb8ac0caec', 'Black Calf - 95 lb', '', 'Livestock', 'Cattle', -332.50, 0.00, 0.00, 0.00, 1, '2022-03-21 17:27:13'),
	('bafd9a98-a7ef-11ec-ac57-d8cb8ac0caec', '9f526005-a7ef-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 1bg', '', 'Feed', 'Mineral Mix', -19.60, 0.00, 0.00, 0.00, 1, '2022-03-19 21:47:36'),
	('bd943db3-a7e3-11ec-ac57-d8cb8ac0caec', '8d949ed7-a7e3-11ec-ac57-d8cb8ac0caec', 'Soybean Meal - 1bg', '', 'Feed', 'Soybean meal', -22.00, 0.00, 0.00, 0.00, 1, '2022-03-19 20:21:46'),
	('bdb27136-a95c-11ec-ac57-d8cb8ac0caec', '9c47eefc-a95c-11ec-ac57-d8cb8ac0caec', 'Black Calf - 255 lb', '', 'Livestock', 'Cattle', -484.50, 0.00, 0.00, 0.00, 1, '2022-03-21 17:20:11'),
	('bde4a5ba-a7e4-11ec-ac57-d8cb8ac0caec', 'a9959d2e-a7e4-11ec-ac57-d8cb8ac0caec', 'Straw - 2 bales', '', 'Feed', 'Straw', -23.50, 0.00, 0.00, 0.00, 1, '2022-03-19 20:28:56'),
	('bfe2d6e8-a957-11ec-ac57-d8cb8ac0caec', 'b2177d4c-a957-11ec-ac57-d8cb8ac0caec', 'Cracked Corn - 2 bgs', '', 'Feed', 'Cracked Corn', -32.00, 0.00, 0.00, 0.00, 1, '2022-03-21 16:44:27'),
	('c05bd9d4-a959-11ec-ac57-d8cb8ac0caec', 'b052e4ba-a959-11ec-ac57-d8cb8ac0caec', 'Black Calf - 115 lb', '', 'Livestock', 'Cattle', -264.50, 0.00, 0.00, 0.00, 1, '2022-03-21 16:58:47'),
	('c2045363-a95e-11ec-ac57-d8cb8ac0caec', 'b3759a5c-a95e-11ec-ac57-d8cb8ac0caec', 'Hay - 3 bales', '', 'Feed', 'Hay', -33.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:34:37'),
	('c4f75c8c-a95f-11ec-ac57-d8cb8ac0caec', '9470bd6d-a95f-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 1 bg', '', 'Feed', 'Mineral Mix', -18.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:41:52'),
	('c6ddff7e-a958-11ec-ac57-d8cb8ac0caec', 'a23361fc-a958-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 1 bg', '', 'Feed', 'Mineral Mix', -19.60, 0.00, 0.00, 0.00, 1, '2022-03-21 16:51:49'),
	('ca6c51c4-a95d-11ec-ac57-d8cb8ac0caec', '5391b875-a95d-11ec-ac57-d8cb8ac0caec', 'Black Calf - 135 lb', '', 'Livestock', 'Cattle', -513.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:27:42'),
	('cbf56002-a7ee-11ec-ac57-d8cb8ac0caec', 'b405c0cd-a7ee-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 3bgs', '', 'Feed', 'Milk Replacer', -216.00, 0.00, 0.00, 0.00, 1, '2022-03-19 21:40:54'),
	('ccd22873-a8c7-11ec-ac57-d8cb8ac0caec', 'bc107127-a8c7-11ec-ac57-d8cb8ac0caec', 'SoyBean Meal - 3 bgs', '', 'Feed', 'Soybean meal', -66.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:34:07'),
	('cce47276-a8c4-11ec-ac57-d8cb8ac0caec', 'b3898a8c-a8c4-11ec-ac57-d8cb8ac0caec', ' Soy and Corn Mix - 1 tone', '', 'Feed', 'Feed Mix', -559.35, 0.00, 0.00, 0.00, 1, '2022-03-20 23:12:39'),
	('d00e04e6-a8cc-11ec-ac57-d8cb8ac0caec', 'be0943a9-a8cc-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 1 bg', '', 'Feed', 'Mineral Mix', -26.99, 0.00, 0.00, 0.00, 1, '2022-03-21 00:10:00'),
	('d087fcf7-a959-11ec-ac57-d8cb8ac0caec', 'b052e4ba-a959-11ec-ac57-d8cb8ac0caec', 'Black Calf - 100 lb', '', 'Livestock', 'Cattle', -270.00, 0.00, 0.00, 0.00, 1, '2022-03-21 16:59:14'),
	('d1a5f12b-a95c-11ec-ac57-d8cb8ac0caec', '9c47eefc-a95c-11ec-ac57-d8cb8ac0caec', 'Black Calf - 95 lb', '', 'Livestock', 'Cattle', -351.50, 0.00, 0.00, 0.00, 1, '2022-03-21 17:20:45'),
	('d22fcbe3-a8c6-11ec-ac57-d8cb8ac0caec', 'bc3827b2-a8c6-11ec-ac57-d8cb8ac0caec', 'Straw - 3 bales', '', 'Feed', 'Straw', -35.25, 0.00, 0.00, 0.00, 1, '2022-03-20 23:27:07'),
	('d23e2a68-a8c5-11ec-ac57-d8cb8ac0caec', 'b9f05c00-a8c5-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 2bgs', '', 'Feed', 'Milk Replacer', -180.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:19:58'),
	('d657eb72-a958-11ec-ac57-d8cb8ac0caec', 'a23361fc-a958-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 2 bgs', '', 'Feed', 'Calf Starter', -45.00, 0.00, 0.00, 0.00, 1, '2022-03-21 16:52:14'),
	('d856f454-a8ce-11ec-ac57-d8cb8ac0caec', 'a2a91f84-a8ce-11ec-ac57-d8cb8ac0caec', 'Black Calf - 2 heads ', '', 'Livestock', 'Cattle', 1556.85, 0.00, 0.00, 0.00, 0, '2022-03-21 00:24:33'),
	('dd06bcc6-a959-11ec-ac57-d8cb8ac0caec', 'b052e4ba-a959-11ec-ac57-d8cb8ac0caec', 'Black Calf - 220 lb', '', 'Livestock', 'Cattle', -374.00, 0.00, 0.00, 0.00, 1, '2022-03-21 16:59:35'),
	('ddc43963-a8ca-11ec-ac57-d8cb8ac0caec', 'cf224c7d-a8ca-11ec-ac57-d8cb8ac0caec', 'Black Calf - 520 lb', '', 'Livestock', 'Cattle', 970.00, 0.00, 0.00, 0.00, 0, '2022-03-20 23:56:04'),
	('df9ba1ca-a8cc-11ec-ac57-d8cb8ac0caec', 'be0943a9-a8cc-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 1 bg', '', 'Feed', 'Calf Starter', -24.50, 0.00, 0.00, 0.00, 1, '2022-03-21 00:10:26'),
	('e177e867-a95c-11ec-ac57-d8cb8ac0caec', '9c47eefc-a95c-11ec-ac57-d8cb8ac0caec', 'Black Calf - 105 lb', '', 'Livestock', 'Cattle', -409.50, 0.00, 0.00, 0.00, 1, '2022-03-21 17:21:11'),
	('e2861e6f-a95d-11ec-ac57-d8cb8ac0caec', '5391b875-a95d-11ec-ac57-d8cb8ac0caec', 'Black Calf - 130 lb', '', 'Livestock', 'Cattle', -494.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:28:22'),
	('e491fb24-a95e-11ec-ac57-d8cb8ac0caec', 'd7c49b53-a95e-11ec-ac57-d8cb8ac0caec', 'Hay - 50 bales', '', 'Feed', 'Hay', -250.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:35:35'),
	('ea6752e6-a8c7-11ec-ac57-d8cb8ac0caec', 'bc107127-a8c7-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 2 bgs', '', 'Feed', 'Mineral Mix', -36.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:34:57'),
	('eba37a2c-a8c5-11ec-ac57-d8cb8ac0caec', 'b9f05c00-a8c5-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 1bg', '', 'Feed', 'Calf Starter', -23.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:20:40'),
	('ecf1c73a-a8cd-11ec-ac57-d8cb8ac0caec', 'd2291662-a8cd-11ec-ac57-d8cb8ac0caec', 'Soy and Corn Mix - 1 tone', '', 'Feed', 'Feed Mix', -576.30, 0.00, 0.00, 0.00, 1, '2022-03-21 00:17:58'),
	('ee6f7db6-a7e2-11ec-ac57-d8cb8ac0caec', '82875753-a7e2-11ec-ac57-d8cb8ac0caec', 'Cracked Corn 4bg', '', 'Feed', 'Cracked Corn', -62.00, 0.00, 0.00, 0.00, 1, '2022-03-19 20:15:58'),
	('f47b34a5-a95d-11ec-ac57-d8cb8ac0caec', '5391b875-a95d-11ec-ac57-d8cb8ac0caec', 'Black Calf - 120 lb', '', 'Livestock', 'Cattle', -468.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:28:53'),
	('f5622a6c-a95c-11ec-ac57-d8cb8ac0caec', '9c47eefc-a95c-11ec-ac57-d8cb8ac0caec', 'Black Calf - 175 lb', '', 'Livestock', 'Cattle', -490.00, 0.00, 0.00, 0.00, 1, '2022-03-21 17:21:45'),
	('f5c25200-a957-11ec-ac57-d8cb8ac0caec', 'df3b38e9-a957-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 3 bgs', '', 'Feed', 'Mineral Mix', -58.80, 0.00, 0.00, 0.00, 1, '2022-03-21 16:45:58'),
	('f8f019f9-a8c7-11ec-ac57-d8cb8ac0caec', 'bc107127-a8c7-11ec-ac57-d8cb8ac0caec', 'Cracked Corn - 8 bgs', '', 'Feed', 'Cracked Corn', -124.00, 0.00, 0.00, 0.00, 1, '2022-03-20 23:35:21'),
	('fbe0100e-a958-11ec-ac57-d8cb8ac0caec', 'ee16c2e2-a958-11ec-ac57-d8cb8ac0caec', 'Milk Replacer - 2 bgs', '', 'Feed', 'Milk Replacer', -144.00, 0.00, 0.00, 0.00, 1, '2022-03-21 16:53:17'),
	('ff9be58f-a8c3-11ec-ac57-d8cb8ac0caec', 'e80add8c-a8c3-11ec-ac57-d8cb8ac0caec', 'Calf Starter - 2bgs', '', 'Feed', 'Calf Starter', -44.84, 0.00, 0.00, 0.00, 1, '2022-03-20 23:06:55'),
	('ffcf0446-a7ef-11ec-ac57-d8cb8ac0caec', 'e29293e3-a7ef-11ec-ac57-d8cb8ac0caec', 'Beef Supplement - 4 bgs', '', 'Feed', 'Mineral Mix', -78.40, 0.00, 0.00, 0.00, 1, '2022-03-19 21:49:31');

-- Dumping structure for table farmwork.user
CREATE TABLE IF NOT EXISTS `user` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `username` varchar(15) NOT NULL,
  `password` varchar(255) NOT NULL,
  `email` varchar(50) NOT NULL,
  `is_active` tinyint(4) NOT NULL DEFAULT 1,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='cattle management members.';

-- Dumping data for table farmwork.user: ~1 rows (approximately)
INSERT INTO `user` (`id`, `username`, `password`, `email`, `is_active`, `created_at`) VALUES
	('5e0d0d6c10096', 'farmer', '$2y$10$YxQsfaEVGMokSlb9QuKkUOkYxyLEOpM9XiuMFhrJifnTzjv9lnmze', 'dimasalt@gmail.com', 1, '2020-01-01 16:30:34'),
	('861020da-512d-11ec-8ab6-d8cb8ac0caec', 'dmitri', '2345', 'dimasalt@yahoo.com', 1, '2021-11-29 10:59:21');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;

-- Dumping data for table farmwork.user_detail: ~0 rows (approximately)

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='contains user login information';

-- Dumping data for table farmwork.user_logins: ~0 rows (approximately)

-- Dumping structure for table farmwork.user_role
CREATE TABLE IF NOT EXISTS `user_role` (
  `id` char(36) NOT NULL DEFAULT uuid(),
  `role` varchar(10) NOT NULL,
  `role_desc` varchar(150) DEFAULT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='member roles in the cattle management system.';

-- Dumping data for table farmwork.user_role: ~2 rows (approximately)
INSERT INTO `user_role` (`id`, `role`, `role_desc`, `created_at`) VALUES
	('98534618084409345', 'admin', NULL, '2020-01-04 15:24:44'),
	('98534618084409346', 'user', NULL, '2020-01-04 15:24:53');

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
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='Cattle Management system users and their role connections';

-- Dumping data for table farmwork.user_to_role: ~0 rows (approximately)

-- Dumping structure for table farmwork.vehicle_log_book
CREATE TABLE IF NOT EXISTS `vehicle_log_book` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `year_start_odometer` int(11) NOT NULL,
  `year_end_odometer` int(11) DEFAULT NULL,
  `vehicle_desc` varchar(150) NOT NULL,
  `created_at` datetime NOT NULL DEFAULT current_timestamp(),
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=16 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='vehicle log book records.';

-- Dumping data for table farmwork.vehicle_log_book: ~0 rows (approximately)

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
) ENGINE=InnoDB AUTO_INCREMENT=29 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci COMMENT='vehicle log book to keep track on a business related travel';

-- Dumping data for table farmwork.vehicle_log_book_item: ~0 rows (approximately)

-- Dumping structure for procedure farmwork.budgetCreate
DELIMITER //
CREATE PROCEDURE `budgetCreate`(
	IN `parent_id` INT,
	IN `budget_name` VARCHAR(250),
	IN `budget_amount` DECIMAL(19,2),
	IN `budget_amount_actual` DECIMAL(19,2),
	IN `is_done` TINYINT,
	IN `is_default` TINYINT,
	IN `budget_date` DATETIME
)
    COMMENT 'creates new budget record'
BEGIN

-- insert record
INSERT INTO budget
(
	budget.parent_id,
	budget.budget_name,
	budget.budget_amount,
	budget.budget_amount_actual,
	budget.is_default,
	budget.is_done,
	budget.budget_date
)
VALUES 
(
	parent_id,
	budget_name,
	budget_amount,
	budget_amount_actual,
	is_default,
	is_done,
	budget_date
);

-- get last insert id
SELECT LAST_INSERT_ID() AS 'id';

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.budgetDelete
DELIMITER //
CREATE PROCEDURE `budgetDelete`(
	IN `id` INT
)
    COMMENT 'Removes budget item from the list'
BEGIN

	-- find if item is main item or not
	DECLARE parent_id INT;	
	SET parent_id = (SELECT budget.parent_id FROM budget WHERE budget.id = id);

	-- remove the item
	DELETE FROM budget WHERE budget.id = id;
	
	-- if item was main item remove all sub items
	IF parent_id = 0 then 
		DELETE FROM budget WHERE budget.parent_id = id;
	END if;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.budgetGetAll
DELIMITER //
CREATE PROCEDURE `budgetGetAll`(
	IN `id` INT
)
    COMMENT 'selects all budget records from a selected (by id) '
BEGIN

	SELECT 
		budget.id,
		budget.parent_id,
		budget.budget_name,
		budget.budget_amount,
		budget.budget_amount_actual,
		budget.is_done,
		budget.is_default,
		DATE(budget.budget_date) AS budget_date,	
		(SELECT SUM(budget.budget_amount) FROM budget) AS budget_amount_total,
		(SELECT SUM(budget.budget_amount_actual) FROM budget) AS budget_amount_actual_total
	FROM budget
	WHERE budget.id = id OR budget.parent_id = id
	ORDER BY budget.budget_date ASC;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.budgetGetMainAll
DELIMITER //
CREATE PROCEDURE `budgetGetMainAll`()
    COMMENT 'Gets all main items for the drop down on a budget page'
BEGIN

	SELECT 
		budget.id,
		budget.parent_id,
		budget.budget_name,	
		budget.is_default
	FROM budget
	WHERE budget.parent_id = 0
	ORDER BY budget.budget_name ASC;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.budgetUpdate
DELIMITER //
CREATE PROCEDURE `budgetUpdate`(
	IN `id` INT,
	IN `budget_name` VARCHAR(250),
	IN `budget_amount` DECIMAL(19,2),
	IN `budget_amount_actual` DECIMAL(19,2),
	IN `budget_date` DATETIME
)
    COMMENT 'updates budget record'
BEGIN

	UPDATE 
		budget
	SET 
		budget.budget_name = budget_name,
		budget.budget_amount = budget_amount,
		budget.budget_amount_actual = budget_amount_actual,
		budget.budget_date = budget_date
	WHERE budget.id = id;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.budgetUpdateDefault
DELIMITER //
CREATE PROCEDURE `budgetUpdateDefault`(
	IN `id` INT,
	IN `is_default` TINYINT
)
BEGIN

	-- reset default status for all budgets
	UPDATE budget 
	SET budget.is_default = 0;
	
	
	-- set status to chosen budget item based on item ID
	UPDATE budget
	SET 
		budget.is_default = is_default
	WHERE 
		budget.id = id; 
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.budgetUpdateStatus
DELIMITER //
CREATE PROCEDURE `budgetUpdateStatus`(
	IN `id` INT,
	IN `is_done` TINYINT
)
    COMMENT 'updates status to done or not done'
BEGIN

	UPDATE 
		budget
	SET 
		budget.is_done = is_done
	WHERE
		budget.id = id; 
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.contactAdd
DELIMITER //
CREATE PROCEDURE `contactAdd`(
	IN `contact_name` VARCHAR(100),
	IN `address` VARCHAR(150),
	IN `phone` VARCHAR(50),
	IN `email` VARCHAR(50),
	IN `note` VARCHAR(250),
	IN `contact_type` TINYINT
)
BEGIN

	INSERT INTO 
		contact (`name`, address, phone, email, note, `type`)
	VALUES 
		(contact_name, address, phone, email, note, contact_type );

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.contactDeleteOne
DELIMITER //
CREATE PROCEDURE `contactDeleteOne`(
	IN `contact_id` CHAR(36)
)
    COMMENT 'remoes selected contact ot vendor from database'
BEGIN

	DELETE 
	FROM contact 
	WHERE contact.id = contact_id;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.contactsGetAll
DELIMITER //
CREATE PROCEDURE `contactsGetAll`(
	IN `search_term` VARCHAR(50),
	IN `contact_type` TINYINT
)
    COMMENT 'get various contacts information'
BEGIN

	-- prepare search term
	IF LENGTH(search_term) < 2 THEN
		SET search_term = "%";
	ELSE
		SET search_term = CONCAT('%', search_term, '%') ;
	END IF;
	

	-- execute search based on vendor and search parameter
	IF contact_type = -1 THEN
		select contact.id, 
			contact.name, 
			contact.address, 		
			contact.phone, 
			contact.email, 
			contact.note,
			contact.`type`
		FROM contact
		WHERE contact.name LIKE search_term OR contact.address LIKE search_term
		ORDER BY contact.name ASC;
	ELSE 
		select contact.id, 
			contact.name, 
			contact.address, 		
			contact.phone, 
			contact.email, 
			contact.note,
			contact.`type`
		FROM contact
		WHERE (contact.name LIKE search_term OR contact.address LIKE search_term) AND contact.`type` = contact_type
		ORDER BY contact.name ASC;
	END IF;
		
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.contactUpdate
DELIMITER //
CREATE PROCEDURE `contactUpdate`(
	IN `id` CHAR(36),
	IN `contact_name` VARCHAR(100),
	IN `address` VARCHAR(50),
	IN `phone` VARCHAR(50),
	IN `email` VARCHAR(50),
	IN `note` VARCHAR(250),
	IN `contact_type` TINYINT
)
BEGIN

	UPDATE contact 
	SET contact.name = contact_name, 
		 contact.address = address, 	
		 contact.phone = phone,
		 contact.email = email,
		 contact.note = note,
		 contact.`type` = contact_type
	WHERE contact.id = id;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.contactVendorsGetAll
DELIMITER //
CREATE PROCEDURE `contactVendorsGetAll`()
select contact.id, 
			contact.name AS vendor_name, 
			contact.address AS vendor_address, 		
			contact.phone, 
			contact.email, 
			contact.note,
			contact.`type`
	FROM contact
	WHERE contact.`type` = 1 OR contact.`type` = 2
	ORDER BY contact.name ASC//
DELIMITER ;

-- Dumping structure for procedure farmwork.feedCreate
DELIMITER //
CREATE PROCEDURE `feedCreate`(
	IN `feed_name` VARCHAR(150),
	IN `feed_desc` VARCHAR(250),
	IN `feed_cp` INT,
	IN `feed_tdn` INT,
	IN `feed_type` VARCHAR(25),
	IN `feed_price` DECIMAL(19,2),
	IN `feed_price_lb` INT,
	IN `feed_usage` INT
)
    COMMENT 'Adds feed to a feed list'
BEGIN

	INSERT INTO feed
	(
		feed.feed_name,
		feed.feed_desc,
		feed.feed_cp,
		feed.feed_tdn,
		feed.feed_type,
		feed.feed_price,
		feed.feed_price_lb,
		feed.feed_usage
	)
	VALUES 
	(
		feed_name,
		feed_desc,
		feed_cp,
		feed_tdn,
		feed_type,
		feed_price,
		feed_price_lb,
		feed_usage
	);

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.feedDeleteOne
DELIMITER //
CREATE PROCEDURE `feedDeleteOne`(
	IN `id` INT
)
    COMMENT 'removes feed item'
BEGIN

	DELETE FROM feed
	WHERE feed.id = id;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.feedGetAll
DELIMITER //
CREATE PROCEDURE `feedGetAll`()
    COMMENT 'gets all feeds'
BEGIN

	SELECT 
		feed.id,
		feed.feed_name,
		feed.feed_desc,
		feed.feed_cp,
		feed.feed_tdn,
		feed.feed_type,
		feed.feed_price,
		feed.feed_price_lb,
		feed.feed_usage,
		feed.is_default
	FROM 
		feed
	ORDER BY feed.feed_name ASC;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.feedGetRequirements
DELIMITER //
CREATE PROCEDURE `feedGetRequirements`(
	IN `adg` DECIMAL(19,1),
	IN `start_weight` INT,
	IN `end_weight` INT
)
    COMMENT 'gets nutritional requirements for animals'
BEGIN

	SELECT 
		feed_requirement.id,
		feed_requirement.weight,
		feed_requirement.animal_type,
		feed_requirement.adg,
		feed_requirement.dm_per_day,
		feed_requirement.cp,
		feed_requirement.tdn
	FROM 
		feed_requirement
	WHERE 
		feed_requirement.adg = adg 
		AND (feed_requirement.weight >= start_weight AND feed_requirement.weight <= end_weight)
	ORDER BY 
		feed_requirement.weight, 
		feed_requirement.adg ASC;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.feedGetRequirementsAdg
DELIMITER //
CREATE PROCEDURE `feedGetRequirementsAdg`()
BEGIN

	SELECT 
		feed_requirement.adg
	FROM 
		feed_requirement
	GROUP BY 
		feed_requirement.adg;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.feedSetDefault
DELIMITER //
CREATE PROCEDURE `feedSetDefault`(
	IN `id` INT,
	IN `is_default` TINYINT
)
    COMMENT 'sets feed as default for ration calculations'
BEGIN

	UPDATE feed 
	SET 
		feed.is_default = is_default 
	WHERE 
		feed.id = id;
	

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.feedUpdate
DELIMITER //
CREATE PROCEDURE `feedUpdate`(
	IN `id` INT,
	IN `feed_name` VARCHAR(150),
	IN `feed_desc` VARCHAR(250),
	IN `feed_cp` INT,
	IN `feed_tdn` INT,
	IN `feed_type` VARCHAR(25),
	IN `feed_price` DECIMAL(19,2),
	IN `feed_price_lb` INT,
	IN `feed_usage` INT
)
BEGIN

	UPDATE feed 
	SET 
		feed.feed_name = feed_name,
		feed.feed_desc = feed_desc,
		feed.feed_cp = feed_cp,
		feed.feed_tdn = feed_tdn,
		feed.feed_type = feed_type,
		feed.feed_price = feed_price,
		feed.feed_price_lb = feed_price_lb,
		feed.feed_usage = feed_usage
	WHERE 
		feed.id = id;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.livestockCatDelete
DELIMITER //
CREATE PROCEDURE `livestockCatDelete`(
	IN `id` INT
)
    COMMENT 'removes category or sub category'
BEGIN
		
		-- remove category by id (if main category)
		DELETE FROM livestock_category 
		WHERE livestock_category.id = id;
		
		-- remove all sub categories
		DELETE FROM livestock_category 
		WHERE livestock_category.parent_id = id;
		
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.livestockCatSave
DELIMITER //
CREATE PROCEDURE `livestockCatSave`(
	IN `id` INT,
	IN `parent_id` INT,
	IN `category_name` VARCHAR(150),
	IN `category_description` VARCHAR(250)
)
    COMMENT 'procedure to update, insert or save transaction category or sub category record'
BEGIN

	-- if new category
	IF id = 0 THEN
			
			INSERT INTO livestock_category(parent_id, category_name, category_description)
			VALUES (parent_id, category_name, category_description);				
		
	-- if update category	
	ELSEIF id != 0 THEN
		
		UPDATE livestock_category
		SET 
			livestock_category.parent_id = parent_id, 
			livestock_category.category_name = category_name, 
			livestock_category.category_description = category_description
		WHERE livestock_category.id = id;			
		
	END IF;

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
	DECLARE total_pages INT DEFAULT 1;
	
	SET total = (SELECT count(livestock.id) FROM livestock WHERE livestock.is_active = is_active);		 

		 	
	IF total > records THEN
		SET total_pages = (total / records) + 1;
	END IF;
	
	 
	SELECT 
		livestock.id, 
		livestock.tag, 
		livestock.livestock_type,
		livestock.livestock_subtype,
		total_pages
	FROM 
		livestock 
	-- LEFT JOIN livestock_category ON livestock_category.id = livestock.livestock_type
	WHERE livestock.is_active >= is_active
	LIMIT offset_rows, records;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.livestockGetSubTypeAll
DELIMITER //
CREATE PROCEDURE `livestockGetSubTypeAll`(
	IN `id` INT
)
    COMMENT 'gets sub types based on parent_id parameter'
BEGIN

	SELECT 
		livestock_category.id, 
		livestock_category.parent_id,
		livestock_category.category_name,
		livestock_category.category_description
	FROM 
		livestock_category 
	WHERE livestock_category.parent_id = id
	ORDER BY livestock_category.category_name ASC;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.livestockGetTypeAll
DELIMITER //
CREATE PROCEDURE `livestockGetTypeAll`()
    COMMENT 'get list of main livestock types'
BEGIN

	SELECT 
		livestock_category.id, 
		livestock_category.parent_id,
		livestock_category.category_name,
		livestock_category.category_description
	FROM 
		livestock_category 
	WHERE livestock_category.parent_id = 0
	ORDER BY livestock_category.category_name ASC;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.livestockGroupGetAll
DELIMITER //
CREATE PROCEDURE `livestockGroupGetAll`()
    COMMENT 'Gets livestock groups and their description'
BEGIN
	
	 
	SELECT 
		livestock_group.id,
		livestock_group.group_name,
		livestock_group.group_desc
	FROM 
		livestock_group;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.medicationAdd
DELIMITER //
CREATE PROCEDURE `medicationAdd`(
	IN `med_name` VARCHAR(50),
	IN `med_desc` VARCHAR(550),
	IN `med_instruction` VARCHAR(2000),
	IN `med_price` DECIMAL(19,2),
	IN `med_on_hand` INT
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
			med_desc, 
			med_instruction,
			med_price,
			med_on_hand
		);
		
		
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
	IN `med_instruction` VARCHAR(2000),
	IN `med_price` DECIMAL(19,2),
	IN `on_hand_doses` INT
)
BEGIN

	UPDATE medication
	SET 
		medication.name = med_name, 
		medication.`desc` = med_desc,
		medication.instruction = med_instruction,
		medication.price = med_price,
		medication.on_hand_doses = on_hand_doses
	WHERE medication.id = id;	

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.pageSettingGet
DELIMITER //
CREATE PROCEDURE `pageSettingGet`(
	IN `page_name` VARCHAR(50)
)
BEGIN

	SELECT 
		page_settings.id,
		page_settings.page_name,
		page_settings.setting_name,
		page_settings.setting_value
	FROM 
		page_settings
	WHERE 
		page_settings.page_name = page_name;
	
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
	IN `vendor_name` VARCHAR(50),
	IN `vendor_address` VARCHAR(250),
	IN `trans_desc` VARCHAR(250),
	IN `trans_currency` VARCHAR(10),
	IN `trans_date` DATETIME
)
    COMMENT 'Inserts new main transactions into database'
BEGIN

	INSERT INTO transaction
			(			
				transaction.vendor_name,			
				transaction.vendor_address,			
				transaction.trans_desc,
				transaction.trans_currency,
				transaction.trans_date
			)
	VALUES
		  (		
	  			vendor_name,
				vendor_address,
				trans_desc,			
				trans_currency,
				trans_date
		  );
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionDelete
DELIMITER //
CREATE PROCEDURE `transactionDelete`(
	IN `id` CHAR(36)
)
BEGIN

	DELETE 
	FROM transaction 
	WHERE transaction.id = id;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionGetTotals
DELIMITER //
CREATE PROCEDURE `transactionGetTotals`(
	IN `search_term` VARCHAR(50),
	IN `category_selected` VARCHAR(150),
	IN `sub_category_selected` VARCHAR(150),
	IN `start_date` VARCHAR(50),
	IN `end_date` VARCHAR(50)
)
    COMMENT 'selects totals for stats based on search parameters and selected categories and dates'
BEGIN

	-- DECLARE total_expences 
	DECLARE total_expences DECIMAL(19,2) DEFAULT 0;
	DECLARE total_income DECIMAL(19,2) DEFAULT 0;
	DECLARE total_feed_expences DECIMAL(19,2) DEFAULT 0;
	DECLARE total_cattle_expences DECIMAL(19,2) DEFAULT 0;
	DECLARE total_veterinary_expences DECIMAL(19,2) DEFAULT 0;
	DECLARE total_gasoline_expences DECIMAL(19,2) DEFAULT 0;
	DECLARE total_equipment DECIMAL(19,2) DEFAULT 0;
	DECLARE total_profit DECIMAL(19,2) DEFAULT 0;

	-- prepare search term
	SET search_term = CONCAT('%', search_term, '%') ;
	SET category_selected = CONCAT('%', category_selected, '%') ;	
	SET sub_category_selected = CONCAT('%', sub_category_selected, '%') ;
		
	
	-- drop temporary table if exists
	DROP TEMPORARY TABLE IF EXISTS transaction_totals_tmp;

	-- create temporary table for all required information
	CREATE TEMPORARY TABLE transaction_totals_tmp
	(
		SELECT 
			transaction.id,
			transaction.trans_desc,
			transaction.vendor_name,
			transaction_item.item_category,
			transaction_item.item_subcategory,
			transaction.trans_date,
			transaction_item.amount,
			transaction_item.is_expence
		FROM 
			transaction INNER JOIN transaction_item 
			ON transaction.id = transaction_item.transaction_id 
		WHERE 	
			(transaction.vendor_name LIKE search_term
				OR transaction.vendor_address LIKE search_term
				OR transaction.trans_desc LIKE search_term)
				AND (transaction.trans_date >= start_date AND transaction.trans_date <= end_date) 		
				AND (transaction_item.item_category LIKE category_selected AND transaction_item.item_subcategory LIKE sub_category_selected) 											
			ORDER BY transaction.trans_date DESC
	);
	
	SET total_expences = (SELECT SUM(transaction_totals_tmp.amount)
							    	FROM transaction_totals_tmp
							    	WHERE transaction_totals_tmp.is_expence = 1);
							    	
	SET total_income = (SELECT SUM(transaction_totals_tmp.amount)
						    	FROM transaction_totals_tmp
						    	WHERE transaction_totals_tmp.is_expence = 0);
							    	
	SET total_feed_expences = (SELECT SUM(transaction_totals_tmp.amount)
								    	FROM transaction_totals_tmp
								    	WHERE transaction_totals_tmp.is_expence = 1 AND transaction_totals_tmp.item_category LIKE 'Feed');
								    	
	SET total_cattle_expences = (SELECT SUM(transaction_totals_tmp.amount)
								    	FROM transaction_totals_tmp
								    	WHERE transaction_totals_tmp.is_expence = 1 AND transaction_totals_tmp.item_category LIKE 'Livestock' AND transaction_totals_tmp.item_subcategory LIKE 'Cattle');
							    	
	SET total_veterinary_expences = (SELECT SUM(transaction_totals_tmp.amount)
										    	FROM transaction_totals_tmp
										    	WHERE transaction_totals_tmp.is_expence = 1 AND transaction_totals_tmp.item_category LIKE 'Veterinary');				
										 
	
	SET total_gasoline_expences = (SELECT SUM(transaction_totals_tmp.amount)
							   		 	FROM transaction_totals_tmp
							    			WHERE transaction_totals_tmp.is_expence = 1 AND transaction_totals_tmp.item_category LIKE 'Vehicle' AND transaction_totals_tmp.item_subcategory LIKE 'Gasoline');	
							    			
	SET total_equipment = (SELECT SUM(transaction_totals_tmp.amount)
						   		FROM transaction_totals_tmp
						    		WHERE transaction_totals_tmp.is_expence = 1 AND transaction_totals_tmp.item_category LIKE 'Equipment');	
							    			
							    		
											 
	SET total_profit = total_income - (-1 * total_expences);												 
								
							    	
	SELECT IFNULL(total_expences, 0) AS total_expences,
			 IFNULL(total_income, 0) AS total_income,
			 IFNULL(total_feed_expences, 0) AS total_feed_expences,
			 IFNULL(total_cattle_expences, 0) AS total_cattle_expences,
			 IFNULL(total_veterinary_expences, 0) AS total_veterinary_expences,
			 IFNULL(total_gasoline_expences, 0) AS total_gasoline_expences,
			 IFNULL(total_equipment, 0) AS total_equipment,
			 IFNULL(total_profit, 0) AS total_profit;
			 
			 
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionItemCreate
DELIMITER //
CREATE PROCEDURE `transactionItemCreate`(
	IN `transaction_id` CHAR(36),
	IN `item_name` VARCHAR(150),
	IN `item_desc` VARCHAR(250),
	IN `item_category` VARCHAR(150),
	IN `item_subcategory` VARCHAR(150),
	IN `amount` DECIMAL(19,2),
	IN `hst_tax` DECIMAL(19,2),
	IN `gst_tax` DECIMAL(19,2),
	IN `pst_tax` DECIMAL(19,2),
	IN `is_expence` TINYINT
)
BEGIN

	INSERT INTO transaction_item
	(
		id,
		transaction_id,
		item_name,
		item_desc,
		item_category,
		item_subcategory,
		amount,
		hst_tax,
		gst_tax,
		pst_tax,
		is_expence
	)
	VALUES 
	(
		UUID(),
		transaction_id,
		item_name,
		item_desc,
		item_category,
		item_subcategory,
		amount,
		hst_tax,
		gst_tax,
		pst_tax,
		is_expence
	);
		
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionItemDelete
DELIMITER //
CREATE PROCEDURE `transactionItemDelete`(
	IN `id` CHAR(36)
)
BEGIN

	DELETE FROM transaction_item
	WHERE transaction_item.id = id;

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionItemsGet
DELIMITER //
CREATE PROCEDURE `transactionItemsGet`(
	IN `transaction_id` CHAR(36),
	IN `category_selected` VARCHAR(150),
	IN `sub_category_selected` VARCHAR(150)
)
BEGIN

	-- prepare category item search
	IF LENGTH(category_selected) = 0 THEN
		SET category_selected = "%";
	ELSE
		SET category_selected = CONCAT('%', category_selected, '%') ;
	END IF;
	
	-- prepare sub category item search
	IF LENGTH(sub_category_selected) = 0 THEN
		SET sub_category_selected = "%";
	ELSE
		SET sub_category_selected = CONCAT('%', sub_category_selected, '%') ;
	END IF;
	

	SELECT 
		transaction_item.id,
		transaction_item.transaction_id,
		transaction_item.item_name,
		transaction_item.item_desc,
		transaction_item.item_category,
		transaction_item.item_subcategory,
		transaction_item.amount,
		transaction_item.hst_tax,
		transaction_item.gst_tax,
		transaction_item.pst_tax,
		transaction_item.is_expence
	FROM 
		transaction_item
	WHERE 		
		transaction_item.transaction_id = transaction_id 
		AND transaction_item.item_category LIKE category_selected 
		AND transaction_item.item_subcategory LIKE sub_category_selected
	ORDER BY transaction_item.item_name ASC;
		
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionsGetAll
DELIMITER //
CREATE PROCEDURE `transactionsGetAll`(
	IN `search_term` VARCHAR(50),
	IN `category_selected` VARCHAR(150),
	IN `sub_category_selected` VARCHAR(150),
	IN `current_page` INT,
	IN `take_records` INT,
	IN `start_date` VARCHAR(50),
	IN `end_date` VARCHAR(50)
)
    COMMENT 'selects all transaction records acording to the search term, categories selected and date span '
BEGIN

	-- set pager variables
	DECLARE offset_rows INT DEFAULT (current_page -1) * take_records;	
	
	DECLARE total_records INT DEFAULT 0;
	DECLARE total_pages INT DEFAULT 1;
	

	-- prepare search term
-- 	IF LENGTH(search_term) < 2 THEN
-- 		SET search_term = "%";
-- 	ELSE
-- 		SET search_term = CONCAT('%', search_term, '%') ;
-- 	END IF;
	
	SET search_term = CONCAT('%', search_term, '%') ;
	
	-- prepare sub category item search
	-- IF LENGTH(sub_category_selected) = 0 THEN
-- 		SET sub_category_selected = "%";	
-- 	ELSE
-- 		SET sub_category_selected = CONCAT('%', sub_category_selected, '%') ;				
-- 	END IF;
	
	SET sub_category_selected = CONCAT('%', sub_category_selected, '%') ;			
	
	
	-- drop temporary table if exists (sometimes mysql will wait before it drops it automatically
	-- so we need to force the table dropping
	DROP TEMPORARY TABLE IF EXISTS transaction_tmp;
		
	
	-- prepare category item search
	IF LENGTH(category_selected) = 0 THEN
		SET category_selected = "%";
					
		CREATE TEMPORARY TABLE transaction_tmp
		(
			SELECT 
				transaction.id,
				transaction.trans_desc,
				transaction.vendor_name,
				transaction.vendor_address,	
				transaction.trans_image,
				transaction.trans_currency,
				DATE(transaction.trans_date) AS trans_date
			FROM 
				transaction
			WHERE 		
				(transaction.vendor_name LIKE search_term
				OR transaction.vendor_address LIKE search_term
				OR transaction.trans_desc LIKE search_term)
				AND (transaction.trans_date >= start_date AND transaction.trans_date <= end_date) 													
--			ORDER BY transaction.trans_date DESC
			ORDER BY transaction.created_at DESC
		);
	ELSE
		SET category_selected = CONCAT('%', category_selected, '%') ;
		
		CREATE TEMPORARY TABLE transaction_tmp
		(
			SELECT 
				transaction.id,
				transaction.trans_desc,
				transaction.vendor_name,
				transaction.vendor_address,	
				transaction.trans_image,
				transaction.trans_currency,
				DATE(transaction.trans_date) AS trans_date
			FROM 
				transaction
			WHERE 		
				(transaction.vendor_name LIKE search_term
				OR transaction.vendor_address LIKE search_term
				OR transaction.trans_desc LIKE search_term)
				AND (transaction.trans_date >= start_date AND transaction.trans_date <= end_date) 		
				AND transaction.id IN (SELECT transaction_item.transaction_id 
												FROM transaction_item 
												WHERE transaction_item.item_category LIKE category_selected AND transaction_item.item_subcategory LIKE sub_category_selected) 											
			ORDER BY transaction.trans_date DESC
		);
	END IF;	
	
	
	
	-- COUNT total NUMBER of records FOR this selection
	SET total_records = (SELECT COUNT(transaction_tmp.id) FROM transaction_tmp);
	
	-- find how many pages there is
	IF total_records > take_records THEN
		SET total_pages = (total_records / take_records) + 1;
	END IF;
	
	-- select totals
	--	SET exprences_total = (SELECT SUM(transaction_tmp.
	
	-- select all the records
	SELECT *, 
		total_records AS 'total_records',
		total_pages AS 'total_pages' 
	FROM transaction_tmp; 
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionsGetAll_2
DELIMITER //
CREATE PROCEDURE `transactionsGetAll_2`(
	IN `search_term` VARCHAR(50),
	IN `category_selected` VARCHAR(150),
	IN `sub_category_selected` VARCHAR(150),
	IN `current_page` INT,
	IN `take_records` INT,
	IN `start_date` VARCHAR(50),
	IN `end_date` VARCHAR(50)
)
    COMMENT 'selects all transaction records acording to the search term, categories selected and date span '
BEGIN

	-- set pager variables
	DECLARE offset_rows INT DEFAULT (current_page -1) * take_records;	
	
	DECLARE total_records INT DEFAULT 0;
	DECLARE total_pages INT DEFAULT 1;
	

	-- prepare search term
-- 	IF LENGTH(search_term) < 2 THEN
-- 		SET search_term = "%";
-- 	ELSE
-- 		SET search_term = CONCAT('%', search_term, '%') ;
-- 	END IF;
	
	SET search_term = CONCAT('%', search_term, '%') ;
	
	-- prepare sub category item search
	-- IF LENGTH(sub_category_selected) = 0 THEN
-- 		SET sub_category_selected = "%";	
-- 	ELSE
-- 		SET sub_category_selected = CONCAT('%', sub_category_selected, '%') ;				
-- 	END IF;
	
	SET sub_category_selected = CONCAT('%', sub_category_selected, '%') ;			
	
	
	-- drop temporary table if exists (sometimes mysql will wait before it drops it automatically
	-- so we need to force the table dropping
	DROP TEMPORARY TABLE IF EXISTS transaction_tmp;
		
	
	-- prepare category item search
	IF LENGTH(category_selected) = 0 THEN
		SET category_selected = "%";
					
		CREATE TEMPORARY TABLE transaction_tmp
		(
			SELECT 
				transaction.id,
				transaction.trans_desc,
				transaction.vendor_name,
				transaction.vendor_address,	
				transaction.trans_image,
				transaction.trans_currency,
				DATE(transaction.trans_date) AS trans_date
			FROM 
				transaction
			WHERE 		
				(transaction.vendor_name LIKE search_term
				OR transaction.vendor_address LIKE search_term
				OR transaction.trans_desc LIKE search_term)
				AND (transaction.trans_date >= start_date AND transaction.trans_date <= end_date) 													
--			ORDER BY transaction.trans_date DESC
			ORDER BY transaction.created_at DESC
		);
	ELSE
		SET category_selected = CONCAT('%', category_selected, '%') ;
		
		CREATE TEMPORARY TABLE transaction_tmp
		(
			SELECT 
				transaction.id,
				transaction.trans_desc,
				transaction.vendor_name,
				transaction.vendor_address,	
				transaction.trans_image,
				transaction.trans_currency,
				DATE(transaction.trans_date) AS trans_date
			FROM 
				transaction
			WHERE 		
				(transaction.vendor_name LIKE search_term
				OR transaction.vendor_address LIKE search_term
				OR transaction.trans_desc LIKE search_term)
				AND (transaction.trans_date >= start_date AND transaction.trans_date <= end_date) 		
				AND transaction.id IN (SELECT transaction_item.transaction_id 
												FROM transaction_item 
												WHERE transaction_item.item_category LIKE category_selected AND transaction_item.item_subcategory LIKE sub_category_selected) 											
			ORDER BY transaction.trans_date DESC
		);
	END IF;	
	
	
	
	-- COUNT total NUMBER of records FOR this selection
	SET total_records = (SELECT COUNT(transaction_tmp.id) FROM transaction_tmp);
	
	-- find how many pages there is
	IF total_records > take_records THEN
		SET total_pages = (total_records / take_records) + 1;
	END IF;
	
	-- select totals
	--	SET exprences_total = (SELECT SUM(transaction_tmp.
	
	-- select all the records
	SELECT *, 
		total_records AS 'total_records',
		total_pages AS 'total_pages' 
	FROM transaction_tmp
		LIMIT take_records OFFSET offset_rows;
	
END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionUpdate
DELIMITER //
CREATE PROCEDURE `transactionUpdate`(
	IN `id` CHAR(36),
	IN `trans_desc` VARCHAR(250),
	IN `vendor_name` VARCHAR(150),
	IN `vendor_address` VARCHAR(250),
	IN `trans_currency` VARCHAR(10),
	IN `trans_date` DATETIME
)
    COMMENT 'updates main transaction record'
BEGIN

		UPDATE transaction
		SET 
			transaction.trans_desc = trans_desc,
			transaction.vendor_name = vendor_name,
			transaction.vendor_address = vendor_address,
			transaction.trans_currency = trans_currency,
			transaction.trans_date = trans_date
		WHERE transaction.id = id;			

END//
DELIMITER ;

-- Dumping structure for procedure farmwork.transactionUpdateImage
DELIMITER //
CREATE PROCEDURE `transactionUpdateImage`(
	IN `id` CHAR(36),
	IN `trans_image` VARCHAR(250)
)
BEGIN

		-- check if image needs to be removed or updated
		-- if image string is empty, set it to the null
			-- prepare search term
		IF LENGTH(trans_image) = 0 THEN
			SET trans_image = NULL;
		END IF;

		-- update image value
		UPDATE transaction
		SET 
			transaction.trans_image = trans_image		
		WHERE transaction.id = id;			

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

	INSERT INTO user(user.id, user.username, user.email, user.password, user.is_active) 
	VALUES(user_id, username, email, password, 1);
	
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

/*!40103 SET TIME_ZONE=IFNULL(@OLD_TIME_ZONE, 'system') */;
/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
