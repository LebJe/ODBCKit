// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

@testable import ODBCKit
import XCTest

final class PostgreSQLTests: XCTestCase {
	static var createTableStmt = """
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
		"binary" bytea NOT NULL,
		null_field varchar,
		PRIMARY KEY ("id")
	);

	INSERT INTO "public"."dataTypes" ("id", "string", "int", "float", "bool", "date", "time", "timestamp", "binary", null_field) VALUES
	(1, 'string 1', 23809, 34023.329, 't', '2021-05-27', '07:52:13.600253', '2021-05-27 12:09:58.14121', '\\x48656c6c6f20576f726c640a', NULL);

	"""

	static var connString = ConnectionType.odbcString("Driver={PostgreSQL};Database=postgres;UID=postgres;Server=localhost;")

	override class func setUp() {
		do {
			let conn = try Connection(Self.connString)

			try conn.justExecute(query: Self.createTableStmt)
		} catch {
			XCTFail("ERROR: Unable to setup DB, error message: \(error)")
		}
	}

	func testRetrieveValues() throws {
		let conn = try Connection(Self.connString)

		var res = try conn.execute(query: "SELECT * FROM \"dataTypes\";")

		XCTAssertTrue(try res.next(), "ERROR: Unable to advance to next row!")

		XCTAssertEqual(try res[0]!.int()!, 1)
		XCTAssertEqual(try res[1]!.string()!, "string 1")
		XCTAssertEqual(try res[2]!.int()!, 23809)
		XCTAssertNil(try res[9]?.string())
	}

	static var allTests = [
		("Test Retrieving Values", testRetrieveValues),
	]
}
