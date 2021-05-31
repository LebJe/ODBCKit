// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import XCTest

#if !canImport(ObjectiveC)
	public func allTests() -> [XCTestCaseEntry] {
		[
			testCase(ODBCKitTests.allTests),
		]
	}
#endif
