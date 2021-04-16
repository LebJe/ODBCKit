import XCTest
@testable import ODBCKit

final class ODBCKitTests: XCTestCase {
    func testExample() throws {
		let conn = try Connection(.odbcString("Driver={PostgreSQL};Server=127.0.0.1;Database=lebje;Uid=lebje;"))

		print(try conn.execute(query: "SELECT * FROM table1;").hasAffectedRows)
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
