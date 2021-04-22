// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

@testable import ODBCKit
import XCTest

final class ODBCKitTests: XCTestCase {
	func testExample() throws {
		// TODO: More general tests.

		// let conn = try Connection(.odbcString("Driver={SQLite3};Database=test.db;"))
		let conn = try Connection(.odbcString("Driver={PostgreSQL};Database=lebje;UID=lebje;Server=127.0.0.1;"))
		// var res = try conn
		// .statement(query: "SELECT * FROM \"dataTypes\" WHERE \"time\" = ?;")
		// .execute(with: [Time(hour: 7, minute: 52, second: 13)])

		var res = try conn.execute(query: "SELECT * FROM \"dataTypes\";")

		// print(try res.rows)

		print("-------------------------")

		while try res.next() {
			print("ID: \(try res["id"]!.int()!)")
			print("String: \(try res["string"]!.string()!)")
			print("Int: \(try res["int"]!.int()!)")
			print("Float: \(try res["float"]!.float()!)")
			print("Bool: \(try res["bool"]!.bool()!)")
			print("Date: \(try res[5]!.date()!)")
			print("Time: \(try res[6]!.time()!)")
			print("TimeStamp: \(try res[7]!.timeStamp()!)")
			print("Bytes: \(try res[8]!.bytes()!)")

			print("-------------------------")
		}
	}

	static var allTests = [
		("testExample", testExample),
	]
}
