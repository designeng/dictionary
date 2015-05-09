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
    ("plum", "слива"),
    ("pomegranate", "гранат"),
    ("cherry", "вишня");

CREATE TABLE mistake (
    id int(11) unsigned NOT NULL auto_increment,
    word_id int(11) unsigned NOT NULL,
    lang VARCHAR(2) NOT NULL,
    value VARCHAR(80) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET=utf8;

CREATE TABLE user (
    id int(11)  unsigned NOT NULL auto_increment,
    name VARCHAR(30) NOT NULL,
    score int(11) NOT NULL,
    PRIMARY KEY (id)
) ENGINE = INNODB DEFAULT CHARSET=utf8;