-- phpMyAdmin SQL Dump
-- version 4.5.1
--
-- 10.1.19-MariaDB
-- PHP Version: 5.6.28

--
-- Database: `loerealm_denver`
--

-- --------------------------------------------------------

CREATE TABLE `accounts` (
  `id` bigint(255) NOT NULL,
  `uuid` varchar(128) NOT NULL,
  `password` varchar(256) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT 'DEFAULT',
  `rank` int(1) NOT NULL DEFAULT '0',
  `namechosen` tinyint(1) NOT NULL DEFAULT '0',
  `verified` tinyint(1) NOT NULL DEFAULT '1',
  `guild` int(11) NOT NULL,
  `guildRank` int(11) NOT NULL,
  `guildFame` int(11) NOT NULL DEFAULT '0',
  `lastip` varchar(128) NOT NULL DEFAULT '',
  `vaultCount` int(11) NOT NULL DEFAULT '1',
  `maxCharSlot` int(11) NOT NULL DEFAULT '2',
  `regTime` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `guest` tinyint(1) NOT NULL DEFAULT '0',
  `banned` tinyint(1) NOT NULL DEFAULT '0',
  `publicMuledump` int(1) NOT NULL DEFAULT '1',
  `muted` tinyint(1) NOT NULL,
  `vipEnd` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `locked` varchar(512) NOT NULL,
  `ignored` varchar(512) NOT NULL,
  `gifts` varchar(10000) NOT NULL DEFAULT '',
  `isAgeVerified` tinyint(1) NOT NULL DEFAULT '0',
  `petYardType` int(11) NOT NULL DEFAULT '1',
  `ownedSkins` varchar(2048) NOT NULL,
  `authToken` varchar(128) NOT NULL DEFAULT '',
  `acceptedNewTos` tinyint(1) NOT NULL DEFAULT '1',
  `lastSeen` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `accountInUse` tinyint(1) NOT NULL,
  `prodAcc` tinyint(1) NOT NULL DEFAULT '0',
  `accWarnings` int(11) NOT NULL DEFAULT '0',
  `banEnd` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `usedMax` int(1) NOT NULL DEFAULT '0',
  `gameGift` int(1) NOT NULL DEFAULT '0',
  `cmdDelay` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `cmdBlock` int(1) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `arenalb` (
  `id` int(11) NOT NULL,
  `wave` int(11) NOT NULL,
  `accid` int(11) NOT NULL,
  `charid` int(11) NOT NULL,
  `petid` int(11) DEFAULT NULL,
  `time` varchar(256) NOT NULL,
  `date` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `backpacks` (
  `accId` int(11) NOT NULL,
  `charId` int(11) NOT NULL,
  `items` varchar(128) NOT NULL DEFAULT '-1, -1, -1, -1, -1, -1, -1, -1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `boards` (
  `guildId` int(11) NOT NULL,
  `text` varchar(1024) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `characters` (
  `id` int(11) NOT NULL,
  `accId` int(11) NOT NULL,
  `charId` int(11) NOT NULL,
  `charType` int(11) NOT NULL DEFAULT '782',
  `level` int(11) NOT NULL DEFAULT '1',
  `exp` bigint(255) NOT NULL DEFAULT '0',
  `fame` int(11) NOT NULL DEFAULT '0',
  `items` varchar(128) NOT NULL DEFAULT '-1, -1, -1, -1',
  `hpPotions` int(11) NOT NULL DEFAULT '0',
  `mpPotions` int(11) NOT NULL DEFAULT '0',
  `hp` int(11) NOT NULL DEFAULT '1',
  `mp` int(11) NOT NULL DEFAULT '1',
  `stats` varchar(128) NOT NULL DEFAULT '1, 1, 1, 1, 1, 1, 1, 1',
  `dead` tinyint(1) NOT NULL DEFAULT '0',
  `tex1` int(11) NOT NULL DEFAULT '0',
  `tex2` int(11) NOT NULL DEFAULT '0',
  `pet` int(11) NOT NULL DEFAULT '-1',
  `petId` int(11) NOT NULL DEFAULT '-1',
  `hasBackpack` int(11) NOT NULL DEFAULT '0',
  `skin` int(11) NOT NULL DEFAULT '0',
  `xpBoosterTime` int(11) NOT NULL DEFAULT '0',
  `ldTimer` int(11) NOT NULL DEFAULT '0',
  `ltTimer` int(11) NOT NULL DEFAULT '0',
  `fameStats` varchar(512) NOT NULL,
  `createTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `deathTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00',
  `totalFame` int(11) NOT NULL DEFAULT '0',
  `lastSeen` datetime NOT NULL,
  `lastLocation` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `classstats` (
  `accId` int(11) NOT NULL,
  `objType` int(11) NOT NULL,
  `bestLv` int(11) NOT NULL DEFAULT '1',
  `bestFame` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `dailyquests` (
  `accId` int(11) NOT NULL,
  `goals` varchar(512) NOT NULL,
  `tier` int(11) NOT NULL DEFAULT '1',
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `death` (
  `accId` int(11) NOT NULL,
  `chrId` int(11) NOT NULL,
  `name` varchar(64) NOT NULL DEFAULT 'DEFAULT',
  `charType` int(11) NOT NULL DEFAULT '782',
  `tex1` int(11) NOT NULL DEFAULT '0',
  `tex2` int(11) NOT NULL DEFAULT '0',
  `skin` int(11) NOT NULL DEFAULT '0',
  `items` varchar(128) NOT NULL DEFAULT '-1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1, -1',
  `fame` int(11) NOT NULL DEFAULT '0',
  `exp` int(11) NOT NULL,
  `fameStats` varchar(256) NOT NULL,
  `totalFame` int(11) NOT NULL DEFAULT '0',
  `firstBorn` tinyint(1) NOT NULL,
  `killer` varchar(128) NOT NULL,
  `time` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `giftcodes` (
  `code` varchar(128) NOT NULL,
  `content` varchar(512) NOT NULL,
  `accId` int(11) NOT NULL DEFAULT '0'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `globalnews` (
  `slot` int(11) NOT NULL,
  `linkType` int(11) NOT NULL,
  `title` varchar(65) NOT NULL,
  `image` text NOT NULL,
  `priority` int(11) NOT NULL,
  `linkDetail` text NOT NULL,
  `platform` varchar(128) NOT NULL DEFAULT 'kabam.com,kongregate,steam,rotmg',
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endTime` timestamp NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `guilds` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL DEFAULT 'DEFAULT_GUILD',
  `members` varchar(128) NOT NULL,
  `guildFame` int(11) NOT NULL,
  `totalGuildFame` int(11) NOT NULL,
  `level` int(11) NOT NULL DEFAULT '1'
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `mysteryboxes` (
  `id` int(11) NOT NULL,
  `title` varchar(128) NOT NULL,
  `weight` int(11) NOT NULL,
  `description` varchar(128) NOT NULL,
  `contents` text NOT NULL,
  `priceAmount` int(11) NOT NULL,
  `priceCurrency` int(11) NOT NULL,
  `image` text NOT NULL,
  `icon` text NOT NULL,
  `salePrice` int(11) NOT NULL,
  `saleCurrency` int(11) NOT NULL,
  `saleEnd` datetime NOT NULL DEFAULT '0000-00-00 00:00:00',
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `boxEnd` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `news` (
  `id` int(11) NOT NULL,
  `icon` varchar(16) NOT NULL DEFAULT 'info',
  `title` varchar(128) NOT NULL DEFAULT 'Default news title',
  `text` varchar(128) NOT NULL DEFAULT 'Default news text',
  `link` varchar(256) NOT NULL DEFAULT 'http://mmoe.net/',
  `date` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `packages` (
  `id` int(11) NOT NULL,
  `name` varchar(128) NOT NULL,
  `maxPurchase` int(11) NOT NULL DEFAULT '-1',
  `weight` int(11) NOT NULL DEFAULT '0',
  `contents` text NOT NULL,
  `bgUrl` varchar(512) NOT NULL,
  `price` int(11) NOT NULL,
  `quantity` int(11) NOT NULL DEFAULT '-1',
  `endDate` datetime NOT NULL DEFAULT '0000-00-00 00:00:00'
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `pets` (
  `accId` int(11) NOT NULL,
  `petId` int(11) NOT NULL,
  `objType` smallint(5) NOT NULL,
  `skinName` varchar(128) NOT NULL,
  `skin` int(11) NOT NULL,
  `family` int(11) NOT NULL,
  `rarity` int(11) NOT NULL,
  `maxLevel` int(11) NOT NULL DEFAULT '30',
  `abilities` varchar(128) NOT NULL,
  `levels` varchar(128) NOT NULL,
  `xp` varchar(128) NOT NULL DEFAULT '0, 0, 0'
) ENGINE=MyISAM DEFAULT CHARSET=utf8;

CREATE TABLE `stats` (
  `accId` int(11) NOT NULL,
  `fame` int(11) NOT NULL,
  `totalFame` int(11) NOT NULL,
  `credits` int(11) NOT NULL,
  `totalCredits` int(11) NOT NULL,
  `fortuneTokens` int(11) NOT NULL,
  `totalFortuneTokens` int(11) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

CREATE TABLE `tguilds` (
  `id` int(11) NOT NULL,
  `members` varchar(128) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `thealchemist` (
  `id` int(11) NOT NULL,
  `title` varchar(512) NOT NULL,
  `description` varchar(512) DEFAULT NULL,
  `image` varchar(512) NOT NULL,
  `icon` varchar(512) NOT NULL,
  `contents` text NOT NULL,
  `priceFirstInGold` int(11) NOT NULL DEFAULT '51',
  `priceFirstInToken` int(11) NOT NULL DEFAULT '1',
  `priceSecondInGold` int(11) NOT NULL DEFAULT '75',
  `startTime` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  `endTime` datetime NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `unlockedclasses` (
  `id` int(11) NOT NULL,
  `accId` int(11) NOT NULL,
  `class` varchar(128) NOT NULL,
  `available` varchar(128) NOT NULL
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

CREATE TABLE `vaults` (
  `accId` int(11) NOT NULL,
  `chestId` int(11) NOT NULL,
  `items` varchar(128) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=utf8;