/*
 Navicat Premium Data Transfer

 Source Server         : timeDB-dev
 Source Server Type    : SQLite
 Source Server Version : 3008004
 Source Database       : main

 Target Server Type    : SQLite
 Target Server Version : 3008004
 File Encoding         : utf-8

 Date: 04/19/2018 21:30:07 PM
*/

PRAGMA foreign_keys = false;

-- ----------------------------
--  Table structure for fin_account
-- ----------------------------
DROP TABLE IF EXISTS "fin_account";
CREATE TABLE "fin_account" (
	 "ac_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "ac_name" TEXT,
	 "ac_desc" TEXT,
	 "ac_balance" real(11,2) DEFAULT 0,
	 "ac_init_balance" real(11,2) DEFAULT 0,
	 "ac_canused" INTEGER DEFAULT 1,
	 "ac_isdelete" INTEGER DEFAULT 0,
	 "ac_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "ac_update_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "org_id" INTEGER DEFAULT 0,
	 "user_id" INTEGER DEFAULT 1,
	 "actype_id" INTEGER
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("fin_account", '36');

-- ----------------------------
--  Table structure for fin_account_inout
-- ----------------------------
DROP TABLE IF EXISTS "fin_account_inout";
CREATE TABLE "fin_account_inout" (
	 "acio_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "acio_desc" TEXT,
	 "acio_money" real(11,2),
	 "acio_balance" real(11,2),
	 "acio_happened_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "acio_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "acio_isdelete" INTEGER DEFAULT 0,
	 "ac_id" INTEGER,
	 "user_id" INTEGER,
	 "aciotype_id" TEXT
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("fin_account_inout", '141');

-- ----------------------------
--  Table structure for fin_account_inout_type
-- ----------------------------
DROP TABLE IF EXISTS "fin_account_inout_type";
CREATE TABLE "fin_account_inout_type" (
	 "aciotype_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "aciotype_inorout" integer DEFAULT 0,
	 "aciotype_name" TEXT,
	 "aciotype_desc" TEXT,
	 "aciotype_level" INTEGER,
	 "aciotype_parent_id" INTEGER,
	 "aciotype_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "aciotype_isdelete" INTEGER DEFAULT 0,
	 "aciotype_seq" INTEGER DEFAULT 0
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("fin_account_inout_type", '23');

-- ----------------------------
--  Table structure for fin_account_transfer
-- ----------------------------
DROP TABLE IF EXISTS "fin_account_transfer";
CREATE TABLE "fin_account_transfer" (
	 "actr_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "actr_desc" TEXT,
	 "actr_money" real,
	 "actr_happened_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "actr_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "actr_isdelete" INTEGER DEFAULT 0,
	 "ac_id_from" INTEGER,
	 "ac_id_to" INTEGER,
	 "user_id" INTEGER
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("fin_account_transfer", '9');

-- ----------------------------
--  Table structure for fin_account_type
-- ----------------------------
DROP TABLE IF EXISTS "fin_account_type";
CREATE TABLE "fin_account_type" (
	 "actype_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "actype_name" TEXT,
	 "actype_desc" TEXT,
	 "actype_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "actype_isdelete" INTEGER DEFAULT 0
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("fin_account_type", '13');

-- ----------------------------
--  Table structure for fin_org
-- ----------------------------
DROP TABLE IF EXISTS "fin_org";
CREATE TABLE "fin_org" (
	 "org_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "org_name" TEXT,
	 "org_desc" TEXT,
	 "org_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "org_isdelete" INTEGER DEFAULT 0
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("fin_org", '8');

-- ----------------------------
--  Table structure for fin_trade_account
-- ----------------------------
DROP TABLE IF EXISTS "fin_trade_account";
CREATE TABLE "fin_trade_account" (
	 "tradeac_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "tradeac_name" TEXT,
	 "tradeac_code" TEXT,
	 "tradeac_type" integer DEFAULT 0,
	 "tradeac_count" REAL,
	 "tradeac_price_now" REAL,
	 "tradeac_money_cost" REAL,
	 "tradeac_remark" TEXT,
	 "tradeac_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "tradeac_update_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "tradeac_isdelete" INTEGER DEFAULT 0,
	 "ac_id" INTEGER DEFAULT -1
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("fin_trade_account", '6');

-- ----------------------------
--  Table structure for fin_trade_account_inout
-- ----------------------------
DROP TABLE IF EXISTS "fin_trade_account_inout";
CREATE TABLE "fin_trade_account_inout" (
	 "tradeacio_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "tradeacio_type" INTEGER,
	 "tradeacio_count" REAL,
	 "tradeacio_price" REAL,
	 "tradeacio_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "tradeacio_update_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "tradeacio_isdelete" INTEGER DEFAULT 0,
	 "tradeacio_fee" REAL,
	 "tradeacio_tax" REAL,
	 "tradeacio_remark" TEXT,
	 "tradeac_id" INTEGER DEFAULT -1
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("fin_trade_account_inout", '27');

-- ----------------------------
--  Table structure for fin_user
-- ----------------------------
DROP TABLE IF EXISTS "fin_user";
CREATE TABLE "fin_user" (
	 "user_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "user_name" TEXT,
	 "user_desc" TEXT,
	 "user_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "user_isowner" integer DEFAULT 1,
	 "user_isdelete" INTEGER DEFAULT 0
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("fin_user", '5');

-- ----------------------------
--  Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS "log";
CREATE TABLE log(  
  
    content varchar(256),  
  
    logtime TIMESTAMP default (datetime('now', 'localtime'))  
  
    );

-- ----------------------------
--  Table structure for timelog
-- ----------------------------
DROP TABLE IF EXISTS "timelog";
CREATE TABLE "timelog" (
	 "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "content" text DEFAULT 默认内容,
	 "type" integer DEFAULT 1,
	 "starttime" integer DEFAULT (datetime('2017-01-01 00:00:00')),
	 "endtime" integer DEFAULT (datetime('2017-01-01 00:00:00')),
	 "timecosted" real,
	 "createtime" integer DEFAULT (datetime('now', 'localtime')),
	 "isdelete" integer DEFAULT 0,
	 "todoitemid" integer DEFAULT 0
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("timelog", '58');

-- ----------------------------
--  Table structure for timelog_constant
-- ----------------------------
DROP TABLE IF EXISTS "timelog_constant";
CREATE TABLE "timelog_constant" (
	 "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "type" integer,
	 "keyid" integer,
	 "key" text,
	 "value" text,
	 "content" TEXT,
	 "desc" text,
	 "createtime" text DEFAULT (datetime('now', 'localtime')),
	 "status" integer DEFAULT 1
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("timelog_constant", '19');

-- ----------------------------
--  Table structure for todoitem
-- ----------------------------
DROP TABLE IF EXISTS "todoitem";
CREATE TABLE "todoitem" (
	 "id" integer NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "content" text DEFAULT 默认内容,
	 "type" integer DEFAULT 1,
	 "starttime" integer DEFAULT (datetime('2017-01-01 00:00:00')),
	 "endtime" integer DEFAULT (datetime('2017-01-01 00:00:00')),
	 "timecosted" real DEFAULT 0,
	 "createtime" integer DEFAULT (datetime('now', 'localtime')),
	 "isdelete" integer DEFAULT 0,
	 "updatetime" integer DEFAULT (datetime('now', 'localtime')),
	 "remark" text DEFAULT 备注,
	 "istoday" integer DEFAULT 0,
	 "status" integer DEFAULT 0,
	 "isfinished" integer DEFAULT 0,
	 "hasrelation" integer DEFAULT 0,
	 "relationid" integer DEFAULT 0,
	 "planstarttime" integer DEFAULT (datetime('2017-01-01 00:00:00')),
	 "planendtime" integer DEFAULT (datetime('2017-01-01 00:00:00')),
	 "plantimecosted" real DEFAULT 0,
	 "priority" integer DEFAULT 0
);
INSERT INTO "main".sqlite_sequence (name, seq) VALUES ("todoitem", '19');

PRAGMA foreign_keys = true;
