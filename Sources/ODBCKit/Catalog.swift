// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public struct Catalog {
	private var catalogPointer: OpaquePointer

	public init(connection: Connection) {
		self.catalogPointer = catalogCreate(connection.connection)
	}

	public var schemas: [String] {
		get throws {
			var size: UInt = 0
			let errorPointer = UnsafeMutablePointer.cErrorPointer

			guard let cSchemas = catalogListSchemas(self.catalogPointer, &size, errorPointer) else { return [] }

			if errorPointer.pointee.isValid {
				throw ODBCError.fromErrorPointer(errorPointer)
			}

			return UnsafeBufferPointer(start: cSchemas, count: Int(size))
				.map(\.string)
		}
	}

	public var catalogs: [String] {
		get throws {
			var size: UInt = 0
			let errorPointer = UnsafeMutablePointer.cErrorPointer

			guard let cCatalogs = catalogListCatalogs(self.catalogPointer, &size, errorPointer) else { return [] }

			if errorPointer.pointee.isValid {
				throw ODBCError.fromErrorPointer(errorPointer)
			}

			return UnsafeBufferPointer(start: cCatalogs, count: Int(size))
				.map(\.string)
		}
	}
}
