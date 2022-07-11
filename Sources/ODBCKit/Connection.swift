// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

/// The method that will be used to pass driver and database details to the ODBC driver.
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

	public var isConnected: Bool {
		connectionConnected(self.connection)
	}

	public var dbmsName: String {
		connectionDBMSName(self.connection).string
	}

	public var dbmsVersion: String {
		connectionDBMSVersion(self.connection).string
	}

	public var databaseName: String {
		connectionDatabaseName(self.connection).string
	}

	/// Create a new connection.
	/// - Parameters:
	///   - connectionType: The ``ConnectionType`` that describes how the driver and database details will be passed to the ODBC driver.
	///   - timeout: The amount of seconds to wait when trying to establish a connection.
	/// - Throws: ``ODBCError/databaseError`` or ``ODBCError/general``.
	public init(_ connectionType: ConnectionType, timeout: Int = 0) throws {
		self.connectionType = connectionType
		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer

		defer {
			errorPointer.deallocate()
		}

		switch connectionType {
			case let .odbcString(connStr):
				if let c = createConnectionConnectionString(connStr, timeout, errorPointer) {
					self.connection = c
				} else {
					if errorPointer.pointee.isValid {
						throw ODBCError.fromErrorPointer(errorPointer)
					} else {
						throw ODBCError.unexpectedNull(name: "nanodbc::connection()")
					}
				}

			case let .dataSource(dsn: dsn, username: username, password: password):
				if let c = createConnectionDSN(dsn, username, password, timeout, errorPointer) {
					self.connection = c
				} else {
					if errorPointer.pointee.isValid {
						throw ODBCError.fromErrorPointer(errorPointer)
					} else {
						throw ODBCError.unexpectedNull(name: "nanodbc::connection()")
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
		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
		CNanODBC.justExecute(self.connection, query, 1, timeout, errorPointer)

		guard !errorPointer.pointee.isValid else {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}

	/// Execute `query` on the database.
	/// - Parameters:
	///   - query: The SQL query to execute.
	///   - timeout: The amount of seconds to wait for the query to execute. 0 means no timeout.
	/// - Throws: `ODBCError`.
	/// - Returns: `Result`.
	public func execute(query: String, timeout: Int = 0) throws -> Result {
		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
		let resPointer = cExecute(connection, query, 1, timeout, errorPointer)

		guard !errorPointer.pointee.isValid else {
			throw ODBCError.fromErrorPointer(errorPointer)
		}

		guard let res = resPointer else {
			throw ODBCError.unexpectedNull(name: "nanodbc::statement::execute")
		}

		return Result(resPointer: res)
	}

	/// Disconnect from the database.
	public func disconnect() throws {
		if let error = connectionDisconnect(self.connection) {
			throw ODBCError.fromErrorPointer(error)
		}
	}
}
