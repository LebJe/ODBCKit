-- -------------------------------------------------------------
-- TablePlus 3.12.8(369)
--
-- https://tableplus.com/
--
-- Database: lebje
-- Generation Time: 2021-05-27 12:10:16.5670
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "public"."dataTypes";
-- This script only contains the table creation statements and does not fully represent the table in the database. It's still missing: indices, triggers. Do not use it as a backup.

-- Sequence and defined type
CREATE SEQUENCE IF NOT EXISTS "dataTypes_id_seq";

-- Table Definition
CREATE TABLE "public"."dataTypes" (
    "id" int4 NOT NULL DEFAULT nextval('"dataTypes_id_seq"'::regclass),
    "string" varchar NOT NULL DEFAULT 'string 1'::character varying,
    "int" int8 NOT NULL DEFAULT 100,
    "float" float8 NOT NULL DEFAULT 100.5,
    "bool" bool NOT NULL DEFAULT false,
    "date" date NOT NULL DEFAULT now(),
    "time" time NOT NULL DEFAULT now(),
    "timestamp" timestamp NOT NULL DEFAULT now(),
    "binary" bytea NOT NULL DEFAULT '\x30783030'::bytea,
    PRIMARY KEY ("id")
);

INSERT INTO "public"."dataTypes" ("id", "string", "int", "float", "bool", "date", "time", "timestamp", "binary") VALUES
(1, 'string 1', 23809, 34023.329, 't', '2021-05-27', '07:52:13.600253', '2021-05-27 12:09:58.14121', '\x48656c6c6f20576f726c640a');
