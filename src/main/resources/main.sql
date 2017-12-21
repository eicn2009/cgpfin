CREATE TABLE "main"."fin_account" (
	 "ac_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "ac_name" TEXT,
	 "ac_desc" TEXT,
	 "ac_balance" real(11,2) DEFAULT 0,
	 "ac_init_balance" real(11,2) DEFAULT 0,
	 "ac_canused" INTEGER DEFAULT 1,
	 "ac_isdelete" INTEGER DEFAULT 0,
	 "ac_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "ac_update_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "actype_id" INTEGER,
	 "org_id" INTEGER DEFAULT 0,
	 "user_id" INTEGER DEFAULT 1
);

CREATE TABLE "main"."fin_account_type" (
	 "actype_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "actype_name" TEXT,
	 "actype_desc" TEXT,
	 "actype_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "actype_isdelete" INTEGER DEFAULT 0
);
CREATE TABLE "main"."fin_account_inout" (
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

CREATE TABLE "main"."fin_account_inout_type" (
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


CREATE TABLE "main"."fin_org" (
	 "org_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "org_name" TEXT,
	 "org_desc" TEXT,
	 "org_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "org_isdelete" INTEGER DEFAULT 0
);


CREATE TABLE "main"."fin_account_transfer" (
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



CREATE TABLE "main"."fin_user" (
	 "user_id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
	 "user_name" TEXT,
	 "user_desc" TEXT,
	 "user_create_time" INTEGER DEFAULT (datetime('now', 'localtime')),
	 "user_isowner" integer DEFAULT 1,
	 "user_isdelete" INTEGER DEFAULT 0
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


