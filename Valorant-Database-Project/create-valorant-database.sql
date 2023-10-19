DROP DATABASE IF EXISTS `valorant-lineups`;
CREATE DATABASE `valorant-lineups`;
USE `valorant-lineups`;

CREATE TABLE `players` (
    `username` varchar(50) NOT NULL,
    `password` varchar(50) NOT NULL,
    `admin` BOOLEAN DEFAULT FALSE,
    PRIMARY KEY (`username`)
);
INSERT INTO `players` VALUES ('Scarlizar', 'notaY2002Ma', TRUE);
INSERT INTO `players` VALUES ('Aajeeb', '12345', TRUE);
INSERT INTO `players` VALUES ('Tekkers', 'abcdefg', DEFAULT);
INSERT INTO `players` VALUES ('Heyodude', '987654321', DEFAULT);
INSERT INTO `players` VALUES ('Rickey', 'helloworld', DEFAULT);
INSERT INTO `players` VALUES ('OnOff', 'imdiamondone', DEFAULT);

CREATE TABLE `agents` (
    `agent_number` INT NOT NULL,
    `agent_name` varchar(50) NOT NULL,
    `role` varchar(50) NOT NULL,
    `agent_image` MEDIUMBLOB,
    PRIMARY KEY (`agent_name`),
    CONSTRAINT `valid_role` CHECK (`role` IN ('Initiator', 'Sentinel', 'Controller', 'Duelist'))
);

INSERT INTO `agents` VALUES (1, 'Brimstone', 'Controller', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Brimstone.webp'));
INSERT INTO `agents` VALUES (2, 'Phoenix', 'Duelist', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Phoenix.webp'));
INSERT INTO `agents` VALUES (3, 'Sage', 'Sentinel', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Sage.webp'));
INSERT INTO `agents` VALUES (4, 'Sova', 'Initiator', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Sova.webp'));
INSERT INTO `agents` VALUES (5, 'Viper', 'Controller', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Viper.webp'));
INSERT INTO `agents` VALUES (6, 'Cypher', 'Sentinel', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Cypher.webp'));
-- INSERT INTO `agents` VALUES (7, 'Reyna', 'Duelist', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Reyna.webp'));
INSERT INTO `agents` VALUES (8, 'Killjoy', 'Sentinel', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Killjoy.webp'));
INSERT INTO `agents` VALUES (9, 'Breach', 'Initiator', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Breach.webp'));
INSERT INTO `agents` VALUES (10, 'Omen', 'Controller', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Omen.webp'));
-- INSERT INTO `agents` VALUES (11, 'Jett', 'Duelist', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Jett.webp'));
INSERT INTO `agents` VALUES (12, 'Raze', 'Initiator', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Raze.webp'));
-- INSERT INTO `agents` VALUES (13, 'Skye', 'Initiator', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Skye.webp'));
INSERT INTO `agents` VALUES (14, 'Yoru', 'Duelist', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Yoru.webp'));
INSERT INTO `agents` VALUES (15, 'Astra', 'Controller', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Astra.webp'));
INSERT INTO `agents` VALUES (16, 'KAY/O', 'Initiator', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/KAYO.webp'));
INSERT INTO `agents` VALUES (17, 'Chamber', 'Sentinel', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Chamber.webp'));
INSERT INTO `agents` VALUES (18, 'Neon', 'Duelist', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Neon.webp'));
INSERT INTO `agents` VALUES (19, 'Fade', 'Initiator', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Fade.webp'));
INSERT INTO `agents` VALUES (20, 'Harbor', 'Controller', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Harbor.webp'));
INSERT INTO `agents` VALUES (21, 'Gekko', 'Initiator', LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Agent_Icons/Gekko.webp'));

CREATE TABLE `abilities` (
    `ability_name` varchar(50) NOT NULL,
    `ability_no` char NOT NULL,
    `ability_image` BLOB,
    `agent_name` varchar(50) NOT NULL,
    PRIMARY KEY (`ability_name`),
    KEY `fk_abilities_agents_idx` (`agent_name`),
    CONSTRAINT `fk_abilities_agents` FOREIGN KEY (`agent_name`) REFERENCES `agents` (`agent_name`) ON UPDATE CASCADE,
    CONSTRAINT `valid_ability_no` CHECK (`ability_no` BETWEEN 1 AND 4)
);
-- Brimstone Abilities
-- INSERT INTO `abilities` VALUES ('Stim Beacon', 1, LOAD_FILE('./Ability_Icons/Brimstone'), 1);
INSERT INTO `abilities` VALUES ('Incendiary', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Brimstone/Incendiary.webp'), 'Brimstone');
INSERT INTO `abilities` VALUES ('Sky Smoke', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Brimstone/Sky_Smoke.webp'), 'Brimstone');
INSERT INTO `abilities` VALUES ('Orbital Strike', 4, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Brimstone/Orbital_Strike.webp'), 'Brimstone');

-- Phoenix Abilities
INSERT INTO `abilities` VALUES ('Hot Hands', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Phoenix/Hot_Hands.webp'), 'Phoenix');

-- Sage Abilities
INSERT INTO `abilities` VALUES ('Slow Orb', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Sage/Slow_Orb.webp'), 'Sage');
INSERT INTO `abilities` VALUES ('Barrier Orb', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Sage/Barrier_Orb.webp'), 'Sage');

-- Sova Abilities
INSERT INTO `abilities` VALUES ('Owl Drone', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Sova/Owl_Drone.webp'), 'Sova');
INSERT INTO `abilities` VALUES ('Shock Bolt', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Sova/Shock_Bolt.webp'), 'Sova');
INSERT INTO `abilities` VALUES ('Recon Bolt', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Sova/Recon_Bolt.webp'), 'Sova');
INSERT INTO `abilities` VALUES ('Hunters Fury', 4, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Sova/Hunters_Fury.webp'), 'Sova');

-- Viper Abilities
INSERT INTO `abilities` VALUES ('Snake Bite', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Viper/Snake_Bite.webp'), 'Viper');
INSERT INTO `abilities` VALUES ('Poison Cloud', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Viper/Poison_Cloud.webp'), 'Viper');
INSERT INTO `abilities` VALUES ('Toxic Screen', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Viper/Toxic_Screen.webp'), 'Viper');
INSERT INTO `abilities` VALUES ('Vipers Pit', 4, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Viper/Vipers_Pit.webp'), 'Viper');

-- Cypher Abilities
INSERT INTO `abilities` VALUES ('Trapwire', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Cypher/Trapwire.webp'), 'Cypher');
INSERT INTO `abilities` VALUES ('Cyber Cage', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Cypher/Cyber_Cage.webp'), 'Cypher');
INSERT INTO `abilities` VALUES ('Spycam', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Cypher/Spycam.webp'), 'Cypher');

-- Reyna Abilities

-- Killjoy Abilities
INSERT INTO `abilities` VALUES ('Nanoswarm', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Killjoy/Nanoswarm.webp'), 'Killjoy');
INSERT INTO `abilities` VALUES ('Alarmbot', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Killjoy/Alarmbot.webp'), 'Killjoy');
INSERT INTO `abilities` VALUES ('Turret', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Killjoy/Turret.webp'), 'Killjoy');
INSERT INTO `abilities` VALUES ('Lockdown', 4, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Killjoy/Lockdown.webp'), 'Killjoy');

-- Breach Abilities
INSERT INTO `abilities` VALUES ('Aftershock', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Breach/Aftershock.webp'), 'Breach');
INSERT INTO `abilities` VALUES ('Flashpoint', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Breach/Flashpoint.webp'), 'Breach');
INSERT INTO `abilities` VALUES ('Fault Line', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Breach/Fault_Line.webp'), 'Breach');
INSERT INTO `abilities` VALUES ('Rolling Thunder', 4, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Breach/Rolling_Thunder.webp'), 'Breach');

-- Omen Abilties
INSERT INTO `abilities` VALUES ('Shrouded Step', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Omen/Shrouded_Step.webp'), 'Omen');
INSERT INTO `abilities` VALUES ('Paranoia', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Omen/Paranoia.webp'), 'Omen');
INSERT INTO `abilities` VALUES ('Dark Cover', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Omen/Dark_Cover.webp'), 'Omen');

-- Jett Abilities

-- Raze Abilities
INSERT INTO `abilities` VALUES ('Boom Bot', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Raze/Boom_Bot.webp'), 'Raze');
INSERT INTO `abilities` VALUES ('Paint Shells', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Raze/Paint_Shells.webp'), 'Raze');

-- Skye Abilties

-- Yoru Abilties
INSERT INTO `abilities` VALUES ('Fakeout', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Yoru/Fakeout.webp'), 'Yoru');
INSERT INTO `abilities` VALUES ('Blindside', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Yoru/Blindside.webp'), 'Yoru');
INSERT INTO `abilities` VALUES ('Gatecrash', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Yoru/Gatecrash.webp'), 'Yoru');

-- Astra Abilities
INSERT INTO `abilities` VALUES ('Gravity Well', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Astra/Gravity_Well.webp'), 'Astra');
INSERT INTO `abilities` VALUES ('Nova Pulse', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Astra/Nova_Pulse.webp'), 'Astra');
INSERT INTO `abilities` VALUES ('Nebula Dissipate', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Astra/Nebula_Dissipate.webp'), 'Astra');
INSERT INTO `abilities` VALUES ('Cosmic_Divide', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Astra/Cosmic_Divide.webp'), 'Astra');

-- KAY/0 Abilties
INSERT INTO `abilities` VALUES ('FRAG/MENT', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Kay-o/Frag_Ment.webp'), 'KAY/O');
INSERT INTO `abilities` VALUES ('FLASH/DRIVE', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Kay-o/Flash_Drive.webp'), 'KAY/O');
INSERT INTO `abilities` VALUES ('ZERO/POINT', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Kay-o/Zero_Point.webp'), 'KAY/O');

-- Chamber Abilities
INSERT INTO `abilities` VALUES ('Trademark', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Chamber/Trademark.webp'), 'Chamber');
INSERT INTO `abilities` VALUES ('Rendezvous', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Chamber/Rendezvous.webp'), 'Chamber');

-- Neon Abilities
INSERT INTO `abilities` VALUES ('Fast Lane', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Neon/Fast_Lane.webp'), 'Neon');
INSERT INTO `abilities` VALUES ('Relay Bolt', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Neon/Relay_Bolt.webp'), 'Neon');

-- Fade Abilities
INSERT INTO `abilities` VALUES ('Prowler', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Fade/Prowler.webp'), 'Fade');
INSERT INTO `abilities` VALUES ('Seize', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Fade/Seize.webp'), 'Fade');
INSERT INTO `abilities` VALUES ('Haunt', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Fade/Haunt.webp'), 'Fade');
INSERT INTO `abilities` VALUES ('Nightfall', 4, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Fade/Nightfall.webp'), 'Fade');

-- Harbor Abilities
INSERT INTO `abilities` VALUES ('Cascade', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Harbor/Cascade.webp'), 'Harbor');
INSERT INTO `abilities` VALUES ('Cove', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Harbor/Cove.webp'), 'Harbor');
INSERT INTO `abilities` VALUES ('High Tide', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Harbor/High_Tide.webp'), 'Harbor');
INSERT INTO `abilities` VALUES ('Reckoning', 4, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Harbor/Reckoning.webp'), 'Harbor');

-- Gekko Abilities
INSERT INTO `abilities` VALUES ('Mosh Pit', 1, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Gekko/Mosh_Pit.webp'), 'Gekko');
INSERT INTO `abilities` VALUES ('Wingman', 2, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Gekko/Wingman.webp'), 'Gekko');
INSERT INTO `abilities` VALUES ('Dizzy', 3, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Gekko/Dizzy.webp'), 'Gekko');
INSERT INTO `abilities` VALUES ('Thrash', 4, LOAD_FILE('C:/Program Files/MySQL/MySQL Server 8.0/ValorantDatabaseAssets/Ability_Icons/Gekko/Thrash.webp'), 'Gekko');


CREATE TABLE `maps` (
    `map_name` varchar(50) NOT NULL,
    `map_image` BLOB,
    PRIMARY KEY (`map_name`)
);
INSERT INTO `maps` VALUES ('Ascent', NULL);
INSERT INTO `maps` VALUES ('Split', NULL);
INSERT INTO `maps` VALUES ('Haven', NULL);
INSERT INTO `maps` VALUES ('Bind', NULL);
INSERT INTO `maps` VALUES ('Icebox', NULL);
INSERT INTO `maps` VALUES ('Breeze', NULL);
INSERT INTO `maps` VALUES ('Fracture', NULL);
INSERT INTO `maps` VALUES ('Pearl', NULL);
INSERT INTO `maps` VALUES ('Lotus', NULL);

CREATE TABLE `lineups` (
    `id` INT NOT NULL AUTO_INCREMENT,
    `video` varchar(150) NOT NULL,
    `date` date NOT NULL,
    `review_flag` BOOLEAN DEFAULT false,
    `difficulty` INT NOT NULL,
    `type` varchar(50) NOT NULL,
    `site` char,
    `username` varchar(50) NOT NULL,
    `map_name` varchar(50) NOT NULL,
    PRIMARY KEY (`id`),
    KEY `fk_lineups_usernames_idx` (`username`),
    KEY `fk_lineups_map_names_idx` (`map_name`),
    CONSTRAINT `fk_lineups_usernames` FOREIGN KEY (`username`) REFERENCES `players` (`username`) ON UPDATE CASCADE,
    CONSTRAINT `fk_lineups_map_names` FOREIGN KEY (`map_name`) REFERENCES `maps` (`map_name`) ON UPDATE CASCADE,
    CONSTRAINT `valid_difficulty` CHECK (`difficulty` BETWEEN 1 AND 5),
    CONSTRAINT `valid_type` CHECK (`type` IN ('defense', 'attack', 'post-plant', 'setup')),
    CONSTRAINT `valid_site` CHECK (`site` IN ('A', 'B', 'C'))
);

CREATE TABLE `agent_tags` (
	`lineup_id` INT NOT NULL,
    `agent_name` varchar(50) NOT NULL,
	KEY `fk_agent_tags_lineup_ids_idx` (`lineup_id`),
    KEY `fk_agent_tags_agent_names_idx` (`agent_name`),
    CONSTRAINT `fk_agent_tags_lineup_ids` FOREIGN KEY (`lineup_id`) REFERENCES `lineups` (`id`) ON UPDATE CASCADE,
    CONSTRAINT `fk_agent_tags_agent_names` FOREIGN KEY (`agent_name`) REFERENCES `agents` (`agent_name`) ON UPDATE CASCADE
);

CREATE TABLE `ability_tags` (
	`lineup_id` INT NOT NULL,
    `ability_name` varchar(50) NOT NULL,
	KEY `fk_ability_tags_lineup_ids_idx` (`lineup_id`),
    KEY `fk_ability_tags_ability_names_idx` (`ability_name`),
    CONSTRAINT `fk_ability_tags_lineup_ids` FOREIGN KEY (`lineup_id`) REFERENCES `lineups` (`id`) ON UPDATE CASCADE,
    CONSTRAINT `fk_ability_tags_ability_names` FOREIGN KEY (`ability_name`) REFERENCES `abilities` (`ability_name`) ON UPDATE CASCADE
);

INSERT INTO `lineups` VALUES (1, 'https://medal.tv/games/valorant/clips/18E6y0I5RirEHn/I2maJKW1S4Wo?invite=cr-MSw3cm8sMTg1MTk1Nzg1LA&theater=true', '2023-01-01', DEFAULT, 3, 'post-plant', 'A', 'Tekkers', 'Icebox');
INSERT INTO `agent_tags` VALUES (1, 'Viper');
INSERT INTO `ability_tags` VALUES (1, 'Snake Bite');

INSERT INTO `lineups` VALUES (2, 'https://medal.tv/games/valorant/clips/18E6y0I5RirEHn/I2maJKW1S4Wo?invite=cr-MSw3cm8sMTg1MTk1Nzg1LA&theater=true', '2023-01-06', DEFAULT, 2, 'setup', 'A', 'Scarlizar', 'split');
INSERT INTO `agent_tags` VALUES (2, 'Cypher');
INSERT INTO `ability_tags` VALUES (2, 'Trapwire');
INSERT INTO `ability_tags` VALUES (2, 'Cyber Cage');
INSERT INTO `ability_tags` VALUES (2, 'Spycam');

INSERT INTO `lineups` VALUES (3, 'https://medal.tv/games/valorant/clips/18E6y0I5RirEHn/I2maJKW1S4Wo?invite=cr-MSw3cm8sMTg1MTk1Nzg1LA&theater=true', '2023-03-23', DEFAULT, 3, 'post-plant', 'B', 'Tekkers', 'Fracture');
INSERT INTO `agent_tags` VALUES (3, 'KAY/O');
INSERT INTO `agent_tags` VALUES (3, 'Killjoy');
INSERT INTO `ability_tags` VALUES (3, 'FRAG/MENT');
INSERT INTO `ability_tags` VALUES (3, 'Nanoswarm');

INSERT INTO `lineups` VALUES (4, 'https://medal.tv/games/fW3AZxHf_c/clips/18E7bjhLuJYIEN/b7LLDmYCUyzH', '2023-03-23', DEFAULT, 3, 'post-plant', 'B', 'OnOff', 'Ascent');
INSERT INTO `agent_tags` VALUES (4, 'Brimstone');
INSERT INTO `ability_tags` VALUES (4, 'Incendiary');

INSERT INTO `lineups` VALUES (5, 'https://medal.tv/games/valorant/clips/18E92JAldtfdVb/QcQtcgfzWmLo?invite=cr-MSw4UlMsMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 5, 'post-plant', 'A', 'OnOff', 'Haven');
INSERT INTO `agent_tags` VALUES (5, 'Brimstone');
INSERT INTO `ability_tags` VALUES (5, 'Incendiary');

INSERT INTO `lineups` VALUES (6, 'https://medal.tv/games/valorant/clips/18E4VkKdbF9b81/v8sqChiMYp87?invite=cr-MSxNbTMsMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 4, 'post-plant', 'A', 'OnOff', 'Ascent');
INSERT INTO `agent_tags` VALUES (6, 'Brimstone');
INSERT INTO `ability_tags` VALUES (6, 'Incendiary');

INSERT INTO `lineups` VALUES (7, 'https://medal.tv/games/valorant/clips/18E4VkKdbF9b81/v8sqChiMYp87?invite=cr-MSxNbTMsMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 4, 'post-plant', 'B', 'OnOff', 'Ascent');
INSERT INTO `agent_tags` VALUES (7, 'Brimstone');
INSERT INTO `ability_tags` VALUES (7, 'Incendiary');

INSERT INTO `lineups` VALUES (8, 'https://medal.tv/games/valorant/clips/18E5DPdUpHa3ft/JoEoDU3aNkPQ?invite=cr-MSw2SmcsMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 2, 'post-plant', 'B', 'OnOff', 'Ascent');
INSERT INTO `agent_tags` VALUES (8, 'Brimstone');
INSERT INTO `ability_tags` VALUES (8, 'Incendiary');

INSERT INTO `lineups` VALUES (9, 'https://medal.tv/games/valorant/clips/18E5DPdUpHa3ft/JoEoDU3aNkPQ?invite=cr-MSw2SmcsMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 3, 'post-plant', 'A', 'OnOff', 'Fracture');
INSERT INTO `agent_tags` VALUES (9, 'Brimstone');
INSERT INTO `ability_tags` VALUES (9, 'Incendiary');

INSERT INTO `lineups` VALUES (10, 'https://medal.tv/games/valorant/clips/FrssiAF0qTLFh/4pV68d5T2UXr?invite=cr-MSxmUUgsMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 2, 'post-plant', 'B', 'Aadeeb', 'Bind');
INSERT INTO `agent_tags` VALUES (10, 'Viper');
INSERT INTO `ability_tags` VALUES (10, 'Snake Bite');

INSERT INTO `lineups` VALUES (11, 'https://medal.tv/games/valorant/clips/CSCpr3Sr515X0/dKfrLCivC2i1?invite=cr-MSxwTmQsMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 1, 'post-plant', 'B', 'Aajeeb', 'Haven');
INSERT INTO `agent_tags` VALUES (11, 'Viper');
INSERT INTO `ability_tags` VALUES (11, 'Snake Bite');
INSERT INTO `ability_tags` VALUES (11, 'Vipers Pit');

INSERT INTO `lineups` VALUES (12, 'https://medal.tv/games/valorant/clips/y2BsgmiH8mr-D/V34dYHOwRJsN?invite=cr-MSxvQnosMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 2, 'post-plant', 'B', 'Aajeeb', 'Pearl');
INSERT INTO `agent_tags` VALUES (12, 'Viper');
INSERT INTO `ability_tags` VALUES (12, 'Snake Bite');
INSERT INTO `ability_tags` VALUES (12, 'Poison Cloud');

INSERT INTO `lineups` VALUES (13, 'https://medal.tv/games/valorant/clips/mEtFsydEZUe86/1XGwqT3KnH0Q?invite=cr-MSw5V2wsMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 1, 'post-plant', 'A', 'Aajeeb', 'Haven');
INSERT INTO `agent_tags` VALUES (13, 'KAY/O');
INSERT INTO `ability_tags` VALUES (13, 'FRAG/MENT');

INSERT INTO `lineups` VALUES (14, 'https://medal.tv/games/valorant/clips/jaHarqJN5jchZ/FCmlAUIPIyb9?invite=cr-MSw3VWcsMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 1, 'setup', 'B', 'Rickey', 'Ascent');
INSERT INTO `agent_tags` VALUES (14, 'Killjoy');
INSERT INTO `ability_tags` VALUES (14, 'Nanoswarm');
INSERT INTO `ability_tags` VALUES (14, 'Alarmbot');
INSERT INTO `ability_tags` VALUES (14, 'Turret');

INSERT INTO `lineups` VALUES (15, 'https://medal.tv/games/valorant/clips/80qqquxQEupMe/Zoc0A5K4pqQK?invite=cr-MSxiV2IsMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 1, 'setup', 'B', 'Rickey', 'Bind');
INSERT INTO `agent_tags` VALUES (15, 'Killjoy');
INSERT INTO `ability_tags` VALUES (15, 'Nanoswarm');
INSERT INTO `ability_tags` VALUES (15, 'Alarmbot');
INSERT INTO `ability_tags` VALUES (15, 'Turret');

INSERT INTO `lineups` VALUES (16, 'https://medal.tv/games/valorant/clips/256N1qcLdao7P/Ag6oQnmlYaGg?invite=cr-MSxrMmosMTg1MTk1Nzg1LA', '2023-03-23', DEFAULT, 1, 'post-plant', 'A', 'Rickey', 'Ascent');
INSERT INTO `agent_tags` VALUES (16, 'Killjoy');
INSERT INTO `ability_tags` VALUES (16, 'Nanoswarm');

CREATE TABLE `saves` (
	`lineup_id` INT NOT NULL,
    `username` varchar(50) NOT NULL,
	KEY `fk_saves_lineup_ids_idx` (`lineup_id`),
    KEY `fk_saves_usernames_idx` (`username`),
    CONSTRAINT `fk_saves_lineup_ids` FOREIGN KEY (`lineup_id`) REFERENCES `lineups` (`id`) ON UPDATE CASCADE,
    CONSTRAINT `fk_saves_usernames` FOREIGN KEY (`username`) REFERENCES `players` (`username`) ON UPDATE CASCADE
);

INSERT INTO `saves` VALUES (3, 'Heyodude');
INSERT INTO `saves` VALUES (2, 'Heyodude');

CREATE TABLE `ratings` (
	`lineup_id` INT NOT NULL,
    `username` varchar(50) NOT NULL,
	KEY `fk_ratings_lineup_ids_idx` (`lineup_id`),
    KEY `fk_ratings_usernames_idx` (`username`),
    `rating` INT NOT NULL,
	CONSTRAINT `fk_ratings_lineup_ids` FOREIGN KEY (`lineup_id`) REFERENCES `lineups` (`id`) ON UPDATE CASCADE,
    CONSTRAINT `fk_ratings_usernames` FOREIGN KEY (`username`) REFERENCES `players` (`username`) ON UPDATE CASCADE
);

INSERT INTO `ratings` VALUES (1, 'OnOff', 5);
INSERT INTO `ratings` VALUES (1, 'Aajeeb', 3);