// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public class Statement {
	let statementPointer: OpaquePointer

	public init(connection: Connection, query: String, timeout: Int = 0) {
		self.statementPointer = stmtCreate(connection.connection, query, timeout)
	}

	/// Executes this `Statement` and returns the `Result` of execution.
	/// - Parameter values: The values to bind to the parameters in your query.
	/// - Throws: `ODBCError`.
	/// - Returns: `Result`.
	public func execute(with values: [BindableValue?] = []) throws -> Result {
		for i in 0..<values.count {
			if values[i] == nil {
				stmtBindNull(self.statementPointer, Int16(i))
			} else {
				try values[i]!.bind(stmtPointer: self.statementPointer, index: Int16(i))
			}
		}

		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		let resPointer = stmtExecute(statementPointer, errorPointer)

		if errorPointer.pointee.message != nil {
			switch errorPointer.pointee.reason {
				case ErrorReason.databaseError: throw ODBCError.databaseError(message: String(cString: errorPointer.pointee.message))
				default: throw ODBCError.general(message: errorPointer.pointee.message != nil ? String(cString: errorPointer.pointee.message) : nil)
			}
		}

		return Result(resPointer: resPointer)
	}

//	deinit {
//		stmtClose(statementPointer)
//	}
}
