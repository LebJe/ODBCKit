import CNanODBC

public enum ConnectionType {
	case odbcString(String)
	case dataSource(dsn: String, username: String, password: String)
}

public class Connection {
	public let connectionType: ConnectionType
	private let connection: OpaquePointer

	public init(_ connectionType: ConnectionType, timeout: Int = 0) throws {
		self.connectionType = connectionType
		switch connectionType {
			case .odbcString(let connStr):
				let errorPointer: UnsafeMutablePointer<CError>? = nil

				if let c = createConnectionConnectionString(connStr, timeout, errorPointer), errorPointer == nil {
					self.connection = c
				} else {
					throw ConnectionError.error(message: String(cString: errorPointer!.pointee.message))
				}

			case let .dataSource(dsn: dsn, username: username, password: password):
				let errorPointer: UnsafeMutablePointer<CError>? = nil

				if let c = createConnectionDSN(dsn, username, password, timeout, errorPointer), errorPointer == nil {
					self.connection = c
				} else {
					throw ConnectionError.error(message: String(cString: errorPointer!.pointee.message))
				}
		}
	}

	//deinit { destroyConnection(connection) }

	public func justExecute(query: String, timeout: Int = 0) throws {
		let errorPointer: UnsafeMutablePointer<CError>? = nil

		CNanODBC.justExecute(connection, query, 1, timeout, errorPointer)

		guard errorPointer == nil else {
			throw ConnectionError.error(message: String(cString: errorPointer!.pointee.message))
		}
	}

	public func execute(query: String, timeout: Int = 0) throws -> Result {
		let errorPointer: UnsafeMutablePointer<CError>? = nil
		let resPointer = cExecute(connection, query, 1, timeout, errorPointer)

		guard errorPointer == nil else {
			throw ConnectionError.error(message: String(cString: errorPointer!.pointee.message))
		}

		guard resPointer != nil else {
			throw ConnectionError.error(message: errorPointer != nil ? String(cString: errorPointer!.pointee.message) : "")
		}

		return Result(resPointer: resPointer)
	}
}
