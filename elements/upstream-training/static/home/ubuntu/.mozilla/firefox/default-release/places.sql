PRAGMA foreign_keys=OFF;
BEGIN TRANSACTION;
CREATE TABLE moz_origins ( id INTEGER PRIMARY KEY, prefix TEXT NOT NULL, host TEXT NOT NULL, frecency INTEGER NOT NULL, UNIQUE (prefix, host) );
INSERT INTO moz_origins VALUES(7,'http://','localhost',-134);
INSERT INTO moz_origins VALUES(9,'https://','opendev.org',57);
INSERT INTO moz_origins VALUES(11,'https://','docs.openstack.org',-134);
CREATE TABLE moz_places (   id INTEGER PRIMARY KEY, url LONGVARCHAR, title LONGVARCHAR, rev_host LONGVARCHAR, visit_count INTEGER DEFAULT 0, hidden INTEGER DEFAULT 0 NOT NULL, typed INTEGER DEFAULT 0 NOT NULL, frecency INTEGER DEFAULT -1 NOT NULL, last_visit_date INTEGER , guid TEXT, foreign_count INTEGER DEFAULT 0 NOT NULL, url_hash INTEGER DEFAULT 0 NOT NULL , description TEXT, preview_image_url TEXT, origin_id INTEGER REFERENCES moz_origins(id));
INSERT INTO moz_places VALUES(13,'http://localhost/dashboard/auth/login/?next=/dashboard/','Login - OpenStack Dashboard','tsohlacol.',0,0,0,-1,NULL,'T1avrkk79Bcy',1,125509329257445,NULL,NULL,7);
INSERT INTO moz_places VALUES(21,'https://opendev.org/openstack/upstream-institute-virtual-environment#user-content-getting-around-in-the-vm','openstack/upstream-institute-virtual-environment: A VirtualBox image that has all the tools needed to begin OpenStack upstream contribution - upstream-institute-virtual-environment - OpenDev: Free Software Needs Free Tools','gro.vednepo.',0,0,0,-1,NULL,'jeTn2YGMmTYX',1,47358254921276,'A VirtualBox image that has all the tools needed to begin OpenStack upstream contribution','https://opendev.org/user/avatar/openstack/-1',9);
INSERT INTO moz_places VALUES(23,'https://docs.openstack.org/upstream-training/','OpenStack Docs: OpenStack Upstream Institute','gro.kcatsnepo.scod.',0,0,0,-1,NULL,'Ss-objjt0p6Y',1,47357000276702,NULL,NULL,11);
CREATE TABLE moz_historyvisits (  id INTEGER PRIMARY KEY, from_visit INTEGER, place_id INTEGER, visit_date INTEGER, visit_type INTEGER, session INTEGER);
CREATE TABLE moz_inputhistory (  place_id INTEGER NOT NULL, input LONGVARCHAR NOT NULL, use_count INTEGER, PRIMARY KEY (place_id, input));
CREATE TABLE moz_bookmarks (  id INTEGER PRIMARY KEY, type INTEGER, fk INTEGER DEFAULT NULL, parent INTEGER, position INTEGER, title LONGVARCHAR, keyword_id INTEGER, folder_type TEXT, dateAdded INTEGER, lastModified INTEGER, guid TEXT, syncStatus INTEGER NOT NULL DEFAULT 0, syncChangeCounter INTEGER NOT NULL DEFAULT 1);
INSERT INTO moz_bookmarks VALUES(1,2,NULL,0,0,'',NULL,NULL,1602831047211000,1602831185097000,'root________',1,1);
INSERT INTO moz_bookmarks VALUES(2,2,NULL,1,0,'menu',NULL,NULL,1602831047211000,1602831064957000,'menu________',1,5);
INSERT INTO moz_bookmarks VALUES(3,2,NULL,1,1,'toolbar',NULL,NULL,1602831047211000,1602831185097000,'toolbar_____',1,7);
INSERT INTO moz_bookmarks VALUES(4,2,NULL,1,2,'tags',NULL,NULL,1602831047211000,1602831047211000,'tags________',1,1);
INSERT INTO moz_bookmarks VALUES(5,2,NULL,1,3,'unfiled',NULL,NULL,1602831047211000,1602831155979000,'unfiled_____',1,6);
INSERT INTO moz_bookmarks VALUES(6,2,NULL,1,4,'mobile',NULL,NULL,1602831047225000,1602831047883000,'mobile______',1,2);
INSERT INTO moz_bookmarks VALUES(7,1,13,3,1,'DevStack dashboard',NULL,NULL,1602831084610000,1602831098067000,'dBaxGDdxd3_3',1,3);
INSERT INTO moz_bookmarks VALUES(8,1,21,3,0,'VM help',NULL,NULL,1602831143349000,1602831155979000,'NmU33M707NBI',1,3);
INSERT INTO moz_bookmarks VALUES(9,1,23,3,2,'Upstream Institute',NULL,NULL,1602831185097000,1602831192441000,'kWXf2DouR7K9',1,2);
CREATE TABLE moz_bookmarks_deleted (  guid TEXT PRIMARY KEY, dateRemoved INTEGER NOT NULL DEFAULT 0);
CREATE TABLE moz_keywords (  id INTEGER PRIMARY KEY AUTOINCREMENT, keyword TEXT UNIQUE, place_id INTEGER, post_data TEXT);
CREATE TABLE moz_anno_attributes (  id INTEGER PRIMARY KEY, name VARCHAR(32) UNIQUE NOT NULL);
CREATE TABLE moz_annos (  id INTEGER PRIMARY KEY, place_id INTEGER NOT NULL, anno_attribute_id INTEGER, content LONGVARCHAR, flags INTEGER DEFAULT 0, expiration INTEGER DEFAULT 0, type INTEGER DEFAULT 0, dateAdded INTEGER DEFAULT 0, lastModified INTEGER DEFAULT 0);
CREATE TABLE moz_items_annos (  id INTEGER PRIMARY KEY, item_id INTEGER NOT NULL, anno_attribute_id INTEGER, content LONGVARCHAR, flags INTEGER DEFAULT 0, expiration INTEGER DEFAULT 0, type INTEGER DEFAULT 0, dateAdded INTEGER DEFAULT 0, lastModified INTEGER DEFAULT 0);
CREATE TABLE moz_meta (key TEXT PRIMARY KEY, value NOT NULL) WITHOUT ROWID ;
INSERT INTO moz_meta VALUES('origin_frecency_count',1);
INSERT INTO moz_meta VALUES('origin_frecency_sum',56.999999999999999998);
INSERT INTO moz_meta VALUES('origin_frecency_sum_of_squares',3248.9999999999999999);
ANALYZE sqlite_master;
INSERT INTO sqlite_stat1 VALUES('moz_places','moz_places_originidindex','23 3');
INSERT INTO sqlite_stat1 VALUES('moz_places','moz_places_guid_uniqueindex','23 1');
INSERT INTO sqlite_stat1 VALUES('moz_places','moz_places_lastvisitdateindex','23 2');
INSERT INTO sqlite_stat1 VALUES('moz_places','moz_places_frecencyindex','23 4');
INSERT INTO sqlite_stat1 VALUES('moz_places','moz_places_visitcount','23 8');
INSERT INTO sqlite_stat1 VALUES('moz_places','moz_places_hostindex','23 3');
INSERT INTO sqlite_stat1 VALUES('moz_places','moz_places_url_hashindex','23 1');
INSERT INTO sqlite_stat1 VALUES('moz_historyvisits','moz_historyvisits_dateindex','17 1');
INSERT INTO sqlite_stat1 VALUES('moz_historyvisits','moz_historyvisits_fromindex','17 2');
INSERT INTO sqlite_stat1 VALUES('moz_historyvisits','moz_historyvisits_placedateindex','17 2 1');
INSERT INTO sqlite_stat1 VALUES('moz_bookmarks','moz_bookmarks_guid_uniqueindex','9 1');
INSERT INTO sqlite_stat1 VALUES('moz_bookmarks','moz_bookmarks_dateaddedindex','9 2');
INSERT INTO sqlite_stat1 VALUES('moz_bookmarks','moz_bookmarks_itemlastmodifiedindex','9 3 2');
INSERT INTO sqlite_stat1 VALUES('moz_bookmarks','moz_bookmarks_parentindex','9 3 1');
INSERT INTO sqlite_stat1 VALUES('moz_bookmarks','moz_bookmarks_itemindex','9 3 3');
DELETE FROM sqlite_sequence;
CREATE INDEX moz_places_url_hashindex ON moz_places (url_hash);
CREATE INDEX moz_places_hostindex ON moz_places (rev_host);
CREATE INDEX moz_places_visitcount ON moz_places (visit_count);
CREATE INDEX moz_places_frecencyindex ON moz_places (frecency);
CREATE INDEX moz_places_lastvisitdateindex ON moz_places (last_visit_date);
CREATE UNIQUE INDEX moz_places_guid_uniqueindex ON moz_places (guid);
CREATE INDEX moz_places_originidindex ON moz_places (origin_id);
CREATE INDEX moz_historyvisits_placedateindex ON moz_historyvisits (place_id, visit_date);
CREATE INDEX moz_historyvisits_fromindex ON moz_historyvisits (from_visit);
CREATE INDEX moz_historyvisits_dateindex ON moz_historyvisits (visit_date);
CREATE INDEX moz_bookmarks_itemindex ON moz_bookmarks (fk, type);
CREATE INDEX moz_bookmarks_parentindex ON moz_bookmarks (parent, position);
CREATE INDEX moz_bookmarks_itemlastmodifiedindex ON moz_bookmarks (fk, lastModified);
CREATE INDEX moz_bookmarks_dateaddedindex ON moz_bookmarks (dateAdded);
CREATE UNIQUE INDEX moz_bookmarks_guid_uniqueindex ON moz_bookmarks (guid);
CREATE UNIQUE INDEX moz_keywords_placepostdata_uniqueindex ON moz_keywords (place_id, post_data);
CREATE UNIQUE INDEX moz_annos_placeattributeindex ON moz_annos (place_id, anno_attribute_id);
CREATE UNIQUE INDEX moz_items_annos_itemattributeindex ON moz_items_annos (item_id, anno_attribute_id);
COMMIT;