DROP TABLE IF EXISTS tags;
DROP TABLE IF EXISTS lectures;
DROP TABLE IF EXISTS lectors;
DROP TABLE IF EXISTS time_table;
DROP TABLE IF EXISTS org_adresses;
DROP TABLE IF EXISTS organizations;
CREATE TABLE organizations(
  org_id INTEGER PRIMARY KEY AUTOINCREMENT,
  org_name VARCHAR(100),
  org_url VARCHAR(100),
  phone VARCHAR(16)
);

CREATE TABLE org_adresses(
office_id INTEGER PRIMARY KEY AUTOINCREMENT,
org_id INTEGER,
city VARCHAR(30) NOT NULL,
district VARCHAR(30),
street VARCHAR(30) NOT NULL,
building VARCHAR(5),
house VARCHAR(5) NOT NULL,
apartment INTEGER,
phone VARCHAR(16),
seat_limit INTEGER DEFAULT -1,
UNIQUE (office_id, seat_limit),
FOREIGN KEY (org_id) REFERENCES organizations(org_id) ON DELETE CASCADE
);

CREATE INDEX city_ind ON org_adresses(city);

CREATE TABLE time_table(
session_id INTEGER PRIMARY KEY AUTOINCREMENT,
office_id INTEGER,
session_date DATE NOT NULL,
session_type VARCHAR(30) NOT NULL,
time_end VARCHAR(5) NOT NULL,
seat_limit INTEGER DEFAULT -1,
busy_seats INTEGER DEFAULT 0,
FOREIGN KEY (office_id, seat_limit)
REFERENCES org_adresses(office_id, seat_limit)
ON DELETE SET NULL
ON UPDATE CASCADE,
CHECK (-1 = seat_limit OR busy_seats <= seat_limit)
);

CREATE TABLE lectors (
lec_last_name VARCHAR(30) NOT NULL,
lec_first_name VARCHAR(30) NOT NULL,
lec_patronymic VARCHAR(30),
email VARCHAR(40) NOT NULL PRIMARY KEY
);

CREATE TABLE lectures (
session_id INTEGER,
email VARCHAR(40),
theme VARCHAR(100) NOT NULL,
time_begin VARCHAR(5),
PRIMARY KEY (time_begin, session_id),
FOREIGN KEY (session_id)
REFERENCES time_table(session_id)
ON DELETE CASCADE,
FOREIGN KEY (email)
REFERENCES lectors(email)
ON DELETE CASCADE
);

CREATE TABLE tags(
session_id INTEGER NOT NULL,
time_begin VARCHAR(5) NOT NULL,
tag VARCHAR(20) NOT NULL,
PRIMARY KEY (session_id, time_begin, tag),
FOREIGN KEY (time_begin, session_id)
REFERENCES lectures(time_begin, session_id)
);

INSERT INTO organizations(org_name, org_url, phone)
VALUES 
    ('Likerka science', NULL, '+7(945)921-38-37'),
    ('Dolgopa science', 'https://go_to_home', '+7(920)921-36-46'),
    ('МФТИ', 'https://nerds_fortune.edu', '+7(920)930-05-05'),
    ('Since 2000', NULL, '+7(945)920-09-19'),
    ('Областная Владимирская библиотека', NULL, '+7(960)950-11-11'),
    ('Открытый лекторий МГУ', NULL, '+7(941)930-12-14'),
    ('Библиотека им. Толстого', NULL, '+7(960)956-91-22'),
    ('Библиотека им. Горького', 'https://overeaters.ru', '+7(960)920-07-36');

INSERT INTO org_adresses(org_id, city, street, house, phone, seat_limit) VALUES (1, 'Mokshan', 'Ulyanova st.', 16, '+7(930)910-56-67', 20);
INSERT INTO org_adresses(org_id, city, district, street, house, seat_limit) VALUES (1, 'Moscow', 'Ujnoe Butovo', 'Ulyanova st.', 8, 10);
INSERT INTO org_adresses(org_id, city, street, house) VALUES
(6, 'Moscow', 'Malaya Bronnaya', '4a'),
(2, 'Dolgoprudniy', 'Pervomayskaya st.', '45'),
(3, 'Dolgoprudniy', 'Institutskiy per.', '3'),
(4, 'Vladivostok', 'Rabochih av.', '8'),
(5, 'Vladimir', 'Stroiteley st.', '9a'),
(7, 'Novomoskovsk', 'Pervomayskaya st.', '10'),
(8, 'Moscow', 'Tverskaya st.', '12a');

INSERT INTO time_table(office_id, session_date, session_type, time_end, seat_limit) VALUES
    (1, '2018-05-07', 'Открытая лекция', '21:00', 20),
    (2, '2018-06-01', 'Открытая лекция', '21:00', 10),
    (2, '2018-06-02', 'Открытая лекция', '21:00', 10),
    (2, '2018-05-25', 'Открытая лекция', '21:00', 10);

INSERT INTO time_table(office_id, session_date, session_type, time_end) VALUES 
    (3, '2018-05-07', 'Science slam', '21:00'),
    (3, '2018-05-21', 'Открытая лекция', '21:00'),
    (4, '2018-05-20', 'Science slam', '21:00'),
    (4, '2018-05-21', 'Science slam', '14:00'),
    (5, '2018-05-16', 'Открытая лекция', '21:00'),
    (5, '2018-06-03', 'Мастер-класс', '21:00'),
    (5, '2018-06-04', 'Открытая лекция', '21:00'),
    (5, '2018-05-11', 'Открытая лекция', '21:00'),
    (6, '2018-06-02', 'Мастер-класс', '21:00'),
    (7, '2018-05-19', 'Открытая лекция', '21:00'),
    (7, '2018-05-23', 'Открытая лекция', '21:00'),
    (8, '2018-05-10', 'Открытая лекция', '21:00'),
    (8, '2018-05-22', 'Открытая лекция', '21:00'),
    (9, '2018-05-27', 'Открытая лекция', '21:00');

INSERT INTO lectors VALUES 
   ('Савватеев', 'Алексей', 'Владимирович', 'savvateev.al@gmail.com'),
   ('Прасолов', 'Виктор', 'Васильевич', 'prasolov@mccme.ru'),
   ('Гасников', 'Александр', 'Владимирович', 'gasnikov@yandex.ru'),
   ('Панчин', 'Александр', 'Юрьевич', 'panchin.au@gmail.com'),
   ('Казанцева', 'Анастасия', 'Андреевна', 'asya.kazanceva@rambler.com'),
   ('Гельфанд', 'Михаил', 'Иосифович', 'Gelfand@msu.su');

INSERT INTO lectures VALUES
(1, 'savvateev.al@gmail.com', 'Математика для гуманитариев', '18:30'),
(2, 'savvateev.al@gmail.com', 'Треугольник Шарыгина', '18:30'),
(3, 'prasolov@mccme.ru', 'Немного о геометри Лобачевского', '16:30'),
(4, 'savvateev.al@gmail.com', 'О великой теореме Ферма', '18:30'),
(5, 'gasnikov@yandex.ru', 'О методах распределенной оптимизации', '18:30'),
(6, 'gasnikov@yandex.ru', 'Оптимизация и поиск равновесия в транспортной сети', '18:30'),
(8, 'panchin.au@gmail.com', 'Почему я ем ГМО', '11:15'),
(8, 'asya.kazanceva@rambler.com', 'Как наш мозг нас обманывает', '12:15'),
(8, 'Gelfand@msu.su', 'Бактерии для ваших детей', '13:15'),
(7, 'savvateev.al@gmail.com', 'Новое и хорошо забытое старое', '18:30'),
(9, 'savvateev.al@gmail.com', 'Эллиптические кривые', '18:30'),
(10, 'savvateev.al@gmail.com', 'Теория игр', '18:30'),
(11, 'panchin.au@gmail.com', 'ДНК и генная инженерия', '18:00'),
(12, 'asya.kazanceva@rambler.com', 'Кто бы мог подумать?', '18:00'),
(13, 'gasnikov@yandex.ru', 'Современные методы выпуклой оптимизации', '18:00'),
(14, 'gasnikov@yandex.ru', 'Методы оптимального управления', '18:00'),
(15, 'panchin.au@gmail.com', 'Сумма технологии', '18:00'),
(16, 'savvateev.al@gmail.com', 'Экономика и математика', '18:00'),
(17, 'prasolov@mccme.ru', 'Наглядная топология', '18:00'),
(18, 'savvateev.al@gmail.com', 'За что дают Филдсовскую медаль?', '18:00');

INSERT INTO tags VALUES
(1, '18:30', 'Maths'),
(2, '18:30', 'Maths'),
(2, '18:30', 'Geometry'),
(8, '11:15', 'Biology'),
(8, '12:15', 'Biology'),
(8, '13:15', 'Biology'),
(3, '16:30', 'Maths'),
(4, '18:30', 'Maths'),
(5, '18:30', 'Maths'),
(5, '18:30', 'Optimization'),
(6, '18:30', 'Maths'),
(7, '18:30', 'Maths'),
(7, '18:30', 'Economics'),
(9, '18:30', 'Maths'),
(9, '18:30', 'Geometry'),
(10, '18:30', 'Economics'),
(10, '18:30', 'Maths'),
(11, '18:00', 'Biology'),
(12, '18:00', 'Biology'),
(13, '18:00', 'Maths'),
(13, '18:00', 'Optimization'),
(14, '18:00', 'Maths'),
(14, '18:00', 'Optimization'),
(15, '18:00', 'Biology'),
(16, '18:00', 'Maths'),
(16, '18:00', 'Economics'),
(17, '18:00', 'Maths'),
(17, '18:00', 'Topology'),
(18, '18:00', 'Maths');
