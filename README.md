# Lections
### Описание
Здесь находится проект по базам данных. Соответственно:  
*CREATE_DB.SQL* - файл создания базы данных  
*STANDART_SELECT.SQL* - пример запроса к базе данных  

### Таблицы

*organizations* - таблица организаций. Поля таблицы: id, имя, адрес сайта и телефон. Первичный ключ по полю id  

*org_adresses* - таблица адресов организаций. Одной организации может соответствовать несколько адресов. Соответственно поля таблицы: id офиса, id организации, город, район, строение, дом, квартира, телефон офиса и количество мест. Первичный ключ - id офиса, внешний - id организации; по городам создан индекс  

*time_table* - таблица с расписанием. Здесь каждому офису, времени  и дате сопоставлены несколько лекций 

*lectures* - таблица с лекциями. Связывается внешним ключом email с таблицей лекторов  

*lectors* - таблица с лекторами 

*tags* - таблица тегов для быстрого поиска лекций по заданной 
