// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

@testable import ODBCKit
import XCTest

final class SQLiteTests: XCTestCase {
	static var dbName = "test.db"
	static var connString = "Driver={SQLite3};Database=test.db;"

	static var dbSetupStmt = """
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
	"""

	override class func setUp() {
		// Remove old database.
		do {
			if FileManager.default.fileExists(atPath: Self.dbName) {
				try FileManager.default.removeItem(at: URL(fileURLWithPath: Self.dbName))
			}
		} catch {
			XCTFail("Unable to delete \(Self.dbName)")
		}
		FileManager.default.createFile(atPath: Self.dbName, contents: nil, attributes: nil)

		do {
			let conn = try Connection(.odbcString(Self.connString))

			try conn.justExecute(query: Self.dbSetupStmt)
		} catch {}
	}

	func testSmallTest() throws {
		let conn = try Connection(.odbcString(Self.connString))

		var res = try conn.execute(query: "SELECT * FROM \"testable1\";")

		XCTAssertTrue(try res.next())

		print("ID: \(try res["id"]!.int()!)")
		print("String: \(try res["string"]!.string()!)")
		print("Int: \(try res["int"]!.int()!)")
		print("Float: \(try res["float"]!.float()!)")
		print("Bool: \(try res["bool"]!.bool()!)")
		print("Date: \(try res[5]!.date()!)")
		print("Time: \(try res[6]!.time()!)")
		print("TimeStamp: \(try res[7]!.timeStamp()!)")
		print("Bytes: \(try res[8]!.bytes()!)")
	}

	static var allTests = [
		("Test smallTest", testSmallTest),
	]
}
