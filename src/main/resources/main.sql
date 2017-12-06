/*
 Navicat Premium Data Transfer

 Source Server         : timeDB-dev
 Source Server Type    : SQLite
 Source Server Version : 3008004
 Source Database       : main

 Target Server Type    : SQLite
 Target Server Version : 3008004
 File Encoding         : utf-8

CREATE TABLE "cgp_fin_account" (
	 "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "name" TEXT,
	 "desc" TEXT,
	 "type" INTEGER,
	 "orgid" INTEGER DEFAULT 0,
	 "balance" real DEFAULT 0,
	 "initbalance" real DEFAULT 0,
	 "userid" INTEGER DEFAULT 1,
	 "canused" INTEGER DEFAULT 1,
	 "isdelete" INTEGER DEFAULT 0,
	 "createtime" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "updatetime" INTEGER DEFAULT (datetime('now', 'localtime'))
);


CREATE TABLE "cgp_fin_account_type" (
"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
"name" TEXT,
"desc" TEXT,
"key" TEXT,
"value" INTEGER,
"createtime" INTEGER DEFAULT (datetime('now', 'localtime')),
"isdelete" INTEGER DEFAULT 0
);


CREATE TABLE "cgp_fin_inoutdetail" (
"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
"type" TEXT,
"desc" TEXT,
"money" real,
"balance" real,
"accountid" INTEGER,
"year" INTEGER,
"month" INTEGER,
"day" INTEGER,
"happenedtime" INTEGER DEFAULT (datetime('now', 'localtime')),
"createtime" INTEGER DEFAULT (datetime('now', 'localtime')),
"isdelete" INTEGER DEFAULT 0
);


CREATE TABLE "cgp_fin_inouttype" (
"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
"name" TEXT,
"desc" TEXT,
"key" TEXT,
"value" INTEGER,
"level" INTEGER,
"parentid" INTEGER,
"createtime" INTEGER DEFAULT (datetime('now', 'localtime')),
"isdelete" INTEGER DEFAULT 0
);


CREATE TABLE "cgp_fin_org" (
"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
"name" TEXT,
"desc" TEXT,
"isdelete" INTEGER DEFAULT 0,
"createtime" INTEGER DEFAULT (datetime('now', 'localtime'))
);


CREATE TABLE "cgp_fin_transfer" (
"id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
"type" TEXT,
"desc" TEXT,
"money" real,
"frombalance" real,
"tobalance" real,
"fromaccountid" INTEGER,
"toaccountid" INTEGER,
"year" INTEGER,
"month" INTEGER,
"day" INTEGER,
"happenedtime" INTEGER DEFAULT (datetime('now', 'localtime')),
"createtime" INTEGER DEFAULT (datetime('now', 'localtime')),
"isdelete" INTEGER DEFAULT 0
);


CREATE TABLE "cgp_fin_user" (
	 "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "name" TEXT,
	 "desc" TEXT,
	 "createtime" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "code" TEXT,
	 "isowner" integer DEFAULT 1,
	 "isdelete" INTEGER DEFAULT 0
);


CREATE TABLE log(  
  
    content varchar(256),  
  
    logtime TIMESTAMP default (datetime('now', 'localtime'))  
  
    );



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


