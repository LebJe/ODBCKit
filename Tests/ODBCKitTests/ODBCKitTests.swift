// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

@testable import ODBCKit
import XCTest

final class ODBCKitTests: XCTestCase {
	func testExample() throws {
		let conn = try Connection(.odbcString("Driver={PostgeSQL};Server=127.0.0.1;Database=lebje;Uid=lebje;"))

		let res = try conn.execute(query: "SELECT * FROM table1;")

		print("-------------------------")
		while try res.next() {
			print("ID: \(try res.getInt(from: 0)!)")
			print("Name: \(try res.getString(from: 1)!)")
			print("EMail: \(try res.getString(from: 2)!)")
			print("Time: \(try res.getTimeStamp(from: 3))")
			print("-------------------------")
		}
	}

	static var allTests = [
		("testExample", testExample),
	]
}
