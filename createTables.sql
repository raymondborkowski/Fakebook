CREATE TABLE Users(
user_id INTEGER,
name_first CHAR(30),
name_last CHAR(30),
birth_year INTEGER,
birth_month INTEGER,
birth_day INTEGER,
gender VARCHAR2(100),
PRIMARY KEY (user_id)
);

CREATE TABLE Location(
loc_ID INTEGER,
city VARCHAR2(100),
state VARCHAR2(100),
country VARCHAR2(100),
PRIMARY KEY (loc_ID)
);

CREATE TABLE Hometown(
  user_id INTEGER,
  loc_id INTEGER,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES Users,
  FOREIGN KEY (loc_id) REFERENCES Location
  );

CREATE TABLE current_location(
  user_id INTEGER,
  loc_ID INTEGER,
  PRIMARY KEY (user_id),
  FOREIGN KEY (user_id) REFERENCES Users,
  FOREIGN KEY (loc_ID) REFERENCES Location
);

CREATE TABLE Studies(
studies_id INTEGER,
college_name VARCHAR2(100),
year INTEGER,
major CHAR(100),
degree VARCHAR2(100),
PRIMARY KEY(studies_id, major)
);

CREATE TABLE Friends(
user_friend1_id INTEGER,
user_friend2_id INTEGER,
PRIMARY KEY(user_friend1_id, user_friend2_id),
FOREIGN KEY(user_friend1_id) REFERENCES Users,
FOREIGN KEY(user_friend2_id) REFERENCES Users
);


CREATE TABLE Photo(
photo_id INTEGER,
caption VARCHAR2(4000),
created_photo TIMESTAMP(6),
modify_photo TIMESTAMP(6),
link CHAR(200),
album_id INTEGER NOT NULL,
PRIMARY KEY(photo_id)
-- FOREIGN KEY (album_id) REFERENCES Album
);

CREATE TABLE Album(
album_id INTEGER,
owner_id INTEGER NOT NULL,
cover_photo_id INTEGER,
album_name VARCHAR2(100),
created_album TIMESTAMP(6),
modified_album TIMESTAMP(6),
link_album VARCHAR2(4000),
visible_album VARCHAR2(2000),
photo_id INTEGER, /*naming convention*/
PRIMARY KEY(album_id),
FOREIGN KEY (owner_id) REFERENCES Users
);

CREATE TABLE Tag(
user_id INTEGER,
photo_id INTEGER,
created TIMESTAMP(6),
x_cord INTEGER,
y_cord INTEGER,
PRIMARY KEY(user_id, photo_id),
FOREIGN KEY (user_id) REFERENCES Users,
FOREIGN KEY (photo_id) REFERENCES Photo
);

CREATE TABLE Comments(
user_id INTEGER,
photo_id INTEGER,
commentTxt CHAR(150),
time_comment TIMESTAMP(6),
PRIMARY KEY (user_id, photo_id),
FOREIGN KEY (user_id) REFERENCES Users,
FOREIGN KEY (photo_id) REFERENCES Photo
);

CREATE TABLE Message(
user_send_id INTEGER,
user_recieve_id INTEGER,
time_message TIMESTAMP(6),
message VARCHAR2(4000),
PRIMARY KEY(user_send_id, user_recieve_id, time_message),
FOREIGN KEY (user_send_id) REFERENCES Users,
FOREIGN KEY (user_recieve_id) REFERENCES Users
); 

CREATE TABLE Events(
event_id INTEGER,
event_name VARCHAR2(100),
event_tagline VARCHAR2(2000),
event_description VARCHAR2(4000),
event_host VARCHAR2(100),
event_type VARCHAR2(100),
location VARCHAR(1000), /*STRING*/
city VARCHAR(1000), /*STRING*/
state VARCHAR(1000), /*STRING*/
country VARCHAR(1000), /*STRING*/
summary VARCHAR2(3000),
start_time TIMESTAMP(6),
end_time TIMESTAMP(6),
user_id INTEGER NOT NULL,
event_subtype VARCHAR2(100),
PRIMARY KEY (event_id),
FOREIGN KEY (user_id) REFERENCES Users
);

CREATE TABLE Participants(
user_id INTEGER,
event_id INTEGER,
status CHAR(30),
PRIMARY KEY (user_id, event_id),
FOREIGN KEY (user_id) REFERENCES Users,
FOREIGN KEY (event_id) REFERENCES Events
);
