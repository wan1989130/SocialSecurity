/*
 Navicat Premium Data Transfer

 Source Server         : demo
 Source Server Type    : SQLite
 Source Server Version : 3008008
 Source Database       : main

 Target Server Type    : SQLite
 Target Server Version : 3008008
 File Encoding         : utf-8

 Date: 06/15/2018 10:36:23 AM
*/

PRAGMA foreign_keys = false;

-- ----------------------------
--  Table structure for MyTable
-- ----------------------------
DROP TABLE IF EXISTS "MyTable";
CREATE TABLE "MyTable" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT,
	 "time" text,
	 "loginName" text,
	 "content" text,
	 "showTime" text
);

PRAGMA foreign_keys = true;
