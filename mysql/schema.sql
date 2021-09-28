-- CREATE USER ‘newuser’@’localhost’ IDENTIFIED BY ‘password’;
CREATE USER IF NOT EXISTS gatechUser@localhost IDENTIFIED BY 'gatech123';

DROP DATABASE IF EXISTS `cs6400_summer2020_team022`;
SET default_storage_engine=InnoDB;
SET NAMES utf8mb4 COLLATE utf8mb4_unicode_ci;

CREATE DATABASE IF NOT EXISTS cs6400_summer2020_team022
          DEFAULT CHARACTER SET utf8mb4
          DEFAULT COLLATE utf8mb4_unicode_ci;
USE cs6400_summer2020_team022;

GRANT SELECT, INSERT, UPDATE, DELETE, FILE ON *.* TO 'gatechUser'@'localhost';
GRANT ALL PRIVILEGES ON  `gatechuser`.* TO 'gatechUser'@'localhost';
GRANT ALL PRIVILEGES ON  `cs6400_summer2020_team022`.* TO 'gatechUser'@'localhost';
FLUSH PRIVILEGES;

-- Tables


CREATE TABLE  IF NOT EXISTS `User` (
     email varchar(250) NOT NULL,
     password varchar(64) NOT NULL,
     first_name varchar(50) NOT NULL,
     last_name varchar(50) NOT NULL,
     phone_number varchar(20) NOT NULL,
     start_date date NOT NULL,
     PRIMARY KEY (email)
);

CREATE TABLE IF NOT EXISTS `Admin` (
     email varchar(250) NOT NULL,
     PRIMARY KEY (email)
);

CREATE TABLE IF NOT EXISTS `Dog` (
     dog_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
     name varchar(50) NOT NULL,
     birth_date date NOT NULL,
     sex ENUM('Female','Male','Unknown') NOT NULL DEFAULT 'Unknown',
     description varchar(250) NOT NULL,
     microchip_id varchar(50) NULL,
     alteration_status BIT(1) NOT NULL DEFAULT b'0',
     surrender_date date NOT NULL,
     surrender_reason varchar(250) NOT NULL,
     surrender_name varchar(50) NULL,
     is_animal_control BIT(1) NOT NULL DEFAULT b'0',
     dog_adder_email varchar(250) NOT NULL,
     UNIQUE KEY (microchip_id),
     PRIMARY KEY (dog_id)
);

CREATE TABLE IF NOT EXISTS `DogBreed` (
     dog_id INT UNSIGNED NOT NULL,
     breed_id INT UNSIGNED NOT NULL,
     PRIMARY KEY (dog_id,breed_id)
);

CREATE TABLE IF NOT EXISTS `Breed` (
     breed_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
     breed_name varchar(250) NOT NULL,
     PRIMARY KEY (breed_id)
);

CREATE TABLE IF NOT EXISTS `Expense` (
     dog_id INT UNSIGNED NOT NULL,
     expense_date date NOT NULL,
     vender_id INT UNSIGNED NOT NULL,
     amount float NOT NULL,
     description varchar(250) NULL,
     PRIMARY KEY (dog_id,expense_date,vender_id)
);

CREATE TABLE IF NOT EXISTS `Vender` (
     vender_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
     vender_name varchar(250) NOT NULL,
     PRIMARY KEY (vender_id)
);

CREATE TABLE IF NOT EXISTS `Applicant` (
     email varchar(250) NOT NULL,
     last_name varchar(50) NOT NULL,
     first_name varchar(50) NOT NULL,
     phone_number varchar(20) NOT NULL,
     address varchar(250) NOT NULL,
     PRIMARY KEY (email)
);

CREATE TABLE IF NOT EXISTS `Application` (
     application_id INT UNSIGNED NOT NULL AUTO_INCREMENT,
     applicant_email varchar(250) NOT NULL,
     submit_date date  NOT NULL,
     status ENUM('Approved','Pending','Rejected') NOT NULL DEFAULT 'Pending',
     co_applicant_first_name varchar(50)  NULL,
     co_applicant_last_name varchar(50)  NULL,
     PRIMARY KEY (application_id)
);

CREATE TABLE IF NOT EXISTS `ApprovedApplication` (
     application_id INT UNSIGNED NOT NULL,
     dog_id INT UNSIGNED NULL,
     adoption_date date NULL,
     PRIMARY KEY (application_id)
);

CREATE TABLE IF NOT EXISTS `RejectedApplication` (
     application_id INT UNSIGNED NOT NULL,
     PRIMARY KEY (application_id)
);


-- Constraints   Foreign keys: FK_ChildTable_childColumn_ParentTable_parentColumn


ALTER TABLE Admin
    ADD CONSTRAINT fk_Admin_email_User_email FOREIGN KEY (email) REFERENCES `User` (email);

ALTER TABLE Dog
    ADD CONSTRAINT fk_Dog_dogadderemail_User_email FOREIGN KEY (dog_adder_email) REFERENCES `User` (email);

ALTER TABLE DogBreed
    ADD CONSTRAINT fk_DogBreed_dogid_Dog_dogid FOREIGN KEY (dog_id) REFERENCES `Dog` (dog_id);

ALTER TABLE DogBreed
    ADD CONSTRAINT fk_DogBreed_breedid_Breed_dogid FOREIGN KEY (breed_id) REFERENCES `Breed` (breed_id);

ALTER TABLE Expense
    ADD CONSTRAINT fk_Expense_dogid_Dog_dogid FOREIGN KEY (dog_id) REFERENCES `Dog` (dog_id);

ALTER TABLE Expense
    ADD CONSTRAINT fk_Expense_venderid_Vender_venderid FOREIGN KEY (vender_id) REFERENCES `Vender` (vender_id);

ALTER TABLE Application
    ADD CONSTRAINT fk_Application_applicantemail_Applicant_email FOREIGN KEY (applicant_email) REFERENCES `Applicant` (email);

ALTER TABLE ApprovedApplication
    ADD CONSTRAINT fk_ApprovedApplication_applicationid_Application_applicationid FOREIGN KEY (application_id) REFERENCES `Application` (application_id);

ALTER TABLE ApprovedApplication
    ADD CONSTRAINT fk_ApprovedApplication_dogid_Dog_dogid FOREIGN KEY (dog_id) REFERENCES `Dog` (dog_id);

ALTER TABLE RejectedApplication
    ADD CONSTRAINT fk_RejectedApplication_applicationid_Application_applicationid FOREIGN KEY (application_id) REFERENCES `Application` (application_id);


INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('asmith@zotware.com', 'pwd', 'Nichelle', 'Ruta', '2154786705', '2019-01-01');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('barias@xx-holding.com', 'pwd', 'Layla', 'Boulter', '6656503829', '2018-12-25');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('cjurney@groovestreet.com', 'pwd', 'Brittni', 'Boord', '1875176352', '2018-12-30');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('cvonasek@toughzap.com', 'pwd', 'Malcolm', 'Vocelka', '3961960379', '2018-12-26');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('dkeetch@golddex.com', 'pwd', 'Roosevelt', 'Springe', '4531134131', '2018-12-24');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('dmontezuma@green-plus.com', 'pwd', 'Jeanice', 'Heintzman', '5515197966', '2018-12-27');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('edubaldi@finhigh.com', 'pwd', 'Candida', 'Nayar', '1787601359', '2018-12-31');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('fcrupi@rangreen.com', 'pwd', 'Gail', 'Fallick', '3703791448', '2018-12-25');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('gmatuszak@green-plus.com', 'pwd', 'Salome', 'Fern', '3731243863', '2018-12-31');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('jgiguere@openlane.com', 'pwd', 'Cory', 'Diestel', '7806817465', '2018-12-23');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('jsweely@fasehatice.com', 'pwd', 'Dalene', 'Craghead', '3875514070', '2019-01-01');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('kmunns@yearin.com', 'pwd', 'Laurel', 'Ahle', '5644284709', '2018-12-31');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('lmenter@plexzap.com', 'pwd', 'Roselle', 'Emigh', '8947815589', '2018-12-23');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('mdeleo@funholding.com', 'pwd', 'Quentin', 'Loader', '8795863139', '2018-12-29');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('mmallett@konex.com', 'pwd', 'Angella', 'Hoogland', '4386427372', '2018-12-26');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('mo@burdell.com', 'mo', 'Mo', 'Burdell', '7807479196', '2018-01-01');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('nbatman@ron-tech.com', 'pwd', 'Raylene', 'Blackwood', '7651019389', '2018-12-29');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('ncoyier@funholding.com', 'pwd', 'Daniel', 'Neither', '8389088169', '2018-12-26');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('rdiestel@goodsilron.com', 'pwd', 'Ronny', 'Tagala', '5301442835', '2018-12-30');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('sahle@treequote.com', 'pwd', 'Lettie', 'Colla', '7962203632', '2018-12-30');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('sjurney@groovestreet.com', 'pwd', 'Evangelina', 'Crupi', '4931010544', '2018-12-26');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('smaclead@openlane.com', 'pwd', 'Casie', 'Comnick', '4275104007', '2018-12-30');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('srodefer@ontomedia.com', 'pwd', 'Paris', 'Yum', '5323782223', '2018-12-30');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('tmarrier@hottechi.com', 'pwd', 'Herminia', 'Nicka', '6652890833', '2018-12-24');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('vmenter@silis.com', 'pwd', 'Nickolas', 'Gochal', '5660399052', '2018-12-29');
        
INSERT INTO cs6400_summer2020_team022.User 
        (email, password, first_name, last_name, phone_number, start_date) 
        VALUES ('walbares@conecom.com', 'pwd', 'Vilma', 'Marrier', '3419223914', '2018-12-23');
     
INSERT INTO cs6400_summer2020_team022.Admin (email) VALUES ('mo@burdell.com');




INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (1,'Affenpinscher');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (2,'Afghan Hound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (3,'Airedale Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (4,'Akbash Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (5,'Akita');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (6,'Alapaha Blue Blood Bulldog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (7,'Alaskan Husky');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (8,'Alaskan Malamute');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (9,'American Bulldog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (10,'American Eskimo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (11,'American Foxhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (12,'American Pit Bull Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (13,'American Staffordshire Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (14,'American Water Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (15,'Anatolian Shepherd Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (16,'Aussiedoodle');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (17,'Australian Cattle Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (18,'Australian Kelpie');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (19,'Australian Shepherd');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (20,'Australian Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (21,'Azawakh');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (22,'Basador');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (23,'Basenji');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (24,'Basset Bleu de Gascogne');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (25,'Basset Hound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (26,'Beagle');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (27,'Bearded Collie');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (28,'Beauceron');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (29,'Bedlington Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (30,'Belgian Laekenois');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (31,'Belgian Malinois');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (32,'Belgian Sheepdog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (33,'Belgian Tervuren');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (34,'Bergamasco');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (35,'Berger Picard');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (36,'Bernese Mountain Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (37,'Bichon Frise');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (38,'Black and Tan Coonhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (39,'Black Russian Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (40,'Bloodhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (41,'Blue Picardy Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (42,'Bluetick Coonhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (43,'Boerboel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (44,'Bolognese');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (45,'Border Collie');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (46,'Border Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (47,'Borzoi');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (48,'Boston Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (49,'Bouvier des Flandres');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (50,'Boxer');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (51,'Boykin Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (52,'Bracco Italiano');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (53,'Briard');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (54,'Brittany');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (55,'Brussels Griffon');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (56,'Bull Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (57,'Bulldog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (58,'Bullmastiff');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (59,'Cairn Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (60,'Canaan Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (61,'Cane Corso');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (62,'Cardigan Welsh Corgi');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (63,'Catahoula Leopard Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (64,'Caucasian Ovcharka');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (65,'Cavalier King Charles Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (66,'Cavapom');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (67,'Cavapoo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (68,'Cesky Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (69,'Chart Polski');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (70,'Chesapeake Bay Retriever');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (71,'Chihuahua');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (72,'Chinese Crested');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (73,'Chinese Shar-Pei');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (74,'Chinook');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (75,'Chow Chow');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (76,'Chug');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (77,'Cirneco dell''Etna');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (78,'Clumber Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (79,'Cockapoo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (80,'Cocker Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (81,'Collie');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (82,'Coton de Tulear');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (83,'Curly-Coated Retriever');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (84,'Dachshund');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (85,'Dalmatian');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (86,'Dandie Dinmont Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (87,'Doberman Pinscher');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (88,'Dogo Argentino');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (89,'Dogue de Bordeaux');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (90,'Doxiepoo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (91,'English Cocker Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (92,'English Foxhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (93,'English Setter');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (94,'English Springer Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (95,'English Toy Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (96,'Entlebucher Mountain Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (97,'Eurasier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (98,'Field Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (99,'Fila Brasileiro');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (100,'Finnish Lapphund');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (101,'Finnish Spitz');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (102,'Flat-Coated Retriever');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (103,'Fox Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (104,'French Bulldog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (105,'German Pinscher');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (106,'German Shepherd Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (107,'German Shorthaired Pointer');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (108,'German Spitz');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (109,'German Wirehaired Pointer');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (110,'Giant Schnauzer');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (111,'Glen of Imaal Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (112,'Golden Retriever');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (113,'Goldendoodle');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (114,'Gordon Setter');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (115,'Great Dane');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (116,'Great Pyrenees');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (117,'Greater Swiss Mountain Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (118,'Greyhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (119,'Harrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (120,'Havanese');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (121,'Ibizan Hound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (122,'Icelandic Sheepdog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (123,'Irish Red and White Setter');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (124,'Irish Setter');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (125,'Irish Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (126,'Irish Water Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (127,'Irish Wolfhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (128,'Italian Greyhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (129,'Jack Russell Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (130,'Japanese Chin');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (131,'Keeshond');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (132,'Kerry Blue Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (133,'Komondor');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (134,'Kooikerhondje');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (135,'Kromfohrlander');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (136,'Kuvasz');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (137,'Labradoodle');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (138,'Labrador Retriever');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (139,'Lacy Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (140,'Lagotto Romagnolo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (141,'Lakeland Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (142,'Large Munsterlander');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (143,'Leonberger');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (144,'Lhasa Apso');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (145,'Lhasapoo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (146,'Longdog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (147,'Lowchen');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (148,'Lurcher');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (149,'Maltese');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (150,'Maltipoo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (151,'Manchester Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (152,'Mastiff');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (153,'Miniature American Shepherd');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (154,'Miniature Bull Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (155,'Miniature Pinscher');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (156,'Miniature Schnauzer');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (157,'Mudi');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (158,'Neapolitan Mastiff');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (159,'Newfoundland');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (160,'Norfolk Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (161,'Norwegian Buhund');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (162,'Norwegian Elkhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (163,'Norwegian Lundehund');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (164,'Norwich Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (165,'Nova Scotia Duck Tolling Retriever');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (166,'Old English Sheepdog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (167,'Otterhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (168,'Papillon');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (169,'Pekeapoo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (170,'Pekingese');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (171,'Pembroke Welsh Corgi');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (172,'Perro de Presa Canario');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (173,'Peruvian Inca Orchid');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (174,'Petit Basset Griffon Vendeen');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (175,'Pharaoh Hound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (176,'Plott');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (177,'Pointer');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (178,'Polish Lowland Sheepdog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (179,'Pomapoo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (180,'Pomeranian');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (181,'Pomsky');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (182,'Poodle');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (183,'Portuguese Podengo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (184,'Portuguese Water Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (185,'Pug');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (186,'Pugapoo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (187,'Puggle');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (188,'Puli');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (189,'Pumi');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (190,'Pyrenean Shepherd');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (191,'Rat Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (192,'Redbone Coonhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (193,'Rhodesian Ridgeback');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (194,'Rottweiler');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (195,'Russian Toy');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (196,'Saint Bernard');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (197,'Saluki');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (198,'Samoyed');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (199,'Schapendoes');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (200,'Schipperke');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (201,'Schnoodle');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (202,'Scottish Deerhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (203,'Scottish Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (204,'Sealyham Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (205,'Shetland Sheepdog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (206,'Shiba Inu');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (207,'Shih Tzu');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (208,'Shihpoo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (209,'Siberian Husky');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (210,'Silken Windhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (211,'Silky Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (212,'Skye Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (213,'Sloughi');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (214,'Small Munsterlander Pointer');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (215,'Soft Coated Wheaten Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (216,'Spanish Greyhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (217,'Spanish Water Dog');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (218,'Spinone Italiano');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (219,'Sprollie');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (220,'Staffordshire Bull Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (221,'Standard Schnauzer');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (222,'Sussex Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (223,'Swedish Lapphund');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (224,'Swedish Vallhund');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (225,'Thai Ridgeback');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (226,'Tibetan Mastiff');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (227,'Tibetan Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (228,'Tibetan Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (229,'Tosa Ken');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (230,'Toy Fox Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (231,'Toy Poodle');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (232,'Treeing Walker Coonhound');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (233,'Vizsla');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (234,'Volpino Italiano');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (235,'Weimaraner');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (236,'Welsh Springer Spaniel');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (237,'Welsh Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (238,'West Highland White Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (239,'Whippet');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (240,'Wirehaired Pointing Griffon');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (241,'Wirehaired Vizsla');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (242,'Xoloitzcuintli');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (243,'Yorkipoo');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (244,'Yorkshire Terrier');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (245,'Mixed');
INSERT INTO cs6400_summer2020_team022.Breed (breed_id, breed_name) VALUES (246,'Unknown');



INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('hcallaro@cancity.com', 'Callaro', 'Helga', '4556917286', "7628 7-street, Greensboro, NJ 04569");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('fdelasancha@inity.com', 'Delasancha', 'France', '2275019405', "2862 12-street, Newark, TX 66783");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('amiceli@blackzim.com', 'Miceli', 'An', '212506214', "6950 8-street, Durham, WI 63410");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('jblackwood@dambase.com', 'Blackwood', 'Judy', '974760756', "6777 15-street, Oakland, MN 61777");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('brhym@dambase.com', 'Rhym', 'Buddy', '1763305209', "6822 11-street, Colorado Springs, NE 48984");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('acoyier@hottechi.com', 'Coyier', 'Annmarie', '3406432705', "1379 17-street, Mesa, VA 98743");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lhamilton@labdrill.com', 'Hamilton', 'Lai', '4670203056', "2726 13-street, Irving, AZ 69986");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lmorocco@year-job.com', 'Morocco', 'Lorrie', '428043150', "2629 1-street, Baltimore, OK 27365");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('mstem@betasoloin.com', 'Stem', 'Margart', '3730603927', "9062 18-street, Hialeah, NV 76455");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('mhollack@scottech.com', 'Hollack', 'Mozell', '2812000053', "321 12-street, Plano, NV 99069");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('rgarufi@bioplex.com', 'Garufi', 'Regenia', '2817952195', "8020 6-street, Kansas City, AZ 14901");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lkarpel@nam-zim.com', 'Karpel', 'Lorrine', '3417123913', "3646 19-street, Miami, CA 45960");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('kharnos@conecom.com', 'Harnos', 'Kanisha', '5651564822', "1343 15-street, Chesapeake, AZ 75142");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ltheodorov@opentech.com', 'Theodorov', 'Louvenia', '7817467627', "6164 5-street, Irving, AZ 65641");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('gkines@inity.com', 'Kines', 'Gearldine', '8292555533', "9024 7-street, St. Petersburg, AZ 54656");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('cscipione@kan-code.com', 'Scipione', 'Cecily', '6166913095', "4492 21-street, Albuquerque, AZ 84625");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lmunns@toughzap.com', 'Munns', 'Lettie', '642648839', "3948 1-street, Oakland, MN 80297");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('jrestrepo@konmatfix.com', 'Restrepo', 'Jettie', '2580479634', "8358 20-street, Baton Rouge, TX 98180");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('jlueckenbach@plussunin.com', 'Lueckenbach', 'Jani', '835309870', "8220 17-street, Fort Wayne, FL 16818");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('aostolaza@finjob.com', 'Ostolaza', 'Alecia', '6965596189', "781 15-street, Phoenix, AZ 81617");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ggalam@ron-tech.com', 'Galam', 'Glen', '6803773336', "1051 20-street, Omaha, NC 70245");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('dkines@betatech.com', 'Kines', 'Dorthy', '9497063223', "9057 19-street, Sacramento, CA 75064");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('kcraghead@sumace.com', 'Craghead', 'Kayleigh', '2945618913', "5350 6-street, Denver, CO 22151");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('dgellinger@dambase.com', 'Gellinger', 'Devora', '8628090963', "3711 13-street, Corpus Christi, KY 03268");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('hmenter@doncon.com', 'Menter', 'Hillary', '5879884007', "3773 11-street, Hialeah, NV 25516");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('bmastella@kan-code.com', 'Mastella', 'Brittni', '3703831645', "1142 11-street, Virginia Beach, GA 86605");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('snicka@year-job.com', 'Nicka', 'Shonda', '2134076388', "8687 19-street, Louisville/Jefferson County, OR 24281");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('cpugh@domzoom.com', 'Pugh', 'Carmela', '1757054248', "647 9-street, Oklahoma City, KY 85065");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('jspickerman@y-corporation.com', 'Spickerman', 'Joseph', '631902612', "3992 8-street, Anaheim, CA 87162");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('cpagliuca@betasoloin.com', 'Pagliuca', 'Catarina', '4285698314', "2537 18-street, Chesapeake, AZ 39058");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('cpaulas@opentech.com', 'Paulas', 'Carlee', '7399274620', "6751 6-street, St. Louis, CA 40354");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('troyster@kan-code.com', 'Royster', 'Ty', '7809866690', "6993 11-street, Jersey City, CA 67631");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ahoogland@doncon.com', 'Hoogland', 'Alex', '4387341818', "255 12-street, Chula Vista, IN 57009");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ebowley@ganjaflex.com', 'Bowley', 'Ernie', '9407037638', "3121 12-street, Plano, NV 03558");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('eperigo@plussunin.com', 'Perigo', 'Eladia', '1059814975', "6759 16-street, Jersey City, CA 50660");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('estenseth@cancity.com', 'Stenseth', 'Erinn', '5878076341', "6364 14-street, Lubbock, CA 12415");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('msarao@newex.com', 'Sarao', 'Maurine', '4568765994', "1334 7-street, Arlington, LA 95129");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('afigeroa@labdrill.com', 'Figeroa', 'Alpha', '6572550852', "812 21-street, Garland, FL 55207");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ajuvera@groovestreet.com', 'Juvera', 'Amie', '6883841586', "7335 9-street, Austin, TX 52943");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('esaylors@y-corporation.com', 'Saylors', 'Evangelina', '167588959', "714 1-street, Sacramento, CA 17261");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('kweglarz@streethex.com', 'Weglarz', 'Kayleigh', '776708535', "9715 16-street, Kansas City, AZ 98923");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('hseewald@j-texon.com', 'Seewald', 'Helga', '1110994610', "4606 15-street, Colorado Springs, NE 66599");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lpadilla@conecom.com', 'Padilla', 'Leota', '6956904911', "6301 14-street, Wichita, TX 78386");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ccoody@sonron.com', 'Coody', 'Carissa', '8809306211', "2335 7-street, Memphis, TN 49402");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lwalthall@betasoloin.com', 'Walthall', 'Laurel', '5336512883', "3863 8-street, Charlotte, NC 18095");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('elary@lexiqvolax.com', 'Lary', 'Erick', '1316212290', "6988 17-street, Buffalo, NJ 51772");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('etromblay@toughzap.com', 'Tromblay', 'Elouise', '947509402', "4110 6-street, Santa Ana, MO 73576");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('eadkin@stanredtax.com', 'Adkin', 'Elly', '7579751550', "346 21-street, Portland, NV 75532");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ckannady@dambase.com', 'Kannady', 'Catalina', '1945134801', "9999 7-street, Sacramento, CA 90468");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('bpoullion@opentech.com', 'Poullion', 'Brett', '8248844862', "2377 13-street, Hialeah, NV 15054");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lsteffensmeier@gogozoom.com', 'Steffensmeier', 'Lashon', '1228445496', "824 2-street, San Francisco, CA 37737");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ttromblay@dontechi.com', 'Tromblay', 'Taryn', '7833051221', "3749 5-street, Cincinnati, MN 81042");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lschoeneck@streethex.com', 'Schoeneck', 'Lindsey', '2211344817', "9020 15-street, Chula Vista, IN 84830");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('rvanheusen@statholdings.com', 'Vanheusen', 'Roosevelt', '9827706913', "1269 13-street, Phoenix, AZ 01497");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lbayless@sumace.com', 'Bayless', 'Lorrine', '3882307371', "4015 17-street, Austin, TX 23088");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('vknipp@year-job.com', 'Knipp', 'Viva', '6920051808', "4275 6-street, Stockton, OH 17197");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('anievas@rangreen.com', 'Nievas', 'Alline', '1540065789', "5735 1-street, Stockton, OH 61767");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('jkarpel@mathtouch.com', 'Karpel', 'Justine', '1064056528', "5493 1-street, Fresno, CA 59927");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ahoogland@y-corporation.com', 'Hoogland', 'Ammie', '3880116823', "7286 6-street, Tampa, HI 84881");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('wmeteer@domzoom.com', 'Meteer', 'Willodean', '1962927175', "826 10-street, Toledo, NC 10134");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('chirpara@rantouch.com', 'Hirpara', 'Clorinda', '5905299590', "4420 18-street, Milwaukee, NM 96662");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('clawler@dontechi.com', 'Lawler', 'Chau', '3270032002', "1147 9-street, Columbus, OH 34302");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('mreiber@scottech.com', 'Reiber', 'Marguerita', '1465945858', "6710 19-street, Wichita, TX 23815");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('mbolognia@finjob.com', 'Bolognia', 'Mitsue', '779534703', "9389 18-street, Detroit, MI 47637");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('kpedrozo@kan-code.com', 'Pedrozo', 'Kris', '2805097775', "289 21-street, North Las Vegas, CA 21987");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('egoldammer@scottech.com', 'Goldammer', 'Elke', '7636589113', "5061 3-street, Madison, TX 31967");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('jmirafuentes@rangreen.com', 'Mirafuentes', 'Jolanda', '7619983851', "5701 5-street, Orlando, FL 01741");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('jpoquette@ron-tech.com', 'Poquette', 'Johnetta', '5358671206', "2714 13-street, Riverside, TX 08562");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('msetter@fasehatice.com', 'Setter', 'Merissa', '8221492776', "4798 5-street, Atlanta, CO 27044");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('esaylors@groovestreet.com', 'Saylors', 'Estrella', '5148314369', "8624 2-street, Winston-Salem, AZ 07775");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('dscipione@dambase.com', 'Scipione', 'Denise', '4302798321', "299 8-street, North Las Vegas, CA 74474");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('aspickerman@green-plus.com', 'Spickerman', 'Albina', '4965767143', "9182 8-street, Anchorage, CA 88656");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('egrenet@y-corporation.com', 'Grenet', 'Ernie', '1697611014', "5073 14-street, Virginia Beach, GA 49648");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('adenooyer@kinnamplus.com', 'Denooyer', 'Art', '1737623015', "8189 4-street, Irvine, NC 93779");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('rhollack@plexzap.com', 'Hollack', 'Rikki', '2522640007', "9390 3-street, New Orleans, CA 11929");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('tkines@sumace.com', 'Kines', 'Timothy', '1717769169', "3481 14-street, Denver, CO 90861");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lmonarrez@goodsilron.com', 'Monarrez', 'Larae', '9692306614', "8793 2-street, Miami, CA 00240");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('dturinetti@doncon.com', 'Turinetti', 'Dorthy', '1178998719', "1196 17-street, Houston, TX 55569");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('szepp@dalttechnology.com', 'Zepp', 'Shonda', '856916853', "4752 5-street, Toledo, NC 80532");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('awildfong@conecom.com', 'Wildfong', 'Amber', '164165810', "8735 7-street, Tampa, HI 87978");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('loldroyd@hottechi.com', 'Oldroyd', 'Lucy', '8274477101', "9392 18-street, Nashville-Davidson, MD 34894");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('jbuvens@plusstrip.com', 'Buvens', 'Janine', '1175638045', "9670 11-street, Bakersfield, FL 13724");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('smeteer@dalttechnology.com', 'Meteer', 'Serina', '9502296621', "1473 12-street, Richmond, CA 19203");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lflister@hottechi.com', 'Flister', 'Lonny', '5160672671', "7359 18-street, Winston-Salem, AZ 75981");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('agillaspie@golddex.com', 'Gillaspie', 'Alline', '1116695849', "2773 19-street, Portland, NV 97544");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lkippley@golddex.com', 'Kippley', 'Louisa', '1491225057', "2539 6-street, Irving, AZ 95249");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('vkeener@kan-code.com', 'Keener', 'Virgina', '4207746671', "6442 21-street, St. Petersburg, AZ 76382");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('mreitler@fasehatice.com', 'Reitler', 'Mariann', '8934510509', "2800 20-street, Philadelphia, PA 70825");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('oflosi@betatech.com', 'Flosi', 'Olive', '2495654893', "3466 14-street, Indianapolis, IN 47706");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('brestrepo@xx-holding.com', 'Restrepo', 'Belen', '6101805651', "3761 7-street, Jersey City, CA 71855");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('yisenhower@dambase.com', 'Isenhower', 'Yvonne', '8159445334', "1787 5-street, Cincinnati, MN 73119");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('whamilton@opentech.com', 'Hamilton', 'Willow', '3870058455', "2265 5-street, Fremont, ID 83391");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('jacey@inity.com', 'Acey', 'Johnetta', '4534969813', "9551 14-street, Wichita, TX 17071");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lstockham@j-texon.com', 'Stockham', 'Laurel', '8834494208', "1636 3-street, Chesapeake, AZ 01939");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('mskulski@sumace.com', 'Skulski', 'Marvel', '2588966131', "4635 3-street, Atlanta, CO 52151");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ehirpara@sunnamplex.com', 'Hirpara', 'Elvera', '1876924079', "3366 1-street, Baton Rouge, TX 73854");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lnunlee@ron-tech.com', 'Nunlee', 'Lai', '8322208696', "2983 6-street, Riverside, TX 70214");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('bdiestel@condax.com', 'Diestel', 'Bette', '5601011487', "7554 8-street, Aurora, CA 09614");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('hgwalthney@funholding.com', 'Gwalthney', 'Helga', '3986052383', "8305 14-street, Boise City, VA 29356");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('aoles@bioplex.com', 'Oles', 'Antione', '1075419082', "6766 17-street, Newark, TX 65824");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('aacey@dontechi.com', 'Acey', 'Alishia', '4315446950', "1877 19-street, Lexington-Fayette, PA 25328");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('xdubaldi@iselectrics.com', 'Dubaldi', 'Xuan', '7455760970', "1372 11-street, Baltimore, OK 06641");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ndenooyer@statholdings.com', 'Denooyer', 'Nan', '1330987794', "4482 20-street, Austin, TX 83645");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('traymo@scotfind.com', 'Raymo', 'Thaddeus', '1332668310', "7830 12-street, Nashville-Davidson, MD 19348");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('cbourbon@betasoloin.com', 'Bourbon', 'Caitlin', '345896524', "2806 18-street, Fort Wayne, FL 12470");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('dstoltzman@condax.com', 'Stoltzman', 'Daniela', '3591178202', "1963 14-street, North Las Vegas, CA 61067");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('nhaufler@zencorporation.com', 'Haufler', 'Nicolette', '8463939610', "8010 8-street, Pittsburgh, AK 14517");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('kmyricks@groovestreet.com', 'Myricks', 'Kenneth', '510828696', "6153 14-street, Gilbert, LA 67479");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('kpatak@groovestreet.com', 'Patak', 'Karl', '3566256867', "5111 8-street, Atlanta, CO 12554");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('kbenimadho@donquadtech.com', 'Benimadho', 'Kristofer', '6809682447', "7934 17-street, Los Angeles, CA 98376");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ldevreese@sonron.com', 'Devreese', 'Lai', '2295763217', "6669 17-street, Atlanta, CO 47892");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ckippley@plussunin.com', 'Kippley', 'Carmela', '2784922561', "5750 9-street, Columbus, OH 44347");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('icaldarera@yearin.com', 'Caldarera', 'Izetta', '7165710328', "1073 3-street, Winston-Salem, AZ 07719");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ladkin@domzoom.com', 'Adkin', 'Leonida', '7423018249', "3273 13-street, Dallas, TX 20939");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ncartan@statholdings.com', 'Cartan', 'Nicolette', '5818532403', "9394 9-street, Portland, NV 78788");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('trulapaugh@yearin.com', 'Rulapaugh', 'Timothy', '8427777663', "6512 1-street, Minneapolis, OK 50531");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('bflosi@ganjaflex.com', 'Flosi', 'Beatriz', '8155072383', "9772 11-street, Jersey City, CA 06026");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('cfelger@stanredtax.com', 'Felger', 'Cristy', '2650324827', "5504 15-street, Chandler, TX 23615");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('cmorasca@ganjaflex.com', 'Morasca', 'Chantell', '4564896082', "669 18-street, Norfolk, NC 66567");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('mhoopengardner@xx-holding.com', 'Hoopengardner', 'Minna', '1148144860', "8533 19-street, San Diego, CA 20674");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('woles@codehow.com', 'Oles', 'Wilda', '7969401687', "7083 18-street, Milwaukee, NM 12696");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('vlouissant@sunnamplex.com', 'Louissant', 'Viva', '6787813627', "9677 17-street, Laredo, VA 17201");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('jdiscipio@singletechno.com', 'Discipio', 'Jolanda', '9344303290', "6649 12-street, Aurora, CA 30452");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('liturbide@dontechi.com', 'Iturbide', 'Leatha', '1251152268', "7080 10-street, Irvine, NC 28123");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ghalter@konmatfix.com', 'Halter', 'Goldie', '3935547137', "538 12-street, Chesapeake, AZ 85885");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lharabedian@plussunin.com', 'Harabedian', 'Lashaunda', '3736831230', "2367 6-street, Charlotte, NC 90090");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('arulapaugh@zencorporation.com', 'Rulapaugh', 'Alecia', '5287301786', "4782 11-street, Gilbert, LA 57524");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('cperruzza@doncon.com', 'Perruzza', 'Colette', '1854047826', "757 18-street, Denver, CO 56082");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('creitler@silis.com', 'Reitler', 'Casie', '9724575734', "9364 2-street, Santa Ana, MO 58819");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('wstockham@zotware.com', 'Stockham', 'Willodean', '7413091810', "6570 17-street, Winston-Salem, AZ 09280");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('rbourbon@lexiqvolax.com', 'Bourbon', 'Roosevelt', '2726060664', "4241 4-street, San Francisco, CA 16949");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lharoldson@rangreen.com', 'Haroldson', 'Lonny', '9234972301', "7603 5-street, Fremont, ID 52777");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('rauber@dambase.com', 'Auber', 'Raymon', '4604406661', "1900 9-street, Los Angeles, CA 08130");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('aboord@faxquote.com', 'Boord', 'Adell', '8180277826', "9664 3-street, Fort Wayne, FL 60156");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('gschnitzler@y-corporation.com', 'Schnitzler', 'Glory', '9343575232', "2762 18-street, Indianapolis, IN 83269");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('nhiatt@plexzap.com', 'Hiatt', 'Nicolette', '413614987', "6230 12-street, Kansas City, AZ 69748");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('kbreland@year-job.com', 'Breland', 'Kallie', '1443932256', "1184 11-street, Colorado Springs, NE 55106");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('iferrario@plexzap.com', 'Ferrario', 'Ilene', '3629127397', "8512 18-street, Hialeah, NV 85689");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('cyori@donware.com', 'Yori', 'Claribel', '1919774747', "598 9-street, Louisville/Jefferson County, OR 17309");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('chagele@zencorporation.com', 'Hagele', 'Claribel', '3187431843', "9115 13-street, Irving, AZ 65051");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('rtegarden@donquadtech.com', 'Tegarden', 'Rolande', '6938497826', "4370 19-street, New York, NY 78429");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('dangalich@donware.com', 'Angalich', 'Delisa', '5503754471', "4632 4-street, Las Vegas, WI 25780");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('bsengbusch@singletechno.com', 'Sengbusch', 'Beatriz', '8127198337', "3716 4-street, Pittsburgh, AK 02407");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('dseewald@goodsilron.com', 'Seewald', 'Dalene', '5329170117', "2541 20-street, Fort Wayne, FL 51178");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('lsturiale@silis.com', 'Sturiale', 'Louvenia', '9890817149', "487 12-street, Chula Vista, IN 08055");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ahusser@finhigh.com', 'Husser', 'Ammie', '4709913261', "8836 18-street, Memphis, TN 91431");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('jzurcher@domzoom.com', 'Zurcher', 'Jess', '3380280041', "4517 5-street, Jersey City, CA 25285");
    
INSERT INTO cs6400_summer2020_team022.Applicant (email, last_name, first_name, phone_number, address)
VALUES ('ebachman@goodsilron.com', 'Bachman', 'Ernie', '6559550575', "5728 9-street, El Paso, TX 90514");
   
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (1,'Katie', '2013-06-03', 'Unknown', ' is a really well-behaved pup for her age. She is a happy, friendly girl.  Sally was fou', NULL, 1, '2019-01-03','I have decided I am allergic to the animal.', 0,'edubaldi@finhigh.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (2,'Cash', '2008-12-03', 'Male', '  was found curled up in a shivering ball one frosty morning in the landscaping outside of a ', '1722217411', 1, '2019-01-03','I didn''t know that owning an animal was this expensive', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (3,'Finn', '2013-10-08', 'Male', ' After being abandoned in rural east Texas, wandered up to a home. The kind family took h', '332935780', 1, '2019-01-08','allergies are a problem', 0,'srodefer@ontomedia.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (4,'Mimi', '2016-12-14', 'Female', ' Hi I am 2 years old. I love long walks in the park and I can be a couch pot', '3359157588', 1, '2019-01-14','The animal turned 10 and you surrender the animal when it reaches that age.', 0,'cvonasek@toughzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (5,'Frankie', '2015-01-16', 'Male', ' I''m looking to to rehome my male Catahoula Leopard Dog/Mountain Cur.', '7782410366', 1, '2019-01-16','The Chihuahua is too big to travel with us since we retired.', 0,'barias@xx-holding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (6,'Midnight', '2018-09-18', 'Unknown', '  is a sweet confident girl that would love a chance to love you. Please fill out an applicati', NULL, 1, '2019-01-18','I am moving and I can''t take them with me.', 1,'cjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (7,'Millie', '2005-08-23', 'Unknown', '  is a sweet girl who would love to be in a new home for the holidays! She is 3 years old ', '9331193714', 1, '2019-01-23','didn''t realize that the animal would need so much attention', 0,'asmith@zotware.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (8,'Holly', '2016-04-24', 'Female', ' LOVES toys and has been entertaining himself in his run. But it''s so much nicer to see', '6113414225', 1, '2019-01-24','The animal turned 10 and you surrender the animal when it reaches that age.', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (9,'Bear', '2009-10-25', 'Male', ' is a fun, energetic girl who was found as a stray in south Texas.  Her owners refused ', '3103245262', 1, '2019-01-25','The animal chews and I don''t want my belongings destroyed.', 0,'barias@xx-holding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (10,'Leo', '2013-11-27', 'Male', ' Hi I am 2 years old. I love long walks in the park and I can be a couch pot', '3173249472', 1, '2019-01-28','I don''t want the dog to scratch my new floors.', 0,'cvonasek@toughzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (11,'Champ', '2012-07-29', 'Male', ' When her dad passed away in a tragic accident, she and her "brother"  found themselv', NULL, 1, '2019-01-29','didn''t realize that the animal would need so much attention', 1,'nbatman@ron-tech.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (12,'Luke', '2016-11-28', 'Male', ' is a sweetie pie! He''s very laid back and gentle with people. He walks well on ', '8445319611', 1, '2019-01-29','decided they have too many animals at home', 1,'nbatman@ron-tech.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (13,'Diesel', '2005-08-31', 'Unknown', '  is a sweet girl that loves her people once she knows you. She is an easy going gi', NULL, 1, '2019-01-31','My dogs pees on my baby.', 0,'cvonasek@toughzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (14,'Sally', '2015-04-08', 'Female', '   a beautiful Hound mix, 7 years old, and weighing 43 pounds.  ', NULL, 1, '2019-02-07','I don''t want the dog to scratch my new floors.', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (15,'Maya', '2011-04-13', 'Female', '  is a 4-year-old Boxer/Lab gal weighing 67 pounds, so of course the name is perfect. She ca', '7611859882', 1, '2019-02-12','I didn''t know that owning an animal was this expensive', 0,'dkeetch@golddex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (16,'Honey', '2011-09-14', 'Female', '  enjoys car rides and loves playing alon', '9597708012', 1, '2019-02-13','don''t like the way the dog reacted to a child', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (17,'Lulu', '2016-09-14', 'Female', ' LOVES toys and has been entertaining himself in his run. But it''s so much nicer to see', '2562552065', 1, '2019-02-14','don''t like the way the dog reacted to a child', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (18,'Elvis', '2016-02-18', 'Male', '   is a goofy, exciteable, very well trained 8 year old pug-boxer-something mix who', NULL, 0, '2019-02-18','My child moved to college and left their animal behind.', 0,'mdeleo@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (19,'Marley', '2016-02-18', 'Female', ' This beautiful girl found herself homeless just before the holidays and no', '159971955', 1, '2019-02-18','upset that the dog chewed on something or had an accident', 0,'mdeleo@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (20,'Mimi', '2015-06-20', 'Female', '  is a sweet girl who would love to be in a new home for the holidays! She is 3 years old ', '6253314653', 1, '2019-02-19','problems with the cat soiling outside the litter box', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (21,'Lilly', '2014-10-20', 'Female', '  is a 9-year-old Treeing Walker Hound, a playful boy who likes toys & like', NULL, 1, '2019-02-19','I have decided I am allergic to the animal.', 0,'lmenter@plexzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (22,'Oliver', '2015-10-21', 'Male', ' Handsome and elegant - that''s how they describe him; was found as a str', NULL, 1, '2019-02-20','problems with the cat soiling outside the litter box', 1,'srodefer@ontomedia.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (23,'Abby', '1996-12-21', 'Female', ' This gorgeous puppy; we believe that he is a Yellow Lab mixed with Siberian Husky and wh', NULL, 1, '2019-02-21','I had no idea that animals were this much work.', 1,'dmontezuma@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (24,'Lacey', '2013-05-26', 'Unknown', ' is a sweet but shy Lab/Terrier mix puppy who will be making his way to NJ o', '1324307979', 1, '2019-02-25','The animal has a behavior that I don''t want to try to work with and correct.', 0,'cvonasek@toughzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (25,'Willow', '1997-10-27', 'Female', ' This pretty girl needs a family!! Was adopted out as a puppy, but due to no fault of her o', NULL, 1, '2019-02-26','I don''t want to be responsible for the animal anymore.', 0,'cjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (26,'Honey', '2008-11-01', 'Female', ' Our girl may look like a plain little black dog but she is anything but ordinary!  Th', NULL, 1, '2019-03-04','The animal has had (puppies/kittens) and I don''t know how that happened and I don''t want them anymore.', 0,'cvonasek@toughzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (27,'Marley', '1998-06-12', 'Female', ' is a super sweet boxer/dane mix!  He came from a rural animal contro', NULL, 1, '2019-03-13','Landlord won''t let me keep the animal.', 0,'dmontezuma@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (28,'Phoebe', '2005-03-13', 'Unknown', '  was adopted from us when he was 2 months old.  He was just returned because they do', '447698661', 1, '2019-03-14','the pet sheds too much', 1,'mo@burdell.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (29,'Hazel', '1997-03-17', 'Female', ' This gorgeous girl hails from Puerto Rico. She is a 3-year-old P', '9544917421', 1, '2019-03-18','The dog barks too much or the cat meows too much.', 0,'dmontezuma@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (30,'Emma', '2011-10-19', 'Female', '  was rescued after she gave birth under a house in rural Texas. She''d been living on the ', NULL, 1, '2019-03-20','don''t know how to handle the animal''s medical needs', 0,'mdeleo@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (31,'Duke', '2009-04-26', 'Male', ' is such a doll! She was recently rescued from euthanasia in a Texas shelt', NULL, 1, '2019-03-27','haven''t thought about any other options', 0,'tmarrier@hottechi.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (32,'Minnie', '2015-05-27', 'Female', '  was found curled up in a shivering ball one frosty morning in the landscaping outside of a ', '4142103190', 1, '2019-03-28','The animal turned 10 and you surrender the animal when it reaches that age.', 0,'dmontezuma@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (33,'Cooper', '2013-11-27', 'Male', ' is a fun, energetic girl who was found as a stray in south Texas.  Her owners refused ', NULL, 1, '2019-03-29','upset that the dog bit somebody', 0,'srodefer@ontomedia.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (34,'Luna', '2016-09-29', 'Female', '  enjoys car rides and loves playing alon', '8686396700', 1, '2019-04-01','I need to surrender my dog because I just had my carpets cleaned.', 1,'gmatuszak@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (35,'Sydney', '2018-12-01', 'Female', ' Meet a handsome black Lab mix who''s almost 5 years old', NULL, 1, '2019-04-02','The animal attacks me and my family.', 0,'barias@xx-holding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (36,'Ruby', '2011-07-03', 'Female', ' is a handsome 3 1/2 year old Shepherd mix. He is good with other dogs.  He would do', '624367218', 1, '2019-04-03','My child went to jail and I don''t want their animal.', 0,'vmenter@silis.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (37,'Jake', '2002-02-02', 'Male', '  If you''re looking for a sporty new best friend to hang out with, this is your guy', '6850378225', 1, '2019-04-04','My dogs pees on my baby.', 0,'smaclead@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (38,'Bandit', '2018-04-04', 'Male', ' When their dad passed away in a tragic accident, he and his "sister"  ', '4018693437', 1, '2019-04-05','didn''t know the cat would sleep all day', 0,'mmallett@konex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (39,'Jackson', '2012-02-09', 'Male', '  came to rescue in a starved state. Despite this, she has so much love to give. She g', NULL, 1, '2019-04-11','The dog barks too much or the cat meows too much.', 0,'barias@xx-holding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (40,'Bentley', '2018-06-14', 'Male', '   is a loving, young, playful bundle of joy & energy who would love to find herself ', NULL, 1, '2019-04-15','I have decided that my family is allergic to the animal.', 0,'nbatman@ron-tech.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (41,'Champ', '2016-11-13', 'Male', ' Meet this beautiful Carolina Dog mix has the biggest, cutest, pointy ears.  She ', '1237604775', 1, '2019-04-15','I need to surrender my dog because it chewed my sprinkler heads.', 0,'jsweely@fasehatice.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (42,'Gigi', '2000-02-14', 'Female', ' This adorable boy is Tango Barnwell.  He wou', NULL, 1, '2019-04-16','upset that the dog chewed on something or had an accident', 0,'mo@burdell.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (43,'Charlie', '2016-06-16', 'Female', ' is a stunning girl who was adopted from Eleventh Hour Rescue a few years ago but was recen', NULL, 1, '2019-04-17','I don''t want the dog to scratch my new floors.', 0,'smaclead@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (44,'Chester', '2014-09-16', 'Male', ' is a beautiful 2-year-old Border Collie/Lab mix weighing 55 lbs. who was rescued from a hoard', NULL, 1, '2019-04-18','My doctor told me that the cat will suck the life out of my newborn baby.', 0,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (45,'Lucky', '2014-10-18', 'Female', ' This gorgeous boy is a Saint Bernard mix. He is', '7168262500', 1, '2019-04-19','I don''t want to be responsible for the animal anymore.', 0,'cvonasek@toughzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (46,'Riley', '2015-08-23', 'Female', '  is a 4-year-old Boxer/Lab gal weighing 67 pounds, so of course the name is perfect. She ca', NULL, 1, '2019-04-24','moving and don''t want to take the dog along', 1,'dmontezuma@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (47,'Oliver', '2003-03-01', 'Male', ' This gorgeous boy is a Saint Bernard mix. He is', '9131352554', 1, '2019-05-01','I told my dying family member that I would care for their animal after they died to make them feel better, but I really don''t want the animal so I am surrendering it to you.', 0,'mmallett@konex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (48,'Madison', '2014-11-29', 'Female', '  is in foster and here''s what her foster has to say: Meet the most lovable, frie', '601033509', 1, '2019-05-01','I don''t want the dog to scratch my new floors.', 0,'nbatman@ron-tech.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (49,'Marley', '2013-01-05', 'Female', '  along with his littermates and mom, was rescued from euthanasia a', '2202768589', 1, '2019-05-08','"My cat is a w***e, she keeps getting pregnant by the neighbor''s cat and the babies keep dying. This is the third time and I am done with this!"', 0,'mmallett@konex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (50,'Annie', '2009-03-09', 'Female', ' was homeless and roaming the streets which eventually led to his being picked-up', NULL, 1, '2019-05-10','The animal doesn''t match my new furniture.', 0,'sahle@treequote.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (51,'Midnight', '1997-05-09', 'Unknown', '  is so smart and curious too.  She''s becoming a TV binge watching c', NULL, 1, '2019-05-10','"My cat is a w***e, she keeps getting pregnant by the neighbor''s cat and the babies keep dying. This is the third time and I am done with this!"', 0,'cjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (52,'Louie', '2004-02-12', 'Male', ' he has had a hard start to his life! This little blue nose nugget of wiggles was scheduled ', NULL, 1, '2019-05-14','"My cat is a w***e, she keeps getting pregnant by the neighbor''s cat and the babies keep dying. This is the third time and I am done with this!"', 0,'barias@xx-holding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (53,'Cleo', '2016-01-13', 'Female', ' is a ball-chasing, attention-loving, breathtakingly gorgeous boy.  A perfect day', '5395133308', 1, '2019-05-15','I need to surrender my dog because it chewed my sprinkler heads.', 1,'asmith@zotware.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (54,'Piper', '2018-05-15', 'Unknown', '  is in foster and here''s what her foster has to say: Meet the most lovable, frie', '3406020447', 1, '2019-05-16','I didn''t know I adopted a boy/girl animal.', 0,'cjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (55,'Brady', '2015-02-13', 'Unknown', ' came to us with an injury to her skin on her back. She looks like someone burned her. She ', NULL, 1, '2019-05-16','I don''t have time for the animal.', 0,'kmunns@yearin.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (56,'Moose', '2017-01-18', 'Male', ' was a stray who found his way to Rescue.  He is a senior guy but acts an', NULL, 1, '2019-05-21','The animal doesn''t match my new furniture.', 0,'sahle@treequote.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (57,'Roxie', '2018-09-20', 'Female', ' is a sweet girl who was separated from her litter after having to have a lifesaving blood tr', '3822482038', 1, '2019-05-22','I have decided that my family is allergic to the animal.', 0,'fcrupi@rangreen.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (58,'Oscar', '2016-05-26', 'Male', '   is a loving, young, playful bundle of joy & energy who would love to find herself ', '2020593158', 1, '2019-05-27','don''t like the way the dog reacted to a child', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (59,'Penny', '2019-03-31', 'Female', ' is a big mush of a dog that enjoys the attention of people and smiles from ear to ear when you', '6282761749', 1, '2019-05-31','I "Found" the animal.', 0,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (60,'Elvis', '2003-02-03', 'Male', ' We don''t know what happened to him before he arrived', '3168256198', 1, '2019-06-05','I got a new house and don''t want it.', 1,'lmenter@plexzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (61,'Blue', '2011-09-05', 'Male', ' If you''re looking for a "no brainer", check out this girl. She is a really E', NULL, 1, '2019-06-06','The animal turned 10 and you surrender the animal when it reaches that age.', 0,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (62,'Bentley', '2013-11-04', 'Male', '  is a very loving and affectionate 5 1/2 year old dog who is great with adults but he ha', '5365023748', 1, '2019-06-06','My doctor told me that the cat will suck the life out of my newborn baby.', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (63,'Maggie', '1998-03-10', 'Female', ' Looking for a happy, silly, sweet & funny pup?  Check out her as she is all these and m', '4484362295', 1, '2019-06-10','don''t know how to handle the animal''s medical needs', 0,'dkeetch@golddex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (64,'Cooper', '2005-05-12', 'Male', '    has the floppiest ears and the saddest eyes, but ', '6210978022', 1, '2019-06-12','The dog barks too much or the cat meows too much.', 0,'lmenter@plexzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (65,'Loki', '1998-08-13', 'Male', '  was being given away for free on a neighborhood site in Texas because a child in the home w', '1761032421', 1, '2019-06-14','problems with the cat soiling outside the litter box', 1,'kmunns@yearin.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (66,'Champ', '1999-06-14', 'Unknown', '  was rescued from a kill shelter and is the sweetest thing ever. Just wants to be loved', NULL, 1, '2019-06-14','The animal has had (puppies/kittens) and I don''t know how that happened and I don''t want them anymore.', 1,'jsweely@fasehatice.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (67,'Zoey', '2014-07-17', 'Female', '  We are looking for a home for our dog . He was born in December of 2015', '9185107913', 1, '2019-06-17','The animal attacks me and my family.', 0,'nbatman@ron-tech.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (68,'Joey', '2016-07-17', 'Male', ' This beautiful boy  was adopted out as a puppy to a loving couple but recently has c', NULL, 1, '2019-06-18','upset that the dog bit somebody', 0,'walbares@conecom.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (69,'Charlie', '2013-12-19', 'Female', ' is a 15 week old Lab mix weighing 9 pounds who lives up to her name with the', '2075926640', 1, '2019-06-20','"My cat is a w***e, she keeps getting pregnant by the neighbor''s cat and the babies keep dying. This is the third time and I am done with this!"', 1,'sjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (70,'Annie', '2014-12-24', 'Female', '   is an 8 year old Pointer mix who is looking for a place to spend his golden years. This ha', NULL, 1, '2019-06-25','The animal turned 10 and you surrender the animal when it reaches that age.', 1,'fcrupi@rangreen.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (71,'Blue', '1998-12-30', 'Male', '  needs a new home ASAP as the landlord says he has to go!! Here is what his mom say', '4648672566', 1, '2019-07-01','I need to surrender my dog because it chewed my sprinkler heads.', 0,'walbares@conecom.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (72,'Beau', '2010-09-02', 'Male', '  is a very loving and affectionate 5 1/2 year old dog who is great with adults but he ha', '4741762601', 1, '2019-07-04','The kitten opened the refrigerator and ruined $200.00 in food.', 0,'kmunns@yearin.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (73,'Holly', '2009-09-06', 'Female', ' was homeless and roaming the streets which eventually led to his being picked-up', NULL, 1, '2019-07-08','My child went to jail and I don''t want their animal.', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (74,'Bubba', '2007-11-07', 'Unknown', '  is a friendly handsome boy that needs his forever home. Please fill out an application a', '3432397581', 1, '2019-07-09','The dog barks too much or the cat meows too much.', 0,'jsweely@fasehatice.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (75,'Joey', '2006-08-10', 'Male', '  is a 9-year-old Treeing Walker Hound, a playful boy who likes toys & like', '346401730', 1, '2019-07-11','the pet sheds too much', 0,'edubaldi@finhigh.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (76,'Harley', '2016-06-09', 'Male', ' Meet this beautiful Carolina Dog mix has the biggest, cutest, pointy ears.  She ', NULL, 1, '2019-07-11','I "Found" the animal.', 0,'walbares@conecom.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (77,'Harley', '2015-12-11', 'Unknown', '  was adopted from us when he was 2 months old.  He was just returned because they do', '8262987496', 1, '2019-07-12','The animal has had (puppies/kittens) and I don''t know how that happened and I don''t want them anymore.', 0,'lmenter@plexzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (78,'Marley', '2008-09-13', 'Female', '   I''m an absolute awesome dog and I love all people. My foster says I have', NULL, 1, '2019-07-15','I am going to have a child and don''t want the animal anymore.', 0,'sjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (79,'Bonnie', '2019-05-16', 'Female', '  along with his littermates and mom, was rescued from euthanasia a', '231531255', 1, '2019-07-16','don''t have time for the dog anymore', 0,'sjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (80,'Sugar', '2018-01-15', 'Female', ' is a beautiful 2-year-old Border Collie/Lab mix weighing 55 lbs. who was rescued from a hoard', '607362081', 1, '2019-07-17','I didn''t know I adopted a boy/girl animal.', 0,'smaclead@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (81,'Bonnie', '2014-03-19', 'Female', '  We are looking for a home for our dog . He was born in December of 2015', '8410783889', 1, '2019-07-19','haven''t thought about any other options', 1,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (82,'Boomer', '2018-04-21', 'Male', '  loves to run and play! She gives the best hugs, and she also high fives and gives a firm ha', NULL, 1, '2019-07-22','The animal has had (puppies/kittens) and I don''t know how that happened and I don''t want them anymore.', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (83,'Annie', '2009-03-22', 'Female', '  was rescued after she gave birth under a house in rural Texas. She''d been living on the ', '2684737194', 1, '2019-07-23','I have decided that my family is allergic to the animal.', 0,'fcrupi@rangreen.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (84,'Piper', '2014-10-22', 'Female', ' From his owner:  Please help me find a new home for my dog , an 8 year old German Sh', NULL, 1, '2019-07-23','My dogs pees on my baby.', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (85,'Sally', '1998-04-23', 'Female', '  is a 9-year-old Treeing Walker Hound, a playful boy who likes toys & like', '47708228', 1, '2019-07-24','My child went to jail and I don''t want their animal.', 0,'jsweely@fasehatice.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (86,'Bandit', '2010-09-23', 'Male', ' Meet a handsome black Lab mix who''s almost 5 years old', NULL, 1, '2019-07-25','can''t or don''t want to handle the costs of the pet''s needs', 0,'mdeleo@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (87,'Macy', '2013-10-28', 'Female', ' Meet a handsome black Lab mix who''s almost 5 years old', '9360975341', 1, '2019-07-30','the pet sheds too much', 0,'gmatuszak@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (88,'Cash', '2006-02-28', 'Male', ' would be a wonderful addition to your family as long as she''s the only fur', NULL, 1, '2019-07-31','I didn''t know that owning an animal was this expensive', 0,'gmatuszak@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (89,'Sheldon', '1997-03-31', 'Unknown', '  is an adorable boy that is friendly and does very well with other cats. If interested please', '4270076427', 1, '2019-08-01','I didn''t know that owning an animal was this expensive', 0,'mdeleo@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (90,'Brutus', '2014-09-01', 'Male', ' she was being given away in the back of a gas station in a rural Texas town when one of our', NULL, 1, '2019-08-02','I didn''t know that owning an animal was this expensive', 0,'dmontezuma@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (91,'Sassy', '2006-04-02', 'Female', ' is a 15 week old Lab mix weighing 9 pounds who lives up to her name with the', NULL, 1, '2019-08-02','I don''t want to be responsible for the animal anymore.', 0,'lmenter@plexzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (92,'Athena', '1997-08-06', 'Female', '  is a 4-year-old Boxer/Lab gal weighing 67 pounds, so of course the name is perfect. She ca', '6159881717', 1, '2019-08-07','think the dog is too hyper', 0,'sahle@treequote.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (93,'Mac', '2014-07-07', 'Male', ' would be a wonderful addition to your family as long as she''s the only fur', NULL, 1, '2019-08-07','having ''personal problems''', 0,'nbatman@ron-tech.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (94,'Lexi', '2010-01-12', 'Female', ' Looking for a wonderful family pet? Please check out this pup with the wagging tail, he''d be s', '9310470281', 1, '2019-08-14','moving and don''t want to take the dog along', 0,'vmenter@silis.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (95,'Ella', '2016-02-13', 'Unknown', '  I''m trying to find a home for a dog,  who I rescued from a trail', NULL, 1, '2019-08-15','think the dog is too hyper', 1,'srodefer@ontomedia.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (96,'Brady', '1997-06-15', 'Male', '  enjoys car rides and loves playing alon', NULL, 1, '2019-08-16','decided they have too many animals at home', 0,'sjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (97,'Lucky', '2015-11-18', 'Female', ' is an adorable dog with a classic Bulldog face.  He was pulled from a high kill shelter ', NULL, 1, '2019-08-19','problems with the cat soiling outside the litter box', 0,'dmontezuma@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (98,'Mocha', '2006-03-20', 'Unknown', ' is a senior boy, 11-12 years old, the life he led before being rescued was filled ', '287101747', 1, '2019-08-20','having ''personal problems''', 1,'sjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (99,'Ace', '2017-07-21', 'Male', ' was a stray who found his way to Rescue.  He is a senior guy but acts an', NULL, 1, '2019-08-21','My child moved to college and left their animal behind.', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (100,'Cleo', '2017-07-27', 'Unknown', ' This gorgeous boy is a Saint Bernard mix. He is', NULL, 1, '2019-08-27','I don''t want the dog to scratch my new floors.', 0,'fcrupi@rangreen.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (101,'Marley', '2013-09-26', 'Female', ' We don''t know what happened to him before he arrived', NULL, 1, '2019-08-28','I have decided I am allergic to the animal.', 0,'smaclead@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (102,'Shadow', '1999-01-28', 'Female', '  was rescued after she gave birth under a house in rural Texas. She''d been living on the ', NULL, 1, '2019-08-29','problems with the cat soiling outside the litter box', 0,'gmatuszak@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (103,'Grace', '2010-10-02', 'Female', ' he has had a hard start to his life! This little blue nose nugget of wiggles was scheduled ', '7588184201', 1, '2019-09-02','I need to surrender my dog because I just had my carpets cleaned.', 1,'mdeleo@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (104,'Ginger', '2016-11-04', 'Female', '  I came from a shelter that euthanizes over a hundred animals a week. I turned on', '9563679426', 1, '2019-09-05','didn''t know the cat would sleep all day', 0,'smaclead@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (105,'Jake', '2000-05-06', 'Male', ' Have you been looking for a Labrador Retriever to join your family? Labs have such great, goofy, c', '9182621865', 1, '2019-09-06','The animal pooped/peed on the floor.', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (106,'Lily', '2004-05-09', 'Female', ' is a super sweet boxer/dane mix!  He came from a rural animal contro', NULL, 1, '2019-09-09','haven''t thought about any other options', 0,'mo@burdell.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (107,'Beau', '2010-10-10', 'Male', '   a beautiful Hound mix, 7 years old, and weighing 43 pounds.  ', NULL, 1, '2019-09-10','having ''personal problems''', 1,'sahle@treequote.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (108,'Gracie', '2018-05-14', 'Female', '  was being given away for free on a neighborhood site in Texas because a child in the home w', NULL, 1, '2019-09-13','The animal has a behavior that I don''t want to try to work with and correct.', 0,'asmith@zotware.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (109,'Casey', '2014-10-19', 'Female', '  along with his littermates and mom, was rescued from euthanasia a', '7438950778', 1, '2019-09-19','I got a new house and don''t want it.', 0,'mdeleo@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (110,'Olive', '2013-04-26', 'Unknown', ' is a very friendly and energetic Rottweiler mix who is7 years old & weighs 59', '4230427909', 1, '2019-09-26','having ''personal problems''', 0,'sahle@treequote.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (111,'Sally', '2017-10-25', 'Female', ' Our girl may look like a plain little black dog but she is anything but ordinary!  Th', '9044340249', 1, '2019-09-26','don''t know how to handle the animal''s medical needs', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (112,'Brody', '1999-03-02', 'Male', '  is a 4-year-old Boxer/Lab gal weighing 67 pounds, so of course the name is perfect. She ca', '4922077392', 1, '2019-10-01','don''t know how to handle the animal''s medical needs', 0,'tmarrier@hottechi.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (113,'Chico', '2006-08-06', 'Male', ' is a very friendly and energetic Rottweiler mix who is7 years old & weighs 59', NULL, 1, '2019-10-07','haven''t thought about any other options', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (114,'Lola', '2007-01-06', 'Female', ' Meet  a sweet-as-pie Brindle/Blue Nose Pit Bull who needs a new place to live', '7638227325', 1, '2019-10-07','having ''personal problems''', 0,'gmatuszak@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (115,'Cali', '2015-03-08', 'Female', ' has quite a resume.  He has graduated Basic I Obedience, Basic II Obedience, learned ', '7289416436', 1, '2019-10-08','My dogs pees on my baby.', 0,'mdeleo@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (116,'Sally', '2014-05-09', 'Female', ' This adorable boy is Tango Barnwell.  He wou', '506467113', 1, '2019-10-09','I had no idea that animals were this much work.', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (117,'Shelby', '2014-09-08', 'Female', '  along with his littermates and mom, was rescued from euthanasia a', NULL, 1, '2019-10-09','don''t know how to handle the animal''s medical needs', 0,'cjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (118,'George', '2016-07-09', 'Male', ' When their dad passed away in a tragic accident, he and his "sister"  ', '845103394', 1, '2019-10-10','I don''t have time for the animal.', 0,'vmenter@silis.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (119,'Gus', '2004-12-09', 'Male', '  was recently rescued from euthanasia at a Texas shelter. She has the sweetest face!  I', NULL, 1, '2019-10-10','I don''t want to be responsible for the animal anymore.', 0,'nbatman@ron-tech.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (120,'Chico', '2011-04-14', 'Male', '   is a goofy, exciteable, very well trained 8 year old pug-boxer-something mix who', '4592937345', 1, '2019-10-14','upset that the dog bit somebody', 0,'kmunns@yearin.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (121,'Emma', '1997-11-15', 'Female', '  is a 9-year-old Treeing Walker Hound, a playful boy who likes toys & like', '5968663850', 1, '2019-10-16','The animal pooped/peed on the floor.', 0,'nbatman@ron-tech.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (122,'Lilly', '2016-07-16', 'Female', ' Our girl may look like a plain little black dog but she is anything but ordinary!  Th', '2033815869', 1, '2019-10-17','I got a new house and don''t want it.', 0,'barias@xx-holding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (123,'Sally', '2015-09-24', 'Female', ' When their dad passed away in a tragic accident, he and his "sister"  ', '7107074830', 1, '2019-10-25','I am moving and I can''t take them with me.', 0,'mmallett@konex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (124,'Pebbles', '1999-02-26', 'Female', '   Meet a 3 month old cuddly, lovable Terrier mix.  He was dumped in', '7444632749', 1, '2019-10-28','I need to surrender my dog because I just had my carpets cleaned.', 0,'walbares@conecom.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (125,'Nikki', '2015-12-31', 'Female', ' This gorgeous puppy; we believe that he is a Yellow Lab mixed with Siberian Husky and wh', '9507138642', 1, '2019-11-01','Landlord won''t let me keep the animal.', 0,'barias@xx-holding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (126,'Oreo', '2018-02-02', 'Male', '  Look at that underbite!!! he is a 3 1/2 year old Terrier mix. He was in a home for a couple y', '3076676382', 1, '2019-11-04','The animal chews and I don''t want my belongings destroyed.', 0,'smaclead@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (127,'Piper', '2015-03-08', 'Female', '  was adopted from us when he was 2 months old.  He was just returned because they do', NULL, 1, '2019-11-07','The animal chews and I don''t want my belongings destroyed.', 0,'lmenter@plexzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (128,'Brandy', '2012-04-11', 'Female', '  was recently rescued from euthanasia at a Texas shelter. She has the sweetest face!  I', NULL, 1, '2019-11-11','The animal has a behavior that I don''t want to try to work with and correct.', 0,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (129,'Dakota', '2006-08-11', 'Female', ' is a stunning girl who was adopted from Eleventh Hour Rescue a few years ago but was recen', '5869537559', 1, '2019-11-11','I told my dying family member that I would care for their animal after they died to make them feel better, but I really don''t want the animal so I am surrendering it to you.', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (130,'Max', '2018-09-11', 'Male', ' Meet  a sweet-as-pie Brindle/Blue Nose Pit Bull who needs a new place to live', NULL, 1, '2019-11-12','I got a new house and don''t want it.', 0,'cvonasek@toughzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (131,'Leo', '2015-12-13', 'Male', ' she was being given away in the back of a gas station in a rural Texas town when one of our', '1968472390', 1, '2019-11-13','The animal has had (puppies/kittens) and I don''t know how that happened and I don''t want them anymore.', 0,'nbatman@ron-tech.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (132,'Cleo', '1998-03-16', 'Female', ' would be a wonderful addition to your family as long as she''s the only fur', NULL, 1, '2019-11-15','I am moving and I can''t take them with me.', 0,'kmunns@yearin.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (133,'Bo', '2013-09-17', 'Male', ' is a 12-week-old Black Cur mix pup who got adopted and who thought he had found his fo', '1459461853', 1, '2019-11-18','The animal doesn''t match my new furniture.', 0,'kmunns@yearin.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (134,'Benny', '2007-07-19', 'Male', ' was homeless and roaming the streets which eventually led to his being picked-up', '8683087184', 1, '2019-11-18','decided they have too many animals at home', 0,'asmith@zotware.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (135,'Honey', '2008-02-18', 'Female', ' has quite a resume.  He has graduated Basic I Obedience, Basic II Obedience, learned ', NULL, 1, '2019-11-19','I don''t want the dog to scratch my new floors.', 0,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (136,'Ace', '1999-10-20', 'Male', ' When her dad passed away in a tragic accident, she and her "brother"  found themselv', '8406288680', 1, '2019-11-20','I didn''t know that owning an animal was this expensive', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (137,'Athena', '2010-04-20', 'Female', '  is a two and a half old and such a sweetheart.   loves the car and likes ', '8855820847', 1, '2019-11-20','decided they have too many animals at home', 0,'dmontezuma@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (138,'Elvis', '2016-04-21', 'Male', '  is a very loving and affectionate 5 1/2 year old dog who is great with adults but he ha', '1588289273', 1, '2019-11-21','I didn''t know that owning an animal was this expensive', 0,'mmallett@konex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (139,'Roxie', '2008-10-21', 'Female', ' If you''re looking for a "no brainer", check out this girl. She is a really E', NULL, 1, '2019-11-22','The animal chews and I don''t want my belongings destroyed.', 1,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (140,'Leo', '2010-03-23', 'Male', ' has quite a resume.  He has graduated Basic I Obedience, Basic II Obedience, learned ', '8995897848', 1, '2019-11-22','The dog barks too much or the cat meows too much.', 0,'sahle@treequote.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (141,'Marley', '1999-05-03', 'Female', ' Looking for a happy, silly, sweet & funny pup?  Check out her as she is all these and m', '2929126033', 1, '2019-12-02','I have decided that my family is allergic to the animal.', 0,'asmith@zotware.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (142,'Abby', '2018-04-03', 'Female', ' This sweet brindle boy with the crooked smile is Whopper. He''s such a good boy - playful,', '7321356173', 1, '2019-12-03','decided they have too many animals at home', 0,'gmatuszak@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (143,'Lexie', '2008-12-02', 'Unknown', ' Looking for a happy, silly, sweet & funny pup?  Check out her as she is all these and m', NULL, 1, '2019-12-03','renovating the house or redoing the yard', 0,'barias@xx-holding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (144,'Lady', '2010-04-05', 'Unknown', '  was a service dog for an elderly man who recently passed away. Now this boy needs a new home', '5556057839', 1, '2019-12-05','My two dogs, who are brother and sister, keep having litters of puppies.', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (145,'Cash', '2012-09-08', 'Male', ' Looking for a happy, silly, sweet & funny pup?  Check out her as she is all these and m', '4353377498', 1, '2019-12-10','don''t like the way the dog reacted to a child', 0,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (146,'Boomer', '2006-01-11', 'Male', ' she was being given away in the back of a gas station in a rural Texas town when one of our', NULL, 1, '2019-12-12','decided they have too many animals at home', 0,'sjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (147,'Milo', '2016-04-12', 'Male', ' he has had a hard start to his life! This little blue nose nugget of wiggles was scheduled ', NULL, 1, '2019-12-13','allergies are a problem', 0,'nbatman@ron-tech.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (148,'Izzy', '2006-01-15', 'Female', ' I''m a good-looking Redbone with big soulful eyes (so I''m told) who&', '7047413542', 1, '2019-12-16','I "Found" the animal.', 0,'dkeetch@golddex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (149,'Buddy', '2005-06-17', 'Male', ' he has had a hard start to his life! This little blue nose nugget of wiggles was scheduled ', '6072982334', 1, '2019-12-18','having ''personal problems''', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (150,'Lacey', '2017-03-20', 'Female', ' is a super sweet boxer/dane mix!  He came from a rural animal contro', '4793706812', 1, '2019-12-20','I don''t want the dog to scratch my new floors.', 0,'mo@burdell.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (151,'Bruno', '2017-12-23', 'Unknown', ' is beautiful and sweet.  Loves to play and eat.  A little shy and independent.', '169698559', 1, '2019-12-24','the pet sheds too much', 1,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (152,'Olive', '2009-06-24', 'Female', '  was dumped at a mailbox in rural Texas; is a sweet shy girl  w', '936657565', 1, '2019-12-25','The animal has had (puppies/kittens) and I don''t know how that happened and I don''t want them anymore.', 0,'smaclead@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (153,'Bear', '2015-10-25', 'Male', ' is a handsome 3 1/2 year old Shepherd mix. He is good with other dogs.  He would do', NULL, 1, '2019-12-25','I am moving and I can''t take them with me.', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (154,'Milo', '2007-10-26', 'Male', '  is a 1 year old Terrier mix! He is walks well on a leash and loves affection. He would prefer', NULL, 1, '2019-12-26','The animal turned 10 and you surrender the animal when it reaches that age.', 0,'dmontezuma@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (155,'Misty', '2004-01-29', 'Unknown', ' Handsome and elegant - that''s how they describe him; was found as a str', NULL, 1, '2019-12-30','I don''t want to be responsible for the animal anymore.', 0,'dkeetch@golddex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (156,'Chance', '2017-09-30', 'Male', ' would be a wonderful addition to your family as long as she''s the only fur', '7463414892', 1, '2019-12-31','haven''t thought about any other options', 1,'mo@burdell.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (157,'Riley', '1997-12-01', 'Female', ' I''m looking to to rehome my male Catahoula Leopard Dog/Mountain Cur.', '8180781419', 1, '2020-01-01','The animal attacks me and my family.', 0,'jsweely@fasehatice.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (158,'Jackson', '1999-03-04', 'Male', ' Meet a handsome black Lab mix who''s almost 5 years old', NULL, 1, '2020-01-03','My two dogs, who are brother and sister, keep having litters of puppies.', 1,'gmatuszak@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (159,'Roxy', '2017-04-07', 'Female', '  is a very loving and affectionate 5 1/2 year old dog who is great with adults but he ha', '5944042237', 1, '2020-01-07','I need to surrender my dog because it chewed my sprinkler heads.', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (160,'Maya', '2000-12-09', 'Female', ' Looking for a wonderful family pet? Please check out this pup with the wagging tail, he''d be s', '2020876706', 1, '2020-01-10','The animal attacks my other animals.', 0,'sahle@treequote.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (161,'Max', '2012-10-15', 'Male', '   is a goofy, exciteable, very well trained 8 year old pug-boxer-something mix who', NULL, 1, '2020-01-16','don''t like the way the dog reacted to a child', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (162,'Brandy', '2017-02-20', 'Female', '   I''m an absolute awesome dog and I love all people. My foster says I have', '734163028', 1, '2020-01-22','I didn''t know I adopted a boy/girl animal.', 0,'lmenter@plexzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (163,'Gizmo', '2006-05-23', 'Male', '  is a loving, snuggly girl who loves long walks and going for car rides but she''s als', '9511448238', 1, '2020-01-22','I have decided that my family is allergic to the animal.', 0,'gmatuszak@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (164,'Champ', '2013-10-23', 'Male', ' has quite a resume.  He has graduated Basic I Obedience, Basic II Obedience, learned ', '7681306976', 1, '2020-01-23','Landlord won''t let me keep the animal.', 0,'barias@xx-holding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (165,'Scout', '2014-02-03', 'Unknown', ' This beautiful boy  was adopted out as a puppy to a loving couple but recently has c', '1712461229', 1, '2020-02-04','The animal pooped/peed on the floor.', 1,'edubaldi@finhigh.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (166,'Marley', '2019-07-13', 'Male', ' When their dad passed away in a tragic accident, he and his "sister"  ', '8069469232', 1, '2020-02-12','My doctor told me that the cat will suck the life out of my newborn baby.', 0,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (167,'Katie', '2016-12-13', 'Female', '   a beautiful Hound mix, 7 years old, and weighing 43 pounds.  ', NULL, 1, '2020-02-13','don''t know how to handle the animal''s medical needs', 1,'gmatuszak@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (168,'Pebbles', '2018-08-18', 'Female', '   is a 3 year old Lab mix who loves people.  She is currently living with 2 children', NULL, 1, '2020-02-17','My doctor told me that the cat will suck the life out of my newborn baby.', 0,'kmunns@yearin.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (169,'Winnie', '2015-06-19', 'Female', ' Meet Louie, originally named Jellybean for his love of candy and sweet disposition. He was adopted', NULL, 1, '2020-02-18','I have decided that my family is allergic to the animal.', 1,'smaclead@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (170,'Benji', '2010-08-20', 'Male', ' is a sweetie pie! He''s very laid back and gentle with people. He walks well on ', NULL, 1, '2020-02-19','The animal chews and I don''t want my belongings destroyed.', 0,'lmenter@plexzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (171,'Layla', '2006-05-29', 'Female', ' ended up at an animal shelter as a stray and that''s where our rescuer discovered this un', '1617929290', 1, '2020-02-28','don''t know how to handle the animal''s medical needs', 0,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (172,'Elvis', '2003-12-29', 'Male', ' he has had a hard start to his life! This little blue nose nugget of wiggles was scheduled ', '2801951418', 1, '2020-02-28','think the dog is too hyper', 1,'walbares@conecom.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (173,'Baxter', '1999-09-01', 'Male', ' was recently diagnosed with glaucoma and required surgery to remove both eyes. :( Consi', NULL, 1, '2020-03-02','I have decided I am allergic to the animal.', 0,'cjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (174,'Sierra', '2013-08-03', 'Female', '  I came from a shelter that euthanizes over a hundred animals a week. I turned on', NULL, 1, '2020-03-04','I have decided that my family is allergic to the animal.', 0,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (175,'Benji', '2012-06-03', 'Male', ' has quite a resume.  He has graduated Basic I Obedience, Basic II Obedience, learned ', NULL, 1, '2020-03-04','haven''t thought about any other options', 0,'srodefer@ontomedia.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (176,'Holly', '2005-12-05', 'Female', ' this boy and his siblings were being given away in a Walmart parking lot in Texas right before the ne', '9684801212', 1, '2020-03-06','upset that the dog bit somebody', 0,'tmarrier@hottechi.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (177,'Max', '2008-10-09', 'Unknown', ' is super friendly and loves other cats', '7476386818', 1, '2020-03-10','the pet sheds too much', 0,'cjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (178,'Duke', '2007-06-18', 'Male', ' Meet  a sweet-as-pie Brindle/Blue Nose Pit Bull who needs a new place to live', NULL, 1, '2020-03-18','the pet sheds too much', 0,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (179,'Cleo', '2020-03-19', 'Unknown', ' Have you been looking for a Labrador Retriever to join your family? Labs have such great, goofy, c', '566618980', 1, '2020-03-19','The animal chews and I don''t want my belongings destroyed.', 0,'cvonasek@toughzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (180,'Cocoa', '2013-03-24', 'Female', ' is a very friendly and energetic Rottweiler mix who is7 years old & weighs 59', '9255463784', 1, '2020-03-24','upset that the dog chewed on something or had an accident', 1,'rdiestel@goodsilron.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (181,'Millie', '2017-06-24', 'Unknown', ' LOVES toys and has been entertaining himself in his run. But it''s so much nicer to see', '7044703794', 1, '2020-03-25','The animal has a behavior that I don''t want to try to work with and correct.', 0,'walbares@conecom.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (182,'Max', '2018-04-25', 'Male', ' he has had a hard start to his life! This little blue nose nugget of wiggles was scheduled ', NULL, 1, '2020-03-26','don''t have time for the dog anymore', 0,'dkeetch@golddex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (183,'Chance', '2014-12-25', 'Male', '  is a wonderful family member.  He is 13 years old and has been with ', '1271437267', 1, '2020-03-26','I have decided that my family is allergic to the animal.', 1,'dkeetch@golddex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (184,'Copper', '2013-10-26', 'Male', ' How could you resist that face! he is a 3 year old stocky little boy who loves attention. ', '2305374321', 1, '2020-03-27','The animal attacks me and my family.', 0,'jsweely@fasehatice.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (185,'Bubba', '2003-03-31', 'Male', '   is a 3 year old Lab mix who loves people.  She is currently living with 2 children', '4376976102', 1, '2020-03-31','The animal attacks my other animals.', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (186,'Sandy', '2011-06-02', 'Female', ' is a fun, energetic girl who was found as a stray in south Texas.  Her owners refused ', NULL, 1, '2020-04-02','"My cat is a w***e, she keeps getting pregnant by the neighbor''s cat and the babies keep dying. This is the third time and I am done with this!"', 0,'mdeleo@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (187,'Penny', '2013-05-03', 'Female', '  was found curled up in a shivering ball one frosty morning in the landscaping outside of a ', '2351193848', 1, '2020-04-03','I have decided I am allergic to the animal.', 0,'mmallett@konex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (188,'Louie', '2016-06-06', 'Male', ' Meet Louie, originally named Jellybean for his love of candy and sweet disposition. He was adopted', NULL, 1, '2020-04-07','"My cat is a w***e, she keeps getting pregnant by the neighbor''s cat and the babies keep dying. This is the third time and I am done with this!"', 1,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (189,'Moose', '2012-07-09', 'Male', ' After being abandoned in rural east Texas, wandered up to a home. The kind family took h', '6332625943', 1, '2020-04-09','allergies are a problem', 0,'smaclead@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (190,'Ellie', '2015-04-10', 'Female', ' We don''t know what happened to him before he arrived', NULL, 0, '2020-04-10','The animal has had (puppies/kittens) and I don''t know how that happened and I don''t want them anymore.', 0,'fcrupi@rangreen.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (191,'Benny', '2008-05-10', 'Male', '   a German Shepherd Mix.  I''m a bit timid at first, but once I get ', '5369822981', 1, '2020-04-10','I need to surrender my dog because I just had my carpets cleaned.', 0,'fcrupi@rangreen.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (192,'Mimi', '2012-07-13', 'Female', ' is a 12-week-old Black Cur mix pup who got adopted and who thought he had found his fo', NULL, 1, '2020-04-13','I don''t want to be responsible for the animal anymore.', 0,'dkeetch@golddex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (193,'Kobe', '2013-05-14', 'Male', '   I''m an absolute awesome dog and I love all people. My foster says I have', NULL, 1, '2020-04-14','didn''t know the cat would sleep all day', 0,'dmontezuma@green-plus.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (194,'Layla', '2016-09-15', 'Female', '   is a 3 year old Lab mix who loves people.  She is currently living with 2 children', '8193161267', 1, '2020-04-16','The animal attacks me and my family.', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (195,'Boomer', '2012-01-16', 'Male', ' After being abandoned in rural east Texas, wandered up to a home. The kind family took h', '7339516057', 1, '2020-04-17','I don''t have time for the animal.', 0,'edubaldi@finhigh.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (196,'Callie', '2007-08-20', 'Female', ' is a PRECIOUS little man!  He''s so sweet and snuggly!   gets along w', '7960026909', 1, '2020-04-20','decided they have too many animals at home', 0,'mmallett@konex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (197,'Buddy', '2018-01-22', 'Male', ' is a senior boy, 11-12 years old, the life he led before being rescued was filled ', NULL, 1, '2020-04-23','allergies are a problem', 0,'cjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (198,'Buster', '2015-09-29', 'Male', ' is a ball-chasing, attention-loving, breathtakingly gorgeous boy.  A perfect day', '1180081313', 1, '2020-04-30','decided they have too many animals at home', 0,'mo@burdell.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (199,'Scout', '2020-01-06', 'Female', ' is a sweet girl who was separated from her litter after having to have a lifesaving blood tr', NULL, 1, '2020-05-07','I got a new house and don''t want it.', 0,'dkeetch@golddex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (200,'Brady', '2014-03-11', 'Male', '   is an 8 year old Pointer mix who is looking for a place to spend his golden years. This ha', NULL, 1, '2020-05-11','think the dog barks too much', 0,'mdeleo@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (201,'Copper', '1998-09-11', 'Male', ' was rescued from euthanasia at a Texas shelter. he is energetic and playful. He gets alon', '5339875379', 1, '2020-05-12','The animal chews and I don''t want my belongings destroyed.', 0,'barias@xx-holding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (202,'Brody', '2018-07-14', 'Male', '  is a wonderful family member.  He is 13 years old and has been with ', NULL, 1, '2020-05-14','renovating the house or redoing the yard', 0,'edubaldi@finhigh.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (203,'Mickey', '2009-11-17', 'Male', '  loves to snuggle & have her ears scratched. She loves to play with oth', '3496488220', 1, '2020-05-19','When I got it the animal was small and cute and now it is grown up and not cute.', 0,'mmallett@konex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (204,'Bandit', '2000-04-21', 'Male', ' she was being given away in the back of a gas station in a rural Texas town when one of our', '4054902946', 1, '2020-05-22','I told my dying family member that I would care for their animal after they died to make them feel better, but I really don''t want the animal so I am surrendering it to you.', 0,'tmarrier@hottechi.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (205,'Brutus', '2013-05-25', 'Male', '  is a two and a half old and such a sweetheart.   loves the car and likes ', '3809882192', 0, '2020-05-25','the pet sheds too much', 0,'tmarrier@hottechi.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (206,'Mocha', '2012-11-23', 'Female', '    has the floppiest ears and the saddest eyes, but ', '2209144417', 1, '2020-05-25','upset that the dog chewed on something or had an accident', 0,'vmenter@silis.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (207,'Shadow', '2009-07-28', 'Female', ' From his foster mom: is an 8-month-old, 43 pound, Black Lab who spent his firs', NULL, 0, '2020-05-28','"My cat is a w***e, she keeps getting pregnant by the neighbor''s cat and the babies keep dying. This is the third time and I am done with this!"', 1,'cvonasek@toughzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (208,'Sugar', '2010-05-29', 'Female', '  was a service dog for an elderly man who recently passed away. Now this boy needs a new home', '1279487985', 0, '2020-05-29','didn''t realize that the animal would need so much attention', 0,'jgiguere@openlane.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id,name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (209,'Bailey', '2015-10-31', 'Male', ' he has had a hard start to his life! This little blue nose nugget of wiggles was scheduled ', NULL, 1, '2020-06-01','don''t have time for the dog anymore', 0,'ncoyier@funholding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (210,'Joey', '2008-04-02', 'Male', ' she was being given away in the back of a gas station in a rural Texas town when one of our', '6580299670', 1, '2020-06-02','allergies are a problem', 0,'cjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (211,'Finn', '2019-03-03', 'Male', ' This gorgeous boy is a Saint Bernard mix. He is', '3069312414', 1, '2020-06-02','I am moving and I can''t take them with me.', 0,'cvonasek@toughzap.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (212,'Sophie', '2011-10-04', 'Unknown', '   is a loving, young, playful bundle of joy & energy who would love to find herself ', '1879183892', 0, '2020-06-04','My child moved to college and left their animal behind.', 0,'kmunns@yearin.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (213,'Charlie', '2007-03-06', 'Female', ' is a handsome 3 1/2 year old Shepherd mix. He is good with other dogs.  He would do', '7241808764', 0, '2020-06-05','The animal pooped/peed on the floor.', 0,'jsweely@fasehatice.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (214,'Grace', '2007-12-05', 'Female', '  He''s approximately one to one and a half years old. He was rescued a few months', '4935743572', 1, '2020-06-05','I am going to have a child and don''t want the animal anymore.', 0,'cjurney@groovestreet.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (215,'Charlie', '2011-07-09', 'Male', '  was recently rescued from euthanasia at a Texas shelter. She has the sweetest face!  I', '9790715047', 1, '2020-06-08','The dog barks too much or the cat meows too much.', 1,'sahle@treequote.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (216,'Dixie', '2017-06-10', 'Female', '  is in foster and here''s what her foster has to say: Meet the most lovable, frie', '4262910035', 1, '2020-06-10','The animal turned 10 and you surrender the animal when it reaches that age.', 0,'fcrupi@rangreen.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (217,'Jackson', '2016-11-11', 'Male', ' this boy and his siblings were being given away in a Walmart parking lot in Texas right before the ne', '3539230546', 0, '2020-06-12','can''t or don''t want to handle the costs of the pet''s needs', 1,'asmith@zotware.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (218,'Angel', '2004-01-14', 'Female', '  a big scruffy pup and devoted friend to those he trusts.  But trust takes tim', '5383692461', 0, '2020-06-15','I don''t have time for the animal.', 0,'dkeetch@golddex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (219,'Bailey', '2010-07-17', 'Male', ' would be a wonderful addition to your family as long as she''s the only fur', '3508454855', 1, '2020-06-16','upset that the dog chewed on something or had an accident', 0,'dkeetch@golddex.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (220,'Josie', '2004-03-17', 'Female', ' was rescued from euthanasia at a Texas shelter. he is energetic and playful. He gets alon', '9249157474', 0, '2020-06-17','allergies are a problem', 0,'barias@xx-holding.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (221,'Hunter', '2013-07-19', 'Male', '  is looking for a family of his own, preferably one with kids as he loves children! ', '9714706018', 1, '2020-06-19','I don''t have time for the animal.', 0,'sahle@treequote.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (222,'Trixie', '2013-01-23', 'Female', ' If you''re looking for a "no brainer", check out this girl. She is a really E', '4662455221', 0, '2020-06-24','The animal chews and I don''t want my belongings destroyed.', 0,'srodefer@ontomedia.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (223,'Athena', '2013-10-24', 'Female', ' Meet Lucky!!! He might not have been so lucky in the past, but we hope he will be lucky ', '2723749351', 0, '2020-06-24','having ''personal problems''', 0,'edubaldi@finhigh.com');
    
INSERT INTO cs6400_summer2020_team022.Dog 
(dog_id, name, birth_date, sex, description, microchip_id, alteration_status, surrender_date, surrender_reason,  is_animal_control, dog_adder_email)
VALUES (224,'Bentley', '2010-08-25', 'Male', ' is a very friendly and energetic Rottweiler mix who is7 years old & weighs 59', '7704051752', 1, '2020-06-25','The animal chews and I don''t want my belongings destroyed.', 0,'rdiestel@goodsilron.com');


INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (1,41);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (1,123);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (2,115);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (2,228);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (3,97);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (4,169);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (5,80);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (5,119);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (5,198);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (6,44);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (6,154);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (7,8);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (8,92);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (9,67);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (10,234);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (11,117);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (12,94);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (12,200);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (13,58);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (13,138);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (13,173);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (14,86);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (15,58);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (16,22);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (17,168);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (17,175);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (18,30);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (18,127);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (19,79);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (19,118);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (19,154);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (20,148);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (21,65);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (21,97);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (21,108);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (21,232);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (22,3);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (22,90);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (23,26);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (24,30);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (24,137);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (25,47);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (25,237);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (26,70);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (26,244);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (27,62);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (27,222);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (28,152);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (28,155);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (29,71);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (30,22);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (30,46);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (31,111);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (31,210);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (32,23);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (33,13);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (33,137);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (33,146);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (34,58);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (34,119);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (35,176);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (36,9);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (36,123);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (37,208);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (38,161);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (39,15);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (40,107);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (40,125);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (40,194);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (41,181);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (42,15);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (42,244);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (43,177);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (44,59);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (44,207);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (45,167);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (46,35);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (47,121);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (48,110);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (49,76);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (49,118);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (50,23);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (50,71);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (51,168);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (51,243);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (52,60);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (53,209);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (54,3);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (55,240);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (56,64);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (57,219);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (58,61);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (59,106);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (59,140);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (60,209);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (61,45);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (62,153);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (62,185);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (63,53);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (64,149);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (64,178);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (65,35);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (66,113);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (66,194);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (67,89);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (67,156);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (67,163);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (68,89);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (68,161);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (69,149);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (70,100);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (71,75);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (71,160);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (72,191);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (73,208);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (74,236);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (75,21);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (75,179);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (76,53);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (77,201);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (78,201);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (79,55);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (79,92);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (80,101);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (81,16);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (82,178);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (83,2);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (83,224);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (84,2);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (84,114);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (84,125);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (85,90);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (85,242);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (86,41);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (87,124);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (88,222);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (88,225);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (89,7);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (90,4);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (90,59);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (90,62);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (91,173);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (92,153);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (92,193);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (93,112);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (93,179);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (94,91);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (94,125);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (95,54);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (95,95);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (96,119);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (97,120);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (98,2);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (98,150);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (99,195);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (100,31);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (100,164);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (101,235);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (102,123);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (103,140);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (103,180);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (104,85);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (104,155);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (105,58);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (106,118);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (107,5);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (107,34);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (108,223);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (109,71);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (109,99);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (110,131);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (111,67);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (112,74);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (113,137);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (114,141);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (115,182);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (116,225);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (117,106);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (118,93);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (119,53);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (120,141);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (121,158);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (122,14);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (123,141);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (124,52);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (124,92);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (124,191);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (125,81);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (126,95);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (126,147);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (127,55);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (127,213);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (128,53);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (129,12);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (129,62);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (130,131);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (131,111);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (132,84);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (132,153);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (133,64);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (133,214);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (134,142);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (134,153);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (135,91);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (135,184);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (135,195);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (136,212);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (137,134);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (137,208);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (138,1);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (138,106);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (138,235);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (139,114);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (139,182);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (140,233);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (141,54);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (141,81);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (142,18);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (143,91);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (143,149);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (144,140);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (145,34);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (145,150);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (146,102);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (147,112);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (148,128);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (149,111);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (149,158);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (150,20);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (151,246);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (152,10);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (153,108);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (154,135);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (155,38);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (155,217);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (156,108);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (156,232);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (157,181);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (158,44);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (159,97);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (159,146);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (160,165);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (161,183);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (162,184);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (163,127);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (164,72);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (164,217);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (165,75);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (165,97);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (165,100);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (166,165);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (166,170);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (167,204);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (167,222);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (167,241);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (168,167);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (169,81);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (169,232);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (170,163);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (170,199);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (171,72);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (171,193);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (171,232);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (172,148);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (173,116);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (174,63);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (174,189);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (175,43);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (175,184);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (176,97);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (177,65);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (178,60);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (179,15);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (180,75);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (181,134);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (182,179);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (183,38);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (184,7);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (184,125);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (185,108);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (186,186);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (187,179);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (188,19);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (188,146);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (189,158);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (190,78);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (191,115);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (192,114);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (193,58);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (193,187);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (194,27);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (194,39);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (195,170);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (196,79);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (197,224);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (198,3);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (198,132);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (199,29);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (200,217);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (201,5);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (201,60);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (201,149);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (202,59);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (202,228);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (203,51);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (203,156);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (203,237);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (204,44);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (204,180);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (205,132);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (206,231);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (207,69);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (207,238);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (208,7);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (209,196);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (209,211);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (210,113);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (210,221);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (211,238);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (212,193);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (213,63);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (214,235);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (215,88);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (216,40);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (216,185);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (217,11);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (217,203);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (218,141);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (219,72);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (220,86);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (221,56);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (221,209);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (222,5);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (223,185);
INSERT INTO cs6400_summer2020_team022.DogBreed (dog_id, breed_id) VALUES (224,75);


INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (1,'Petco');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (2,'Dr Smith');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (3,'Dr Hudson');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (4,'Kahoots Pet');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (5,'Dr Rozenman');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (6,'Canine Learning Centers');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (7,'Dr Arnold');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (8,'Dr Brown');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (9,'Arrieros Pet Shop');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (10,'Decker''s Dog and Cat');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (11,'Dr Wilson');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (12,'Pet Kingdom');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (13,'Dr Jones');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (14,'Pawerica Pet Store');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (15,'Unleashed by Petco');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (16,'Pet Group Inc');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (17,'TagWorks');
INSERT INTO cs6400_summer2020_team022.Vender (vender_id,vender_name) VALUES (18,'Dr Towers');

INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (2, '2019-01-13', 1, 74.02, 'Purina Pro Plan Focus Adult Sensitive Skin & Stomach Salmon & Rice Formula Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (7, '2019-01-28', 2, 105.07, 'medicine');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (9, '2019-01-26', 3, 144.22, 'Exploratory celiotomy - ventral midline ');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (9, '2019-02-16', 4, 60.56, 'Blue Buffalo Homestyle Recipe Chicken Dinner with Garden Vegetables & Brown Rice Canned Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (11, '2019-02-12', 5, 278.95);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (11, '2019-02-27', 2, 191.42, 'medical procedure');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (12, '2019-03-08', 6, 22.43, 'Top Paw Spiky Ball Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (12, '2019-04-09', 7, 277.37, 'Exploratory celiotomy - left flank');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (12, '2019-02-03', 5, 125.21);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (14, '2019-02-18', 8, 124.43, 'vaccination');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (18, '2019-11-08', 9, 0.05, 'Trixie Activity Flip Board Activity Strategy Game Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (18, '2019-12-10', 9, 8.59, 'Chuckit! Indoor Ball Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (18, '2019-10-16', 6, 0.26, 'Iams ProActive Health Adult MiniChunks Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (18, '2019-12-28', 10, 14.9, 'American Journey Salmon & Sweet Potato Recipe Grain-Free Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (18, '2020-04-05', 7, 194.96, 'fractures');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (18, '2019-06-29', 8, 288.54, 'bleeding');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (18, '2019-08-09', 11, 86.07);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (18, '2019-05-11', 4, 73.41);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (18, '2019-03-15', 12, 19.67, 'Top Paw Spiky Ball Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (18, '2019-04-11', 12, 24.66, 'JW Pet Hol-ee Roller Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (18, '2019-06-21', 1, 40.46, 'Rachael Ray Nutrish Natural Chicken & Veggies Recipe Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (18, '2020-05-23', 1, 5.77, 'Top Paw Spiky Ball Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (25, '2019-03-17', 13, 95.29, 'fractures');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (31, '2019-04-19', 7, 71.4, 'surgery');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (33, '2019-04-09', 14, 6.79, 'Nylabone DuraChew Textured Ring Flavor Medley Dog Chew Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (34, '2019-04-21', 1, 44.29, 'Taste of the Wild High Prairie Grain-Free Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (39, '2019-04-11', 2, 108.73, 'fractures');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (42, '2019-05-11', 13, 255.55);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (42, '2019-05-03', 11, 3.67, 'medicine');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (43, '2019-05-05', 3, 258.8, 'medicine');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (45, '2019-04-20', 5, 282.5, 'Exploratory celiotomy - ventral midline ');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (47, '2019-05-02', 4, 9.4, 'Chuckit! Indoor Ball Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (49, '2019-05-21', 8, 1.57);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (49, '2019-06-13', 15, 9.92, 'Top Paw Spiky Ball Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (50, '2019-05-18', 5, 164.1, 'surgery');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (55, '2019-05-17', 9, 8.1, 'Nylabone DuraChew Textured Ring Flavor Medley Dog Chew Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (58, '2019-05-28', 1, 30.22, 'Hill''s Science Diet Adult Sensitive Stomach & Skin Chicken Recipe Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (58, '2019-06-05', 15, 47.45, 'Hill''s Science Diet Adult Sensitive Stomach & Skin Chicken Recipe Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (63, '2019-06-10', 7, 59.89);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (66, '2019-06-15', 2, 38.66, 'physical');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (67, '2019-08-26', 13, 90.19, 'surgery');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (67, '2019-07-10', 15, 0.14, 'Top Paw Spiky Ball Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (68, '2019-06-19', 9, 30.67, 'American Journey Salmon & Sweet Potato Recipe Grain-Free Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (70, '2019-07-14', 9, 60.46, 'SmartBones SmartSticks Peanut Butter Chews Dog Treats Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (70, '2019-07-23', 14, 45.72, 'Taste of the Wild High Prairie Grain-Free Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (70, '2019-06-28', 16, 19.34, 'JW Pet Hol-ee Roller Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (72, '2019-07-15', 3, 208.33, 'Exploratory celiotomy - left flank');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (72, '2019-09-26', 1, 14.57, 'Blue Buffalo Homestyle Recipe Chicken Dinner with Garden Vegetables & Brown Rice Canned Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (72, '2019-08-11', 17, 20.52, 'American Journey Salmon & Sweet Potato Recipe Grain-Free Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (72, '2019-07-06', 15, 24.69, 'Nylabone DuraChew Textured Ring Flavor Medley Dog Chew Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (72, '2019-09-15', 15, 11.04, 'Blue Buffalo Homestyle Recipe Chicken Dinner with Garden Vegetables & Brown Rice Canned Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (74, '2019-07-15', 14, 24.55, 'Blue Buffalo Homestyle Recipe Chicken Dinner with Garden Vegetables & Brown Rice Canned Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (76, '2019-07-28', 2, 82.28, 'Abomasopexy, left flank ');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (76, '2019-07-25', 4, 70.44, 'Taste of the Wild High Prairie Grain-Free Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (83, '2019-08-02', 10, 5.94, 'JW Pet Hol-ee Roller Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (83, '2019-07-29', 1, 74.13);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (84, '2019-07-24', 9, 64.61);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (86, '2019-07-26', 18, 117.82, 'Abomasopexy, left flank ');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (86, '2019-09-05', 1, 56.08);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (89, '2019-08-01', 14, 5.95, 'Nylabone Puppy X Bone Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (90, '2019-09-04', 10, 15.77);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (90, '2019-08-12', 18, 292.93);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (90, '2019-08-04', 17, 15.6, 'Trixie Activity Flip Board Activity Strategy Game Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (96, '2019-08-19', 14, 66.58, 'Taste of the Wild High Prairie Grain-Free Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (105, '2019-10-01', 7, 257.53, 'surgery');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (106, '2019-09-11', 11, 286.61, 'fractures');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (107, '2019-09-11', 12, 53.27, 'Blue Buffalo Homestyle Recipe Chicken Dinner with Garden Vegetables & Brown Rice Canned Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (108, '2019-09-15', 8, 198.62);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (111, '2019-09-26', 16, 12.84, 'Trixie Activity Flip Board Activity Strategy Game Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (112, '2019-10-29', 6, 19.06, 'Outward Hound HedgehogZ Squeaky Plush Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (112, '2019-10-11', 8, 265.91, 'fractures');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (112, '2019-10-03', 3, 264.27, 'Abomasopexy, left flank ');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (112, '2019-11-26', 13, 122.03, 'vaccination');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (112, '2019-12-08', 12, 66.04, 'Taste of the Wild High Prairie Grain-Free Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (113, '2019-12-08', 7, 290.47);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (113, '2019-10-15', 8, 96.82);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (113, '2020-01-20', 8, 42.19, 'Exploratory celiotomy - left flank');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (113, '2020-01-12', 3, 250.39, 'Exploratory celiotomy - ventral midline ');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (113, '2019-12-21', 18, 253.01, 'Abomasopexy, left flank ');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (113, '2020-01-01', 17, 5.85, 'Hill''s Science Diet Adult Sensitive Stomach & Skin Chicken Recipe Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (113, '2019-11-09', 15, 6.35, 'Hill''s Science Diet Adult Sensitive Stomach & Skin Chicken Recipe Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (114, '2019-10-13', 10, 55.36, 'KONG Easy Treat Dog Treat - Bacon & Cheese Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (117, '2019-10-15', 11, 193.74, 'physical');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (123, '2019-10-26', 6, 60.83, 'Taste of the Wild High Prairie Grain-Free Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (124, '2019-11-11', 8, 36.65, 'surgery');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (124, '2019-11-04', 3, 83.35, 'surgery');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (125, '2019-11-03', 6, 15.82, 'JW Pet Hol-ee Roller Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (127, '2019-11-07', 3, 82.54, 'Abomasopexy, left flank ');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (129, '2019-11-12', 13, 29.29, 'medical procedure');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (130, '2019-12-09', 13, 206.15, 'medical procedure');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (130, '2019-11-19', 2, 279.09, 'Exploratory celiotomy - left flank');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (131, '2019-11-16', 15, 36.74, 'Iams ProActive Health Adult MiniChunks Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (133, '2019-12-18', 6, 13.11);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (133, '2019-11-25', 12, 3.23, 'Nylabone Puppy X Bone Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (133, '2019-11-21', 15, 13.82);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (134, '2019-11-20', 8, 296.56, 'medicine');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (134, '2019-11-18', 3, 117.61, 'Abomasopexy, left flank ');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (138, '2019-11-22', 3, 234.9, 'physical');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (139, '2020-01-01', 6, 22.68, 'Nylabone DuraChew Textured Ring Flavor Medley Dog Chew Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (139, '2019-12-29', 10, 62.07, 'Hill''s Science Diet Adult Sensitive Stomach & Skin Chicken Recipe Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (139, '2019-11-30', 7, 193.36, 'medicine');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (139, '2019-12-21', 7, 63.31, 'Exploratory celiotomy - left flank');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (139, '2019-11-26', 8, 94.93);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (139, '2020-03-07', 3, 125.15, 'fractures');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (139, '2020-01-27', 4, 22.7);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (139, '2020-02-12', 4, 27.1, 'Blue Buffalo Life Protection Formula Adult Chicken & Brown Rice Recipe Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (139, '2020-01-14', 1, 35.53, 'Iams ProActive Health Adult MiniChunks Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (139, '2020-04-06', 15, 17.1, 'Nylabone DuraChew Textured Ring Flavor Medley Dog Chew Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (140, '2019-12-01', 2, 249.58, 'vaccination');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (143, '2019-12-11', 14, 14.53, 'Nylabone Puppy X Bone Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (146, '2019-12-12', 10, 43.32, 'Taste of the Wild High Prairie Grain-Free Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (146, '2019-12-22', 4, 66.05, 'Blue Buffalo Life Protection Formula Adult Chicken & Brown Rice Recipe Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (153, '2019-12-26', 13, 188.23, 'medicine');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (157, '2020-01-01', 8, 82.72, 'Abomasopexy, left flank ');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (159, '2020-01-08', 17, 21.47, 'Top Paw Spiky Ball Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (160, '2020-01-14', 13, 231.99, 'surgery');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (160, '2020-01-26', 13, 242.42, 'medicine');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (160, '2020-02-17', 15, 65.56, 'Blue Buffalo Life Protection Formula Adult Chicken & Brown Rice Recipe Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (166, '2020-03-11', 9, 15.54, 'JW Pet Hol-ee Roller Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (166, '2020-04-05', 3, 30.16, 'Exploratory celiotomy - left flank');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (166, '2020-03-15', 13, 117.23, 'Exploratory celiotomy - left flank');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (166, '2020-03-26', 1, 3.99, 'Nylabone DuraChew Textured Ring Flavor Medley Dog Chew Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (166, '2020-03-31', 1, 1.05, 'KONG Easy Treat Dog Treat - Bacon & Cheese Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (171, '2020-03-01', 14, 20.69, 'SmartBones SmartSticks Peanut Butter Chews Dog Treats Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (172, '2020-03-06', 6, 44.29);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (172, '2020-03-24', 2, 217.15, 'fractures');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (174, '2020-03-05', 16, 12.24);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (176, '2020-03-28', 6, 35.83, 'SmartBones SmartSticks Peanut Butter Chews Dog Treats Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (176, '2020-03-08', 2, 37.18, 'Exploratory celiotomy - left flank');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (176, '2020-04-28', 17, 7.39, 'Top Paw Spiky Ball Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (177, '2020-03-18', 12, 20.21);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (179, '2020-03-20', 5, 159.78, 'surgery');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (183, '2020-03-31', 13, 27.53, 'physical');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (183, '2020-04-02', 15, 3.8, 'Chuckit! Indoor Ball Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (184, '2020-03-27', 12, 10.4, 'KONG AirDog Tennis Ball Squeaker Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (185, '2020-04-23', 3, 166.54, 'physical');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (185, '2020-05-18', 13, 208.53);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (185, '2020-04-09', 16, 20.14, 'Chuckit! Indoor Ball Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (187, '2020-04-15', 7, 68.54);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (187, '2020-05-06', 5, 114.41, 'vaccination');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (188, '2020-05-05', 6, 57.37, 'Rachael Ray Nutrish Natural Chicken & Veggies Recipe Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (188, '2020-04-16', 8, 178.98, 'fractures');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (188, '2020-04-22', 11, 147.02, 'surgery');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (188, '2020-05-25', 11, 179.66, 'bleeding');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (188, '2020-05-15', 1, 6.61, 'Purina Pro Plan Focus Adult Sensitive Skin & Stomach Salmon & Rice Formula Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (189, '2020-04-24', 6, 21.49, 'KONG Easy Treat Dog Treat - Bacon & Cheese Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (190, '2020-04-12', 8, 290.32, 'medicine');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (190, '2020-04-27', 11, 279.14, 'medicine');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (190, '2020-05-17', 12, 11.82);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount) 
    VALUES (193, '2020-04-29', 9, 3.32);
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (193, '2020-04-22', 11, 169.85, 'bleeding');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (193, '2020-05-11', 14, 1.88, 'Hill''s Science Diet Adult Sensitive Stomach & Skin Chicken Recipe Dry Dog Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (193, '2020-04-19', 12, 7.24, 'JW Pet Hol-ee Roller Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (196, '2020-04-23', 18, 153.49, 'surgery');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (199, '2020-05-14', 11, 181.53, 'bleeding');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (200, '2020-05-11', 17, 49.34, 'SmartBones SmartSticks Peanut Butter Chews Dog Treats Food');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (202, '2020-05-15', 10, 11.16, 'JW Pet Hol-ee Roller Dog Toy');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (204, '2020-05-25', 11, 175.96, 'medical procedure');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (205, '2020-05-29', 13, 211.12, 'bleeding');
INSERT INTO cs6400_summer2020_team022.Expense (dog_id, expense_date, vender_id, amount, description) 
    VALUES (208, '2020-06-01', 10, 1.36, 'KONG AirDog Tennis Ball Squeaker Dog Toy');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (1,'hcallaro@cancity.com', '2019-01-01', 'Approved', 'Casie',  'Comnick');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (2,'fdelasancha@inity.com', '2019-01-01', 'Approved', 'Selma',  'Maclead');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (3,'amiceli@blackzim.com', '2019-01-01', 'Rejected', 'Kristeen',  'Acey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (4,'jblackwood@dambase.com', '2019-01-02', 'Approved', 'Nana',  'Tollner');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (5,'brhym@dambase.com', '2019-01-02', 'Rejected', 'Avery',  'Klusman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (6,'acoyier@hottechi.com', '2019-01-02', 'Approved', 'Quentin',  'Loader');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (7,'lhamilton@labdrill.com', '2019-01-03', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (8,'lmorocco@year-job.com', '2019-01-03', 'Rejected', 'Mona',  'Deleo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (9,'mstem@betasoloin.com', '2019-01-03', 'Rejected', 'Yuki',  'Vonasek');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (10,'mhollack@scottech.com', '2019-01-04', 'Approved', 'Kaitlyn',  'Klimek');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (11,'rgarufi@bioplex.com', '2019-01-07', 'Approved', 'Raylene',  'Blackwood');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (12,'lkarpel@nam-zim.com', '2019-01-07', 'Rejected', 'Nieves',  'Batman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (13,'kharnos@conecom.com', '2019-01-07', 'Rejected', 'Matthew',  'Rauser');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (14,'ltheodorov@opentech.com', '2019-01-08', 'Rejected', 'Lizette',  'Witten');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (15,'gkines@inity.com', '2019-01-08', 'Approved', 'Roosevelt',  'Springe');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (16,'amiceli@blackzim.com', '2019-01-08', 'Approved', 'Delisa',  'Keetch');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (17,'cscipione@kan-code.com', '2019-01-09', 'Approved', 'Ammie',  'Heintzman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (18,'lmorocco@year-job.com', '2019-01-09', 'Approved', 'Lashaunda',  'Paulas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (19,'lmunns@toughzap.com', '2019-01-09', 'Rejected', 'Thaddeus',  'Caudy');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (20,'jrestrepo@konmatfix.com', '2019-01-10', 'Approved', 'Evangelina',  'Crupi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (21,'jlueckenbach@plussunin.com', '2019-01-10', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (22,'aostolaza@finjob.com', '2019-01-10', 'Rejected', 'Serina',  'Jurney');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (23,'ggalam@ron-tech.com', '2019-01-11', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (24,'dkines@betatech.com', '2019-01-14', 'Approved', 'Leonora',  'Coyier');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (25,'kcraghead@sumace.com', '2019-01-14', 'Approved', 'Virgina',  'Perin');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (26,'dgellinger@dambase.com', '2019-01-15', 'Approved', 'Melissa',  'Vanheusen');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (27,'hmenter@doncon.com', '2019-01-16', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (28,'bmastella@kan-code.com', '2019-01-17', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (29,'snicka@year-job.com', '2019-01-17', 'Approved', 'Vilma',  'Marrier');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (30,'cpugh@domzoom.com', '2019-01-17', 'Approved', 'Willard',  'Albares');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (31,'cscipione@kan-code.com', '2019-01-17', 'Approved', 'Lezlie',  'Steffensmeier');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (32,'jspickerman@y-corporation.com', '2019-01-18', 'Approved', 'Devora',  'Meinerding');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (33,'cpagliuca@betasoloin.com', '2019-01-18', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (34,'cpaulas@opentech.com', '2019-01-21', 'Approved', 'Janine',  'Cetta');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (35,'troyster@kan-code.com', '2019-01-21', 'Approved', 'Tamar',  'Lawler');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (36,'ahoogland@doncon.com', '2019-01-22', 'Approved', 'Mirta',  'Yglesias');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (37,'mhollack@scottech.com', '2019-01-22', 'Approved', 'Dorothy',  'Frerking');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (38,'ebowley@ganjaflex.com', '2019-01-23', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (39,'eperigo@plussunin.com', '2019-01-23', 'Approved', 'Izetta',  'Myricks');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (40,'estenseth@cancity.com', '2019-01-23', 'Approved', 'Felix',  'Kitty');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (41,'kharnos@conecom.com', '2019-01-23', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (42,'cpugh@domzoom.com', '2019-01-24', 'Approved', 'Jennifer',  'Saylors');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (43,'msarao@newex.com', '2019-01-24', 'Rejected', 'Delisa',  'Abdallah');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (44,'afigeroa@labdrill.com', '2019-01-24', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (45,'hcallaro@cancity.com', '2019-01-25', 'Approved', 'Wynell',  'Candlish');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (46,'jblackwood@dambase.com', '2019-01-25', 'Rejected', 'Britt',  'Rhym');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (47,'ajuvera@groovestreet.com', '2019-01-25', 'Rejected', 'Lavonna',  'Nicolozakes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (48,'ebowley@ganjaflex.com', '2019-01-25', 'Approved', 'Bette',  'Nachor');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (49,'estenseth@cancity.com', '2019-01-28', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (50,'esaylors@y-corporation.com', '2019-01-28', 'Approved', 'Kris',  'Pedrozo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (51,'kweglarz@streethex.com', '2019-01-28', 'Approved', 'An',  'Dhamer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (52,'hseewald@j-texon.com', '2019-01-29', 'Rejected', 'Leonora',  'Motley');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (53,'lpadilla@conecom.com', '2019-01-29', 'Approved', 'Howard',  'Lipke');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (54,'ccoody@sonron.com', '2019-01-30', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (55,'lwalthall@betasoloin.com', '2019-01-30', 'Approved', 'Jeanice',  'Heintzman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (56,'elary@lexiqvolax.com', '2019-01-31', 'Approved', 'Daren',  'Montezuma');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (57,'jspickerman@y-corporation.com', '2019-01-31', 'Rejected', 'Mitsue',  'Bilden');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (58,'etromblay@toughzap.com', '2019-02-01', 'Approved', 'Christiane',  'Rentfro');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (59,'eadkin@stanredtax.com', '2019-02-01', 'Approved', 'Brittni',  'Boord');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (60,'snicka@year-job.com', '2019-02-01', 'Approved', 'Carlee',  'Jurney');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (61,'jblackwood@dambase.com', '2019-02-04', 'Approved', 'Estrella',  'Acey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (62,'ckannady@dambase.com', '2019-02-04', 'Rejected', 'Izetta',  'Batman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (63,'lpadilla@conecom.com', '2019-02-04', 'Approved', 'Shalon',  'Perruzza');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (64,'brhym@dambase.com', '2019-02-04', 'Approved', 'Matthew',  'Sawchuk');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (65,'bpoullion@opentech.com', '2019-02-05', 'Approved', 'Detra',  'Kohnert');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (66,'lsteffensmeier@gogozoom.com', '2019-02-05', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (67,'msarao@newex.com', '2019-02-05', 'Approved', 'Yolando',  'Wieser');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (68,'ebowley@ganjaflex.com', '2019-02-06', 'Approved', 'Novella',  'Heintzman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (69,'ttromblay@dontechi.com', '2019-02-06', 'Rejected', 'Levi',  'Pagliuca');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (70,'cpaulas@opentech.com', '2019-02-06', 'Rejected', 'Delmy',  'Theodorov');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (71,'lschoeneck@streethex.com', '2019-02-07', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (72,'bmastella@kan-code.com', '2019-02-07', 'Approved', 'Myra',  'Caudy');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (73,'rvanheusen@statholdings.com', '2019-02-08', 'Approved', 'Timothy',  'Aquas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (74,'lbayless@sumace.com', '2019-02-08', 'Approved', 'Viola',  'Riden');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (75,'vknipp@year-job.com', '2019-02-08', 'Approved', 'Lezlie',  'Gabisi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (76,'anievas@rangreen.com', '2019-02-11', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (77,'jkarpel@mathtouch.com', '2019-02-12', 'Approved', 'Tresa',  'Juvera');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (78,'msarao@newex.com', '2019-02-12', 'Approved', 'Aja',  'Vonasek');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (79,'ahoogland@y-corporation.com', '2019-02-12', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (80,'mhollack@scottech.com', '2019-02-13', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (81,'wmeteer@domzoom.com', '2019-02-13', 'Approved', 'Kallie',  'Tollner');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (82,'chirpara@rantouch.com', '2019-02-14', 'Rejected', 'Jamal',  'Sayaphon');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (83,'clawler@dontechi.com', '2019-02-14', 'Approved', 'Alesia',  'Scriven');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (84,'hseewald@j-texon.com', '2019-02-15', 'Approved', 'Malcolm',  'Vocelka');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (85,'mreiber@scottech.com', '2019-02-15', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (86,'mbolognia@finjob.com', '2019-02-15', 'Approved', 'Carissa',  'Vonasek');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (87,'amiceli@blackzim.com', '2019-02-18', 'Rejected', 'Keneth',  'Engelberg');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (88,'kpedrozo@kan-code.com', '2019-02-18', 'Approved', 'Winfred',  'Daufeldt');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (89,'eadkin@stanredtax.com', '2019-02-18', 'Rejected', 'Jeanice',  'Tjepkema');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (90,'acoyier@hottechi.com', '2019-02-18', 'Approved', 'Rima',  'Corbley');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (91,'mreiber@scottech.com', '2019-02-19', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (92,'lpadilla@conecom.com', '2019-02-20', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (93,'egoldammer@scottech.com', '2019-02-20', 'Approved', 'Rikki',  'Sengbusch');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (94,'vknipp@year-job.com', '2019-02-21', 'Approved', 'Pete',  'Campain');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (95,'kharnos@conecom.com', '2019-02-21', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (96,'mbolognia@finjob.com', '2019-02-21', 'Rejected', 'Virgie',  'Inouye');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (97,'jmirafuentes@rangreen.com', '2019-02-22', 'Approved', 'Venita',  'Springe');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (98,'jpoquette@ron-tech.com', '2019-02-22', 'Approved', 'Carlee',  'Figeroa');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (99,'msetter@fasehatice.com', '2019-02-25', 'Approved', 'Alyce',  'Tawil');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (100,'lbayless@sumace.com', '2019-02-25', 'Approved', 'Kanisha',  'Lungren');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (101,'brhym@dambase.com', '2019-02-26', 'Approved', 'Leota',  'Estell');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (102,'esaylors@groovestreet.com', '2019-02-26', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (103,'dscipione@dambase.com', '2019-02-27', 'Approved', 'Stephen',  'Reiber');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (104,'aspickerman@green-plus.com', '2019-02-27', 'Approved', 'Oretha',  'Swayze');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (105,'jblackwood@dambase.com', '2019-02-27', 'Rejected', 'Jacqueline',  'Hagele');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (106,'egrenet@y-corporation.com', '2019-02-27', 'Rejected', 'Stephen',  'Wide');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (107,'adenooyer@kinnamplus.com', '2019-02-28', 'Approved', 'Dierdre',  'Schmaltz');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (108,'rhollack@plexzap.com', '2019-02-28', 'Rejected', 'Bernardine',  'Mauson');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (109,'tkines@sumace.com', '2019-02-28', 'Rejected', 'Danica',  'Loder');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (110,'adenooyer@kinnamplus.com', '2019-03-01', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (111,'ggalam@ron-tech.com', '2019-03-01', 'Approved', 'Nicolette',  'Samara');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (112,'esaylors@y-corporation.com', '2019-03-01', 'Approved', 'Elvera',  'Isenhower');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (113,'troyster@kan-code.com', '2019-03-04', 'Approved', 'Zona',  'Lacovara');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (114,'vknipp@year-job.com', '2019-03-04', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (115,'brhym@dambase.com', '2019-03-05', 'Rejected', 'Delmy',  'Claucherty');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (116,'lmonarrez@goodsilron.com', '2019-03-05', 'Approved', 'Chaya',  'Cloney');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (117,'clawler@dontechi.com', '2019-03-05', 'Approved', 'Kimbery',  'Bourbon');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (118,'lmonarrez@goodsilron.com', '2019-03-05', 'Rejected', 'Lai',  'Juvera');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (119,'amiceli@blackzim.com', '2019-03-06', 'Approved', 'Freeman',  'Berlanga');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (120,'dturinetti@doncon.com', '2019-03-06', 'Pending', 'Oretha',  'Acey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (121,'szepp@dalttechnology.com', '2019-03-06', 'Approved', 'Thurman',  'Saylors');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (122,'lkarpel@nam-zim.com', '2019-03-06', 'Approved', 'Sabra',  'Sweigard');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (123,'mbolognia@finjob.com', '2019-03-07', 'Approved', 'Shenika',  'Gibes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (124,'awildfong@conecom.com', '2019-03-07', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (125,'tkines@sumace.com', '2019-03-07', 'Approved', 'Lonna',  'Biddy');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (126,'loldroyd@hottechi.com', '2019-03-07', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (127,'jbuvens@plusstrip.com', '2019-03-08', 'Rejected', 'Wilda',  'Butt');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (128,'dscipione@dambase.com', '2019-03-08', 'Approved', 'Regenia',  'Ostrosky');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (129,'smeteer@dalttechnology.com', '2019-03-08', 'Approved', 'Joni',  'Neither');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (130,'mhollack@scottech.com', '2019-03-11', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (131,'mbolognia@finjob.com', '2019-03-11', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (132,'lmunns@toughzap.com', '2019-03-11', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (133,'cpugh@domzoom.com', '2019-03-12', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (134,'jmirafuentes@rangreen.com', '2019-03-12', 'Approved', 'Louisa',  'Caiafa');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (135,'lflister@hottechi.com', '2019-03-13', 'Approved', 'Annelle',  'Keener');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (136,'lmorocco@year-job.com', '2019-03-13', 'Approved', 'Lonna',  'Venere');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (137,'loldroyd@hottechi.com', '2019-03-13', 'Approved', 'Ashlyn',  'Walthall');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (138,'hseewald@j-texon.com', '2019-03-14', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (139,'chirpara@rantouch.com', '2019-03-14', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (140,'agillaspie@golddex.com', '2019-03-14', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (141,'dgellinger@dambase.com', '2019-03-15', 'Approved', 'Tarra',  'Wiklund');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (142,'ccoody@sonron.com', '2019-03-15', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (143,'kweglarz@streethex.com', '2019-03-18', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (144,'kharnos@conecom.com', '2019-03-18', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (145,'cpagliuca@betasoloin.com', '2019-03-18', 'Approved', 'Caitlin',  'Lacovara');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (146,'lkippley@golddex.com', '2019-03-18', 'Approved', 'Natalie',  'Acey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (147,'vkeener@kan-code.com', '2019-03-19', 'Rejected', 'Olive',  'Farrow');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (148,'aostolaza@finjob.com', '2019-03-19', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (149,'mreitler@fasehatice.com', '2019-03-19', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (150,'oflosi@betatech.com', '2019-03-19', 'Approved', 'Abel',  'Modzelewski');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (151,'brestrepo@xx-holding.com', '2019-03-20', 'Rejected', 'Krissy',  'Hochard');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (152,'mbolognia@finjob.com', '2019-03-20', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (153,'amiceli@blackzim.com', '2019-03-20', 'Rejected', 'Rebecka',  'Meteer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (154,'acoyier@hottechi.com', '2019-03-20', 'Rejected', 'Graciela',  'Baltimore');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (155,'yisenhower@dambase.com', '2019-03-21', 'Approved', 'Ty',  'Papasergi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (156,'jbuvens@plusstrip.com', '2019-03-21', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (157,'whamilton@opentech.com', '2019-03-22', 'Approved', 'Chantell',  'Monterrubio');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (158,'lmonarrez@goodsilron.com', '2019-03-22', 'Approved', 'Ronny',  'Strassner');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (159,'chirpara@rantouch.com', '2019-03-25', 'Rejected', 'Felicidad',  'Hoffis');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (160,'jacey@inity.com', '2019-03-25', 'Approved', 'Sharen',  'Gibes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (161,'lstockham@j-texon.com', '2019-03-26', 'Approved', 'Sharee',  'Gudroe');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (162,'lwalthall@betasoloin.com', '2019-03-26', 'Approved', 'Latrice',  'Vizarro');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (163,'mskulski@sumace.com', '2019-03-26', 'Approved', 'Dean',  'Gellinger');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (164,'ehirpara@sunnamplex.com', '2019-03-27', 'Approved', 'An',  'Miceli');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (165,'aspickerman@green-plus.com', '2019-03-27', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (166,'lnunlee@ron-tech.com', '2019-03-28', 'Rejected', 'Caitlin',  'Theodorov');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (167,'rhollack@plexzap.com', '2019-03-28', 'Approved', 'Minna',  'Blunk');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (168,'aspickerman@green-plus.com', '2019-03-28', 'Approved', 'Jacqueline',  'Korando');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (169,'bdiestel@condax.com', '2019-03-28', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (170,'esaylors@groovestreet.com', '2019-03-29', 'Approved', 'Amber',  'Bubash');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (171,'acoyier@hottechi.com', '2019-03-29', 'Approved', 'Jolene',  'Tomasulo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (172,'etromblay@toughzap.com', '2019-03-29', 'Approved', 'Jacqueline',  'Nicolozakes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (173,'hgwalthney@funholding.com', '2019-04-01', 'Approved', 'Georgene',  'Neither');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (174,'aoles@bioplex.com', '2019-04-01', 'Approved', 'Rodolfo',  'Canlas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (175,'aacey@dontechi.com', '2019-04-01', 'Rejected', 'Helga',  'Gwalthney');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (176,'xdubaldi@iselectrics.com', '2019-04-02', 'Approved', 'My',  'Farrow');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (177,'mhollack@scottech.com', '2019-04-02', 'Approved', 'Lenna',  'Ventura');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (178,'ndenooyer@statholdings.com', '2019-04-03', 'Rejected', 'Ligia',  'Baltimore');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (179,'lflister@hottechi.com', '2019-04-03', 'Approved', 'Judy',  'Konopacki');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (180,'lbayless@sumace.com', '2019-04-04', 'Approved', 'Nichelle',  'Cookey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (181,'acoyier@hottechi.com', '2019-04-04', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (182,'mhollack@scottech.com', '2019-04-05', 'Approved', 'Lenna',  'Saulter');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (183,'esaylors@y-corporation.com', '2019-04-05', 'Approved', 'Nana',  'Nabours');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (184,'mreiber@scottech.com', '2019-04-08', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (185,'kcraghead@sumace.com', '2019-04-08', 'Approved', 'Gregoria',  'Sweigard');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (186,'kharnos@conecom.com', '2019-04-09', 'Approved', 'Regenia',  'Garufi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (187,'traymo@scotfind.com', '2019-04-09', 'Approved', 'Skye',  'Regusters');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (188,'cbourbon@betasoloin.com', '2019-04-09', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (189,'rgarufi@bioplex.com', '2019-04-10', 'Approved', 'Larae',  'Scheyer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (190,'lstockham@j-texon.com', '2019-04-10', 'Rejected', 'Fletcher',  'Eroman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (191,'ahoogland@y-corporation.com', '2019-04-10', 'Approved', 'Truman',  'Rhoden');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (192,'hgwalthney@funholding.com', '2019-04-11', 'Approved', 'Tawna',  'Wildfong');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (193,'mreiber@scottech.com', '2019-04-11', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (194,'adenooyer@kinnamplus.com', '2019-04-11', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (195,'dstoltzman@condax.com', '2019-04-12', 'Approved', 'Louvenia',  'Burnard');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (196,'nhaufler@zencorporation.com', '2019-04-12', 'Approved', 'Fatima',  'Hoa');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (197,'kweglarz@streethex.com', '2019-04-12', 'Approved', 'Izetta',  'Restrepo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (198,'awildfong@conecom.com', '2019-04-15', 'Approved', 'France',  'Delasancha');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (199,'kmyricks@groovestreet.com', '2019-04-15', 'Approved', 'Tiera',  'Louissant');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (200,'jlueckenbach@plussunin.com', '2019-04-16', 'Rejected', 'Cecily',  'Andreason');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (201,'vkeener@kan-code.com', '2019-04-16', 'Approved', 'Xochitl',  'Dallen');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (202,'nhaufler@zencorporation.com', '2019-04-17', 'Approved', 'Christiane',  'Vizarro');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (203,'agillaspie@golddex.com', '2019-04-17', 'Approved', 'Tiffiny',  'Staback');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (204,'ndenooyer@statholdings.com', '2019-04-18', 'Rejected', 'Paris',  'Wolfgramm');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (205,'jbuvens@plusstrip.com', '2019-04-18', 'Approved', 'Raylene',  'Buzick');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (206,'jpoquette@ron-tech.com', '2019-04-18', 'Approved', 'Beatriz',  'Grenet');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (207,'kpatak@groovestreet.com', '2019-04-19', 'Rejected', 'Elvera',  'Hirpara');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (208,'yisenhower@dambase.com', '2019-04-19', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (209,'kbenimadho@donquadtech.com', '2019-04-19', 'Approved', 'Jettie',  'Treston');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (210,'lflister@hottechi.com', '2019-04-22', 'Approved', 'Lauran',  'Lipke');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (211,'amiceli@blackzim.com', '2019-04-22', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (212,'ldevreese@sonron.com', '2019-04-23', 'Approved', 'Linn',  'Borgman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (213,'esaylors@groovestreet.com', '2019-04-23', 'Approved', 'Angella',  'Patak');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (214,'cpugh@domzoom.com', '2019-04-24', 'Rejected', 'Mitsue',  'Kolmetz');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (215,'ckippley@plussunin.com', '2019-04-24', 'Rejected', 'Staci',  'Hengel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (216,'icaldarera@yearin.com', '2019-04-25', 'Approved', 'Roosevelt',  'Hirpara');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (217,'rgarufi@bioplex.com', '2019-04-25', 'Approved', 'Jovita',  'Tomblin');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (218,'lnunlee@ron-tech.com', '2019-04-25', 'Approved', 'Raymon',  'Auber');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (219,'kharnos@conecom.com', '2019-04-26', 'Approved', 'Nicolette',  'Weight');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (220,'anievas@rangreen.com', '2019-04-29', 'Approved', 'Lettie',  'Yum');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (221,'lflister@hottechi.com', '2019-04-29', 'Approved', 'Sharee',  'Ventura');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (222,'kbenimadho@donquadtech.com', '2019-04-29', 'Approved', 'Venita',  'Beech');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (223,'xdubaldi@iselectrics.com', '2019-04-30', 'Approved', 'Kerry',  'Lipke');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (224,'ttromblay@dontechi.com', '2019-04-30', 'Approved', 'Elli',  'Dilliard');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (225,'esaylors@y-corporation.com', '2019-04-30', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (226,'ladkin@domzoom.com', '2019-05-01', 'Approved', 'Talia',  'Tolfree');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (227,'snicka@year-job.com', '2019-05-01', 'Approved', 'Karan',  'Bilden');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (228,'lkippley@golddex.com', '2019-05-01', 'Approved', 'Laurel',  'Stockham');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (229,'xdubaldi@iselectrics.com', '2019-05-02', 'Approved', 'Levi',  'Haufler');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (230,'lkippley@golddex.com', '2019-05-02', 'Approved', 'Dalene',  'Pelkowski');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (231,'ncartan@statholdings.com', '2019-05-03', 'Approved', 'Beatriz',  'Montezuma');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (232,'kharnos@conecom.com', '2019-05-03', 'Approved', 'Rickie',  'Aquas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (233,'rvanheusen@statholdings.com', '2019-05-06', 'Approved', 'Kallie',  'Strassner');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (234,'bdiestel@condax.com', '2019-05-06', 'Approved', 'Skye',  'Chaffins');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (235,'esaylors@groovestreet.com', '2019-05-06', 'Approved', 'Thaddeus',  'Hughey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (236,'xdubaldi@iselectrics.com', '2019-05-07', 'Rejected', 'Detra',  'Rim');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (237,'rvanheusen@statholdings.com', '2019-05-07', 'Rejected', 'Antione',  'Tomblin');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (238,'trulapaugh@yearin.com', '2019-05-07', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (239,'bflosi@ganjaflex.com', '2019-05-08', 'Rejected', 'Ceola',  'Lace');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (240,'jlueckenbach@plussunin.com', '2019-05-08', 'Approved', 'Novella',  'Hirpara');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (241,'cfelger@stanredtax.com', '2019-05-09', 'Approved', 'Detra',  'Lace');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (242,'ldevreese@sonron.com', '2019-05-09', 'Approved', 'Merlyn',  'Oldroyd');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (243,'ccoody@sonron.com', '2019-05-10', 'Approved', 'Rikki',  'Hollack');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (244,'rhollack@plexzap.com', '2019-05-10', 'Pending', 'Quentin',  'Wildfong');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (245,'cmorasca@ganjaflex.com', '2019-05-10', 'Rejected', 'Sabra',  'Dilliard');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (246,'ltheodorov@opentech.com', '2019-05-10', 'Rejected', 'Lizbeth',  'Cronauer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (247,'msarao@newex.com', '2019-05-13', 'Approved', 'Meaghan',  'Samu');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (248,'smeteer@dalttechnology.com', '2019-05-13', 'Approved', 'Fatima',  'Berlanga');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (249,'ahoogland@y-corporation.com', '2019-05-14', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (250,'cbourbon@betasoloin.com', '2019-05-15', 'Approved', 'Leslie',  'Papasergi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (251,'rhollack@plexzap.com', '2019-05-15', 'Pending', 'Regenia',  'Perez');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (252,'brestrepo@xx-holding.com', '2019-05-16', 'Rejected', 'Heike',  'Asar');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (253,'lsteffensmeier@gogozoom.com', '2019-05-16', 'Rejected', 'Bette',  'Diestel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (254,'ehirpara@sunnamplex.com', '2019-05-16', 'Approved', 'Denise',  'Frankel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (255,'mhoopengardner@xx-holding.com', '2019-05-17', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (256,'egrenet@y-corporation.com', '2019-05-17', 'Approved', 'Fatima',  'Chesterfield');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (257,'jmirafuentes@rangreen.com', '2019-05-17', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (258,'esaylors@y-corporation.com', '2019-05-20', 'Rejected', 'Marjory',  'Burnard');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (259,'acoyier@hottechi.com', '2019-05-20', 'Approved', 'Tiera',  'Toelkes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (260,'bmastella@kan-code.com', '2019-05-20', 'Approved', 'Sheron',  'Paa');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (261,'traymo@scotfind.com', '2019-05-21', 'Rejected', 'Reena',  'Lukasik');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (262,'dturinetti@doncon.com', '2019-05-22', 'Approved', 'Van',  'Degonia');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (263,'ltheodorov@opentech.com', '2019-05-22', 'Approved', 'Bok',  'Ferrario');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (264,'elary@lexiqvolax.com', '2019-05-22', 'Approved', 'Carissa',  'Coody');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (265,'woles@codehow.com', '2019-05-23', 'Rejected', 'Jerry',  'Nestle');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (266,'mskulski@sumace.com', '2019-05-24', 'Approved', 'Felix',  'Storment');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (267,'vlouissant@sunnamplex.com', '2019-05-24', 'Approved', 'Franklyn',  'Nachor');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (268,'trulapaugh@yearin.com', '2019-05-27', 'Approved', 'Refugia',  'Sweely');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (269,'cmorasca@ganjaflex.com', '2019-05-27', 'Approved', 'Xuan',  'Dubaldi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (270,'dkines@betatech.com', '2019-05-28', 'Approved', 'Lai',  'Manno');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (271,'cscipione@kan-code.com', '2019-05-28', 'Approved', 'Annabelle',  'Harnos');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (272,'msetter@fasehatice.com', '2019-05-28', 'Approved', 'Izetta',  'Thyberg');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (273,'cpugh@domzoom.com', '2019-05-29', 'Approved', 'Mitsue',  'Kitzman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (274,'kbenimadho@donquadtech.com', '2019-05-29', 'Approved', 'Merlyn',  'Sturiale');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (275,'msarao@newex.com', '2019-05-29', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (276,'jdiscipio@singletechno.com', '2019-05-29', 'Approved', 'Gail',  'Buzick');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (277,'aspickerman@green-plus.com', '2019-05-30', 'Approved', 'Art',  'Gellinger');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (278,'elary@lexiqvolax.com', '2019-05-30', 'Approved', 'Dean',  'Luczki');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (279,'lsteffensmeier@gogozoom.com', '2019-05-31', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (280,'liturbide@dontechi.com', '2019-05-31', 'Pending', 'Alline',  'Gillaspie');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (281,'ghalter@konmatfix.com', '2019-05-31', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (282,'lharabedian@plussunin.com', '2019-05-31', 'Approved', 'Hubert',  'Royster');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (283,'aoles@bioplex.com', '2019-06-03', 'Approved', 'Xochitl',  'Heintzman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (284,'elary@lexiqvolax.com', '2019-06-03', 'Approved', 'Deonna',  'Gwalthney');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (285,'mskulski@sumace.com', '2019-06-04', 'Approved', 'Carissa',  'Pelkowski');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (286,'jkarpel@mathtouch.com', '2019-06-04', 'Rejected', 'Cecily',  'Newville');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (287,'egoldammer@scottech.com', '2019-06-05', 'Approved', 'Elvera',  'Craghead');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (288,'loldroyd@hottechi.com', '2019-06-05', 'Approved', 'Marjory',  'Hoffis');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (289,'lharabedian@plussunin.com', '2019-06-06', 'Rejected', 'Derick',  'Lace');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (290,'arulapaugh@zencorporation.com', '2019-06-07', 'Approved', 'Delisa',  'Angalich');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (291,'lnunlee@ron-tech.com', '2019-06-07', 'Approved', 'Krissy',  'Harabedian');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (292,'yisenhower@dambase.com', '2019-06-07', 'Approved', 'Elke',  'Bourbon');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (293,'snicka@year-job.com', '2019-06-07', 'Approved', 'Howard',  'Kalafatis');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (294,'cperruzza@doncon.com', '2019-06-10', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (295,'lflister@hottechi.com', '2019-06-10', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (296,'elary@lexiqvolax.com', '2019-06-10', 'Pending', 'Rolland',  'Maynerich');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (297,'jmirafuentes@rangreen.com', '2019-06-11', 'Approved', 'Simona',  'Andreason');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (298,'cmorasca@ganjaflex.com', '2019-06-11', 'Rejected', 'Alline',  'Andreason');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (299,'creitler@silis.com', '2019-06-11', 'Approved', 'Timothy',  'Degroot');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (300,'wstockham@zotware.com', '2019-06-12', 'Approved', 'Britt',  'Tolfree');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (301,'ebowley@ganjaflex.com', '2019-06-12', 'Approved', 'Olive',  'Flosi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (302,'esaylors@y-corporation.com', '2019-06-13', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (303,'cmorasca@ganjaflex.com', '2019-06-13', 'Approved', 'Shawnda',  'Wieser');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (304,'egrenet@y-corporation.com', '2019-06-14', 'Approved', 'Ashlyn',  'Hauenstein');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (305,'brestrepo@xx-holding.com', '2019-06-14', 'Approved', 'Lenna',  'Breland');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (306,'lsteffensmeier@gogozoom.com', '2019-06-17', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (307,'jacey@inity.com', '2019-06-17', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (308,'ladkin@domzoom.com', '2019-06-18', 'Approved', 'Penney',  'Rhymes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (309,'rbourbon@lexiqvolax.com', '2019-06-18', 'Approved', 'Jolanda',  'Mirafuentes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (310,'woles@codehow.com', '2019-06-18', 'Approved', 'Cassi',  'Grenet');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (311,'tkines@sumace.com', '2019-06-18', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (312,'msetter@fasehatice.com', '2019-06-19', 'Pending', 'Kate',  'Acuff');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (313,'lflister@hottechi.com', '2019-06-19', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (314,'msetter@fasehatice.com', '2019-06-20', 'Approved', 'Barrett',  'Pelkowski');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (315,'cpugh@domzoom.com', '2019-06-20', 'Approved', 'Jina',  'Venere');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (316,'wstockham@zotware.com', '2019-06-21', 'Rejected', 'Haydee',  'Vonasek');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (317,'lharoldson@rangreen.com', '2019-06-21', 'Approved', 'Melodie',  'Oldroyd');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (318,'tkines@sumace.com', '2019-06-21', 'Rejected', 'Mattie',  'Lawler');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (319,'eadkin@stanredtax.com', '2019-06-24', 'Pending', 'Youlanda',  'Mconnell');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (320,'lharabedian@plussunin.com', '2019-06-24', 'Rejected', 'Erinn',  'Stenseth');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (321,'yisenhower@dambase.com', '2019-06-24', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (322,'icaldarera@yearin.com', '2019-06-25', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (323,'bdiestel@condax.com', '2019-06-25', 'Approved', 'Paris',  'Yum');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (324,'rauber@dambase.com', '2019-06-26', 'Rejected', 'Hillary',  'Stuer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (325,'aboord@faxquote.com', '2019-06-26', 'Approved', 'Krissy',  'Hellickson');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (326,'hseewald@j-texon.com', '2019-06-26', 'Approved', 'Erinn',  'Biddy');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (327,'icaldarera@yearin.com', '2019-06-27', 'Approved', 'Mari',  'Arceo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (328,'lkippley@golddex.com', '2019-06-27', 'Approved', 'Tegan',  'Mconnell');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (329,'lbayless@sumace.com', '2019-06-28', 'Pending', 'Regenia',  'Sarbacher');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (330,'wstockham@zotware.com', '2019-06-28', 'Rejected', 'Youlanda',  'Lother');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (331,'esaylors@groovestreet.com', '2019-07-01', 'Approved', 'Lashaunda',  'Harabedian');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (332,'jacey@inity.com', '2019-07-01', 'Approved', 'Stevie',  'Hamilton');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (333,'ldevreese@sonron.com', '2019-07-01', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (334,'traymo@scotfind.com', '2019-07-02', 'Approved', 'Nichelle',  'Mugnolo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (335,'gschnitzler@y-corporation.com', '2019-07-02', 'Approved', 'Paris',  'Tjepkema');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (336,'kcraghead@sumace.com', '2019-07-02', 'Approved', 'Sue',  'Brossart');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (337,'eadkin@stanredtax.com', '2019-07-03', 'Rejected', 'Marguerita',  'Scriven');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (338,'tkines@sumace.com', '2019-07-03', 'Rejected', 'Natalie',  'Farrar');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (339,'etromblay@toughzap.com', '2019-07-04', 'Rejected', 'Gail',  'Auffrey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (340,'nhiatt@plexzap.com', '2019-07-04', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (341,'rvanheusen@statholdings.com', '2019-07-04', 'Approved', 'Nana',  'Chickering');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (342,'kbreland@year-job.com', '2019-07-05', 'Approved', 'Gearldine',  'Kines');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (343,'rbourbon@lexiqvolax.com', '2019-07-05', 'Approved', 'Laticia',  'Weirather');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (344,'ghalter@konmatfix.com', '2019-07-08', 'Approved', 'Alpha',  'Stenseth');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (345,'dgellinger@dambase.com', '2019-07-08', 'Approved', 'Maryann',  'Nayar');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (346,'jlueckenbach@plussunin.com', '2019-07-08', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (347,'liturbide@dontechi.com', '2019-07-09', 'Rejected', 'Alesia',  'Comnick');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (348,'jrestrepo@konmatfix.com', '2019-07-09', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (349,'rauber@dambase.com', '2019-07-09', 'Approved', 'Junita',  'Pedrozo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (350,'aoles@bioplex.com', '2019-07-10', 'Approved', 'Edna',  'Grenet');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (351,'gkines@inity.com', '2019-07-10', 'Approved', 'Ashlyn',  'Dewar');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (352,'wmeteer@domzoom.com', '2019-07-11', 'Approved', 'Jose',  'Wiklund');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (353,'lbayless@sumace.com', '2019-07-11', 'Rejected', 'Leatha',  'Iturbide');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (354,'smeteer@dalttechnology.com', '2019-07-11', 'Approved', 'Mariann',  'Kiel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (355,'lpadilla@conecom.com', '2019-07-12', 'Approved', 'Lindsey',  'Riden');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (356,'rbourbon@lexiqvolax.com', '2019-07-12', 'Approved', 'Elza',  'Papasergi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (357,'dkines@betatech.com', '2019-07-12', 'Rejected', 'Deandrea',  'Bartolet');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (358,'brhym@dambase.com', '2019-07-15', 'Approved', 'Britt',  'Neither');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (359,'iferrario@plexzap.com', '2019-07-15', 'Approved', 'Corinne',  'Stockham');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (360,'cperruzza@doncon.com', '2019-07-15', 'Approved', 'Corinne',  'Bolognia');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (361,'aboord@faxquote.com', '2019-07-16', 'Approved', 'Cristy',  'Pedrozo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (362,'cyori@donware.com', '2019-07-16', 'Approved', 'Elly',  'Adkin');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (363,'cperruzza@doncon.com', '2019-07-17', 'Approved', 'Youlanda',  'Lueckenbach');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (364,'estenseth@cancity.com', '2019-07-17', 'Rejected', 'Jerry',  'Malet');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (365,'kharnos@conecom.com', '2019-07-17', 'Approved', 'Mariann',  'Emard');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (366,'kweglarz@streethex.com', '2019-07-18', 'Rejected', 'Devora',  'Moyd');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (367,'aspickerman@green-plus.com', '2019-07-18', 'Rejected', 'Malcolm',  'Gleich');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (368,'mhollack@scottech.com', '2019-07-18', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (369,'esaylors@y-corporation.com', '2019-07-19', 'Rejected', 'Jolene',  'Shire');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (370,'afigeroa@labdrill.com', '2019-07-19', 'Approved', 'Avery',  'Fritz');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (371,'lschoeneck@streethex.com', '2019-07-22', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (372,'chagele@zencorporation.com', '2019-07-22', 'Approved', 'Rasheeda',  'Palaia');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (373,'kpatak@groovestreet.com', '2019-07-23', 'Rejected', 'Nicolette',  'Haufler');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (374,'mreitler@fasehatice.com', '2019-07-24', 'Rejected', 'Mariann',  'Waymire');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (375,'dgellinger@dambase.com', '2019-07-24', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (376,'ebowley@ganjaflex.com', '2019-07-25', 'Approved', 'Sylvie',  'Miceli');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (377,'lwalthall@betasoloin.com', '2019-07-26', 'Approved', 'Kris',  'Bevelacqua');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (378,'jbuvens@plusstrip.com', '2019-07-26', 'Approved', 'Kaitlyn',  'Gudroe');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (379,'awildfong@conecom.com', '2019-07-26', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (380,'chirpara@rantouch.com', '2019-07-29', 'Approved', 'Amber',  'Chui');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (381,'jacey@inity.com', '2019-07-29', 'Approved', 'Jamal',  'Saras');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (382,'troyster@kan-code.com', '2019-07-30', 'Approved', 'Pamella',  'Upthegrove');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (383,'aspickerman@green-plus.com', '2019-07-31', 'Approved', 'Earleen',  'Perigo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (384,'whamilton@opentech.com', '2019-07-31', 'Pending', 'Wilda',  'Oles');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (385,'jacey@inity.com', '2019-07-31', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (386,'vknipp@year-job.com', '2019-08-01', 'Pending', 'Tamar',  'Heimann');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (387,'rtegarden@donquadtech.com', '2019-08-01', 'Rejected', 'Dalene',  'Isenhower');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (388,'cmorasca@ganjaflex.com', '2019-08-01', 'Approved', 'Kate',  'Bayless');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (389,'ckippley@plussunin.com', '2019-08-02', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (390,'arulapaugh@zencorporation.com', '2019-08-02', 'Approved', 'Arlette',  'Frerking');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (391,'jmirafuentes@rangreen.com', '2019-08-05', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (392,'szepp@dalttechnology.com', '2019-08-06', 'Approved', 'Levi',  'Kardas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (393,'woles@codehow.com', '2019-08-06', 'Approved', 'Daniel',  'Malet');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (394,'wstockham@zotware.com', '2019-08-06', 'Approved', 'Kristofer',  'Hauenstein');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (395,'eadkin@stanredtax.com', '2019-08-07', 'Approved', 'Derick',  'Hughey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (396,'jacey@inity.com', '2019-08-07', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (397,'arulapaugh@zencorporation.com', '2019-08-07', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (398,'jlueckenbach@plussunin.com', '2019-08-08', 'Approved', 'Danica',  'Springe');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (399,'estenseth@cancity.com', '2019-08-08', 'Approved', 'Catarina',  'Pagliuca');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (400,'lkarpel@nam-zim.com', '2019-08-09', 'Approved', 'Skye',  'Lorens');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (401,'fdelasancha@inity.com', '2019-08-09', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (402,'rtegarden@donquadtech.com', '2019-08-09', 'Pending', 'Josphine',  'Scriven');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (403,'cperruzza@doncon.com', '2019-08-12', 'Approved', 'Jose',  'Saylors');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (404,'bflosi@ganjaflex.com', '2019-08-12', 'Approved', 'Marti',  'Chaffins');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (405,'ttromblay@dontechi.com', '2019-08-13', 'Pending', 'Jerry',  'Drymon');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (406,'eperigo@plussunin.com', '2019-08-13', 'Approved', 'Alesia',  'Claucherty');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (407,'rauber@dambase.com', '2019-08-13', 'Approved', 'Youlanda',  'Garufi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (408,'bdiestel@condax.com', '2019-08-14', 'Approved', 'Izetta',  'Frey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (409,'lkarpel@nam-zim.com', '2019-08-14', 'Pending', 'Alecia',  'Rulapaugh');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (410,'ltheodorov@opentech.com', '2019-08-15', 'Approved', 'Roosevelt',  'Dilello');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (411,'aboord@faxquote.com', '2019-08-15', 'Approved', 'Whitley',  'Nicolozakes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (412,'msetter@fasehatice.com', '2019-08-16', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (413,'trulapaugh@yearin.com', '2019-08-16', 'Rejected', 'Theodora',  'Haroldson');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (414,'whamilton@opentech.com', '2019-08-19', 'Rejected', 'Evangelina',  'Treston');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (415,'rauber@dambase.com', '2019-08-20', 'Approved', 'Dyan',  'Ragel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (416,'kmyricks@groovestreet.com', '2019-08-20', 'Approved', 'Leota',  'Hauenstein');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (417,'nhaufler@zencorporation.com', '2019-08-21', 'Approved', 'Louisa',  'Klang');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (418,'snicka@year-job.com', '2019-08-21', 'Rejected', 'Myra',  'Shealy');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (419,'dangalich@donware.com', '2019-08-22', 'Approved', 'Annmarie',  'Coyier');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (420,'smeteer@dalttechnology.com', '2019-08-22', 'Rejected', 'Teddy',  'Grenet');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (421,'cyori@donware.com', '2019-08-22', 'Pending', 'Janey',  'Caiafa');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (422,'aostolaza@finjob.com', '2019-08-23', 'Approved', 'Cyril',  'Motley');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (423,'ncartan@statholdings.com', '2019-08-23', 'Approved', 'Simona',  'Mulqueen');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (424,'eperigo@plussunin.com', '2019-08-26', 'Pending', 'Kati',  'Diestel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (425,'kpatak@groovestreet.com', '2019-08-26', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (426,'icaldarera@yearin.com', '2019-08-27', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (427,'yisenhower@dambase.com', '2019-08-27', 'Approved', 'Lettie',  'Fritz');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (428,'hgwalthney@funholding.com', '2019-08-28', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (429,'brhym@dambase.com', '2019-08-28', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (430,'creitler@silis.com', '2019-08-28', 'Pending', 'Larae',  'Maclead');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (431,'cpugh@domzoom.com', '2019-08-29', 'Rejected', 'Joseph',  'Samu');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (432,'bsengbusch@singletechno.com', '2019-08-30', 'Approved', 'Josphine',  'Nievas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (433,'jdiscipio@singletechno.com', '2019-08-30', 'Approved', 'Nan',  'Isaacs');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (434,'dturinetti@doncon.com', '2019-09-02', 'Pending', 'Jade',  'Ostrosky');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (435,'dseewald@goodsilron.com', '2019-09-02', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (436,'jacey@inity.com', '2019-09-03', 'Approved', 'Tegan',  'Colla');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (437,'ckannady@dambase.com', '2019-09-03', 'Rejected', 'Kanisha',  'Mugnolo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (438,'rgarufi@bioplex.com', '2019-09-03', 'Pending', 'Salena',  'Miceli');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (439,'cscipione@kan-code.com', '2019-09-04', 'Rejected', 'Raul',  'Berray');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (440,'liturbide@dontechi.com', '2019-09-04', 'Pending', 'Willow',  'Oles');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (441,'nhaufler@zencorporation.com', '2019-09-05', 'Pending', 'Viola',  'Chavous');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (442,'vknipp@year-job.com', '2019-09-06', 'Pending', 'Helga',  'Callaro');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (443,'rgarufi@bioplex.com', '2019-09-06', 'Pending', 'Eden',  'Ankeny');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (444,'cscipione@kan-code.com', '2019-09-06', 'Rejected', 'Tamar',  'Nicolozakes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (445,'lharabedian@plussunin.com', '2019-09-06', 'Approved', 'Van',  'Breland');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (446,'lsturiale@silis.com', '2019-09-09', 'Approved', 'Winfred',  'Lipkin');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (447,'vkeener@kan-code.com', '2019-09-09', 'Rejected', 'Annabelle',  'Klimek');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (448,'ahusser@finhigh.com', '2019-09-10', 'Approved', 'Pete',  'Maisto');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (449,'mskulski@sumace.com', '2019-09-10', 'Approved', 'Derick',  'Tolfree');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (450,'jacey@inity.com', '2019-09-10', 'Rejected', 'Jamal',  'Latzke');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (451,'lbayless@sumace.com', '2019-09-10', 'Pending', 'Kayleigh',  'Craghead');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (452,'wmeteer@domzoom.com', '2019-09-11', 'Approved', 'Elly',  'Craghead');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (453,'lkippley@golddex.com', '2019-09-12', 'Approved', 'Alyce',  'Meteer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (454,'ckippley@plussunin.com', '2019-09-13', 'Rejected', 'Margart',  'Maynerich');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (455,'esaylors@groovestreet.com', '2019-09-13', 'Approved', 'Carmela',  'Sengbusch');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (456,'lstockham@j-texon.com', '2019-09-13', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (457,'jzurcher@domzoom.com', '2019-09-16', 'Approved', 'Cyndy',  'Dorshorst');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (458,'cfelger@stanredtax.com', '2019-09-16', 'Approved', 'Shalon',  'Dorshorst');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (459,'ahoogland@doncon.com', '2019-09-16', 'Approved', 'Rolland',  'Pugh');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (460,'dscipione@dambase.com', '2019-09-17', 'Rejected', 'Rebecka',  'Hagele');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (461,'traymo@scotfind.com', '2019-09-17', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (462,'anievas@rangreen.com', '2019-09-17', 'Pending', 'Lorrie',  'Morocco');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (463,'lsturiale@silis.com', '2019-09-18', 'Approved', 'Yolando',  'Louissant');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (464,'ebowley@ganjaflex.com', '2019-09-18', 'Approved', 'Sheron',  'Haroldson');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (465,'ccoody@sonron.com', '2019-09-18', 'Pending', 'Lucina',  'Koppinger');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (466,'cpugh@domzoom.com', '2019-09-19', 'Approved', 'Venita',  'Hollack');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (467,'hmenter@doncon.com', '2019-09-19', 'Approved', 'Mitsue',  'Pagliuca');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (468,'lharabedian@plussunin.com', '2019-09-19', 'Approved', 'Delmy',  'Farrow');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (469,'cbourbon@betasoloin.com', '2019-09-20', 'Approved', 'Carma',  'Ankeny');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (470,'yisenhower@dambase.com', '2019-09-23', 'Approved', 'Olive',  'Luczki');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (471,'ggalam@ron-tech.com', '2019-09-23', 'Approved', 'Louisa',  'Kippley');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (472,'jmirafuentes@rangreen.com', '2019-09-24', 'Pending', 'Devorah',  'Rauser');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (473,'gkines@inity.com', '2019-09-24', 'Approved', 'Weldon',  'Seewald');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (474,'lwalthall@betasoloin.com', '2019-09-24', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (475,'vknipp@year-job.com', '2019-09-25', 'Approved', 'Valentine',  'Hengel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (476,'jkarpel@mathtouch.com', '2019-09-25', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (477,'oflosi@betatech.com', '2019-09-26', 'Approved', 'Glen',  'Smith');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (478,'aoles@bioplex.com', '2019-09-26', 'Approved', 'Maryann',  'Kohnert');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (479,'dangalich@donware.com', '2019-09-27', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (480,'ckannady@dambase.com', '2019-09-27', 'Approved', 'Tiffiny',  'Waycott');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (481,'lflister@hottechi.com', '2019-09-30', 'Approved', 'Georgene',  'Oles');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (482,'whamilton@opentech.com', '2019-09-30', 'Approved', 'Gregoria',  'Skulski');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (483,'troyster@kan-code.com', '2019-10-01', 'Rejected', 'Lonny',  'Haroldson');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (484,'adenooyer@kinnamplus.com', '2019-10-01', 'Approved', 'Helene',  'Sweigard');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (485,'ladkin@domzoom.com', '2019-10-02', 'Approved', 'Gayla',  'Gleich');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (486,'vlouissant@sunnamplex.com', '2019-10-03', 'Approved', 'Kristeen',  'Cetta');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (487,'aostolaza@finjob.com', '2019-10-03', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (488,'cpaulas@opentech.com', '2019-10-03', 'Rejected', 'Bernardine',  'Brucato');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (489,'lbayless@sumace.com', '2019-10-04', 'Approved', 'Nan',  'Denooyer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (490,'ahusser@finhigh.com', '2019-10-07', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (491,'kcraghead@sumace.com', '2019-10-07', 'Rejected', 'Helga',  'Mirafuentes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (492,'mhoopengardner@xx-holding.com', '2019-10-08', 'Approved', 'Louisa',  'Candlish');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (493,'troyster@kan-code.com', '2019-10-08', 'Approved', 'Mona',  'Keneipp');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (494,'lmunns@toughzap.com', '2019-10-09', 'Rejected', 'Carey',  'Harabedian');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (495,'lbayless@sumace.com', '2019-10-09', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (496,'lmorocco@year-job.com', '2019-10-09', 'Approved', 'Charlene',  'Foller');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (497,'ehirpara@sunnamplex.com', '2019-10-10', 'Rejected', 'Marjory',  'Slusarski');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (498,'lmorocco@year-job.com', '2019-10-10', 'Approved', 'Tonette',  'Frankel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (499,'ebachman@goodsilron.com', '2019-10-11', 'Approved', 'Beatriz',  'Karpin');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (500,'esaylors@y-corporation.com', '2019-10-11', 'Approved', 'Leonida',  'Adkin');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (501,'mbolognia@finjob.com', '2019-10-14', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (502,'bsengbusch@singletechno.com', '2019-10-14', 'Approved', 'Jennie',  'Vizarro');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (503,'cpagliuca@betasoloin.com', '2019-10-15', 'Approved', 'Lizette',  'Stimmel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (504,'aspickerman@green-plus.com', '2019-10-15', 'Approved', 'Deonna',  'Steffensmeier');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (505,'lflister@hottechi.com', '2019-10-16', 'Pending', 'Fatima',  'Toelkes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (506,'mreiber@scottech.com', '2019-10-16', 'Approved', 'Melodie',  'Luczki');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (507,'gkines@inity.com', '2019-10-16', 'Pending', 'Nelida',  'Rentfro');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (508,'vlouissant@sunnamplex.com', '2019-10-17', 'Rejected', 'Fabiola',  'Bubash');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (509,'nhaufler@zencorporation.com', '2019-10-17', 'Approved', 'Katina',  'Benimadho');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (510,'kweglarz@streethex.com', '2019-10-17', 'Approved', 'Clorinda',  'Hirpara');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (511,'afigeroa@labdrill.com', '2019-10-18', 'Rejected', 'Abel',  'Amyot');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (512,'hmenter@doncon.com', '2019-10-18', 'Approved', 'Ma',  'Shields');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (513,'brestrepo@xx-holding.com', '2019-10-21', 'Pending', 'Golda',  'Hellickson');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (514,'cyori@donware.com', '2019-10-21', 'Approved', 'Lenna',  'Grenet');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (515,'cperruzza@doncon.com', '2019-10-22', 'Rejected', 'Stephane',  'Kalafatis');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (516,'oflosi@betatech.com', '2019-10-22', 'Rejected', 'Beatriz',  'Semidey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (517,'jlueckenbach@plussunin.com', '2019-10-23', 'Approved', 'Andra',  'Craghead');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (518,'chirpara@rantouch.com', '2019-10-23', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (519,'elary@lexiqvolax.com', '2019-10-23', 'Pending', 'Eun',  'Berganza');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (520,'lharoldson@rangreen.com', '2019-10-24', 'Pending', 'Kanisha',  'Harnos');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (521,'eadkin@stanredtax.com', '2019-10-24', 'Approved', 'Rasheeda',  'Acey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (522,'rtegarden@donquadtech.com', '2019-10-24', 'Approved', 'Peggie',  'Martabano');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (523,'jzurcher@domzoom.com', '2019-10-25', 'Approved', 'Nobuko',  'Mulqueen');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (524,'gkines@inity.com', '2019-10-25', 'Pending', 'Rikki',  'Hoffis');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (525,'mreiber@scottech.com', '2019-10-28', 'Approved', 'Carma',  'Riopelle');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (526,'lbayless@sumace.com', '2019-10-28', 'Approved', 'Adell',  'Loader');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (527,'lpadilla@conecom.com', '2019-10-29', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (528,'awildfong@conecom.com', '2019-10-29', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (529,'rgarufi@bioplex.com', '2019-10-29', 'Approved', 'Nichelle',  'Riden');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (530,'fdelasancha@inity.com', '2019-10-30', 'Pending', 'Valentine',  'Wide');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (531,'kcraghead@sumace.com', '2019-10-30', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (532,'gschnitzler@y-corporation.com', '2019-10-31', 'Approved', 'Shonda',  'Nicka');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (533,'kharnos@conecom.com', '2019-10-31', 'Approved', 'Timothy',  'Yglesias');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (534,'mstem@betasoloin.com', '2019-11-01', 'Approved', 'Bulah',  'Schoeneck');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (535,'ccoody@sonron.com', '2019-11-01', 'Approved', 'Merilyn',  'Meisel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (536,'amiceli@blackzim.com', '2019-11-01', 'Approved', 'Izetta',  'Julia');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (537,'jblackwood@dambase.com', '2019-11-04', 'Pending', 'Sharen',  'Fillingim');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (538,'kcraghead@sumace.com', '2019-11-04', 'Pending', 'Micaela',  'Buemi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (539,'lkarpel@nam-zim.com', '2019-11-05', 'Approved', 'Alisha',  'Eschberger');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (540,'elary@lexiqvolax.com', '2019-11-05', 'Pending', 'Ammie',  'Polidori');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (541,'mhoopengardner@xx-holding.com', '2019-11-06', 'Rejected', 'Marvel',  'Skulski');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (542,'yisenhower@dambase.com', '2019-11-06', 'Approved', 'Cecil',  'Rodefer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (543,'jrestrepo@konmatfix.com', '2019-11-06', 'Approved', 'Nobuko',  'Paulas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (544,'dgellinger@dambase.com', '2019-11-07', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (545,'bdiestel@condax.com', '2019-11-08', 'Approved', 'Becky',  'Buzick');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (546,'vknipp@year-job.com', '2019-11-08', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (547,'adenooyer@kinnamplus.com', '2019-11-08', 'Approved', 'Gail',  'Fredicks');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (548,'lharoldson@rangreen.com', '2019-11-11', 'Approved', 'Shenika',  'Dinos');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (549,'cmorasca@ganjaflex.com', '2019-11-11', 'Approved', 'Audry',  'Fallick');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (550,'cfelger@stanredtax.com', '2019-11-12', 'Pending', 'Tiffiny',  'Korando');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (551,'snicka@year-job.com', '2019-11-12', 'Rejected', 'Tegan',  'Springe');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (552,'ahoogland@y-corporation.com', '2019-11-13', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (553,'chirpara@rantouch.com', '2019-11-13', 'Rejected', 'Ernie',  'Bowley');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (554,'chagele@zencorporation.com', '2019-11-14', 'Approved', 'Bernardo',  'Nicka');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (555,'loldroyd@hottechi.com', '2019-11-14', 'Pending', 'Fletcher',  'Gotter');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (556,'aostolaza@finjob.com', '2019-11-15', 'Approved', 'Ty',  'Raymo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (557,'chirpara@rantouch.com', '2019-11-15', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (558,'esaylors@groovestreet.com', '2019-11-18', 'Approved', 'Lai',  'Cloney');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (559,'bsengbusch@singletechno.com', '2019-11-18', 'Approved', 'Bobbye',  'Strassner');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (560,'mstem@betasoloin.com', '2019-11-19', 'Rejected', 'Daniel',  'Seewald');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (561,'ebowley@ganjaflex.com', '2019-11-19', 'Rejected', 'Viola',  'Halter');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (562,'trulapaugh@yearin.com', '2019-11-20', 'Approved', 'Melissa',  'Gillaspie');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (563,'estenseth@cancity.com', '2019-11-20', 'Pending', 'Johnetta',  'Poquette');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (564,'cperruzza@doncon.com', '2019-11-20', 'Approved', 'Antione',  'Coyier');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (565,'xdubaldi@iselectrics.com', '2019-11-21', 'Rejected', 'Solange',  'Limmel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (566,'traymo@scotfind.com', '2019-11-22', 'Approved', 'Rebecka',  'Biddy');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (567,'rbourbon@lexiqvolax.com', '2019-11-22', 'Rejected', 'Barrett',  'Worlds');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (568,'vlouissant@sunnamplex.com', '2019-11-25', 'Pending', 'Merilyn',  'Bruschke');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (569,'hmenter@doncon.com', '2019-11-25', 'Pending', 'Clorinda',  'Manno');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (570,'msarao@newex.com', '2019-11-26', 'Pending', 'Izetta',  'Albares');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (571,'aacey@dontechi.com', '2019-11-26', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (572,'rauber@dambase.com', '2019-11-26', 'Approved', 'Nobuko',  'Gillian');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (573,'lmunns@toughzap.com', '2019-11-27', 'Approved', 'Lai',  'Devreese');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (574,'jpoquette@ron-tech.com', '2019-11-27', 'Approved', 'Clay',  'Pugh');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (575,'lharoldson@rangreen.com', '2019-11-28', 'Pending', 'Bobbye',  'Gochal');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (576,'dturinetti@doncon.com', '2019-11-29', 'Rejected', 'Novella',  'Plumer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (577,'cmorasca@ganjaflex.com', '2019-11-29', 'Approved', 'Cheryl',  'Cryer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (578,'ladkin@domzoom.com', '2019-12-02', 'Approved', 'Rolande',  'Sergi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (579,'lflister@hottechi.com', '2019-12-02', 'Rejected', 'Lenna',  'Threets');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (580,'kbreland@year-job.com', '2019-12-02', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (581,'lstockham@j-texon.com', '2019-12-03', 'Approved', 'Jesusa',  'Ankeny');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (582,'cpaulas@opentech.com', '2019-12-03', 'Approved', 'France',  'Tillotson');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (583,'elary@lexiqvolax.com', '2019-12-04', 'Approved', 'Minna',  'Hoopengardner');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (584,'tkines@sumace.com', '2019-12-04', 'Approved', 'Filiberto',  'Melnyk');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (585,'cmorasca@ganjaflex.com', '2019-12-04', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (586,'hgwalthney@funholding.com', '2019-12-05', 'Approved', 'Willodean',  'Maillard');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (587,'ehirpara@sunnamplex.com', '2019-12-05', 'Approved', 'Ernie',  'Rodefer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (588,'aboord@faxquote.com', '2019-12-05', 'Approved', 'Jacqueline',  'Zagen');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (589,'gschnitzler@y-corporation.com', '2019-12-06', 'Pending', 'Nichelle',  'Acey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (590,'dstoltzman@condax.com', '2019-12-06', 'Approved', 'Rebecka',  'Keetch');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (591,'lbayless@sumace.com', '2019-12-09', 'Approved', 'Xuan',  'Juvera');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (592,'aacey@dontechi.com', '2019-12-09', 'Approved', 'Glen',  'Merced');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (593,'lhamilton@labdrill.com', '2019-12-09', 'Approved', 'Jolanda',  'Discipio');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (594,'woles@codehow.com', '2019-12-10', 'Approved', 'Annelle',  'Pinilla');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (595,'ncartan@statholdings.com', '2019-12-10', 'Approved', 'Chauncey',  'Mallett');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (596,'kpatak@groovestreet.com', '2019-12-10', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (597,'nhiatt@plexzap.com', '2019-12-11', 'Approved', 'Theola',  'Kines');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (598,'dstoltzman@condax.com', '2019-12-11', 'Approved', 'Elke',  'Lace');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (599,'dangalich@donware.com', '2019-12-12', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (600,'woles@codehow.com', '2019-12-12', 'Rejected', 'Lonny',  'Stimmel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (601,'elary@lexiqvolax.com', '2019-12-12', 'Rejected', 'Corinne',  'Onofrio');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (602,'kbreland@year-job.com', '2019-12-13', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (603,'dgellinger@dambase.com', '2019-12-13', 'Approved', 'Solange',  'Blunk');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (604,'amiceli@blackzim.com', '2019-12-16', 'Pending', 'Daren',  'Similton');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (605,'gschnitzler@y-corporation.com', '2019-12-16', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (606,'msetter@fasehatice.com', '2019-12-16', 'Approved', 'Beatriz',  'Sengbusch');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (607,'bdiestel@condax.com', '2019-12-17', 'Approved', 'Ty',  'Maynerich');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (608,'jspickerman@y-corporation.com', '2019-12-17', 'Approved', 'Kaitlyn',  'Keneipp');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (609,'msetter@fasehatice.com', '2019-12-17', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (610,'brhym@dambase.com', '2019-12-18', 'Pending', 'Glen',  'Yori');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (611,'dscipione@dambase.com', '2019-12-18', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (612,'fdelasancha@inity.com', '2019-12-19', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (613,'jmirafuentes@rangreen.com', '2019-12-19', 'Approved', 'Karl',  'Schoeneck');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (614,'trulapaugh@yearin.com', '2019-12-20', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (615,'jspickerman@y-corporation.com', '2019-12-20', 'Pending', 'Shenika',  'Rodeigues');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (616,'agillaspie@golddex.com', '2019-12-23', 'Rejected', 'Stephaine',  'Corrington');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (617,'agillaspie@golddex.com', '2019-12-23', 'Pending', 'Shawna',  'Schemmer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (618,'aboord@faxquote.com', '2019-12-24', 'Approved', 'Hermila',  'Weglarz');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (619,'acoyier@hottechi.com', '2019-12-25', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (620,'jblackwood@dambase.com', '2019-12-25', 'Approved', 'Alishia',  'Acey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (621,'dseewald@goodsilron.com', '2019-12-26', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (622,'dangalich@donware.com', '2019-12-26', 'Approved', 'Ty',  'Munis');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (623,'ladkin@domzoom.com', '2019-12-27', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (624,'lmunns@toughzap.com', '2019-12-27', 'Approved', 'Daren',  'Rowling');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (625,'ttromblay@dontechi.com', '2019-12-30', 'Approved', 'Markus',  'Moyd');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (626,'aoles@bioplex.com', '2019-12-30', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (627,'ldevreese@sonron.com', '2019-12-31', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (628,'esaylors@groovestreet.com', '2019-12-31', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (629,'eadkin@stanredtax.com', '2019-12-31', 'Approved', 'Freeman',  'Varriano');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (630,'ckippley@plussunin.com', '2020-01-01', 'Approved', 'Shawnda',  'Ogg');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (631,'ttromblay@dontechi.com', '2020-01-01', 'Approved', 'Blondell',  'Kohl');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (632,'lwalthall@betasoloin.com', '2020-01-02', 'Approved', 'Daron',  'Fern');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (633,'lmonarrez@goodsilron.com', '2020-01-02', 'Approved', 'Pamella',  'Agramonte');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (634,'jmirafuentes@rangreen.com', '2020-01-02', 'Rejected', 'Mitsue',  'Bolognia');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (635,'lhamilton@labdrill.com', '2020-01-02', 'Approved', 'Annmarie',  'Tromblay');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (636,'hseewald@j-texon.com', '2020-01-03', 'Pending', 'Ammie',  'Pinilla');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (637,'hgwalthney@funholding.com', '2020-01-06', 'Pending', 'Gertude',  'Mauson');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (638,'kbreland@year-job.com', '2020-01-06', 'Approved', 'Vincent',  'Reitler');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (639,'loldroyd@hottechi.com', '2020-01-07', 'Rejected', 'Hubert',  'Bitsuie');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (640,'clawler@dontechi.com', '2020-01-07', 'Pending', 'Karl',  'Kulzer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (641,'cbourbon@betasoloin.com', '2020-01-08', 'Pending', 'Ciara',  'Linahan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (642,'brestrepo@xx-holding.com', '2020-01-08', 'Pending', 'Lilli',  'Gleich');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (643,'dseewald@goodsilron.com', '2020-01-09', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (644,'ncartan@statholdings.com', '2020-01-09', 'Pending', 'Ammie',  'Husser');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (645,'bflosi@ganjaflex.com', '2020-01-10', 'Pending', 'Roxane',  'Lizama');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (646,'elary@lexiqvolax.com', '2020-01-13', 'Approved', 'Cammy',  'Hamilton');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (647,'agillaspie@golddex.com', '2020-01-13', 'Pending', 'Corinne',  'Schieler');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (648,'elary@lexiqvolax.com', '2020-01-13', 'Approved', 'Izetta',  'Monarrez');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (649,'lharoldson@rangreen.com', '2020-01-14', 'Approved', 'Cassi',  'Shire');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (650,'aboord@faxquote.com', '2020-01-14', 'Approved', 'Lili',  'Berray');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (651,'jpoquette@ron-tech.com', '2020-01-14', 'Approved', 'Raina',  'Karpel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (652,'rauber@dambase.com', '2020-01-15', 'Pending', 'Arminda',  'Skulski');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (653,'lharoldson@rangreen.com', '2020-01-15', 'Approved', 'Alline',  'Nievas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (654,'arulapaugh@zencorporation.com', '2020-01-15', 'Pending', 'Cristy',  'Bolognia');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (655,'cpagliuca@betasoloin.com', '2020-01-16', 'Rejected', 'Virgie',  'Maisto');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (656,'agillaspie@golddex.com', '2020-01-16', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (657,'wmeteer@domzoom.com', '2020-01-16', 'Approved', 'Salena',  'Scipione');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (658,'etromblay@toughzap.com', '2020-01-17', 'Rejected', 'Felix',  'Konopacki');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (659,'icaldarera@yearin.com', '2020-01-20', 'Pending', 'Jose',  'Bolognia');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (660,'agillaspie@golddex.com', '2020-01-20', 'Pending', 'Gladys',  'Berlanga');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (661,'vlouissant@sunnamplex.com', '2020-01-21', 'Approved', 'Amie',  'Mondella');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (662,'troyster@kan-code.com', '2020-01-22', 'Approved', 'Dean',  'Meinerding');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (663,'trulapaugh@yearin.com', '2020-01-22', 'Pending', 'Glory',  'Schnitzler');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (664,'clawler@dontechi.com', '2020-01-23', 'Pending', 'Tiffiny',  'Lietz');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (665,'cpagliuca@betasoloin.com', '2020-01-23', 'Approved', 'Jutta',  'Saulter');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (666,'vkeener@kan-code.com', '2020-01-24', 'Approved', 'Charlene',  'Maclead');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (667,'dseewald@goodsilron.com', '2020-01-24', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (668,'aspickerman@green-plus.com', '2020-01-27', 'Pending', 'Erick',  'Radde');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (669,'kpatak@groovestreet.com', '2020-01-27', 'Approved', 'Fatima',  'Bitsuie');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (670,'jspickerman@y-corporation.com', '2020-01-27', 'Approved', 'Ilene',  'Threets');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (671,'kharnos@conecom.com', '2020-01-28', 'Approved', 'Cecilia',  'Gesick');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (672,'mhoopengardner@xx-holding.com', '2020-01-28', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (673,'dscipione@dambase.com', '2020-01-28', 'Pending', 'Loren',  'Rentfro');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (674,'cpaulas@opentech.com', '2020-01-29', 'Approved', 'Dorthy',  'Kines');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (675,'lbayless@sumace.com', '2020-01-29', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (676,'dangalich@donware.com', '2020-01-29', 'Pending', 'Marge',  'Mondella');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (677,'mskulski@sumace.com', '2020-01-30', 'Pending', 'Tiffiny',  'Modzelewski');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (678,'xdubaldi@iselectrics.com', '2020-01-30', 'Pending', 'Amber',  'Harnos');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (679,'jbuvens@plusstrip.com', '2020-01-30', 'Approved', 'Merissa',  'Weglarz');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (680,'estenseth@cancity.com', '2020-01-31', 'Pending', 'Jesusita',  'Kusko');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (681,'cmorasca@ganjaflex.com', '2020-01-31', 'Approved', 'Carey',  'Vanheusen');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (682,'kweglarz@streethex.com', '2020-02-03', 'Pending', 'Jennifer',  'Gwalthney');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (683,'lsteffensmeier@gogozoom.com', '2020-02-03', 'Approved', 'Mirta',  'Hamilton');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (684,'lkarpel@nam-zim.com', '2020-02-04', 'Pending', 'Rolande',  'Tegarden');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (685,'whamilton@opentech.com', '2020-02-04', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (686,'ebowley@ganjaflex.com', '2020-02-05', 'Approved', 'Dierdre',  'Darakjy');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (687,'rgarufi@bioplex.com', '2020-02-06', 'Approved', 'Talia',  'Nabours');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (688,'afigeroa@labdrill.com', '2020-02-06', 'Pending', 'Regenia',  'Daufeldt');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (689,'lsteffensmeier@gogozoom.com', '2020-02-06', 'Rejected', 'Kallie',  'Strassner');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (690,'mhoopengardner@xx-holding.com', '2020-02-06', 'Approved', 'Theodora',  'Zane');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (691,'aspickerman@green-plus.com', '2020-02-07', 'Pending', 'Colette',  'Lukasik');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (692,'hmenter@doncon.com', '2020-02-07', 'Approved', 'Carissa',  'Farrar');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (693,'nhaufler@zencorporation.com', '2020-02-10', 'Pending', 'Tyra',  'Aquas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (694,'jdiscipio@singletechno.com', '2020-02-10', 'Pending', 'Virgina',  'Keener');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (695,'kbenimadho@donquadtech.com', '2020-02-10', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (696,'bflosi@ganjaflex.com', '2020-02-11', 'Pending', 'Ilene',  'Parlato');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (697,'jzurcher@domzoom.com', '2020-02-11', 'Pending', 'Ligia',  'Fallick');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (698,'msarao@newex.com', '2020-02-11', 'Pending', 'Shonda',  'Dubaldi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (699,'lbayless@sumace.com', '2020-02-12', 'Approved', 'Samira',  'Mconnell');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (700,'mbolognia@finjob.com', '2020-02-12', 'Approved', 'Theodora',  'Reitler');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (701,'lstockham@j-texon.com', '2020-02-13', 'Pending', 'Theola',  'Madarang');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (702,'kmyricks@groovestreet.com', '2020-02-13', 'Approved', 'Thurman',  'Zepp');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (703,'egrenet@y-corporation.com', '2020-02-14', 'Approved', 'Vilma',  'Hixenbaugh');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (704,'awildfong@conecom.com', '2020-02-14', 'Pending', 'Timothy',  'Kines');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (705,'wstockham@zotware.com', '2020-02-17', 'Pending', 'Buddy',  'Berray');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (706,'kcraghead@sumace.com', '2020-02-17', 'Approved', 'Bernardine',  'Degroot');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (707,'cperruzza@doncon.com', '2020-02-17', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (708,'aoles@bioplex.com', '2020-02-18', 'Approved', 'Shawnda',  'Tegarden');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (709,'fdelasancha@inity.com', '2020-02-18', 'Pending', 'Keneth',  'Stenseth');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (710,'ldevreese@sonron.com', '2020-02-19', 'Approved', 'Kenneth',  'Juhas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (711,'lbayless@sumace.com', '2020-02-19', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (712,'trulapaugh@yearin.com', '2020-02-20', 'Approved', 'Mitsue',  'Monarrez');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (713,'dseewald@goodsilron.com', '2020-02-20', 'Approved', 'Graciela',  'Rhym');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (714,'jdiscipio@singletechno.com', '2020-02-21', 'Pending', 'Teddy',  'Meteer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (715,'lbayless@sumace.com', '2020-02-21', 'Rejected', 'Hillary',  'Menter');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (716,'cmorasca@ganjaflex.com', '2020-02-21', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (717,'ckippley@plussunin.com', '2020-02-21', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (718,'kweglarz@streethex.com', '2020-02-24', 'Pending', 'Diane',  'Wenner');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (719,'etromblay@toughzap.com', '2020-02-25', 'Pending', 'Roslyn',  'Dilliard');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (720,'bpoullion@opentech.com', '2020-02-25', 'Pending', 'Deonna',  'Wenner');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (721,'fdelasancha@inity.com', '2020-02-26', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (722,'brestrepo@xx-holding.com', '2020-02-26', 'Pending', 'Lonny',  'Hiatt');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (723,'kbenimadho@donquadtech.com', '2020-02-27', 'Pending', 'Ligia',  'Campain');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (724,'creitler@silis.com', '2020-02-27', 'Approved', 'Dorothy',  'Kownacki');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (725,'lbayless@sumace.com', '2020-02-28', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (726,'ahusser@finhigh.com', '2020-02-28', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (727,'icaldarera@yearin.com', '2020-02-28', 'Approved', 'Vincenza',  'Bitsuie');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (728,'lmonarrez@goodsilron.com', '2020-03-02', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (729,'cpaulas@opentech.com', '2020-03-02', 'Pending', 'Daniela',  'Bruschke');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (730,'iferrario@plexzap.com', '2020-03-02', 'Pending', 'Lettie',  'Munns');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (731,'lkarpel@nam-zim.com', '2020-03-03', 'Rejected', 'France',  'Martabano');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (732,'snicka@year-job.com', '2020-03-03', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (733,'mskulski@sumace.com', '2020-03-03', 'Pending', 'Lonny',  'Ogg');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (734,'ggalam@ron-tech.com', '2020-03-04', 'Pending', 'Britt',  'Brucato');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (735,'mhoopengardner@xx-holding.com', '2020-03-04', 'Pending', 'Arlene',  'Ragel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (736,'anievas@rangreen.com', '2020-03-05', 'Approved', 'Bulah',  'Sayaphon');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (737,'creitler@silis.com', '2020-03-05', 'Rejected', 'Alecia',  'Schirpke');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (738,'chirpara@rantouch.com', '2020-03-06', 'Pending', 'Mitzie',  'Turinetti');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (739,'ahusser@finhigh.com', '2020-03-09', 'Approved', 'Shonda',  'Waymire');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (740,'kcraghead@sumace.com', '2020-03-09', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (741,'trulapaugh@yearin.com', '2020-03-09', 'Approved', 'Elouise',  'Tromblay');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (742,'brhym@dambase.com', '2020-03-09', 'Pending', 'Maryann',  'Wardrip');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (743,'adenooyer@kinnamplus.com', '2020-03-10', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (744,'lharabedian@plussunin.com', '2020-03-10', 'Approved', 'Kristofer',  'Lapage');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (745,'msetter@fasehatice.com', '2020-03-10', 'Pending', 'Mollie',  'Steffensmeier');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (746,'kweglarz@streethex.com', '2020-03-10', 'Approved', 'Caprice',  'Keetch');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (747,'dgellinger@dambase.com', '2020-03-11', 'Pending', 'Beatriz',  'Flosi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (748,'lpadilla@conecom.com', '2020-03-12', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (749,'estenseth@cancity.com', '2020-03-13', 'Approved', 'Donette',  'Rodeigues');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (750,'creitler@silis.com', '2020-03-13', 'Pending', 'Kaitlyn',  'Ventura');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (751,'lmunns@toughzap.com', '2020-03-13', 'Rejected', 'Joseph',  'Borgman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (752,'troyster@kan-code.com', '2020-03-16', 'Rejected', 'Estrella',  'Abdallah');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (753,'jblackwood@dambase.com', '2020-03-17', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (754,'ckannady@dambase.com', '2020-03-17', 'Approved', 'Geoffrey',  'Chavous');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (755,'ckannady@dambase.com', '2020-03-18', 'Pending', 'Virgie',  'Parvis');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (756,'jdiscipio@singletechno.com', '2020-03-18', 'Pending', 'Noah',  'Munns');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (757,'ebachman@goodsilron.com', '2020-03-18', 'Pending', 'Cherry',  'Bolognia');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (758,'smeteer@dalttechnology.com', '2020-03-19', 'Approved', 'Glenn',  'Perruzza');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (759,'cyori@donware.com', '2020-03-19', 'Rejected', 'Karl',  'Patak');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (760,'loldroyd@hottechi.com', '2020-03-20', 'Approved', 'Shenika',  'Pawlowicz');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (761,'jacey@inity.com', '2020-03-20', 'Approved', 'Lenna',  'Wide');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (762,'ebachman@goodsilron.com', '2020-03-23', 'Pending', 'Edna',  'Brossart');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (763,'lmorocco@year-job.com', '2020-03-23', 'Approved', 'Cecily',  'Yglesias');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (764,'etromblay@toughzap.com', '2020-03-23', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (765,'traymo@scotfind.com', '2020-03-23', 'Pending', 'Hoa',  'Wenzinger');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (766,'bmastella@kan-code.com', '2020-03-24', 'Pending', 'Salome',  'Bubash');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (767,'ncartan@statholdings.com', '2020-03-24', 'Pending', 'Lai',  'Brucato');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (768,'lharoldson@rangreen.com', '2020-03-25', 'Approved', 'Kanisha',  'Wolny');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (769,'egrenet@y-corporation.com', '2020-03-25', 'Rejected', 'Carmela',  'Kippley');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (770,'dseewald@goodsilron.com', '2020-03-26', 'Pending', 'Krissy',  'Ahle');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (771,'cfelger@stanredtax.com', '2020-03-26', 'Pending', 'Lindsey',  'Vanausdal');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (772,'lnunlee@ron-tech.com', '2020-03-26', 'Approved', 'Portia',  'Julia');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (773,'hseewald@j-texon.com', '2020-03-26', 'Pending', 'Nieves',  'Blackwood');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (774,'jdiscipio@singletechno.com', '2020-03-27', 'Pending', 'Joni',  'Restrepo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (775,'cpagliuca@betasoloin.com', '2020-03-27', 'Pending', 'Annelle',  'Gibes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (776,'lnunlee@ron-tech.com', '2020-03-30', 'Approved', 'Deandrea',  'Varriano');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (777,'vlouissant@sunnamplex.com', '2020-03-30', 'Pending', 'Jade',  'Rhymes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (778,'jkarpel@mathtouch.com', '2020-03-31', 'Pending', 'Lorrine',  'Karpel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (779,'jacey@inity.com', '2020-03-31', 'Pending', 'Yoko',  'Nachor');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (780,'smeteer@dalttechnology.com', '2020-04-01', 'Pending', 'Marjory',  'Schmaltz');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (781,'rvanheusen@statholdings.com', '2020-04-01', 'Rejected', 'Fernanda',  'Vonasek');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (782,'cperruzza@doncon.com', '2020-04-01', 'Pending', 'Van',  'Good');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (783,'ebachman@goodsilron.com', '2020-04-02', 'Approved', 'Laurel',  'Gudroe');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (784,'egoldammer@scottech.com', '2020-04-02', 'Approved', 'Roosevelt',  'Shields');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (785,'cyori@donware.com', '2020-04-03', 'Pending', 'Salena',  'Rauser');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (786,'bdiestel@condax.com', '2020-04-03', 'Pending', 'Sheridan',  'Garufi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (787,'lharoldson@rangreen.com', '2020-04-03', 'Approved', 'Claribel',  'Hagele');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (788,'lmunns@toughzap.com', '2020-04-06', 'Pending', 'Mariann',  'Corrington');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (789,'rauber@dambase.com', '2020-04-06', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (790,'lstockham@j-texon.com', '2020-04-06', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (791,'ahusser@finhigh.com', '2020-04-07', 'Pending', 'Lavera',  'Halsey');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (792,'rgarufi@bioplex.com', '2020-04-07', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (793,'ladkin@domzoom.com', '2020-04-08', 'Pending', 'Pamella',  'Schnitzler');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (794,'esaylors@y-corporation.com', '2020-04-08', 'Pending', 'Rima',  'Beech');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (795,'egoldammer@scottech.com', '2020-04-08', 'Pending', 'Peggie',  'Gudroe');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (796,'lharoldson@rangreen.com', '2020-04-09', 'Pending', 'Daron',  'Hoa');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (797,'aboord@faxquote.com', '2020-04-09', 'Approved', 'Theola',  'Chesterfield');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (798,'chagele@zencorporation.com', '2020-04-09', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (799,'lpadilla@conecom.com', '2020-04-10', 'Pending', 'Sabra',  'Rochin');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (800,'mskulski@sumace.com', '2020-04-13', 'Pending', 'Brittni',  'Mastella');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (801,'jbuvens@plusstrip.com', '2020-04-13', 'Pending', 'Novella',  'Lindall');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (802,'gkines@inity.com', '2020-04-14', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (803,'etromblay@toughzap.com', '2020-04-15', 'Pending', 'Heike',  'Weirather');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (804,'lharabedian@plussunin.com', '2020-04-15', 'Pending', 'Sheridan',  'Abdallah');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (805,'lflister@hottechi.com', '2020-04-15', 'Rejected', 'Celeste',  'Greenbush');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (806,'mreitler@fasehatice.com', '2020-04-16', 'Approved', 'Vincenza',  'Keneipp');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (807,'ltheodorov@opentech.com', '2020-04-16', 'Pending', 'Selma',  'Wiklund');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (808,'dseewald@goodsilron.com', '2020-04-17', 'Pending', 'Shalon',  'Sama');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (809,'dgellinger@dambase.com', '2020-04-17', 'Pending', 'Marvel',  'Nachor');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (810,'lflister@hottechi.com', '2020-04-20', 'Approved', 'Kris',  'Pedrozo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (811,'jpoquette@ron-tech.com', '2020-04-20', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (812,'anievas@rangreen.com', '2020-04-20', 'Pending', 'Scarlet',  'Ruta');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (813,'cmorasca@ganjaflex.com', '2020-04-21', 'Pending', 'Larae',  'Iturbide');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (814,'kbenimadho@donquadtech.com', '2020-04-21', 'Pending', 'Ma',  'Maisto');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (815,'vlouissant@sunnamplex.com', '2020-04-21', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (816,'bmastella@kan-code.com', '2020-04-21', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (817,'aoles@bioplex.com', '2020-04-22', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (818,'rauber@dambase.com', '2020-04-22', 'Pending', 'Izetta',  'Jacobos');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (819,'ahoogland@y-corporation.com', '2020-04-23', 'Pending', 'Albina',  'Spickerman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (820,'vlouissant@sunnamplex.com', '2020-04-23', 'Pending', 'Francine',  'Gesick');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (821,'brestrepo@xx-holding.com', '2020-04-24', 'Approved', 'Galen',  'Kohnert');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (822,'cpugh@domzoom.com', '2020-04-24', 'Pending', 'Carmela',  'Sweely');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (823,'creitler@silis.com', '2020-04-27', 'Approved', 'Roosevelt',  'Loader');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (824,'hcallaro@cancity.com', '2020-04-27', 'Pending', 'Tamar',  'Wrinkles');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (825,'hcallaro@cancity.com', '2020-04-27', 'Pending', 'Stephane',  'Hoogland');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (826,'gschnitzler@y-corporation.com', '2020-04-28', 'Pending', 'Jesusita',  'Dopico');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (827,'smeteer@dalttechnology.com', '2020-04-28', 'Approved', 'Alyce',  'Ostrosky');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (828,'bmastella@kan-code.com', '2020-04-28', 'Pending', 'Carlee',  'Paulas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (829,'bsengbusch@singletechno.com', '2020-04-29', 'Pending', 'Tasia',  'Tegarden');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (830,'ckannady@dambase.com', '2020-04-29', 'Pending', 'Rasheeda',  'Smith');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (831,'ncartan@statholdings.com', '2020-04-29', 'Approved', 'Rhea',  'Samu');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (832,'kbreland@year-job.com', '2020-04-29', 'Pending', 'Jutta',  'Hidvegi');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (833,'amiceli@blackzim.com', '2020-04-30', 'Pending', 'Kristeen',  'Haroldson');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (834,'kpatak@groovestreet.com', '2020-04-30', 'Pending', 'Gail',  'Restrepo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (835,'cscipione@kan-code.com', '2020-04-30', 'Pending', 'Glendora',  'Scheyer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (836,'rgarufi@bioplex.com', '2020-05-01', 'Rejected', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (837,'jrestrepo@konmatfix.com', '2020-05-01', 'Pending', 'Freeman',  'Wide');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (838,'clawler@dontechi.com', '2020-05-01', 'Pending', 'Catalina',  'Kannady');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (839,'dangalich@donware.com', '2020-05-04', 'Pending', 'Willard',  'Asar');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (840,'chagele@zencorporation.com', '2020-05-04', 'Pending', 'Josephine',  'Turinetti');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (841,'ndenooyer@statholdings.com', '2020-05-04', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (842,'aostolaza@finjob.com', '2020-05-05', 'Approved', 'Jani',  'Tolfree');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (843,'ncartan@statholdings.com', '2020-05-05', 'Approved', 'Thaddeus',  'Palaia');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (844,'rhollack@plexzap.com', '2020-05-05', 'Pending', 'Bernardo',  'Schnitzler');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (845,'dseewald@goodsilron.com', '2020-05-06', 'Pending', 'Margart',  'Barfield');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (846,'bsengbusch@singletechno.com', '2020-05-06', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (847,'jdiscipio@singletechno.com', '2020-05-06', 'Pending', 'Shalon',  'Canlas');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (848,'egrenet@y-corporation.com', '2020-05-06', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (849,'vkeener@kan-code.com', '2020-05-07', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (850,'cpugh@domzoom.com', '2020-05-07', 'Pending', 'Tresa',  'Schemmer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (851,'ckannady@dambase.com', '2020-05-07', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (852,'etromblay@toughzap.com', '2020-05-08', 'Rejected', 'Amie',  'Juvera');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (853,'mhollack@scottech.com', '2020-05-08', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (854,'esaylors@groovestreet.com', '2020-05-11', 'Pending', 'Kimbery',  'Paprocki');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (855,'dgellinger@dambase.com', '2020-05-11', 'Pending', 'Felicidad',  'Munns');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (856,'loldroyd@hottechi.com', '2020-05-12', 'Pending', 'Tarra',  'Gibes');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (857,'jdiscipio@singletechno.com', '2020-05-12', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (858,'ggalam@ron-tech.com', '2020-05-12', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (859,'ttromblay@dontechi.com', '2020-05-13', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (860,'lpadilla@conecom.com', '2020-05-13', 'Pending', 'Jutta',  'Kusko');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (861,'lkippley@golddex.com', '2020-05-14', 'Pending', 'Charlene',  'Jacobos');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (862,'troyster@kan-code.com', '2020-05-14', 'Approved', 'Viola',  'Ruta');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (863,'smeteer@dalttechnology.com', '2020-05-15', 'Pending', 'Alline',  'Fortino');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (864,'oflosi@betatech.com', '2020-05-15', 'Rejected', 'Jennie',  'Nachor');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (865,'aoles@bioplex.com', '2020-05-18', 'Pending', 'Lai',  'Nunlee');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (866,'afigeroa@labdrill.com', '2020-05-18', 'Pending', 'Aja',  'Konopacki');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (867,'lkarpel@nam-zim.com', '2020-05-18', 'Pending', 'Billye',  'Scheyer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (868,'hmenter@doncon.com', '2020-05-19', 'Pending', 'Gilma',  'Harabedian');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (869,'ckannady@dambase.com', '2020-05-19', 'Pending', 'Cristy',  'Eroman');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (870,'mhollack@scottech.com', '2020-05-19', 'Pending', 'Justine',  'Albares');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (871,'liturbide@dontechi.com', '2020-05-20', 'Pending', 'Iluminada',  'Matuszak');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (872,'jrestrepo@konmatfix.com', '2020-05-20', 'Pending', 'Kristeen',  'Munis');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (873,'lmunns@toughzap.com', '2020-05-20', 'Pending', 'Abel',  'Arceo');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (874,'kpedrozo@kan-code.com', '2020-05-20', 'Pending', 'Laticia',  'Brossart');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (875,'jmirafuentes@rangreen.com', '2020-05-21', 'Pending', 'Scarlet',  'Cronauer');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (876,'rgarufi@bioplex.com', '2020-05-21', 'Pending', 'Raymon',  'Bilden');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (877,'dgellinger@dambase.com', '2020-05-22', 'Approved', 'Teddy',  'Pagliuca');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (878,'dgellinger@dambase.com', '2020-05-25', 'Pending', 'Shawnda',  'Centini');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (879,'lschoeneck@streethex.com', '2020-05-26', 'Pending', 'Carmela',  'Pugh');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (880,'dgellinger@dambase.com', '2020-05-26', 'Pending', 'Carmela',  'Hauenstein');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (881,'ttromblay@dontechi.com', '2020-05-27', 'Pending', 'Elly',  'Fritz');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (882,'jrestrepo@konmatfix.com', '2020-05-27', 'Pending', 'Gearldine',  'Ahle');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (883,'egrenet@y-corporation.com', '2020-05-28', 'Approved', 'Taryn',  'Meisel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (884,'cpagliuca@betasoloin.com', '2020-05-28', 'Approved', 'Lizette',  'Hengel');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (885,'lkarpel@nam-zim.com', '2020-05-29', 'Pending', 'Sharen',  'Brucato');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (886,'rgarufi@bioplex.com', '2020-05-29', 'Pending', 'Trinidad',  'Vanausdal');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (887,'rgarufi@bioplex.com', '2020-05-29', 'Pending', 'Ligia',  'Darakjy');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (888,'oflosi@betatech.com', '2020-06-01', 'Pending', 'Ammie',  'Hoogland');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (889,'bdiestel@condax.com', '2020-06-02', 'Pending', 'Viola',  'Sarao');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (890,'ldevreese@sonron.com', '2020-06-02', 'Pending', 'Laurel',  'Buzick');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (891,'xdubaldi@iselectrics.com', '2020-06-03', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (892,'bflosi@ganjaflex.com', '2020-06-03', 'Rejected', 'Junita',  'Farrow');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (893,'egrenet@y-corporation.com', '2020-06-04', 'Approved', 'Rory',  'Bennick');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (894,'cyori@donware.com', '2020-06-04', 'Pending', 'Elvera',  'Barfield');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (895,'ehirpara@sunnamplex.com', '2020-06-05', 'Pending', 'Lizette',  'Ehmann');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (896,'kpatak@groovestreet.com', '2020-06-05', 'Pending', 'Cassi',  'Wenzinger');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (897,'ltheodorov@opentech.com', '2020-06-08', 'Pending', 'Laticia',  'Worlds');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (898,'mhollack@scottech.com', '2020-06-08', 'Pending', 'Erick',  'Lary');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (899,'adenooyer@kinnamplus.com', '2020-06-09', 'Pending', 'Lauran',  'Agramonte');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (900,'mbolognia@finjob.com', '2020-06-09', 'Pending', 'Rolland',  'Pontoriero');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (901,'egrenet@y-corporation.com', '2020-06-09', 'Pending', 'Gail',  'Ogg');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (902,'brhym@dambase.com', '2020-06-10', 'Pending', 'Kirk',  'Wiklund');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (903,'hmenter@doncon.com', '2020-06-10', 'Pending', 'Lashon',  'Abdallah');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (904,'lmonarrez@goodsilron.com', '2020-06-10', 'Pending', 'Mitsue',  'Pinilla');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (905,'wstockham@zotware.com', '2020-06-10', 'Pending', 'Gayla',  'Mcrae');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (906,'cperruzza@doncon.com', '2020-06-11', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (907,'ahoogland@doncon.com', '2020-06-11', 'Pending', 'Helene',  'Bruschke');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (908,'esaylors@groovestreet.com', '2020-06-12', 'Pending', 'Goldie',  'Halter');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (909,'vkeener@kan-code.com', '2020-06-12', 'Approved', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (910,'nhiatt@plexzap.com', '2020-06-12', 'Pending', 'Jenelle',  'Ventura');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (911,'oflosi@betatech.com', '2020-06-15', 'Pending', 'Thurman',  'Maybury');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (912,'kpatak@groovestreet.com', '2020-06-15', 'Pending', 'Rozella',  'Degonia');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (913,'aostolaza@finjob.com', '2020-06-15', 'Pending', 'Cathrine',  'Saulter');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (914,'cpugh@domzoom.com', '2020-06-15', 'Pending', 'Amie',  'Tolfree');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (915,'gkines@inity.com', '2020-06-16', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (916,'rbourbon@lexiqvolax.com', '2020-06-16', 'Pending', 'Joanna',  'Merced');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (917,'egoldammer@scottech.com', '2020-06-17', 'Pending', 'Diane',  'Staback');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (918,'rtegarden@donquadtech.com', '2020-06-18', 'Pending', 'Sage',  'Mconnell');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (919,'lharabedian@plussunin.com', '2020-06-18', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (920,'cfelger@stanredtax.com', '2020-06-18', 'Pending', 'Antione',  'Oles');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (921,'mreitler@fasehatice.com', '2020-06-19', 'Pending', 'Cecilia',  'Amigon');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (922,'nhaufler@zencorporation.com', '2020-06-19', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (923,'ebachman@goodsilron.com', '2020-06-22', 'Pending', 'Jennifer',  'Honeywell');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (924,'jpoquette@ron-tech.com', '2020-06-22', 'Pending', 'Harrison',  'Korando');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (925,'cfelger@stanredtax.com', '2020-06-22', 'Pending', 'Danica',  'Bilden');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (926,'brhym@dambase.com', '2020-06-23', 'Pending', 'Laurel',  'Kippley');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (927,'ajuvera@groovestreet.com', '2020-06-23', 'Pending', 'Alaine',  'Pawlowicz');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (928,'troyster@kan-code.com', '2020-06-24', 'Pending', 'Sage',  'Sweely');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (929,'acoyier@hottechi.com', '2020-06-24', 'Pending', 'Salena',  'Lukasik');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (930,'rhollack@plexzap.com', '2020-06-24', 'Pending', 'Izetta',  'Caldarera');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (931,'ttromblay@dontechi.com', '2020-06-25', 'Pending', 'nan',  'nan');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (932,'cperruzza@doncon.com', '2020-06-26', 'Pending', 'Mollie',  'Venere');
INSERT INTO cs6400_summer2020_team022.`application` (application_id, applicant_email, submit_date,status, co_applicant_first_name, co_applicant_last_name)
VALUES (933,'jrestrepo@konmatfix.com', '2020-06-26', 'Pending', 'Kate',  'Ragel');

INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(3);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(5);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(8);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(9);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(12);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(13);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(14);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(19);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(22);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(28);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(38);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(43);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(46);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(47);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(52);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(57);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(62);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(66);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(69);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(70);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(80);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(82);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(87);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(89);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(96);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(105);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(106);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(108);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(109);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(115);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(118);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(127);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(130);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(138);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(142);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(147);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(151);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(152);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(153);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(154);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(156);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(159);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(166);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(175);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(178);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(190);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(200);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(204);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(207);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(214);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(215);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(236);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(237);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(239);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(245);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(246);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(252);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(253);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(258);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(261);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(265);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(279);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(281);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(286);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(289);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(298);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(316);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(318);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(320);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(324);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(330);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(337);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(338);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(339);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(340);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(346);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(347);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(348);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(353);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(357);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(364);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(366);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(367);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(369);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(373);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(374);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(387);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(413);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(414);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(418);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(420);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(425);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(429);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(431);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(437);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(439);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(444);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(447);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(450);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(454);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(460);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(474);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(483);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(488);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(491);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(494);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(497);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(501);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(508);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(511);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(515);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(516);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(541);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(551);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(553);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(560);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(561);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(565);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(567);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(571);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(576);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(579);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(600);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(601);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(609);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(616);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(623);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(634);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(639);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(655);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(656);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(658);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(689);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(715);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(717);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(731);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(737);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(751);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(752);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(759);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(769);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(781);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(790);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(805);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(836);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(852);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(864);
INSERT INTO cs6400_summer2020_team022.`RejectedApplication` (application_id) VALUES(892);
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(6,1,'2019-01-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(45,2,'2019-02-04');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(4,3,'2019-01-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(35,4,'2019-01-21');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(16,5,'2019-01-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(26,6,'2019-01-22');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(17,7,'2019-01-28');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(23,8,'2019-01-25');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(53,9,'2019-02-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(18,10,'2019-01-29');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(25,11,'2019-03-11');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(51,12,'2019-05-15');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(2,13,'2019-02-01');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(42,14,'2019-02-20');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(37,15,'2019-02-21');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(27,16,'2019-02-14');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(60,17,'2019-02-15');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(59,19,'2019-03-04');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(39,20,'2019-02-20');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(20,21,'2019-02-21');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(65,22,'2019-02-21');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(29,23,'2019-02-22');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(85,24,'2019-02-26');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(101,25,'2019-03-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(41,26,'2019-03-05');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(49,27,'2019-03-21');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(61,28,'2019-04-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(50,29,'2019-03-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(7,30,'2019-03-22');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(242,31,'2019-06-11');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(34,32,'2019-03-29');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(111,33,'2019-04-25');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(140,34,'2019-04-22');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(71,35,'2019-04-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(113,36,'2019-04-04');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(141,37,'2019-04-05');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(32,38,'2019-04-08');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(110,39,'2019-04-12');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(1,40,'2019-04-16');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(124,41,'2019-04-16');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(158,42,'2019-05-23');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(228,43,'2019-06-10');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(173,44,'2019-04-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(183,45,'2019-05-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(31,46,'2019-05-08');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(90,47,'2019-05-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(100,48,'2019-05-02');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(143,49,'2019-06-18');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(33,50,'2019-05-27');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(219,51,'2019-05-13');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(197,52,'2019-05-16');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(44,53,'2019-05-16');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(177,54,'2019-05-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(54,55,'2019-05-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(11,56,'2019-06-04');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(98,57,'2019-05-23');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(161,58,'2019-06-25');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(146,59,'2019-06-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(15,60,'2019-06-06');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(179,61,'2019-06-14');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(48,62,'2019-06-07');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(255,63,'2019-06-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(168,64,'2019-06-13');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(40,65,'2019-06-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(67,66,'2019-06-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(209,67,'2019-09-05');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(77,68,'2019-06-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(104,69,'2019-06-21');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(128,70,'2019-07-24');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(121,71,'2019-07-05');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(241,72,'2019-09-27');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(139,73,'2019-07-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(167,74,'2019-08-16');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(36,75,'2019-07-12');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(94,76,'2019-08-16');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(78,77,'2019-07-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(247,78,'2019-07-16');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(225,79,'2019-07-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(97,80,'2019-07-18');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(163,81,'2019-07-22');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(300,82,'2019-07-23');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(248,83,'2019-08-02');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(304,84,'2019-07-24');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(230,85,'2019-07-25');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(148,86,'2019-09-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(134,87,'2019-08-06');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(169,88,'2019-08-01');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(192,89,'2019-08-02');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(203,90,'2019-09-05');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(30,91,'2019-08-05');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(273,92,'2019-08-08');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(267,93,'2019-08-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(131,94,'2019-08-15');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(383,95,'2019-08-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(275,96,'2019-08-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(201,97,'2019-08-20');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(325,98,'2019-08-21');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(63,99,'2019-08-22');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(227,100,'2019-09-04');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(194,101,'2019-08-29');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(133,102,'2019-08-30');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(180,103,'2019-09-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(232,104,'2019-09-06');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(294,105,'2019-10-02');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(276,106,'2019-10-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(269,107,'2019-09-11');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(114,108,'2019-09-16');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(136,109,'2019-09-20');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(176,110,'2019-09-30');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(344,111,'2019-09-27');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(428,112,'2019-12-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(574,113,'2020-02-10');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(68,114,'2019-10-21');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(259,115,'2019-10-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(220,116,'2019-10-10');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(292,117,'2019-11-14');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(309,118,'2019-10-11');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(305,119,'2019-10-11');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(206,120,'2019-10-15');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(365,121,'2019-10-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(191,122,'2019-10-18');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(184,123,'2019-10-28');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(290,124,'2019-11-11');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(86,125,'2019-11-26');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(74,126,'2019-11-05');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(216,127,'2019-11-08');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(199,128,'2019-11-13');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(181,129,'2019-11-12');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(285,130,'2019-12-11');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(196,131,'2019-11-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(358,132,'2019-11-18');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(355,133,'2019-12-18');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(302,134,'2019-11-22');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(411,135,'2019-11-20');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(423,136,'2019-11-21');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(435,137,'2019-11-21');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(185,138,'2019-11-22');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(591,139,'2020-04-30');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(313,140,'2019-12-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(352,141,'2019-12-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(395,142,'2019-12-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(393,143,'2020-01-01');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(381,144,'2019-12-06');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(308,145,'2019-12-11');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(99,146,'2020-01-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(522,147,'2019-12-16');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(293,148,'2019-12-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(145,149,'2019-12-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(223,150,'2019-12-26');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(164,151,'2019-12-25');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(382,152,'2019-12-26');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(482,153,'2020-01-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(314,154,'2020-01-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(84,155,'2019-12-31');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(129,156,'2020-01-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(162,157,'2020-01-02');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(470,158,'2020-01-06');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(186,159,'2020-01-08');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(557,160,'2020-02-26');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(322,161,'2020-01-22');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(534,162,'2020-02-06');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(643,163,'2020-01-23');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(377,164,'2020-01-24');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(307,165,'2020-02-05');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(620,166,'2020-05-07');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(581,167,'2020-02-14');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(81,168,'2020-02-18');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(631,169,'2020-02-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(76,170,'2020-02-20');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(621,171,'2020-03-02');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(484,172,'2020-03-30');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(198,173,'2020-03-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(188,174,'2020-03-05');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(222,175,'2020-03-05');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(517,176,'2020-04-29');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(486,177,'2020-04-10');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(727,178,'2020-03-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(380,179,'2020-03-20');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(398,180,'2020-03-25');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(514,181,'2020-03-26');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(512,182,'2020-03-27');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(556,183,'2020-04-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(554,184,'2020-04-07');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(594,185,'2020-06-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(427,186,'2020-04-06');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(669,187,'2020-05-13');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(630,188,'2020-06-15');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(602,189,'2020-05-04');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(607,191,'2020-04-13');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(391,192,'2020-04-14');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(661,193,'2020-05-13');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(445,194,'2020-04-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(670,195,'2020-04-20');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(88,196,'2020-05-01');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(116,197,'2020-04-24');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(217,198,'2020-05-01');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(64,199,'2020-05-20');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(165,200,'2020-05-12');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(426,201,'2020-05-29');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(464,202,'2020-05-15');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(404,203,'2020-05-20');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(650,204,'2020-05-25');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(665,206,'2020-05-26');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(205,209,'2020-06-02');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(301,210,'2020-06-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(260,211,'2020-06-03');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(490,214,'2020-06-19');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(746,215,'2020-06-09');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(170,216,'2020-06-11');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(303,219,'2020-06-17');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(137,221,'2020-06-22');
INSERT INTO cs6400_summer2020_team022.`ApprovedApplication` (application_id, dog_id, adoption_date)
    VALUES(827,224,'2020-06-26');
