/*
Navicat SQLite Data Transfer

Source Server         : timeDb.sqlite-dev
Source Server Version : 30714
Source Host           : :0

Target Server Type    : SQLite
Target Server Version : 30714
File Encoding         : 65001

Date: 2018-03-05 01:38:26
*/

PRAGMA foreign_keys = OFF;

-- ----------------------------
-- Table structure for fin_account
-- ----------------------------
DROP TABLE IF EXISTS "main"."fin_account";
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

-- ----------------------------
-- Table structure for fin_account_inout
-- ----------------------------
DROP TABLE IF EXISTS "main"."fin_account_inout";
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

-- ----------------------------
-- Table structure for fin_account_inout_type
-- ----------------------------
DROP TABLE IF EXISTS "main"."fin_account_inout_type";
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

-- ----------------------------
-- Table structure for fin_account_transfer
-- ----------------------------
DROP TABLE IF EXISTS "main"."fin_account_transfer";
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

-- ----------------------------
-- Table structure for fin_account_type
-- ----------------------------
DROP TABLE IF EXISTS "main"."fin_account_type";
CREATE TABLE "fin_account_type" (
	 "actype_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "actype_name" TEXT,
	 "actype_desc" TEXT,
	 "actype_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "actype_isdelete" INTEGER DEFAULT 0
);

-- ----------------------------
-- Table structure for fin_org
-- ----------------------------
DROP TABLE IF EXISTS "main"."fin_org";
CREATE TABLE "fin_org" (
	 "org_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "org_name" TEXT,
	 "org_desc" TEXT,
	 "org_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "org_isdelete" INTEGER DEFAULT 0
);

-- ----------------------------
-- Table structure for fin_trade_account
-- ----------------------------
DROP TABLE IF EXISTS "main"."fin_trade_account";
CREATE TABLE "fin_trade_account" (
"tradeac_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeac_name"  TEXT,
"tradeac_code"  TEXT,
"tradeac_count"  REAL,
"tradeac_price_now"  REAL,
"tradeac_money_cost"  REAL,
"tradeac_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_update_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_isdelete"  INTEGER DEFAULT 0,
"ac_id"  INTEGER DEFAULT -1
);

-- ----------------------------
-- Table structure for fin_trade_account_inout
-- ----------------------------
DROP TABLE IF EXISTS "main"."fin_trade_account_inout";
CREATE TABLE "fin_trade_account_inout" (
"tradeacio_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeacio_type"  INTEGER,
"tradeacio_count"  REAL,
"tradeacio_price"  REAL,
"tradeacio_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeacio_update_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_isdelete"  INTEGER DEFAULT 0,
"tradeacio_fee"  REAL,
"tradeacio_tax"  REAL,
"tradeacio_remark"  TEXT,
"tradeac_id"  INTEGER DEFAULT -1
);

-- ----------------------------
-- Table structure for fin_user
-- ----------------------------
DROP TABLE IF EXISTS "main"."fin_user";
CREATE TABLE "fin_user" (
	 "user_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "user_name" TEXT,
	 "user_desc" TEXT,
	 "user_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "user_isowner" integer DEFAULT 1,
	 "user_isdelete" INTEGER DEFAULT 0
);

-- ----------------------------
-- Table structure for log
-- ----------------------------
DROP TABLE IF EXISTS "main"."log";
CREATE TABLE log(  
  
    content varchar(256),  
  
    logtime TIMESTAMP default (datetime('now', 'localtime'))  
  
    );

-- ----------------------------
-- Table structure for sqlite_sequence
-- ----------------------------
DROP TABLE IF EXISTS "main"."sqlite_sequence";
CREATE TABLE sqlite_sequence(name,seq);

-- ----------------------------
-- Table structure for timelog
-- ----------------------------
DROP TABLE IF EXISTS "main"."timelog";
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

-- ----------------------------
-- Table structure for timelog_constant
-- ----------------------------
DROP TABLE IF EXISTS "main"."timelog_constant";
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

-- ----------------------------
-- Table structure for todoitem
-- ----------------------------
DROP TABLE IF EXISTS "main"."todoitem";
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

-- ----------------------------
-- Table structure for _fin_trade_account_inout_old_20180304
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_inout_old_20180304";
CREATE TABLE "_fin_trade_account_inout_old_20180304" (
"tradeacio_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL
);

-- ----------------------------
-- Table structure for _fin_trade_account_inout_old_20180304_1
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_inout_old_20180304_1";
CREATE TABLE "_fin_trade_account_inout_old_20180304_1" (
"tradeacio_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeacio_type"  INTEGER,
"tradeacio_count"  REAL,
"tradeacio_price"  REAL,
"tradeacio_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeacio_update_time"  INTEGER DEFAULT (datetime('now', 'localtime'))
);

-- ----------------------------
-- Table structure for _fin_trade_account_inout_old_20180304_2
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_inout_old_20180304_2";
CREATE TABLE "_fin_trade_account_inout_old_20180304_2" (
"tradeacio_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeacio_type"  INTEGER,
"tradeacio_count"  REAL,
"tradeacio_price"  REAL,
"tradeacio_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeacio_update_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeacio_fee"  REAL,
"tradeacio_tax"  REAL
);

-- ----------------------------
-- Table structure for _fin_trade_account_inout_old_20180304_3
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_inout_old_20180304_3";
CREATE TABLE "_fin_trade_account_inout_old_20180304_3" (
"tradeacio_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeacio_type"  INTEGER,
"tradeacio_count"  REAL,
"tradeacio_price"  REAL,
"tradeacio_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeacio_update_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeacio_fee"  REAL,
"tradeacio_tax"  REAL,
"tradeac_id"  INTEGER
);

-- ----------------------------
-- Table structure for _fin_trade_account_inout_old_20180304_4
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_inout_old_20180304_4";
CREATE TABLE "_fin_trade_account_inout_old_20180304_4" (
"tradeacio_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeacio_type"  INTEGER,
"tradeacio_count"  REAL,
"tradeacio_price"  REAL,
"tradeacio_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeacio_update_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_isdelete"  INTEGER,
"tradeacio_fee"  REAL,
"tradeacio_tax"  REAL,
"tradeac_id"  INTEGER
);

-- ----------------------------
-- Table structure for _fin_trade_account_inout_old_20180304_5
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_inout_old_20180304_5";
CREATE TABLE "_fin_trade_account_inout_old_20180304_5" (
"tradeacio_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeacio_type"  INTEGER,
"tradeacio_count"  REAL,
"tradeacio_price"  REAL,
"tradeacio_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeacio_update_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_isdelete"  INTEGER,
"tradeacio_fee"  REAL,
"tradeacio_tax"  REAL,
"tradeacio_remark"  TEXT,
"tradeac_id"  INTEGER
);

-- ----------------------------
-- Table structure for _fin_trade_account_inout_old_20180304_6
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_inout_old_20180304_6";
CREATE TABLE "_fin_trade_account_inout_old_20180304_6" (
"tradeacio_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeacio_type"  INTEGER,
"tradeacio_count"  REAL,
"tradeacio_price"  REAL,
"tradeacio_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeacio_update_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_isdelete"  INTEGER DEFAULT 0,
"tradeacio_fee"  REAL,
"tradeacio_tax"  REAL,
"tradeacio_remark"  TEXT,
"tradeac_id"  INTEGER
);

-- ----------------------------
-- Table structure for _fin_trade_account_old_20180304
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_old_20180304";
CREATE TABLE "_fin_trade_account_old_20180304" (
"tradeac_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeac_name"  TEXT,
"tradeac_codet"  TEXT,
"tradeac_count"  REAL,
"tradeac_price_now"  REAL,
"tradeac_money_cost"  REAL,
"tradeac_create_time"  INTEGER,
"tradeac_update_time"  INTEGER
);

-- ----------------------------
-- Table structure for _fin_trade_account_old_20180304_1
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_old_20180304_1";
CREATE TABLE "_fin_trade_account_old_20180304_1" (
"tradeac_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeac_name"  TEXT,
"tradeac_code"  TEXT,
"tradeac_count"  REAL,
"tradeac_price_now"  REAL,
"tradeac_money_cost"  REAL,
"tradeac_create_time"  INTEGER,
"tradeac_update_time"  INTEGER
);

-- ----------------------------
-- Table structure for _fin_trade_account_old_20180304_2
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_old_20180304_2";
CREATE TABLE "_fin_trade_account_old_20180304_2" (
"tradeac_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeac_name"  TEXT,
"tradeac_code"  TEXT,
"tradeac_count"  REAL,
"tradeac_price_now"  REAL,
"tradeac_money_cost"  REAL,
"tradeac_create_time"  INTEGER,
"tradeac_update_time"  INTEGER,
"ac_id"  INTEGER
);

-- ----------------------------
-- Table structure for _fin_trade_account_old_20180304_3
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_old_20180304_3";
CREATE TABLE "_fin_trade_account_old_20180304_3" (
"tradeac_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeac_name"  TEXT,
"tradeac_code"  TEXT,
"tradeac_count"  REAL,
"tradeac_price_now"  REAL,
"tradeac_money_cost"  REAL,
"tradeac_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_update_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"ac_id"  INTEGER
);

-- ----------------------------
-- Table structure for _fin_trade_account_old_20180304_4
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_old_20180304_4";
CREATE TABLE "_fin_trade_account_old_20180304_4" (
"tradeac_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeac_name"  TEXT,
"tradeac_code"  TEXT,
"tradeac_count"  REAL,
"tradeac_price_now"  REAL,
"tradeac_money_cost"  REAL,
"tradeac_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_update_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_isdelete"  TEXT,
"ac_id"  INTEGER
);

-- ----------------------------
-- Table structure for _fin_trade_account_old_20180304_5
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_old_20180304_5";
CREATE TABLE "_fin_trade_account_old_20180304_5" (
"tradeac_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeac_name"  TEXT,
"tradeac_code"  TEXT,
"tradeac_count"  REAL,
"tradeac_price_now"  REAL,
"tradeac_money_cost"  REAL,
"tradeac_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_update_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_isdelete"  INTEGER,
"ac_id"  INTEGER
);

-- ----------------------------
-- Table structure for _fin_trade_account_old_20180304_6
-- ----------------------------
DROP TABLE IF EXISTS "main"."_fin_trade_account_old_20180304_6";
CREATE TABLE "_fin_trade_account_old_20180304_6" (
"tradeac_id"  INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
"tradeac_name"  TEXT,
"tradeac_code"  TEXT,
"tradeac_count"  REAL,
"tradeac_price_now"  REAL,
"tradeac_money_cost"  REAL,
"tradeac_create_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_update_time"  INTEGER DEFAULT (datetime('now', 'localtime')),
"tradeac_isdelete"  INTEGER DEFAULT 0,
"ac_id"  INTEGER
);
