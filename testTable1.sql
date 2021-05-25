-- -------------------------------------------------------------
-- TablePlus 3.12.8(369)
--
-- https://tableplus.com/
--
-- Database: test.db
-- Generation Time: 2021-05-25 11:36:19.2560
-- -------------------------------------------------------------


DROP TABLE IF EXISTS "testTable1";
CREATE TABLE "testTable1" (
    "id" INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL,
    "string" VARCHAR(255) NOT NULL DEFAULT 'string 1',
    "int" INTEGER NOT NULL DEFAULT 100,
    "double" REAL NOT NULL DEFAULT 100.5,
    "bool" INTEGER NOT NULL DEFAULT false,
    "date" TEXT NOT NULL DEFAULT CURRENT_DATE,
    "time" TEXT NOT NULL DEFAULT CURRENT_TIME,
    "timestamp" TEXT NOT NULL DEFAULT CURRENT_TIMESTAMP,
	"binary" BLOB NOT NULL
);

INSERT INTO "testTable1" ("id", "string", "int", "double", "bool", "date", "time", "timestamp", "binary") VALUES
('1', 'string 1', '23059823', '3403.4592', '0', '2021-05-25', '01:13:48', '2021-05-25 11:32:48', X'48656C6C6F20576F726C640A');
