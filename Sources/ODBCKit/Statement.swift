// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public class Statement {
	enum BindDirection: Int {
		case `in`
		case out
	}

	let statementPointer: OpaquePointer

	public init(connection: Connection, query: String, timeout: Int = 0) {
		self.statementPointer = stmtCreate(connection.connection, query, timeout)
	}

	/// Binds `value` to the `?` parameter at `index`.
	///
	/// `?` parameters start from 0.
	///
	/// - Throws: ``ODBCError``
	public func bind<B: BindableValue>(_ value: B, to index: Int) throws {
		try value.bind(stmtPointer: self.statementPointer, index: Int16(index))
	}

	/// Executes this `Statement` and returns the `Result` of execution.
	/// - Parameter values: The values to bind to the `?` parameters in your query.
	/// - Throws: `ODBCError`.
	/// - Returns: `Result`.
	public func execute<B: BindableValue>(with values: [B?] = [], timeout: Int = 0) throws -> Result {
		for i in 0..<values.count {
			try values[i].bind(stmtPointer: self.statementPointer, index: Int16(i))
		}

		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
		let resPointer = stmtExecute(statementPointer, timeout, errorPointer)

		if errorPointer.pointee.isValid {
			throw ODBCError.fromErrorPointer(errorPointer)
		}

		guard let res = resPointer else { throw ODBCError.unexpectedNull(name: "nanodbc::statement::execute") }

		return Result(resPointer: res)
	}

//	deinit {
//		stmtClose(statementPointer)
//	}
}
