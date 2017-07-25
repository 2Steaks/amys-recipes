# ************************************************************
# Sequel Pro SQL dump
# Version 4541
#
# http://www.sequelpro.com/
# https://github.com/sequelpro/sequelpro
#
# Host: 127.0.0.1 (MySQL 5.7.18)
# Database: amys-recipes
# Generation Time: 2017-07-25 14:16:24 +0000
# ************************************************************


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


# Dump of table assetindexdata
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assetindexdata`;

CREATE TABLE `assetindexdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sessionId` varchar(36) NOT NULL DEFAULT '',
  `volumeId` int(11) NOT NULL,
  `uri` text,
  `size` bigint(20) unsigned DEFAULT NULL,
  `timestamp` datetime DEFAULT NULL,
  `recordId` int(11) DEFAULT NULL,
  `inProgress` tinyint(1) DEFAULT '0',
  `completed` tinyint(1) DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assetindexdata_sessionId_volumeId_idx` (`sessionId`,`volumeId`),
  KEY `assetindexdata_volumeId_idx` (`volumeId`),
  CONSTRAINT `assetindexdata_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assets`;

CREATE TABLE `assets` (
  `id` int(11) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `folderId` int(11) NOT NULL,
  `filename` varchar(255) NOT NULL,
  `kind` varchar(50) NOT NULL DEFAULT 'unknown',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `size` bigint(20) unsigned DEFAULT NULL,
  `focalPoint` varchar(13) DEFAULT NULL,
  `dateModified` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assets_filename_folderId_unq_idx` (`filename`,`folderId`),
  KEY `assets_folderId_idx` (`folderId`),
  KEY `assets_volumeId_idx` (`volumeId`),
  CONSTRAINT `assets_folderId_fk` FOREIGN KEY (`folderId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `assets_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `assets` WRITE;
/*!40000 ALTER TABLE `assets` DISABLE KEYS */;

INSERT INTO `assets` (`id`, `volumeId`, `folderId`, `filename`, `kind`, `width`, `height`, `size`, `focalPoint`, `dateModified`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(8,1,3,'chorizo-pasta.jpg','image',787,524,88977,NULL,'2017-07-25 14:04:22','2017-07-25 14:04:22','2017-07-25 14:04:22','b777bd78-563f-4651-840a-2a46da384333');

/*!40000 ALTER TABLE `assets` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table assettransformindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransformindex`;

CREATE TABLE `assettransformindex` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `assetId` int(11) NOT NULL,
  `filename` varchar(255) DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `location` varchar(255) NOT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `fileExists` tinyint(1) NOT NULL DEFAULT '0',
  `inProgress` tinyint(1) NOT NULL DEFAULT '0',
  `dateIndexed` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `assettransformindex_volumeId_assetId_location_idx` (`volumeId`,`assetId`,`location`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table assettransforms
# ------------------------------------------------------------

DROP TABLE IF EXISTS `assettransforms`;

CREATE TABLE `assettransforms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `mode` enum('stretch','fit','crop') NOT NULL DEFAULT 'crop',
  `position` enum('top-left','top-center','top-right','center-left','center-center','center-right','bottom-left','bottom-center','bottom-right') NOT NULL DEFAULT 'center-center',
  `width` int(11) unsigned DEFAULT NULL,
  `height` int(11) unsigned DEFAULT NULL,
  `format` varchar(255) DEFAULT NULL,
  `quality` int(11) DEFAULT NULL,
  `dimensionChangeTime` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `assettransforms_name_unq_idx` (`name`),
  UNIQUE KEY `assettransforms_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `assettransforms` WRITE;
/*!40000 ALTER TABLE `assettransforms` DISABLE KEYS */;

INSERT INTO `assettransforms` (`id`, `name`, `handle`, `mode`, `position`, `width`, `height`, `format`, `quality`, `dimensionChangeTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Mobile','mobile','fit','center-center',768,432,NULL,NULL,'2017-07-25 12:00:36','2017-07-25 12:00:36','2017-07-25 12:00:36','04967db3-8359-413f-8f6f-1c34fe0fcf3a'),
	(2,'Tablet','tablet','fit','center-center',960,540,NULL,NULL,'2017-07-25 12:01:03','2017-07-25 12:01:03','2017-07-25 12:01:03','2e94a589-8cf6-4a4f-af07-ca58a933d1e1'),
	(3,'Desktop','desktop','fit','center-center',1200,675,NULL,NULL,'2017-07-25 12:01:46','2017-07-25 12:01:22','2017-07-25 12:01:46','b08fe0b1-78a7-4434-b592-857e93bf5e2d');

/*!40000 ALTER TABLE `assettransforms` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table categories
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categories`;

CREATE TABLE `categories` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `categories_groupId_idx` (`groupId`),
  CONSTRAINT `categories_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categories_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups`;

CREATE TABLE `categorygroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_name_unq_idx` (`name`),
  UNIQUE KEY `categorygroups_handle_unq_idx` (`handle`),
  KEY `categorygroups_structureId_idx` (`structureId`),
  KEY `categorygroups_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `categorygroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `categorygroups_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table categorygroups_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `categorygroups_sites`;

CREATE TABLE `categorygroups_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `categorygroups_sites_groupId_siteId_unq_idx` (`groupId`,`siteId`),
  KEY `categorygroups_sites_siteId_idx` (`siteId`),
  CONSTRAINT `categorygroups_sites_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `categorygroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `categorygroups_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table content
# ------------------------------------------------------------

DROP TABLE IF EXISTS `content`;

CREATE TABLE `content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `title` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  `field_recipe` text,
  PRIMARY KEY (`id`),
  UNIQUE KEY `content_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  KEY `content_siteId_idx` (`siteId`),
  KEY `content_title_idx` (`title`),
  CONSTRAINT `content_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `content_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `content` WRITE;
/*!40000 ALTER TABLE `content` DISABLE KEYS */;

INSERT INTO `content` (`id`, `elementId`, `siteId`, `title`, `dateCreated`, `dateUpdated`, `uid`, `field_recipe`)
VALUES
	(1,1,1,NULL,'2017-07-25 11:50:42','2017-07-25 11:50:42','611a1824-cc31-4927-893e-f4afaf254f86',NULL),
	(3,3,1,'Chorizo Pasta','2017-07-25 13:10:49','2017-07-25 13:21:48','c27d68c5-bf4f-454c-8a4f-11019d3204b2','{\"name\":\"Chorizo Pasta\",\"description\":\"Amy\'s favourite meal!\",\"skill\":\"beginner\",\"serves\":\"1\",\"ingredients\":[{\"quantity\":\"200\",\"units\":\"gs\",\"ingredient\":\"pasta\"},{\"quantity\":\"1\",\"units\":\"\",\"ingredient\":\"Onion\"},{\"quantity\":\"1\",\"units\":\"\",\"ingredient\":\"Pepper\"}],\"directions\":[{\"direction\":\"Dice the onion and pepper and fry in oil until translucent.\"},{\"direction\":\"Cut the chorizo in slices and then quarter it all and add to pan.\"},{\"direction\":\"Add pinch of salt, black pepper, chilli powder and paprika then give it a stir\"},{\"direction\":\"Add the chopped tomatoes, stir and cook down for 20mins.\"},{\"direction\":\"Once finished stir in the soft cheese and mix with the cooked pasta.\"}],\"imageId\":\"\",\"prepTime\":\"20\",\"cookTime\":\"20\",\"totalTime\":\"40\",\"ratings\":[],\"servingSize\":\"\",\"calories\":\"\",\"carbohydrateContent\":\"\",\"cholesterolContent\":\"\",\"fatContent\":\"\",\"fiberContent\":\"\",\"proteinContent\":\"\",\"saturatedFatContent\":\"\",\"sodiumContent\":\"\",\"sugarContent\":\"\",\"transFatContent\":\"\",\"unsaturatedFatContent\":\"\"}'),
	(8,8,1,'Chorizo-Pasta','2017-07-25 14:04:22','2017-07-25 14:04:22','8da7fef1-72f0-4387-8906-42e75d68adb0',NULL);

/*!40000 ALTER TABLE `content` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table deprecationerrors
# ------------------------------------------------------------

DROP TABLE IF EXISTS `deprecationerrors`;

CREATE TABLE `deprecationerrors` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `key` varchar(255) NOT NULL,
  `fingerprint` varchar(255) NOT NULL,
  `lastOccurrence` datetime NOT NULL,
  `file` varchar(255) NOT NULL,
  `line` smallint(6) unsigned NOT NULL,
  `message` varchar(255) DEFAULT NULL,
  `traces` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `deprecationerrors_key_fingerprint_unq_idx` (`key`,`fingerprint`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elementindexsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elementindexsettings`;

CREATE TABLE `elementindexsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elementindexsettings_type_unq_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table elements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements`;

CREATE TABLE `elements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `elements_fieldLayoutId_idx` (`fieldLayoutId`),
  KEY `elements_type_idx` (`type`),
  KEY `elements_enabled_idx` (`enabled`),
  KEY `elements_archived_dateCreated_idx` (`archived`,`dateCreated`),
  CONSTRAINT `elements_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements` WRITE;
/*!40000 ALTER TABLE `elements` DISABLE KEYS */;

INSERT INTO `elements` (`id`, `fieldLayoutId`, `type`, `enabled`, `archived`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'craft\\elements\\User',1,0,'2017-07-25 11:50:42','2017-07-25 11:50:42','608e7e34-2a02-46c1-8970-13de466f7c64'),
	(3,1,'craft\\elements\\Entry',1,0,'2017-07-25 13:10:49','2017-07-25 13:21:48','f90920dd-f916-42cd-8398-4a2e710161ee'),
	(8,2,'craft\\elements\\Asset',1,0,'2017-07-25 14:04:22','2017-07-25 14:04:22','c5be095a-8e39-43eb-827c-48ba0b3e9400');

/*!40000 ALTER TABLE `elements` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table elements_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `elements_sites`;

CREATE TABLE `elements_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `elementId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `slug` varchar(255) DEFAULT NULL,
  `uri` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `elements_sites_elementId_siteId_unq_idx` (`elementId`,`siteId`),
  UNIQUE KEY `elements_sites_uri_siteId_unq_idx` (`uri`,`siteId`),
  KEY `elements_sites_siteId_idx` (`siteId`),
  KEY `elements_sites_slug_siteId_idx` (`slug`,`siteId`),
  KEY `elements_sites_enabled_idx` (`enabled`),
  CONSTRAINT `elements_sites_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `elements_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `elements_sites` WRITE;
/*!40000 ALTER TABLE `elements_sites` DISABLE KEYS */;

INSERT INTO `elements_sites` (`id`, `elementId`, `siteId`, `slug`, `uri`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,NULL,NULL,1,'2017-07-25 11:50:42','2017-07-25 11:50:42','18d23ff9-de32-487d-908f-9801552ae488'),
	(3,3,1,'chorizo-pasta','recipes/chorizo-pasta',1,'2017-07-25 13:10:49','2017-07-25 13:21:48','440275b2-8f2d-42f4-a13b-829c40e938e6'),
	(8,8,1,NULL,NULL,1,'2017-07-25 14:04:22','2017-07-25 14:04:22','0b3e8382-9f5b-492d-9ae3-1a44bb4e09ab');

/*!40000 ALTER TABLE `elements_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entries`;

CREATE TABLE `entries` (
  `id` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `authorId` int(11) DEFAULT NULL,
  `postDate` datetime DEFAULT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entries_postDate_idx` (`postDate`),
  KEY `entries_expiryDate_idx` (`expiryDate`),
  KEY `entries_authorId_idx` (`authorId`),
  KEY `entries_sectionId_idx` (`sectionId`),
  KEY `entries_typeId_idx` (`typeId`),
  CONSTRAINT `entries_authorId_fk` FOREIGN KEY (`authorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entries_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `entrytypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entries` WRITE;
/*!40000 ALTER TABLE `entries` DISABLE KEYS */;

INSERT INTO `entries` (`id`, `sectionId`, `typeId`, `authorId`, `postDate`, `expiryDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(3,1,1,1,'2017-07-25 13:10:00',NULL,'2017-07-25 13:10:49','2017-07-25 13:21:48','76261dbf-5449-402c-b428-d94cede23945');

/*!40000 ALTER TABLE `entries` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entrydrafts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrydrafts`;

CREATE TABLE `entrydrafts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entrydrafts_sectionId_idx` (`sectionId`),
  KEY `entrydrafts_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entrydrafts_siteId_idx` (`siteId`),
  KEY `entrydrafts_creatorId_idx` (`creatorId`),
  CONSTRAINT `entrydrafts_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entrydrafts_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table entrytypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entrytypes`;

CREATE TABLE `entrytypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `hasTitleField` tinyint(1) NOT NULL DEFAULT '1',
  `titleLabel` varchar(255) DEFAULT 'Title',
  `titleFormat` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `entrytypes_name_sectionId_unq_idx` (`name`,`sectionId`),
  UNIQUE KEY `entrytypes_handle_sectionId_unq_idx` (`handle`,`sectionId`),
  KEY `entrytypes_sectionId_idx` (`sectionId`),
  KEY `entrytypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `entrytypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entrytypes_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entrytypes` WRITE;
/*!40000 ALTER TABLE `entrytypes` DISABLE KEYS */;

INSERT INTO `entrytypes` (`id`, `sectionId`, `fieldLayoutId`, `name`, `handle`, `hasTitleField`, `titleLabel`, `titleFormat`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,'Recipes','recipes',1,'Title',NULL,1,'2017-07-25 11:55:35','2017-07-25 13:21:27','0a0f4502-8ed6-4bd7-9560-94ab18fcd6ed');

/*!40000 ALTER TABLE `entrytypes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table entryversions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `entryversions`;

CREATE TABLE `entryversions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `entryId` int(11) NOT NULL,
  `sectionId` int(11) NOT NULL,
  `creatorId` int(11) DEFAULT NULL,
  `siteId` int(11) NOT NULL,
  `num` smallint(6) unsigned NOT NULL,
  `notes` text,
  `data` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `entryversions_sectionId_idx` (`sectionId`),
  KEY `entryversions_entryId_siteId_idx` (`entryId`,`siteId`),
  KEY `entryversions_siteId_idx` (`siteId`),
  KEY `entryversions_creatorId_idx` (`creatorId`),
  CONSTRAINT `entryversions_creatorId_fk` FOREIGN KEY (`creatorId`) REFERENCES `users` (`id`) ON DELETE SET NULL,
  CONSTRAINT `entryversions_entryId_fk` FOREIGN KEY (`entryId`) REFERENCES `entries` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `entryversions_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `entryversions` WRITE;
/*!40000 ALTER TABLE `entryversions` DISABLE KEYS */;

INSERT INTO `entryversions` (`id`, `entryId`, `sectionId`, `creatorId`, `siteId`, `num`, `notes`, `data`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,3,1,1,1,1,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Chorizo Pasta\",\"slug\":\"chorizo-pasta\",\"postDate\":1500988249,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":\"{\\\"name\\\":\\\"Chorizo Pasta\\\",\\\"description\\\":\\\"Amy\'s favourite meal!\\\",\\\"skill\\\":\\\"beginner\\\",\\\"serves\\\":\\\"1\\\",\\\"ingredients\\\":[{\\\"quantity\\\":\\\"200\\\",\\\"units\\\":\\\"gs\\\",\\\"ingredient\\\":\\\"pasta\\\"},{\\\"quantity\\\":\\\"1\\\",\\\"units\\\":\\\"\\\",\\\"ingredient\\\":\\\"Onion\\\"},{\\\"quantity\\\":\\\"1\\\",\\\"units\\\":\\\"\\\",\\\"ingredient\\\":\\\"Pepper\\\"}],\\\"directions\\\":[{\\\"direction\\\":\\\"Dice the onion and pepper and fry in oil until translucent.\\\"},{\\\"direction\\\":\\\"Cut the chorizo in slices and then quarter it all and add to pan.\\\"},{\\\"direction\\\":\\\"Add pinch of salt, black pepper, chilli powder and paprika then give it a stir\\\"},{\\\"direction\\\":\\\"Add the chopped tomatoes, stir and cook down for 20mins.\\\"},{\\\"direction\\\":\\\"Once finished stir in the soft cheese and mix with the cooked pasta.\\\"}],\\\"imageId\\\":\\\"\\\",\\\"prepTime\\\":\\\"20\\\",\\\"cookTime\\\":\\\"20\\\",\\\"totalTime\\\":\\\"40\\\",\\\"ratings\\\":[],\\\"servingSize\\\":\\\"\\\",\\\"calories\\\":\\\"\\\",\\\"carbohydrateContent\\\":\\\"\\\",\\\"cholesterolContent\\\":\\\"\\\",\\\"fatContent\\\":\\\"\\\",\\\"fiberContent\\\":\\\"\\\",\\\"proteinContent\\\":\\\"\\\",\\\"saturatedFatContent\\\":\\\"\\\",\\\"sodiumContent\\\":\\\"\\\",\\\"sugarContent\\\":\\\"\\\",\\\"transFatContent\\\":\\\"\\\",\\\"unsaturatedFatContent\\\":\\\"\\\"}\"}}','2017-07-25 13:10:49','2017-07-25 13:10:49','bca1d534-2d5b-4032-ae48-343549669b3c'),
	(3,3,1,1,1,2,NULL,'{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Chorizo Pasta\",\"slug\":\"chorizo-pasta\",\"postDate\":1500988249,\"expiryDate\":null,\"enabled\":\"1\",\"newParentId\":null,\"fields\":{\"1\":\"{\\\"name\\\":\\\"Chorizo Pasta\\\",\\\"description\\\":\\\"Amy\'s favourite meal!\\\",\\\"skill\\\":\\\"beginner\\\",\\\"serves\\\":\\\"1\\\",\\\"ingredients\\\":[{\\\"quantity\\\":\\\"200\\\",\\\"units\\\":\\\"gs\\\",\\\"ingredient\\\":\\\"pasta\\\"},{\\\"quantity\\\":\\\"1\\\",\\\"units\\\":\\\"\\\",\\\"ingredient\\\":\\\"Onion\\\"},{\\\"quantity\\\":\\\"1\\\",\\\"units\\\":\\\"\\\",\\\"ingredient\\\":\\\"Pepper\\\"}],\\\"directions\\\":[{\\\"direction\\\":\\\"Dice the onion and pepper and fry in oil until translucent.\\\"},{\\\"direction\\\":\\\"Cut the chorizo in slices and then quarter it all and add to pan.\\\"},{\\\"direction\\\":\\\"Add pinch of salt, black pepper, chilli powder and paprika then give it a stir\\\"},{\\\"direction\\\":\\\"Add the chopped tomatoes, stir and cook down for 20mins.\\\"},{\\\"direction\\\":\\\"Once finished stir in the soft cheese and mix with the cooked pasta.\\\"}],\\\"imageId\\\":\\\"\\\",\\\"prepTime\\\":\\\"20\\\",\\\"cookTime\\\":\\\"20\\\",\\\"totalTime\\\":\\\"40\\\",\\\"ratings\\\":[],\\\"servingSize\\\":\\\"\\\",\\\"calories\\\":\\\"\\\",\\\"carbohydrateContent\\\":\\\"\\\",\\\"cholesterolContent\\\":\\\"\\\",\\\"fatContent\\\":\\\"\\\",\\\"fiberContent\\\":\\\"\\\",\\\"proteinContent\\\":\\\"\\\",\\\"saturatedFatContent\\\":\\\"\\\",\\\"sodiumContent\\\":\\\"\\\",\\\"sugarContent\\\":\\\"\\\",\\\"transFatContent\\\":\\\"\\\",\\\"unsaturatedFatContent\\\":\\\"\\\"}\"}}','2017-07-25 13:21:27','2017-07-25 13:21:27','ea2d76d7-a7ce-4611-9745-9ed1a4fd7597'),
	(4,3,1,1,1,3,'','{\"typeId\":\"1\",\"authorId\":\"1\",\"title\":\"Chorizo Pasta\",\"slug\":\"chorizo-pasta\",\"postDate\":1500988200,\"expiryDate\":null,\"enabled\":true,\"newParentId\":null,\"fields\":{\"1\":\"{\\\"name\\\":\\\"Chorizo Pasta\\\",\\\"description\\\":\\\"Amy\'s favourite meal!\\\",\\\"skill\\\":\\\"beginner\\\",\\\"serves\\\":\\\"1\\\",\\\"ingredients\\\":[{\\\"quantity\\\":\\\"200\\\",\\\"units\\\":\\\"gs\\\",\\\"ingredient\\\":\\\"pasta\\\"},{\\\"quantity\\\":\\\"1\\\",\\\"units\\\":\\\"\\\",\\\"ingredient\\\":\\\"Onion\\\"},{\\\"quantity\\\":\\\"1\\\",\\\"units\\\":\\\"\\\",\\\"ingredient\\\":\\\"Pepper\\\"}],\\\"directions\\\":[{\\\"direction\\\":\\\"Dice the onion and pepper and fry in oil until translucent.\\\"},{\\\"direction\\\":\\\"Cut the chorizo in slices and then quarter it all and add to pan.\\\"},{\\\"direction\\\":\\\"Add pinch of salt, black pepper, chilli powder and paprika then give it a stir\\\"},{\\\"direction\\\":\\\"Add the chopped tomatoes, stir and cook down for 20mins.\\\"},{\\\"direction\\\":\\\"Once finished stir in the soft cheese and mix with the cooked pasta.\\\"}],\\\"imageId\\\":\\\"\\\",\\\"prepTime\\\":\\\"20\\\",\\\"cookTime\\\":\\\"20\\\",\\\"totalTime\\\":\\\"40\\\",\\\"ratings\\\":[],\\\"servingSize\\\":\\\"\\\",\\\"calories\\\":\\\"\\\",\\\"carbohydrateContent\\\":\\\"\\\",\\\"cholesterolContent\\\":\\\"\\\",\\\"fatContent\\\":\\\"\\\",\\\"fiberContent\\\":\\\"\\\",\\\"proteinContent\\\":\\\"\\\",\\\"saturatedFatContent\\\":\\\"\\\",\\\"sodiumContent\\\":\\\"\\\",\\\"sugarContent\\\":\\\"\\\",\\\"transFatContent\\\":\\\"\\\",\\\"unsaturatedFatContent\\\":\\\"\\\"}\"}}','2017-07-25 13:21:48','2017-07-25 13:21:48','45a9b29e-6c28-41fd-8c7b-e3099a243d31');

/*!40000 ALTER TABLE `entryversions` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldgroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldgroups`;

CREATE TABLE `fieldgroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldgroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldgroups` WRITE;
/*!40000 ALTER TABLE `fieldgroups` DISABLE KEYS */;

INSERT INTO `fieldgroups` (`id`, `name`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,'Recipes','2017-07-25 11:56:38','2017-07-25 11:56:38','70286560-d9d1-4d94-9ee9-45398f6896df');

/*!40000 ALTER TABLE `fieldgroups` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayoutfields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayoutfields`;

CREATE TABLE `fieldlayoutfields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `tabId` int(11) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `required` tinyint(1) NOT NULL DEFAULT '0',
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fieldlayoutfields_layoutId_fieldId_unq_idx` (`layoutId`,`fieldId`),
  KEY `fieldlayoutfields_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayoutfields_tabId_idx` (`tabId`),
  KEY `fieldlayoutfields_fieldId_idx` (`fieldId`),
  CONSTRAINT `fieldlayoutfields_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE,
  CONSTRAINT `fieldlayoutfields_tabId_fk` FOREIGN KEY (`tabId`) REFERENCES `fieldlayouttabs` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayoutfields` WRITE;
/*!40000 ALTER TABLE `fieldlayoutfields` DISABLE KEYS */;

INSERT INTO `fieldlayoutfields` (`id`, `layoutId`, `tabId`, `fieldId`, `required`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,1,2,1,0,1,'2017-07-25 13:21:27','2017-07-25 13:21:27','9b704f38-abea-4d8d-868e-830b18f90613');

/*!40000 ALTER TABLE `fieldlayoutfields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouts
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouts`;

CREATE TABLE `fieldlayouts` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `type` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouts_type_idx` (`type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouts` WRITE;
/*!40000 ALTER TABLE `fieldlayouts` DISABLE KEYS */;

INSERT INTO `fieldlayouts` (`id`, `type`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'craft\\elements\\Entry','2017-07-25 11:55:35','2017-07-25 13:21:27','ef7ba029-1a25-4f06-8921-22c98e8a59ff'),
	(2,'craft\\elements\\Asset','2017-07-25 11:58:38','2017-07-25 14:04:01','0791874a-20c7-421e-839a-9303e7e2d5f3');

/*!40000 ALTER TABLE `fieldlayouts` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fieldlayouttabs
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fieldlayouttabs`;

CREATE TABLE `fieldlayouttabs` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `layoutId` int(11) NOT NULL,
  `name` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `fieldlayouttabs_sortOrder_idx` (`sortOrder`),
  KEY `fieldlayouttabs_layoutId_idx` (`layoutId`),
  CONSTRAINT `fieldlayouttabs_layoutId_fk` FOREIGN KEY (`layoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fieldlayouttabs` WRITE;
/*!40000 ALTER TABLE `fieldlayouttabs` DISABLE KEYS */;

INSERT INTO `fieldlayouttabs` (`id`, `layoutId`, `name`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(2,1,'Content',1,'2017-07-25 13:21:27','2017-07-25 13:21:27','1ccb2ed9-6773-4593-9971-f761eb483ee3');

/*!40000 ALTER TABLE `fieldlayouttabs` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table fields
# ------------------------------------------------------------

DROP TABLE IF EXISTS `fields`;

CREATE TABLE `fields` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(64) NOT NULL,
  `context` varchar(255) NOT NULL DEFAULT 'global',
  `instructions` text,
  `translationMethod` enum('none','language','site','custom') NOT NULL DEFAULT 'none',
  `translationKeyFormat` text,
  `type` varchar(255) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `fields_handle_context_unq_idx` (`handle`,`context`),
  KEY `fields_groupId_idx` (`groupId`),
  KEY `fields_context_idx` (`context`),
  CONSTRAINT `fields_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `fieldgroups` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `fields` WRITE;
/*!40000 ALTER TABLE `fields` DISABLE KEYS */;

INSERT INTO `fields` (`id`, `groupId`, `name`, `handle`, `context`, `instructions`, `translationMethod`, `translationKeyFormat`, `type`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,'Recipe','recipe','global','','none',NULL,'nystudio107\\recipe\\fields\\Recipe','{\"assetSources\":[\"0\"]}','2017-07-25 13:06:33','2017-07-25 13:20:45','fdca7026-30cd-4126-a431-095a6e1b0556');

/*!40000 ALTER TABLE `fields` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table globalsets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `globalsets`;

CREATE TABLE `globalsets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `globalsets_name_unq_idx` (`name`),
  UNIQUE KEY `globalsets_handle_unq_idx` (`handle`),
  KEY `globalsets_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `globalsets_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL,
  CONSTRAINT `globalsets_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table info
# ------------------------------------------------------------

DROP TABLE IF EXISTS `info`;

CREATE TABLE `info` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `version` varchar(50) NOT NULL,
  `schemaVersion` varchar(15) NOT NULL,
  `edition` smallint(6) unsigned NOT NULL,
  `timezone` varchar(30) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `on` tinyint(1) NOT NULL DEFAULT '0',
  `maintenance` tinyint(1) NOT NULL DEFAULT '0',
  `fieldVersion` char(12) NOT NULL DEFAULT '000000000000',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `info` WRITE;
/*!40000 ALTER TABLE `info` DISABLE KEYS */;

INSERT INTO `info` (`id`, `version`, `schemaVersion`, `edition`, `timezone`, `name`, `on`, `maintenance`, `fieldVersion`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'3.0.0-beta.22','3.0.51',0,'Europe/London','Amys Recipes',1,0,'imCXibmCnMgc','2017-07-25 11:50:42','2017-07-25 13:20:45','93a13528-87ca-41e9-bb22-b22440770c7b');

/*!40000 ALTER TABLE `info` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table matrixblocks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocks`;

CREATE TABLE `matrixblocks` (
  `id` int(11) NOT NULL,
  `ownerId` int(11) NOT NULL,
  `ownerSiteId` int(11) DEFAULT NULL,
  `fieldId` int(11) NOT NULL,
  `typeId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `matrixblocks_ownerId_idx` (`ownerId`),
  KEY `matrixblocks_fieldId_idx` (`fieldId`),
  KEY `matrixblocks_typeId_idx` (`typeId`),
  KEY `matrixblocks_sortOrder_idx` (`sortOrder`),
  KEY `matrixblocks_ownerSiteId_idx` (`ownerSiteId`),
  CONSTRAINT `matrixblocks_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerId_fk` FOREIGN KEY (`ownerId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocks_ownerSiteId_fk` FOREIGN KEY (`ownerSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `matrixblocks_typeId_fk` FOREIGN KEY (`typeId`) REFERENCES `matrixblocktypes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table matrixblocktypes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `matrixblocktypes`;

CREATE TABLE `matrixblocktypes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `matrixblocktypes_name_fieldId_unq_idx` (`name`,`fieldId`),
  UNIQUE KEY `matrixblocktypes_handle_fieldId_unq_idx` (`handle`,`fieldId`),
  KEY `matrixblocktypes_fieldId_idx` (`fieldId`),
  KEY `matrixblocktypes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `matrixblocktypes_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `matrixblocktypes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table migrations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `migrations`;

CREATE TABLE `migrations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `pluginId` int(11) DEFAULT NULL,
  `type` enum('app','plugin','content') NOT NULL DEFAULT 'app',
  `name` varchar(255) NOT NULL,
  `applyTime` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `migrations_pluginId_idx` (`pluginId`),
  KEY `migrations_type_pluginId_idx` (`type`,`pluginId`),
  CONSTRAINT `migrations_pluginId_fk` FOREIGN KEY (`pluginId`) REFERENCES `plugins` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `migrations` WRITE;
/*!40000 ALTER TABLE `migrations` DISABLE KEYS */;

INSERT INTO `migrations` (`id`, `pluginId`, `type`, `name`, `applyTime`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'app','Install','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','deb09ea4-5c2f-4aab-9b82-3b0c7d09e8c9'),
	(2,NULL,'app','m150403_183908_migrations_table_changes','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','6d9f9fa0-ddee-421d-a93b-e34002044d75'),
	(3,NULL,'app','m150403_184247_plugins_table_changes','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','c9c89c14-b67e-43fc-8cbc-6fc9ae8f5ec8'),
	(4,NULL,'app','m150403_184533_field_version','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','9dc45742-92d3-40e8-a42a-97d75bf0e223'),
	(5,NULL,'app','m150403_184729_type_columns','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','8c3f3e51-4855-4597-bffc-a6d00a7a9d57'),
	(6,NULL,'app','m150403_185142_volumes','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','4602193d-bed2-45b1-935e-66f72d2d8c7d'),
	(7,NULL,'app','m150428_231346_userpreferences','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','a6f9a7d0-efe9-44fb-b772-729855d89cbc'),
	(8,NULL,'app','m150519_150900_fieldversion_conversion','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','22e71df1-0084-4bb0-ab1d-115070752b83'),
	(9,NULL,'app','m150617_213829_update_email_settings','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','b80709c0-f5f8-4b59-b28b-afcbffe1b06c'),
	(10,NULL,'app','m150721_124739_templatecachequeries','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','93c5d3c0-9e46-47b0-8352-b21a639346b2'),
	(11,NULL,'app','m150724_140822_adjust_quality_settings','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','d6866c8b-0b85-478e-97a4-ee880c94b1cd'),
	(12,NULL,'app','m150815_133521_last_login_attempt_ip','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','c6fb4fc6-d5fb-45c2-b171-ea35b3033e8c'),
	(13,NULL,'app','m151002_095935_volume_cache_settings','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','ccc77609-baf7-4ff7-b1e3-f74a13ce84e9'),
	(14,NULL,'app','m151005_142750_volume_s3_storage_settings','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','4330a3c3-6934-4dc3-a0ba-6a2616ec3126'),
	(15,NULL,'app','m151016_133600_delete_asset_thumbnails','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','430618ce-1dad-446b-a7d7-7cad8ff3b028'),
	(16,NULL,'app','m151209_000000_move_logo','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','eeb60509-3990-42cf-9d80-457ee044c757'),
	(17,NULL,'app','m151211_000000_rename_fileId_to_assetId','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','9f311ec4-ea4e-4f09-8ed7-21045f90472f'),
	(18,NULL,'app','m151215_000000_rename_asset_permissions','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','c5614216-3606-42cc-b3c6-4cc9360d2f8b'),
	(19,NULL,'app','m160707_000001_rename_richtext_assetsource_setting','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','03a51864-2684-4003-8e04-5445736c3e7c'),
	(20,NULL,'app','m160708_185142_volume_hasUrls_setting','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','5bbe0d40-efdf-48d5-b826-64564b94b27d'),
	(21,NULL,'app','m160714_000000_increase_max_asset_filesize','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','36191981-3b76-40a4-8e5f-9dbb467876ab'),
	(22,NULL,'app','m160727_194637_column_cleanup','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','9b079873-e938-45f8-9694-2677da25a391'),
	(23,NULL,'app','m160804_110002_userphotos_to_assets','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','6e9021d0-4fb4-421d-a6bb-6b47905c6a98'),
	(24,NULL,'app','m160807_144858_sites','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','2c95a3eb-3e29-4a57-a321-df1ec9f2ee29'),
	(25,NULL,'app','m160817_161600_move_assets_cache','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','9e90a872-973e-42e8-a4d8-f14b41d632f0'),
	(26,NULL,'app','m160829_000000_pending_user_content_cleanup','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','80a60bf3-1e95-4afb-ad7a-3017aff4ce60'),
	(27,NULL,'app','m160830_000000_asset_index_uri_increase','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','43c1a3d8-0dae-463f-b9f1-e6f0c0ca8a6d'),
	(28,NULL,'app','m160912_230520_require_entry_type_id','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','f696f5a2-5e5a-4902-8cf2-6886d7566e2e'),
	(29,NULL,'app','m160913_134730_require_matrix_block_type_id','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','c17cce18-6aed-4db3-9591-848ee040b414'),
	(30,NULL,'app','m160920_174553_matrixblocks_owner_site_id_nullable','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','db5d2728-ade4-496f-b3df-7fd1b98877b6'),
	(31,NULL,'app','m160920_231045_usergroup_handle_title_unique','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','d1f85a10-aeef-47a6-aa95-ece08955b314'),
	(32,NULL,'app','m160925_113941_route_uri_parts','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','e6ef917a-bdbc-4863-bad1-8c8ff902fe78'),
	(33,NULL,'app','m161006_205918_schemaVersion_not_null','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','d1a23918-4e3b-4442-859a-a5455cab47ea'),
	(34,NULL,'app','m161007_130653_update_email_settings','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','b53f9e87-26cb-4484-99b4-efcd947de38d'),
	(35,NULL,'app','m161013_175052_newParentId','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','685ea081-14a4-4476-be4e-7ced590eeb63'),
	(36,NULL,'app','m161021_102916_fix_recent_entries_widgets','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','aaf5147c-494f-46a7-9893-e9f54e73edda'),
	(37,NULL,'app','m161021_182140_rename_get_help_widget','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','566d1168-7d70-490c-b3d2-d5f92bc63689'),
	(38,NULL,'app','m161025_000000_fix_char_columns','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','0d50a7cf-b4ee-4096-9328-e3f36ddb42fa'),
	(39,NULL,'app','m161029_124145_email_message_languages','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','7b1bccc5-1f18-4010-9b78-316cbdd46e8e'),
	(40,NULL,'app','m161108_000000_new_version_format','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','f53a6d59-c7e8-4105-b97a-5e68bb236b9e'),
	(41,NULL,'app','m161109_000000_index_shuffle','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','510f5f62-f41e-4a12-b34f-c26a63a2a28a'),
	(42,NULL,'app','m161122_185500_no_craft_app','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','bbcded8b-85dc-49bf-b53b-08f7682b8074'),
	(43,NULL,'app','m161125_150752_clear_urlmanager_cache','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','a1d8071d-bae5-4ae3-a1a6-2abc3b247278'),
	(44,NULL,'app','m161220_000000_volumes_hasurl_notnull','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','75958dfb-d3ca-4a34-b7bf-4926065ee62a'),
	(45,NULL,'app','m170114_161144_udates_permission','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','8bc9e1c6-9a0c-43ab-9431-51468171984a'),
	(46,NULL,'app','m170120_000000_schema_cleanup','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','d27e2bfd-790b-485a-9150-ba34f21bd2c0'),
	(47,NULL,'app','m170126_000000_assets_focal_point','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','64b4ecd1-a837-40d4-aafd-7a436888960d'),
	(48,NULL,'app','m170206_142126_system_name','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','f69260eb-89bb-4d0c-a237-4a69bb014c5c'),
	(49,NULL,'app','m170217_044740_category_branch_limits','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','c7e88380-6070-43c6-a40c-1cd19a9adf73'),
	(50,NULL,'app','m170217_120224_asset_indexing_columns','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','eb83931b-b01c-4322-8d41-a448a5c0b975'),
	(51,NULL,'app','m170223_224012_plain_text_settings','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','8f416661-807d-4141-bf4e-fef9302f7a54'),
	(52,NULL,'app','m170227_120814_focal_point_percentage','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','8904b895-d0bb-4989-8c31-ecdcc7def05c'),
	(53,NULL,'app','m170228_171113_system_messages','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','c80c9186-8cc8-44d8-82eb-742fc20ffc0c'),
	(54,NULL,'app','m170303_140500_asset_field_source_settings','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','939924fe-4533-4ec3-a91f-ad2beb8c458d'),
	(55,NULL,'app','m170306_150500_asset_temporary_uploads','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','7bc6ab7b-cf22-418a-85db-3966090140d1'),
	(56,NULL,'app','m170414_162429_rich_text_config_setting','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','8df42d59-2c18-47c5-843f-223e8af24cb9'),
	(57,NULL,'app','m170523_190652_element_field_layout_ids','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','72d05bee-4f57-487c-9e9a-e6d477818cf9'),
	(58,NULL,'app','m170612_000000_route_index_shuffle','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','590579fb-00cb-4478-91fb-9d17a512c957'),
	(59,NULL,'app','m170620_203910_no_disabled_plugins','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','dfc5a9d4-004d-43e0-8d0c-b26de31fe20b'),
	(60,NULL,'app','m170621_195237_format_plugin_handles','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','8195a687-b229-4b28-8f52-1807a2db2f83'),
	(61,NULL,'app','m170630_161028_deprecation_changes','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','353c7647-a008-4461-9ddc-a6ad9f0333f0'),
	(62,NULL,'app','m170703_181539_plugins_table_tweaks','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','197c9a61-f799-482d-925e-5fcfcafccb3e'),
	(63,NULL,'app','m170704_134916_sites_tables','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','a2eadb82-8258-4970-80fd-cf4c345bab03'),
	(64,NULL,'app','m170706_183216_rename_sequences','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','665fe82f-a727-4b91-a8ef-e97bf023a189'),
	(65,NULL,'app','m170707_094758_delete_compiled_traits','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','3d645e79-51d1-4af4-9e73-e2caa3dbf9fc'),
	(66,NULL,'app','m170707_131841_fix_db_routes','2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','662cded4-006a-42d7-9cbd-16065bd8af56');

/*!40000 ALTER TABLE `migrations` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table plugins
# ------------------------------------------------------------

DROP TABLE IF EXISTS `plugins`;

CREATE TABLE `plugins` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `handle` varchar(255) NOT NULL,
  `version` varchar(255) NOT NULL,
  `schemaVersion` varchar(255) NOT NULL,
  `licenseKey` char(24) DEFAULT NULL,
  `licenseKeyStatus` enum('valid','invalid','mismatched','unknown') NOT NULL DEFAULT 'unknown',
  `settings` text,
  `installDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `plugins_handle_unq_idx` (`handle`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `plugins` WRITE;
/*!40000 ALTER TABLE `plugins` DISABLE KEYS */;

INSERT INTO `plugins` (`id`, `handle`, `version`, `schemaVersion`, `licenseKey`, `licenseKeyStatus`, `settings`, `installDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'element-api','2.4.1','1.0.0',NULL,'unknown',NULL,'2017-07-25 11:54:23','2017-07-25 11:54:23','2017-07-25 11:54:55','bd91ed73-d65e-4d9c-91f5-1f258824993f'),
	(2,'recipe','1.0.4','1.0.0',NULL,'unknown',NULL,'2017-07-25 11:54:24','2017-07-25 11:54:24','2017-07-25 11:54:55','c5d3fed3-c746-4995-a297-1fc1e17e615f');

/*!40000 ALTER TABLE `plugins` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table relations
# ------------------------------------------------------------

DROP TABLE IF EXISTS `relations`;

CREATE TABLE `relations` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldId` int(11) NOT NULL,
  `sourceId` int(11) NOT NULL,
  `sourceSiteId` int(11) DEFAULT NULL,
  `targetId` int(11) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `relations_fieldId_sourceId_sourceSiteId_targetId_unq_idx` (`fieldId`,`sourceId`,`sourceSiteId`,`targetId`),
  KEY `relations_sourceId_idx` (`sourceId`),
  KEY `relations_targetId_idx` (`targetId`),
  KEY `relations_sourceSiteId_idx` (`sourceSiteId`),
  CONSTRAINT `relations_fieldId_fk` FOREIGN KEY (`fieldId`) REFERENCES `fields` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceId_fk` FOREIGN KEY (`sourceId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `relations_sourceSiteId_fk` FOREIGN KEY (`sourceSiteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `relations_targetId_fk` FOREIGN KEY (`targetId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table routes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `routes`;

CREATE TABLE `routes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) DEFAULT NULL,
  `uriParts` varchar(255) NOT NULL,
  `uriPattern` varchar(255) NOT NULL,
  `template` varchar(500) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `routes_uriPattern_idx` (`uriPattern`),
  KEY `routes_siteId_idx` (`siteId`),
  CONSTRAINT `routes_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table searchindex
# ------------------------------------------------------------

DROP TABLE IF EXISTS `searchindex`;

CREATE TABLE `searchindex` (
  `elementId` int(11) NOT NULL,
  `attribute` varchar(25) NOT NULL,
  `fieldId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `keywords` text NOT NULL,
  PRIMARY KEY (`elementId`,`attribute`,`fieldId`,`siteId`),
  FULLTEXT KEY `searchindex_keywords_idx` (`keywords`)
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

LOCK TABLES `searchindex` WRITE;
/*!40000 ALTER TABLE `searchindex` DISABLE KEYS */;

INSERT INTO `searchindex` (`elementId`, `attribute`, `fieldId`, `siteId`, `keywords`)
VALUES
	(1,'username',0,1,' benjo696 '),
	(1,'firstname',0,1,''),
	(1,'lastname',0,1,''),
	(1,'fullname',0,1,''),
	(1,'email',0,1,' benjo696 gmail com '),
	(1,'slug',0,1,''),
	(3,'field',1,1,' chorizo pasta amy s favourite meal beginner 1 200 gs pasta 1 onion 1 pepper dice the onion and pepper and fry in oil until translucent cut the chorizo in slices and then quarter it all and add to pan add pinch of salt black pepper chilli powder and paprika then give it a stir add the chopped tomatoes stir and cook down for 20mins once finished stir in the soft cheese and mix with the cooked pasta 20 20 40 '),
	(3,'slug',0,1,' chorizo pasta '),
	(3,'title',0,1,' chorizo pasta '),
	(8,'title',0,1,' chorizo pasta '),
	(8,'slug',0,1,''),
	(8,'kind',0,1,' image '),
	(8,'filename',0,1,' chorizo pasta jpg '),
	(8,'extension',0,1,' jpg ');

/*!40000 ALTER TABLE `searchindex` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections`;

CREATE TABLE `sections` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` enum('single','channel','structure') NOT NULL DEFAULT 'channel',
  `enableVersioning` tinyint(1) NOT NULL DEFAULT '0',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_handle_unq_idx` (`handle`),
  UNIQUE KEY `sections_name_unq_idx` (`name`),
  KEY `sections_structureId_idx` (`structureId`),
  CONSTRAINT `sections_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections` WRITE;
/*!40000 ALTER TABLE `sections` DISABLE KEYS */;

INSERT INTO `sections` (`id`, `structureId`, `name`, `handle`, `type`, `enableVersioning`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,'Recipes','recipes','channel',1,'2017-07-25 11:55:35','2017-07-25 11:55:35','ff64a41b-d361-4f22-af29-7d1d24b18661');

/*!40000 ALTER TABLE `sections` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sections_sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sections_sites`;

CREATE TABLE `sections_sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `sectionId` int(11) NOT NULL,
  `siteId` int(11) NOT NULL,
  `enabledByDefault` tinyint(1) NOT NULL DEFAULT '1',
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `uriFormat` text,
  `template` varchar(500) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sections_sites_sectionId_siteId_unq_idx` (`sectionId`,`siteId`),
  KEY `sections_sites_siteId_idx` (`siteId`),
  CONSTRAINT `sections_sites_sectionId_fk` FOREIGN KEY (`sectionId`) REFERENCES `sections` (`id`) ON DELETE CASCADE,
  CONSTRAINT `sections_sites_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sections_sites` WRITE;
/*!40000 ALTER TABLE `sections_sites` DISABLE KEYS */;

INSERT INTO `sections_sites` (`id`, `sectionId`, `siteId`, `enabledByDefault`, `hasUrls`, `uriFormat`, `template`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,1,1,1,'recipes/{slug}','recipes/_entry','2017-07-25 11:55:35','2017-07-25 11:55:35','0fc6366d-cf53-4016-9350-a8804d4fc229');

/*!40000 ALTER TABLE `sections_sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table sessions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sessions`;

CREATE TABLE `sessions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `token` char(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `sessions_uid_idx` (`uid`),
  KEY `sessions_token_idx` (`token`),
  KEY `sessions_dateUpdated_idx` (`dateUpdated`),
  KEY `sessions_userId_idx` (`userId`),
  CONSTRAINT `sessions_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table shunnedmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `shunnedmessages`;

CREATE TABLE `shunnedmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `message` varchar(255) NOT NULL,
  `expiryDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `shunnedmessages_userId_message_unq_idx` (`userId`,`message`),
  CONSTRAINT `shunnedmessages_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table sites
# ------------------------------------------------------------

DROP TABLE IF EXISTS `sites`;

CREATE TABLE `sites` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `language` varchar(12) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '0',
  `baseUrl` varchar(255) DEFAULT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `sites_handle_unq_idx` (`handle`),
  KEY `sites_sortOrder_idx` (`sortOrder`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `sites` WRITE;
/*!40000 ALTER TABLE `sites` DISABLE KEYS */;

INSERT INTO `sites` (`id`, `name`, `handle`, `language`, `hasUrls`, `baseUrl`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'Amys Recipes','default','en-GB',1,'http://localhost/',1,'2017-07-25 11:50:42','2017-07-25 11:50:42','a3f2f4cc-f2d5-43a7-b6bb-1ed19c02ab98');

/*!40000 ALTER TABLE `sites` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table structureelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structureelements`;

CREATE TABLE `structureelements` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `structureId` int(11) NOT NULL,
  `elementId` int(11) DEFAULT NULL,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `structureelements_structureId_elementId_unq_idx` (`structureId`,`elementId`),
  KEY `structureelements_root_idx` (`root`),
  KEY `structureelements_lft_idx` (`lft`),
  KEY `structureelements_rgt_idx` (`rgt`),
  KEY `structureelements_level_idx` (`level`),
  KEY `structureelements_elementId_idx` (`elementId`),
  CONSTRAINT `structureelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `structureelements_structureId_fk` FOREIGN KEY (`structureId`) REFERENCES `structures` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table structures
# ------------------------------------------------------------

DROP TABLE IF EXISTS `structures`;

CREATE TABLE `structures` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `maxLevels` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table systemmessages
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemmessages`;

CREATE TABLE `systemmessages` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `language` varchar(255) NOT NULL,
  `key` varchar(255) NOT NULL,
  `subject` text NOT NULL,
  `body` text NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemmessages_key_language_unq_idx` (`key`,`language`),
  KEY `systemmessages_language_idx` (`language`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table systemsettings
# ------------------------------------------------------------

DROP TABLE IF EXISTS `systemsettings`;

CREATE TABLE `systemsettings` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `category` varchar(15) NOT NULL,
  `settings` text,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `systemsettings_category_unq_idx` (`category`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `systemsettings` WRITE;
/*!40000 ALTER TABLE `systemsettings` DISABLE KEYS */;

INSERT INTO `systemsettings` (`id`, `category`, `settings`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'email','{\"fromEmail\":\"benjo696@gmail.com\",\"fromName\":\"Amys Recipes\",\"transportType\":\"craft\\\\mail\\\\transportadapters\\\\Php\"}','2017-07-25 11:50:43','2017-07-25 11:50:43','10d6b18e-1499-40be-b3d6-ef2e653c2486'),
	(2,'mailer','{\"class\":\"craft\\\\mail\\\\Mailer\",\"from\":{\"benjo696@gmail.com\":\"Amys Recipes\"},\"transport\":{\"class\":\"Swift_MailTransport\"}}','2017-07-25 11:50:43','2017-07-25 11:50:43','e3bb9841-d833-4f19-891c-c4d0d7eeb501');

/*!40000 ALTER TABLE `systemsettings` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table taggroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `taggroups`;

CREATE TABLE `taggroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `taggroups_name_unq_idx` (`name`),
  UNIQUE KEY `taggroups_handle_unq_idx` (`handle`),
  KEY `taggroups_fieldLayoutId_fk` (`fieldLayoutId`),
  CONSTRAINT `taggroups_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tags
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tags`;

CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tags_groupId_idx` (`groupId`),
  CONSTRAINT `tags_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `taggroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `tags_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tasks
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tasks`;

CREATE TABLE `tasks` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `root` int(11) unsigned DEFAULT NULL,
  `lft` int(11) unsigned NOT NULL,
  `rgt` int(11) unsigned NOT NULL,
  `level` smallint(6) unsigned NOT NULL,
  `currentStep` int(11) unsigned DEFAULT NULL,
  `totalSteps` int(11) unsigned DEFAULT NULL,
  `status` enum('pending','error','running') DEFAULT NULL,
  `type` varchar(255) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `settings` mediumtext NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `tasks_root_idx` (`root`),
  KEY `tasks_lft_idx` (`lft`),
  KEY `tasks_rgt_idx` (`rgt`),
  KEY `tasks_level_idx` (`level`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecacheelements
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecacheelements`;

CREATE TABLE `templatecacheelements` (
  `cacheId` int(11) NOT NULL,
  `elementId` int(11) NOT NULL,
  KEY `templatecacheelements_cacheId_idx` (`cacheId`),
  KEY `templatecacheelements_elementId_idx` (`elementId`),
  CONSTRAINT `templatecacheelements_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE,
  CONSTRAINT `templatecacheelements_elementId_fk` FOREIGN KEY (`elementId`) REFERENCES `elements` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecachequeries
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecachequeries`;

CREATE TABLE `templatecachequeries` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cacheId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `query` text NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecachequeries_cacheId_idx` (`cacheId`),
  KEY `templatecachequeries_type_idx` (`type`),
  CONSTRAINT `templatecachequeries_cacheId_fk` FOREIGN KEY (`cacheId`) REFERENCES `templatecaches` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table templatecaches
# ------------------------------------------------------------

DROP TABLE IF EXISTS `templatecaches`;

CREATE TABLE `templatecaches` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `siteId` int(11) NOT NULL,
  `cacheKey` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `body` mediumtext NOT NULL,
  PRIMARY KEY (`id`),
  KEY `templatecaches_expiryDate_cacheKey_siteId_path_idx` (`expiryDate`,`cacheKey`,`siteId`,`path`),
  KEY `templatecaches_siteId_idx` (`siteId`),
  CONSTRAINT `templatecaches_siteId_fk` FOREIGN KEY (`siteId`) REFERENCES `sites` (`id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table tokens
# ------------------------------------------------------------

DROP TABLE IF EXISTS `tokens`;

CREATE TABLE `tokens` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `token` char(32) NOT NULL,
  `route` text,
  `usageLimit` smallint(6) unsigned DEFAULT NULL,
  `usageCount` smallint(6) unsigned DEFAULT NULL,
  `expiryDate` datetime NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `tokens_token_unq_idx` (`token`),
  KEY `tokens_expiryDate_idx` (`expiryDate`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups`;

CREATE TABLE `usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_handle_unq_idx` (`handle`),
  UNIQUE KEY `usergroups_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table usergroups_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `usergroups_users`;

CREATE TABLE `usergroups_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `groupId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `usergroups_users_groupId_userId_unq_idx` (`groupId`,`userId`),
  KEY `usergroups_users_userId_idx` (`userId`),
  CONSTRAINT `usergroups_users_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `usergroups_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions`;

CREATE TABLE `userpermissions` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_name_unq_idx` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_usergroups
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_usergroups`;

CREATE TABLE `userpermissions_usergroups` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `groupId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_usergroups_permissionId_groupId_unq_idx` (`permissionId`,`groupId`),
  KEY `userpermissions_usergroups_groupId_idx` (`groupId`),
  CONSTRAINT `userpermissions_usergroups_groupId_fk` FOREIGN KEY (`groupId`) REFERENCES `usergroups` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_usergroups_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpermissions_users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpermissions_users`;

CREATE TABLE `userpermissions_users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `permissionId` int(11) NOT NULL,
  `userId` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `userpermissions_users_permissionId_userId_unq_idx` (`permissionId`,`userId`),
  KEY `userpermissions_users_userId_idx` (`userId`),
  CONSTRAINT `userpermissions_users_permissionId_fk` FOREIGN KEY (`permissionId`) REFERENCES `userpermissions` (`id`) ON DELETE CASCADE,
  CONSTRAINT `userpermissions_users_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table userpreferences
# ------------------------------------------------------------

DROP TABLE IF EXISTS `userpreferences`;

CREATE TABLE `userpreferences` (
  `userId` int(11) NOT NULL AUTO_INCREMENT,
  `preferences` text,
  PRIMARY KEY (`userId`),
  CONSTRAINT `userpreferences_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;



# Dump of table users
# ------------------------------------------------------------

DROP TABLE IF EXISTS `users`;

CREATE TABLE `users` (
  `id` int(11) NOT NULL,
  `username` varchar(100) NOT NULL,
  `photoId` int(11) DEFAULT NULL,
  `firstName` varchar(100) DEFAULT NULL,
  `lastName` varchar(100) DEFAULT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) DEFAULT NULL,
  `admin` tinyint(1) NOT NULL DEFAULT '0',
  `client` tinyint(1) NOT NULL DEFAULT '0',
  `locked` tinyint(1) NOT NULL DEFAULT '0',
  `suspended` tinyint(1) NOT NULL DEFAULT '0',
  `pending` tinyint(1) NOT NULL DEFAULT '0',
  `archived` tinyint(1) NOT NULL DEFAULT '0',
  `lastLoginDate` datetime DEFAULT NULL,
  `lastLoginAttemptIp` varchar(45) DEFAULT NULL,
  `invalidLoginWindowStart` datetime DEFAULT NULL,
  `invalidLoginCount` smallint(6) unsigned DEFAULT NULL,
  `lastInvalidLoginDate` datetime DEFAULT NULL,
  `lockoutDate` datetime DEFAULT NULL,
  `verificationCode` varchar(255) DEFAULT NULL,
  `verificationCodeIssuedDate` datetime DEFAULT NULL,
  `unverifiedEmail` varchar(255) DEFAULT NULL,
  `passwordResetRequired` tinyint(1) NOT NULL DEFAULT '0',
  `lastPasswordChangeDate` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `users_username_unq_idx` (`username`),
  UNIQUE KEY `users_email_unq_idx` (`email`),
  KEY `users_uid_idx` (`uid`),
  KEY `users_verificationCode_idx` (`verificationCode`),
  KEY `users_photoId_fk` (`photoId`),
  CONSTRAINT `users_id_fk` FOREIGN KEY (`id`) REFERENCES `elements` (`id`) ON DELETE CASCADE,
  CONSTRAINT `users_photoId_fk` FOREIGN KEY (`photoId`) REFERENCES `assets` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;

INSERT INTO `users` (`id`, `username`, `photoId`, `firstName`, `lastName`, `email`, `password`, `admin`, `client`, `locked`, `suspended`, `pending`, `archived`, `lastLoginDate`, `lastLoginAttemptIp`, `invalidLoginWindowStart`, `invalidLoginCount`, `lastInvalidLoginDate`, `lockoutDate`, `verificationCode`, `verificationCodeIssuedDate`, `unverifiedEmail`, `passwordResetRequired`, `lastPasswordChangeDate`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,'benjo696',NULL,NULL,NULL,'benjo696@gmail.com','$2y$13$oAxebB31BpcG1RqVU5Bpi.5Ix21qQtR9Tivdul/Lx4ly0.l3cU5qq',1,0,0,0,0,0,'2017-07-25 11:50:43','::1',NULL,NULL,NULL,NULL,NULL,NULL,NULL,0,'2017-07-25 11:50:43','2017-07-25 11:50:43','2017-07-25 11:50:43','07fbc6dd-7e95-4b20-81dd-25b33498f062');

/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumefolders
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumefolders`;

CREATE TABLE `volumefolders` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `parentId` int(11) DEFAULT NULL,
  `volumeId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `path` varchar(255) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumefolders_name_parentId_volumeId_unq_idx` (`name`,`parentId`,`volumeId`),
  KEY `volumefolders_parentId_idx` (`parentId`),
  KEY `volumefolders_volumeId_idx` (`volumeId`),
  CONSTRAINT `volumefolders_parentId_fk` FOREIGN KEY (`parentId`) REFERENCES `volumefolders` (`id`) ON DELETE CASCADE,
  CONSTRAINT `volumefolders_volumeId_fk` FOREIGN KEY (`volumeId`) REFERENCES `volumes` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumefolders` WRITE;
/*!40000 ALTER TABLE `volumefolders` DISABLE KEYS */;

INSERT INTO `volumefolders` (`id`, `parentId`, `volumeId`, `name`, `path`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,NULL,NULL,'Temporary source',NULL,'2017-07-25 11:56:41','2017-07-25 11:56:41','f91fa1a7-1aa6-45fa-9c06-84d2d459fa8b'),
	(2,1,NULL,'user_1','user_1/','2017-07-25 11:56:41','2017-07-25 11:56:41','4f71fb1b-657b-4ebb-846a-d6d538c03628'),
	(3,NULL,1,'Recipes','','2017-07-25 11:58:38','2017-07-25 11:58:38','540a69de-454b-4c0c-8ef3-00db22326533');

/*!40000 ALTER TABLE `volumefolders` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table volumes
# ------------------------------------------------------------

DROP TABLE IF EXISTS `volumes`;

CREATE TABLE `volumes` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `fieldLayoutId` int(11) DEFAULT NULL,
  `name` varchar(255) NOT NULL,
  `handle` varchar(255) NOT NULL,
  `type` varchar(255) NOT NULL,
  `hasUrls` tinyint(1) NOT NULL DEFAULT '1',
  `url` varchar(255) DEFAULT NULL,
  `settings` text,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  UNIQUE KEY `volumes_name_unq_idx` (`name`),
  UNIQUE KEY `volumes_handle_unq_idx` (`handle`),
  KEY `volumes_fieldLayoutId_idx` (`fieldLayoutId`),
  CONSTRAINT `volumes_fieldLayoutId_fk` FOREIGN KEY (`fieldLayoutId`) REFERENCES `fieldlayouts` (`id`) ON DELETE SET NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `volumes` WRITE;
/*!40000 ALTER TABLE `volumes` DISABLE KEYS */;

INSERT INTO `volumes` (`id`, `fieldLayoutId`, `name`, `handle`, `type`, `hasUrls`, `url`, `settings`, `sortOrder`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,2,'Recipes','recipes','craft\\volumes\\Local',1,'/','{\"path\":\"images/recipes\"}',1,'2017-07-25 11:58:38','2017-07-25 14:04:01','8d3b82d9-9e36-4013-9b00-621bbff17e9a');

/*!40000 ALTER TABLE `volumes` ENABLE KEYS */;
UNLOCK TABLES;


# Dump of table widgets
# ------------------------------------------------------------

DROP TABLE IF EXISTS `widgets`;

CREATE TABLE `widgets` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) NOT NULL,
  `type` varchar(255) NOT NULL,
  `sortOrder` smallint(6) unsigned DEFAULT NULL,
  `colspan` tinyint(1) NOT NULL DEFAULT '0',
  `settings` text,
  `enabled` tinyint(1) NOT NULL DEFAULT '1',
  `dateCreated` datetime NOT NULL,
  `dateUpdated` datetime NOT NULL,
  `uid` char(36) NOT NULL DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `widgets_userId_idx` (`userId`),
  CONSTRAINT `widgets_userId_fk` FOREIGN KEY (`userId`) REFERENCES `users` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

LOCK TABLES `widgets` WRITE;
/*!40000 ALTER TABLE `widgets` DISABLE KEYS */;

INSERT INTO `widgets` (`id`, `userId`, `type`, `sortOrder`, `colspan`, `settings`, `enabled`, `dateCreated`, `dateUpdated`, `uid`)
VALUES
	(1,1,'craft\\widgets\\RecentEntries',1,0,'{\"section\":\"*\",\"siteId\":\"1\",\"limit\":10}',1,'2017-07-25 11:50:48','2017-07-25 11:50:48','9645ffb7-5302-48bf-a025-150b410e0ce6'),
	(2,1,'craft\\widgets\\CraftSupport',2,0,'[]',1,'2017-07-25 11:50:48','2017-07-25 11:50:48','6e877d79-1524-47d4-b02a-16c04e82063b'),
	(3,1,'craft\\widgets\\Updates',3,0,'[]',1,'2017-07-25 11:50:48','2017-07-25 11:50:48','fea4a1b2-b315-495f-80df-95b7166e3e75'),
	(4,1,'craft\\widgets\\Feed',4,0,'{\"url\":\"https://craftcms.com/news.rss\",\"title\":\"Craft News\",\"limit\":5}',1,'2017-07-25 11:50:48','2017-07-25 11:50:48','ee19817b-0ac7-477e-8c7e-49ca2996a5a7');

/*!40000 ALTER TABLE `widgets` ENABLE KEYS */;
UNLOCK TABLES;



/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;
/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
