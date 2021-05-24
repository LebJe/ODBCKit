// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public struct ResultValue {
	let numOrName: Either<Int16, String>
	let resPointer: OpaquePointer

	// `true` if we should return the value and `false` if we should return `nil`.
	func handleError(errorPointer: UnsafeMutablePointer<CError>) throws -> Bool {
		if errorPointer.pointee.message == nil {
			return true
		}

		switch errorPointer.pointee.reason {
			case ErrorReason.general:
				throw ODBCError.general(message: String(cString: errorPointer.pointee.message))
			case ErrorReason.nullAccessError:
				return false
			case ErrorReason.invalidType:
				throw ODBCError.invalidType
			case ErrorReason.indexOutOfRange:
				throw ODBCError.indexOutOfRange
			case ErrorReason.programmingError:
				throw ODBCError.programmingError(message: String(cString: errorPointer.pointee.message))
			case ErrorReason.databaseError:
				throw ODBCError.databaseError(message: String(cString: errorPointer.pointee.message))
			default:
				throw ODBCError.general(message: String(cString: errorPointer.pointee.message))
		}
	}

	/// Retrieves an `Int16` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int16`.
	func int16() throws -> Int16? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: Int16?

		switch self.numOrName {
			case var .left(index):
				res = resultGetShort(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetShort(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return res!
		} else {
			return nil
		}
	}

	/// Retrieves an `UInt16` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `UInt16`.
	func uInt16() throws -> UInt16? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: UInt16?

		switch self.numOrName {
			case var .left(index):
				res = resultGetUnsignedShort(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetUnsignedShort(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return res!
		} else {
			return nil
		}
	}

	/// Retrieves an `Int` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int`.
	func int() throws -> Int? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: Int32?

		switch self.numOrName {
			case var .left(index):
				res = resultGetInt(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetInt(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return Int(res!)
		} else {
			return nil
		}
	}

	/// Retrieves an `Int32` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int32`.
	mutating func int32() throws -> Int32? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: Int32?

		switch self.numOrName {
			case var .left(index):
				res = resultGetLong(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetLong(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return res!
		} else {
			return nil
		}
	}

	/// Retrieves an `Int64` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int64`.
	func int64() throws -> Int64? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: Int64?

		switch self.numOrName {
			case var .left(index):
				res = resultGetBigInt(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetBigInt(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return res!
		} else {
			return nil
		}
	}

	/// Retrieves a `Float` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Float`.
	func float() throws -> Float? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: Float?

		switch self.numOrName {
			case var .left(index):
				res = resultGetFloat(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetFloat(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return res!
		} else {
			return nil
		}
	}

	/// Retrieves a `Double` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Double`.
	func double() throws -> Double? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: Double?

		switch self.numOrName {
			case var .left(index):
				res = resultGetDouble(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetDouble(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return res!
		} else {
			return nil
		}
	}

	/// Retrieves a `Bool` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Bool`.
	func bool() throws -> Bool? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: Bool?

		switch self.numOrName {
			case var .left(index):
				res = resultGetBool(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetBool(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return res!
		} else {
			return nil
		}
	}

	/// Retrieves a `String` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `String`.
	func string() throws -> String? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: UnsafePointer<Int8>?

		switch self.numOrName {
			case var .left(index):
				res = resultGetString(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetString(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return String(cString: res!)
		} else {
			return nil
		}
	}

	/// Retrieves a `Time` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Time`.
	func time() throws -> ODBCTime? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: UnsafeMutablePointer<CTime>?

		switch self.numOrName {
			case var .left(index):
				res = resultGetTime(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetTime(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return ODBCTime(cTime: res!.pointee)
		} else {
			return nil
		}
	}

	/// Retrieves a `TimeStamp` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `TimeStamp`.
	func timeStamp() throws -> ODBCTimeStamp? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: UnsafeMutablePointer<CTimeStamp>?

		switch self.numOrName {
			case var .left(index):
				res = resultGetTimeStamp(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetTimeStamp(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return ODBCTimeStamp(cTimeStamp: res!.pointee)
		} else {
			return nil
		}
	}

	/// Retrieves a `Date` from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Date`.
	func date() throws -> ODBCDate? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: UnsafeMutablePointer<CDate>?

		switch self.numOrName {
			case var .left(index):
				res = resultGetDate(self.resPointer, &index, nil, errorPointer)
			case let .right(name):
				res = resultGetDate(self.resPointer, nil, name, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return ODBCDate(cDate: res!.pointee)
		} else {
			return nil
		}
	}

	/// Retrieves an `Array<UInt8>` (bytes) from this `ResultValue`.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Array<UInt8>`.
	func bytes() throws -> [UInt8]? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var res: UnsafeMutablePointer<UInt8>?
		var data: [UInt8] = []
		var size: UInt = 0

		switch self.numOrName {
			case var .left(index):
				res = resultGetBinary(self.resPointer, &index, nil, &size, errorPointer)
			case let .right(name):
				res = resultGetBinary(self.resPointer, nil, name, &size, errorPointer)
		}

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			for i in 0..<Int(size) {
				data.append(res![i])
			}

			return data
		} else {
			return nil
		}
	}
}
