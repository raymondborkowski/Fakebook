@createTables.sql
CREATE TABLE PUBLIC_USER_INFORMATION AS (SELECT * FROM SHRAVYAK.PUBLIC_USER_INFORMATION);
CREATE TABLE PUBLIC_ARE_FRIENDS AS (SELECT * FROM SHRAVYAK.PUBLIC_ARE_FRIENDS);
CREATE TABLE PUBLIC_PHOTO_INFORMATION AS (SELECT * FROM SHRAVYAK.PUBLIC_PHOTO_INFORMATION);
CREATE TABLE PUBLIC_TAG_INFORMATION AS (SELECT * FROM SHRAVYAK.PUBLIC_TAG_INFORMATION);
CREATE TABLE PUBLIC_EVENT_INFORMATION AS (SELECT * FROM SHRAVYAK.PUBLIC_EVENT_INFORMATION);
INSERT INTO Users(user_id,name_first,name_last,birth_year,birth_month,birth_day, gender) SELECT DISTINCT USER_ID, FIRST_NAME, LAST_NAME, YEAR_OF_BIRTH, MONTH_OF_BIRTH, DAY_OF_BIRTH, GENDER FROM PUBLIC_USER_INFORMATION;
CREATE SEQUENCE location_id_seq;
CREATE TRIGGER trg_location_id BEFORE INSERT ON Location FOR EACH ROW BEGIN SELECT location_id_seq.NEXTVAL INTO :new.loc_id FROM dual;
END;
/
INSERT INTO Location(city,state,country) SELECT DISTINCT HOMETOWN_CITY, HOMETOWN_STATE, HOMETOWN_COUNTRY FROM PUBLIC_USER_INFORMATION UNION SELECT DISTINCT CURRENT_CITY, CURRENT_STATE, CURRENT_COUNTRY FROM PUBLIC_USER_INFORMATION UNION SELECT DISTINCT EVENT_CITY, EVENT_STATE, EVENT_COUNTRY FROM PUBLIC_EVENT_INFORMATION;
DROP SEQUENCE location_id_seq;

INSERT INTO Hometown(user_id, loc_id) SELECT DISTINCT u.user_id, h.loc_id FROM PUBLIC_USER_INFORMATION u, Location h WHERE u.hometown_city = h.city AND u.hometown_state = h.state  AND u.hometown_country = h.country;

CREATE SEQUENCE studies_id_seq;
CREATE TRIGGER trg_studies_id BEFORE INSERT ON Studies FOR EACH ROW BEGIN SELECT studies_id_seq.NEXTVAL INTO :new.studies_id FROM dual;
END;
/
CREATE SEQUENCE major_id_seq;
CREATE TRIGGER trg_major_id BEFORE INSERT ON Studies FOR EACH ROW BEGIN SELECT major_id_seq.NEXTVAL INTO :new.major FROM dual;
END;
/
INSERT INTO Studies(college_name, year, major, degree) SELECT DISTINCT INSTITUTION_NAME, PROGRAM_YEAR, PROGRAM_CONCENTRATION, PROGRAM_DEGREE  FROM PUBLIC_USER_INFORMATION;
DROP SEQUENCE major_id_seq;
DROP SEQUENCE studies_id_seq;
INSERT INTO current_location(user_id, loc_id) SELECT DISTINCT u.user_id, c.loc_id FROM PUBLIC_USER_INFORMATION u, Location c WHERE U.hometown_city = c.city AND U.hometown_state = c.state  AND U.hometown_country = c.country;
INSERT INTO Friends(user_friend1_id, user_friend2_id) SELECT DISTINCT USER1_ID, USER2_ID FROM PUBLIC_ARE_FRIENDS A ORDER BY A.USER1_ID ASC, A.USER2_ID ASC;


-- CREATE OR REPLACE TRIGGER my_trigger
--    before insert 
--    ON Album
--    FOR EACH ROW
-- BEGIN
--   IF :NEW.ALBUM_VISIBILITY = 'EVERYONE'
--   then
--     INSERT INTO Album (visible_album) VALUES (:NEW.ALBUM_VISIBILITY);

--   END IF;
-- END;
-- /
INSERT INTO Album (album_id, owner_id, cover_photo_id, album_name, created_album, modified_album, link_album, visible_album, photo_id) 
 SELECT ALBUM_ID, OWNER_ID, COVER_PHOTO_ID, ALBUM_NAME, ALBUM_CREATED_TIME, ALBUM_MODIFIED_TIME, ALBUM_LINK, ALBUM_VISIBILITY, PHOTO_ID 
 FROM PUBLIC_PHOTO_INFORMATION;


INSERT INTO Photo (album_id, photo_id, caption, created_photo, modify_photo, link) SELECT ALBUM_ID, PHOTO_ID, PHOTO_CAPTION, PHOTO_CREATED_TIME, PHOTO_MODIFIED_TIME, PHOTO_LINK FROM PUBLIC_PHOTO_INFORMATION;


INSERT INTO Tag (photo_id, user_id, x_cord, y_cord) SELECT PHOTO_ID, TAG_SUBJECT_ID, TAG_X_COORDINATE, TAG_Y_COORDINATE FROM PUBLIC_TAG_INFORMATION;
INSERT INTO Events (event_id, event_name, event_tagline, event_description, event_host, event_type, location, city, state, country, summary, start_time, end_time, user_id) SELECT EVENT_ID, EVENT_NAME, EVENT_TAGLINE, EVENT_DESCRIPTION, EVENT_HOST, EVENT_TYPE, EVENT_SUBTYPE, EVENT_LOCATION, EVENT_CITY, EVENT_STATE, EVENT_COUNTRY, EVENT_START_TIME, EVENT_END_TIME, EVENT_CREATOR_ID FROM PUBLIC_EVENT_INFORMATION;