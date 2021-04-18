// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public class Statement {
	let statementPointer: OpaquePointer

	public init(connection: Connection, query: String, timeout: Int = 0) {
		self.statementPointer = CNanODBC.stmtCreate(connection.connection, query, timeout)
	}

	deinit {
		stmtClose(statementPointer)
	}
}
