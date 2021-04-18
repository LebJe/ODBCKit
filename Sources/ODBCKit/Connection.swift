// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public enum ConnectionType {
	case odbcString(String)
	case dataSource(dsn: String, username: String, password: String)
}

public class Connection {
	public let connectionType: ConnectionType
	internal let connection: OpaquePointer

	public init(_ connectionType: ConnectionType, timeout: Int = 0) throws {
		self.connectionType = connectionType
		switch connectionType {
			case let .odbcString(connStr):
				let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

				if let c = createConnectionConnectionString(connStr, timeout, errorPointer), errorPointer.pointee.message == nil {
					self.connection = c
				} else {
					switch errorPointer.pointee.reason {
						case databaseError:
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
						case databaseError:
							throw ODBCError.databaseError(message: String(cString: errorPointer.pointee.message))
						default:
							throw ODBCError.general(message: errorPointer.pointee.message != nil ? String(cString: errorPointer.pointee.message) : nil)
					}
				}
		}
	}

	// deinit { destroyConnection(connection) }

	public func justExecute(query: String, timeout: Int = 0) throws {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		CNanODBC.justExecute(self.connection, query, 1, timeout, errorPointer)

		guard errorPointer.pointee.message == nil else {
			throw ODBCError.general(message: errorPointer.pointee.message != nil ? String(cString: errorPointer.pointee.message) : nil)
		}
	}

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
