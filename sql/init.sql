-- CREATE TABLE `word` (
--   `id` MEDIUMINT NOT NULL AUTO_INCREMENT,
--   `value` CHAR(52) NOT NULL,
--   `translation` CHAR(52) NOT NULL
-- ) ENGINE=InnoDB DEFAULT CHARSET=utf8;

SET foreign_key_checks = 0;
DROP TABLE russian;
DROP TABLE english;
SET foreign_key_checks = 1;

CREATE TABLE russian ( 
    id int(11)  unsigned NOT NULL auto_increment,
    english_id int(11) NOT NULL,
    value VARCHAR(30) NOT NULL ,
    lang_code VARCHAR(2) NOT NULL ,
    PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET=utf8;

CREATE TABLE english ( 
    id int(11)  unsigned NOT NULL auto_increment,
    russian_id int(11) NOT NULL,
    value VARCHAR(30) NOT NULL ,
    lang_code VARCHAR(2) NOT NULL ,
    PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET=utf8;

-- ALTER TABLE russian 
-- ADD CONSTRAINT FK_russian 
-- FOREIGN KEY (english_id) REFERENCES english(id);

-- ALTER TABLE english 
-- ADD CONSTRAINT FK_english 
-- FOREIGN KEY (russian_id) REFERENCES russian(id);

INSERT INTO russian (english_id, value, lang_code) VALUES
    (1, "яблоко", "RU"),
    (2, "груша", "RU"),
    (3, "апельсин", "RU"),
    (4, "виноград", "RU"),
    (5, "лимон", "RU"),
    (6, "ананас", "RU"),
    (7, "арбуз", "RU"),
    (8, "кокос", "RU"),
    (9, "банан", "RU"),
    (10, "помело", "RU"),
    (11, "клубника", "RU"),
    (12, "малина", "RU"),
    (13, "дыня", "RU"),
    (14, "персик", "RU"),
    (15, "абрикос", "RU"),
    (16, "манго", "RU"),
    (17, "слива", "RU"),
    (18, "гранат", "RU"),
    (19, "вишня", "RU");

INSERT INTO english (russian_id, value, lang_code) VALUES
    (1, "apple", "EN"),
    (2, "pear", "EN"),
    (3, "orange", "EN"),
    (4, "grape", "EN"),
    (5, "lemon", "EN"),
    (6, "pineapple", "EN"),
    (7, "watermelon", "EN"),
    (8, "coconut", "EN"),
    (9, "banana", "EN"),
    (10, "pomelo", "EN"),
    (11, "strawberry", "EN"),
    (12, "raspberry", "EN"),
    (13, "melon", "EN"),
    (14, "peach", "EN"),
    (15, "apricot", "EN"),
    (16, "mango", "EN"),
    (17, "pear", "EN"),
    (18, "pomegranate", "EN"),
    (19, "cherry", "EN");


CREATE TABLE mistake (
    id int(11) unsigned NOT NULL auto_increment,
    word_id int(11) unsigned NOT NULL,
    lang VARCHAR(2) NOT NULL,
    value VARCHAR(80) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET=utf8;

-- CREATE TABLE employee (
--     id smallint(5) unsigned NOT NULL,
--     firstname varchar(30),
--     lastname varchar(30),
--     birthdate date,
--     PRIMARY KEY (id),
--     KEY idx_lastname (lastname)
-- ) ENGINE=InnoDB;

-- CREATE TABLE borrowed (
--     ref int(10) unsigned NOT NULL auto_increment,
--     employeeid smallint(5) unsigned NOT NULL,
--     book varchar(50),
--     PRIMARY KEY (ref)
-- ) ENGINE=InnoDB;

ALTER TABLE mistake 
ADD CONSTRAINT FK_mistake 
FOREIGN KEY (employeeid) REFERENCES employee(id) 
ON UPDATE CASCADE
ON DELETE CASCADE;

CREATE TABLE word ( 
    id int(11)  unsigned NOT NULL auto_increment,
    en VARCHAR(30) NOT NULL,
    ru VARCHAR(30) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET=utf8;

INSERT INTO word (en, ru) VALUES
    ("apple", "яблоко"),
    ("pear", "груша"),
    ("orange", "апельсин"),
    ("grape", "виноград"),
    ("lemon", "лимон"),
    ("pineapple", "ананас"),
    ("watermelon", "арбуз"),
    ("coconut", "кокос"),
    ("banana", "банан"),
    ("pomelo", "помело"),
    ("strawberry", "клубника"),
    ("raspberry", "малина"),
    ("melon", "дыня"),
    ("peach", "персик"),
    ("apricot", "абрикос"),
    ("mango", "манго"),
    ("pear", "слива"),
    ("pomegranate", "гранат"),
    ("cherry", "вишня");

CREATE TABLE quiz (
    id int(11)  unsigned NOT NULL auto_increment,
    user_id int(11) NOT NULL,
    session_id int(11) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET=utf8;