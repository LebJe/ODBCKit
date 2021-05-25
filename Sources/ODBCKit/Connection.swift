// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

/// How the driver and database details will be passed to the ODBC driver.
public enum ConnectionType {
	/// Connect using an ODBC string,
	///
	/// Example:
	/// ```
	/// Driver={PostgreSQL};Database=postgres;UID=postgres;Server=localhost;Port=5432;
	/// ```
	case odbcString(String)

	/// Connect using a ODBC DSN (Data Source Name).
	///
	/// Example
	///
	/// `~/.odbc.ini`:
	/// ```ini
	/// [PostgreSQLDSN]
	/// Driver = PostgreSQL
	/// Server = localhost
	/// Database = postgres
	/// ```
	/// Swift code:
	///
	/// ```swift
	/// Connection(
	/// 	.dataSource(
	/// 		dsn: "PostgreSQLDSN",
	/// 		username: "postgres",
	/// 		password: "postgres"
	/// 	)
	/// )
	/// ```
	case dataSource(dsn: String, username: String, password: String)
}

/// An ODBC connection.
public class Connection {
	public let connectionType: ConnectionType
	internal let connection: OpaquePointer

	/// Create a new connection.
	/// - Parameters:
	///   - connectionType: The `ConnectionType` that describes how the driver and database details will be passed to the ODBC driver.
	///   - timeout: The amount of seconds to wait when trying to establish a connection.
	/// - Throws: `ODBCError.databaseError` or `ODBCError.general`.
	public init(_ connectionType: ConnectionType, timeout: Int = 0) throws {
		self.connectionType = connectionType
		switch connectionType {
			case let .odbcString(connStr):
				let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

				if let c = createConnectionConnectionString(connStr, timeout, errorPointer), errorPointer.pointee.message == nil {
					self.connection = c
				} else {
					switch errorPointer.pointee.reason {
						case ErrorReason.databaseError:
							throw ODBCError.databaseError(message: String(cString: errorPointer.pointee.message))
						default:
							throw ODBCError.general(message: errorPointer.pointee.message != nil ? String(cString: errorPointer.pointee.message) : nil)
					}
				}

			case let .dataSource(dsn: dsn, username: username, password: password):
				let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

				if let c = createConnectionDSN(dsn, username, password, timeout, errorPointer), errorPointer.pointee.message == nil {
					self.connection = c
				} else {
					switch errorPointer.pointee.reason {
						case ErrorReason.databaseError:
							throw ODBCError.databaseError(message: String(cString: errorPointer.pointee.message))
						default:
							throw ODBCError.general(message: errorPointer.pointee.message != nil ? String(cString: errorPointer.pointee.message) : nil)
					}
				}
		}
	}

	// deinit { destroyConnection(connection) }

	/// Create a new `Statement`.
	/// - Parameter query: The SQL query to pass to the `Statement`.
	/// - Returns: `Statement`.
	public func statement(query: String) -> Statement {
		.init(connection: self, query: query)
	}

	/// Execute `query` on the database, without returning the results of the query.
	/// - Parameters:
	///   - query: The SQL query to execute.
	///   - timeout: The amount of seconds to wait for the query to execute.
	/// - Throws: `ODBCError`.
	public func justExecute(query: String, timeout: Int = 0) throws {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		CNanODBC.justExecute(self.connection, query, 1, timeout, errorPointer)

		guard errorPointer.pointee.message == nil else {
			throw ODBCError.general(message: errorPointer.pointee.message != nil ? String(cString: errorPointer.pointee.message) : nil)
		}
	}

	/// Execute `query` on the database.
	/// - Parameters:
	///   - query: The SQL query to execute.
	///   - timeout: The amount of seconds to wait for the query to execute.
	/// - Throws: `ODBCError`.
	/// - Returns: `Result`.
	public func execute(query: String, timeout: Int = 0) throws -> Result {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		let resPointer = cExecute(connection, query, 1, timeout, errorPointer)

		guard errorPointer.pointee.message == nil else {
			throw ODBCError.general(message: errorPointer.pointee.message != nil ? String(cString: errorPointer.pointee.message) : nil)
		}

		guard resPointer != nil else {
			throw ODBCError.general(message: errorPointer.pointee.message != nil ? String(cString: errorPointer.pointee.message) : nil)
		}

		return Result(resPointer: resPointer)
	}
}
