BEGIN TRANSACTION;
CREATE TABLE IF NOT EXISTS "django_migrations" (
	"id"	integer NOT NULL,
	"app"	varchar(255) NOT NULL,
	"name"	varchar(255) NOT NULL,
	"applied"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group_permissions" (
	"id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_groups" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"group_id"	integer NOT NULL,
	FOREIGN KEY("group_id") REFERENCES "auth_group"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user_user_permissions" (
	"id"	integer NOT NULL,
	"user_id"	integer NOT NULL,
	"permission_id"	integer NOT NULL,
	FOREIGN KEY("permission_id") REFERENCES "auth_permission"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_admin_log" (
	"id"	integer NOT NULL,
	"action_time"	datetime NOT NULL,
	"object_id"	text,
	"object_repr"	varchar(200) NOT NULL,
	"change_message"	text NOT NULL,
	"content_type_id"	integer,
	"user_id"	integer NOT NULL,
	"action_flag"	smallint unsigned NOT NULL CHECK("action_flag" >= 0),
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("user_id") REFERENCES "auth_user"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_content_type" (
	"id"	integer NOT NULL,
	"app_label"	varchar(100) NOT NULL,
	"model"	varchar(100) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_permission" (
	"id"	integer NOT NULL,
	"content_type_id"	integer NOT NULL,
	"codename"	varchar(100) NOT NULL,
	"name"	varchar(255) NOT NULL,
	FOREIGN KEY("content_type_id") REFERENCES "django_content_type"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_group" (
	"id"	integer NOT NULL,
	"name"	varchar(150) NOT NULL UNIQUE,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "auth_user" (
	"id"	integer NOT NULL,
	"password"	varchar(128) NOT NULL,
	"last_login"	datetime,
	"is_superuser"	bool NOT NULL,
	"username"	varchar(150) NOT NULL UNIQUE,
	"last_name"	varchar(150) NOT NULL,
	"email"	varchar(254) NOT NULL,
	"is_staff"	bool NOT NULL,
	"is_active"	bool NOT NULL,
	"date_joined"	datetime NOT NULL,
	"first_name"	varchar(150) NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "django_session" (
	"session_key"	varchar(40) NOT NULL,
	"session_data"	text NOT NULL,
	"expire_date"	datetime NOT NULL,
	PRIMARY KEY("session_key")
);
CREATE TABLE IF NOT EXISTS "climbcville_question" (
	"id"	integer NOT NULL,
	"question_text"	varchar(200) NOT NULL,
	"pub_date"	datetime NOT NULL,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "climbcville_choice" (
	"id"	integer NOT NULL,
	"choice_text"	varchar(200) NOT NULL,
	"votes"	integer NOT NULL,
	"question_id"	integer NOT NULL,
	FOREIGN KEY("question_id") REFERENCES "climbcville_question"("id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "climbcville_route_setter" (
	"person_id"	integer NOT NULL,
	"f_name"	varchar(50) NOT NULL,
	"l_name"	varchar(50) NOT NULL,
	"email"	varchar(50) NOT NULL,
	"rs_experience_level"	integer unsigned NOT NULL CHECK("rs_experience_level" >= 0),
	"certifications"	text NOT NULL,
	"phone"	integer NOT NULL,
	PRIMARY KEY("person_id")
);
CREATE TABLE IF NOT EXISTS "climbcville_route_log_entry" (
	"entry_id"	INTEGER NOT NULL,
	"comment"	text NOT NULL,
	"beta"	text NOT NULL,
	"c_grade"	varchar(10) NOT NULL,
	"c_rating"	varchar(10) NOT NULL,
	"route_id_id"	integer,
	"c_id_id"	integer,
	FOREIGN KEY("c_id_id") REFERENCES "climbcville_climber"("person_id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("route_id_id") REFERENCES "climbcville_route"("route_id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("entry_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "climbcville_admin" (
	"person_id"	INTEGER NOT NULL,
	"f_name"	varchar(50) NOT NULL,
	"l_name"	varchar(50) NOT NULL,
	"email"	varchar(50) NOT NULL,
	"is_owner"	bool NOT NULL,
	"edit_permission"	bool NOT NULL,
	"create_permission"	bool NOT NULL,
	"delete_permission"	bool NOT NULL,
	"phone"	integer NOT NULL,
	PRIMARY KEY("person_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "climbcville_climber" (
	"person_id"	INTEGER NOT NULL,
	"f_name"	varchar(50) NOT NULL,
	"l_name"	varchar(50) NOT NULL,
	"email"	varchar(50) NOT NULL,
	"c_experience_level"	integer unsigned NOT NULL CHECK("c_experience_level" >= 0),
	"routes_attempted"	integer unsigned NOT NULL CHECK("routes_attempted" >= 0),
	"is_team_member"	bool NOT NULL,
	"phone"	integer NOT NULL,
	PRIMARY KEY("person_id" AUTOINCREMENT)
);
CREATE TABLE IF NOT EXISTS "climbcville_route_person_id" (
	"route_id"	integer NOT NULL,
	"route_setter_id"	integer NOT NULL,
	FOREIGN KEY("route_setter_id") REFERENCES "climbcville_route_setter"("person_id") DEFERRABLE INITIALLY DEFERRED,
	FOREIGN KEY("route_id") REFERENCES "climbcville_route"("route_id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("route_id","route_setter_id")
);
CREATE TABLE IF NOT EXISTS "climbcville_route" (
	"route_id"	integer NOT NULL,
	"r_type"	varchar(20) NOT NULL,
	"rs_grade"	varchar(10) NOT NULL,
	"location_id_id"	integer,
	"route_name"	varchar(100) NOT NULL,
	FOREIGN KEY("location_id_id") REFERENCES "climbcville_location"("location_id") DEFERRABLE INITIALLY DEFERRED,
	PRIMARY KEY("route_id")
);
CREATE TABLE IF NOT EXISTS "climbcville_location" (
	"location_id"	integer NOT NULL,
	"latitude"	real NOT NULL,
	"approach_info"	text NOT NULL,
	"location_name"	varchar(100),
	"longitude"	real NOT NULL,
	PRIMARY KEY("location_id")
);
CREATE TABLE IF NOT EXISTS "climbcville_user_input" (
	"location_id"	INTEGER,
	"user_code"	INTEGER,
	"route_id"	INTEGER,
	PRIMARY KEY("user_code" AUTOINCREMENT)
);
INSERT INTO "django_migrations" ("id","app","name","applied") VALUES (1,'contenttypes','0001_initial','2021-06-08 05:55:34.914772'),
 (2,'auth','0001_initial','2021-06-08 05:55:34.933162'),
 (3,'admin','0001_initial','2021-06-08 05:55:34.944229'),
 (4,'admin','0002_logentry_remove_auto_add','2021-06-08 05:55:34.958121'),
 (5,'admin','0003_logentry_add_action_flag_choices','2021-06-08 05:55:34.969451'),
 (6,'contenttypes','0002_remove_content_type_name','2021-06-08 05:55:34.989113'),
 (7,'auth','0002_alter_permission_name_max_length','2021-06-08 05:55:35.000265'),
 (8,'auth','0003_alter_user_email_max_length','2021-06-08 05:55:35.013813'),
 (9,'auth','0004_alter_user_username_opts','2021-06-08 05:55:35.024424'),
 (10,'auth','0005_alter_user_last_login_null','2021-06-08 05:55:35.036189'),
 (11,'auth','0006_require_contenttypes_0002','2021-06-08 05:55:35.038811'),
 (12,'auth','0007_alter_validators_add_error_messages','2021-06-08 05:55:35.052017'),
 (13,'auth','0008_alter_user_username_max_length','2021-06-08 05:55:35.066562'),
 (14,'auth','0009_alter_user_last_name_max_length','2021-06-08 05:55:35.076014'),
 (15,'auth','0010_alter_group_name_max_length','2021-06-08 05:55:35.086509'),
 (16,'auth','0011_update_proxy_permissions','2021-06-08 05:55:35.094350'),
 (17,'auth','0012_alter_user_first_name_max_length','2021-06-08 05:55:35.104674'),
 (18,'sessions','0001_initial','2021-06-08 05:55:35.109650'),
 (19,'climbcville','0001_initial','2021-06-10 03:14:37.159949'),
 (20,'climbcville','0002_admin_climber_location_route_route_log_entry_route_setter','2021-06-12 01:20:37.920347'),
 (21,'climbcville','0003_auto_20210611_2003','2021-06-12 01:20:37.933592'),
 (22,'climbcville','0004_route_location_id','2021-06-12 01:20:37.940550'),
 (23,'climbcville','0005_auto_20210611_2014','2021-06-12 01:20:37.955269'),
 (24,'climbcville','0006_auto_20210611_2016','2021-06-12 01:20:37.972600'),
 (25,'climbcville','0007_auto_20210611_2134','2021-06-12 02:34:49.857114'),
 (26,'climbcville','0008_auto_20210612_1407','2021-06-12 19:10:43.454703');
INSERT INTO "django_admin_log" ("id","action_time","object_id","object_repr","change_message","content_type_id","user_id","action_flag") VALUES (1,'2021-06-10 04:13:18.418837','1','What is your favorite color?','[{"added": {}}]',8,1,1),
 (2,'2021-06-10 04:13:34.261063','2','What is your name?','[{"added": {}}]',8,1,1),
 (3,'2021-06-10 04:14:24.289409','3','What is your quest?','[{"added": {}}]',8,1,1),
 (4,'2021-06-10 04:14:44.681609','4','What is the air-speed velocity of an unladen swallow?','[{"added": {}}]',8,1,1),
 (5,'2021-06-11 02:01:42.158179','1','blue','[{"added": {}}]',7,1,1),
 (6,'2021-06-11 02:01:47.503930','2','green','[{"added": {}}]',7,1,1),
 (7,'2021-06-11 02:01:52.150743','3','red','[{"added": {}}]',7,1,1),
 (8,'2021-06-11 02:01:57.907423','4','yellow','[{"added": {}}]',7,1,1),
 (9,'2021-06-11 02:14:25.410904','4','What is the air-speed velocity of an unladen swallow?','',8,1,3),
 (10,'2021-06-11 02:14:25.414828','3','What is your quest?','',8,1,3),
 (11,'2021-06-11 02:14:25.416945','2','What is your name?','',8,1,3),
 (12,'2021-06-11 02:14:25.418960','1','What is your favorite color?','',8,1,3),
 (13,'2021-06-11 02:14:46.561890','5','Who is the best climber?','[{"added": {}}]',8,1,1),
 (14,'2021-06-11 02:16:37.050042','6','Whats your favorite type of climbing?','[{"added": {}}]',8,1,1),
 (15,'2021-06-11 02:16:48.507197','5','Bouldering','[{"added": {}}]',7,1,1),
 (16,'2021-06-11 02:16:57.287560','6','Top roping','[{"added": {}}]',7,1,1),
 (17,'2021-06-11 02:17:37.654081','7','Sport Climbing','[{"added": {}}]',7,1,1),
 (18,'2021-06-11 02:17:46.723366','8','Trad Climbing','[{"added": {}}]',7,1,1),
 (19,'2021-06-11 02:17:53.960758','9','Chris Sharma','[{"added": {}}]',7,1,1),
 (20,'2021-06-11 02:18:09.821887','10','Alex Honnold','[{"added": {}}]',7,1,1),
 (21,'2021-06-11 02:18:16.228681','11','Adam Ondra','[{"added": {}}]',7,1,1),
 (22,'2021-06-11 02:18:40.218528','12','Zachery Key','[{"added": {}}]',7,1,1),
 (23,'2021-06-11 02:25:06.010440','6','What''s your favorite type of climbing?','[{"changed": {"fields": ["Question text"]}}]',8,1,2),
 (24,'2021-06-12 02:12:51.684221','1','1','[{"added": {}}]',9,1,1),
 (25,'2021-06-12 02:13:30.762963','2','2','[{"added": {}}]',9,1,1),
 (26,'2021-06-12 02:19:53.542806','1','1','[{"added": {}}]',10,1,1),
 (27,'2021-06-12 02:21:33.065814','2','2','[{"added": {}}]',10,1,1),
 (28,'2021-06-12 02:23:06.547903','1','Location object (1)','[{"added": {}}]',11,1,1),
 (29,'2021-06-12 02:32:56.457137','1','1','[{"added": {}}]',14,1,1),
 (30,'2021-06-12 02:33:05.971757','1','Route object (1)','[{"added": {}}]',12,1,1),
 (31,'2021-06-12 02:33:54.565303','1','Route_Log_Entry object (1)','[{"added": {}}]',13,1,1),
 (32,'2021-06-12 19:12:55.448021','1','Route object (1)','[]',12,1,2),
 (33,'2021-06-12 19:14:54.771524','1','Route object (1)','[]',12,1,2),
 (34,'2021-06-12 19:17:19.041850','1','Route object (1)','[{"changed": {"fields": ["Route name"]}}]',12,1,2),
 (35,'2021-06-12 19:21:55.719682','2','2','[{"added": {}}]',14,1,1),
 (36,'2021-06-12 19:22:06.038564','2','Route object (2)','[{"added": {}}]',12,1,1);
INSERT INTO "django_content_type" ("id","app_label","model") VALUES (1,'admin','logentry'),
 (2,'auth','permission'),
 (3,'auth','group'),
 (4,'auth','user'),
 (5,'contenttypes','contenttype'),
 (6,'sessions','session'),
 (7,'climbcville','choice'),
 (8,'climbcville','question'),
 (9,'climbcville','admin'),
 (10,'climbcville','climber'),
 (11,'climbcville','location'),
 (12,'climbcville','route'),
 (13,'climbcville','route_log_entry'),
 (14,'climbcville','route_setter');
INSERT INTO "auth_permission" ("id","content_type_id","codename","name") VALUES (1,1,'add_logentry','Can add log entry'),
 (2,1,'change_logentry','Can change log entry'),
 (3,1,'delete_logentry','Can delete log entry'),
 (4,1,'view_logentry','Can view log entry'),
 (5,2,'add_permission','Can add permission'),
 (6,2,'change_permission','Can change permission'),
 (7,2,'delete_permission','Can delete permission'),
 (8,2,'view_permission','Can view permission'),
 (9,3,'add_group','Can add group'),
 (10,3,'change_group','Can change group'),
 (11,3,'delete_group','Can delete group'),
 (12,3,'view_group','Can view group'),
 (13,4,'add_user','Can add user'),
 (14,4,'change_user','Can change user'),
 (15,4,'delete_user','Can delete user'),
 (16,4,'view_user','Can view user'),
 (17,5,'add_contenttype','Can add content type'),
 (18,5,'change_contenttype','Can change content type'),
 (19,5,'delete_contenttype','Can delete content type'),
 (20,5,'view_contenttype','Can view content type'),
 (21,6,'add_session','Can add session'),
 (22,6,'change_session','Can change session'),
 (23,6,'delete_session','Can delete session'),
 (24,6,'view_session','Can view session'),
 (25,7,'add_choice','Can add choice'),
 (26,7,'change_choice','Can change choice'),
 (27,7,'delete_choice','Can delete choice'),
 (28,7,'view_choice','Can view choice'),
 (29,8,'add_question','Can add question'),
 (30,8,'change_question','Can change question'),
 (31,8,'delete_question','Can delete question'),
 (32,8,'view_question','Can view question'),
 (33,9,'add_admin','Can add admin'),
 (34,9,'change_admin','Can change admin'),
 (35,9,'delete_admin','Can delete admin'),
 (36,9,'view_admin','Can view admin'),
 (37,10,'add_climber','Can add climber'),
 (38,10,'change_climber','Can change climber'),
 (39,10,'delete_climber','Can delete climber'),
 (40,10,'view_climber','Can view climber'),
 (41,11,'add_location','Can add location'),
 (42,11,'change_location','Can change location'),
 (43,11,'delete_location','Can delete location'),
 (44,11,'view_location','Can view location'),
 (45,12,'add_route','Can add route'),
 (46,12,'change_route','Can change route'),
 (47,12,'delete_route','Can delete route'),
 (48,12,'view_route','Can view route'),
 (49,13,'add_route_log_entry','Can add route_ log_ entry'),
 (50,13,'change_route_log_entry','Can change route_ log_ entry'),
 (51,13,'delete_route_log_entry','Can delete route_ log_ entry'),
 (52,13,'view_route_log_entry','Can view route_ log_ entry'),
 (53,14,'add_route_setter','Can add route_ setter'),
 (54,14,'change_route_setter','Can change route_ setter'),
 (55,14,'delete_route_setter','Can delete route_ setter'),
 (56,14,'view_route_setter','Can view route_ setter');
INSERT INTO "auth_user" ("id","password","last_login","is_superuser","username","last_name","email","is_staff","is_active","date_joined","first_name") VALUES (1,'pbkdf2_sha256$216000$pcAANolg1z5R$D8z3zJ9+yO0p4gB08vXxuHr4pAIVnZOhzLCjqVSyrsY=','2021-06-10 03:34:16.049144',1,'tclift','','tjc5xp@virginia.edu',1,1,'2021-06-10 03:33:09.523723','');
INSERT INTO "django_session" ("session_key","session_data","expire_date") VALUES ('rrjziyy9hzzdo21fq1326uucfvvyf0ey','.eJxVjDsOgzAQRO_iOrL8wzYp03MGa5ddxySRkTBUUe4ekCgSaap5b-YtEmxrSVvjJU0krkKLy2-HMD65HoAeUO-zHOe6LhPKQ5EnbXKYiV-30_07KNDKvo7U0R5nXQYk03OwMZIB6pzJY4jodWSyQWGOrND0hDoonzOb7EFp8fkCARM4mg:1lrBSS:qtGmE3aSfRtVp5vgg8--mXtePI_b2eKXJcIhnHr3OZw','2021-06-24 03:34:16.051852');
INSERT INTO "climbcville_question" ("id","question_text","pub_date") VALUES (5,'Who is the best climber?','2021-06-11 02:14:36'),
 (6,'What''s your favorite type of climbing?','2021-06-11 02:16:33');
INSERT INTO "climbcville_choice" ("id","choice_text","votes","question_id") VALUES (5,'Bouldering',4,6),
 (6,'Top roping',1,6),
 (7,'Sport Climbing',3,6),
 (8,'Trad Climbing',7,6),
 (9,'Chris Sharma',2,5),
 (10,'Alex Honnold',1,5),
 (11,'Adam Ondra',3,5),
 (12,'Zachery Key',9,5);
INSERT INTO "climbcville_route_setter" ("person_id","f_name","l_name","email","rs_experience_level","certifications","phone") VALUES (1,'Tyler','Clift','tyjclift@gmail.com',9,'CPR/AED, Wilderness First Aid, TR & Lead Belay',3333333333),
 (2,'Zach','Key','zach@gmail.com',10,'n/a',6666666666);
INSERT INTO "climbcville_route_log_entry" ("entry_id","comment","beta","c_grade","c_rating","route_id_id","c_id_id") VALUES (1,'This route was bananas!','Start with your left hand on the crimp rail and right hand on the obvious jug. Keep your feet low as you bump your right hand to the pinch overhead. Then heel hook on the rail and match on the pinch. Finish by leaning into the sidepull to the right and then grab the top and mantle.','V5','8/10',1,1),
 (45,'Most fun I have had in a while','Mantle over the blue marking','V5','4/10',3,1),
 (46,'this route was great','toe hook on the sharp ledge','V5','4/10',1,1),
 (47,'asdlkcnaskldc','asdcasdca','V2','3/10',2,1);
INSERT INTO "climbcville_admin" ("person_id","f_name","l_name","email","is_owner","edit_permission","create_permission","delete_permission","phone") VALUES (1,'Tyler','Clift','tjc5xp@virginia.edu',1,1,1,1,7819991470),
 (2,'Peter','Parker','peterp@gmail.com',0,1,1,0,12345678980);
INSERT INTO "climbcville_climber" ("person_id","f_name","l_name","email","c_experience_level","routes_attempted","is_team_member","phone") VALUES (1,'Natalia','Grossman','ngrossman@gmail.com',3,24,1,1111111111),
 (2,'Brooke','Raboutou','brookerab@gmail.com',9,45,1,2222222222);
INSERT INTO "climbcville_route_person_id" ("route_id","route_setter_id") VALUES (1,1),
 (2,2);
INSERT INTO "climbcville_route" ("route_id","r_type","rs_grade","location_id_id","route_name") VALUES (1,'boulder','V4',1,'Ty''s Favorite Route'),
 (2,'boulder','V6',1,'Crazy Crimps'),
 (3,'boulder','V5',2,'Taco Tues'),
 (4,'boulder','V10',2,'Squeezy McSqueezums'),
 (5,'boulder','V6',3,'tummy tumbler');
INSERT INTO "climbcville_location" ("location_id","latitude","approach_info","location_name","longitude") VALUES (1,-77.877435,'Walk northeast from the trailhead until you reach a stream. Follow the stream down the hill and you''ll see a cluster of boulders on the right.','shenendoah national park',-37.251469),
 (2,-78.90234,'Mozy on over past the watering hole','carbins cove',-36.9991234),
 (3,-77.643897,'Hike past buzzards roost until you can see the ridgeline','peaks of otter',-35.0012723);
INSERT INTO "climbcville_user_input" ("location_id","user_code","route_id") VALUES (2,1,4);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_group_permissions_group_id_permission_id_0cd325b0_uniq" ON "auth_group_permissions" (
	"group_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_group_id_b120cbf9" ON "auth_group_permissions" (
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_group_permissions_permission_id_84c5c92e" ON "auth_group_permissions" (
	"permission_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_groups_user_id_group_id_94350c0c_uniq" ON "auth_user_groups" (
	"user_id",
	"group_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_user_id_6a12ed8b" ON "auth_user_groups" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_groups_group_id_97559544" ON "auth_user_groups" (
	"group_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_permission_id_14a6b632_uniq" ON "auth_user_user_permissions" (
	"user_id",
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_user_id_a95ead1b" ON "auth_user_user_permissions" (
	"user_id"
);
CREATE INDEX IF NOT EXISTS "auth_user_user_permissions_permission_id_1fbb5f2c" ON "auth_user_user_permissions" (
	"permission_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_content_type_id_c4bce8eb" ON "django_admin_log" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_admin_log_user_id_c564eba6" ON "django_admin_log" (
	"user_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "django_content_type_app_label_model_76bd3d3b_uniq" ON "django_content_type" (
	"app_label",
	"model"
);
CREATE UNIQUE INDEX IF NOT EXISTS "auth_permission_content_type_id_codename_01ab375a_uniq" ON "auth_permission" (
	"content_type_id",
	"codename"
);
CREATE INDEX IF NOT EXISTS "auth_permission_content_type_id_2f476e4b" ON "auth_permission" (
	"content_type_id"
);
CREATE INDEX IF NOT EXISTS "django_session_expire_date_a5c62663" ON "django_session" (
	"expire_date"
);
CREATE INDEX IF NOT EXISTS "climbcville_choice_question_id_8ffd9f70" ON "climbcville_choice" (
	"question_id"
);
CREATE INDEX IF NOT EXISTS "climbcville_route_log_entry_route_id_id_455a3933" ON "climbcville_route_log_entry" (
	"route_id_id"
);
CREATE INDEX IF NOT EXISTS "climbcville_route_log_entry_c_id_id_1a99a2f0" ON "climbcville_route_log_entry" (
	"c_id_id"
);
CREATE UNIQUE INDEX IF NOT EXISTS "climbcville_route_person_id_route_id_route_setter_id_7600722f_uniq" ON "climbcville_route_person_id" (
	"route_id",
	"route_setter_id"
);
CREATE INDEX IF NOT EXISTS "climbcville_route_person_id_route_id_0b37e92e" ON "climbcville_route_person_id" (
	"route_id"
);
CREATE INDEX IF NOT EXISTS "climbcville_route_person_id_route_setter_id_11ce2157" ON "climbcville_route_person_id" (
	"route_setter_id"
);
CREATE INDEX IF NOT EXISTS "climbcville_route_location_id_id_3c15d2a0" ON "climbcville_route" (
	"location_id_id"
);
COMMIT;
