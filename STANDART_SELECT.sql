SELECT DISTINCT 'Адрес: ', city || ',' as cityname, CASE WHEN district IS NULL THEN '' ELSE 'district ' || district || ',' END districtname,
street || ',' as streetname,
CASE WHEN building IS NULL THEN '' ELSE 'building ' || building || ',' END buildname,'h. ' || house as housenum,
CASE WHEN apartment IS NULL THEN '' ELSE 'of. ' || CAST(apartment AS VARCHAR(7)) END officenum,
'Телефон: ', CASE WHEN org_adresses.phone IS NULL THEN organizations.phone ELSE org_adresses.phone END,
'Когда: ', session_date, tags.time_begin,
'Тема: ', theme,
'Свободных мест: ', CASE WHEN org_adresses.seat_limit = -1 THEN 'infinity' ELSE org_adresses.seat_limit - busy_seats END free_seats
FROM tags INNER JOIN lectures ON tags.session_id = lectures.session_id AND tags.time_begin = lectures.time_begin
INNER JOIN time_table ON lectures.session_id = time_table.session_id
INNER JOIN org_adresses ON org_adresses.office_id = time_table.office_id
INNER JOIN organizations ON organizations.org_id = org_adresses.org_id
WHERE city = ?001 AND (tag = ?002 OR ?002 = 'All')
ORDER BY session_date, lectures.time_begin;