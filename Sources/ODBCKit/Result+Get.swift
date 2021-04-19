// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

// MARK: - Get through column index.

public extension Result {
	/// Retrieves an `Int16` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Int16` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int16`.
	func getInt16(from column: Int) throws -> Int16? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)
		let res = resultGetShort(resPointer, &column, nil, errorPointer)

		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `UInt16` from the column at index `column`.
	/// - Parameter column: The column you want to get the `UInt16` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `UInt16`.
	func getUInt16(from column: Int) throws -> UInt16? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)

		let res = resultGetUnsignedShort(resPointer, &column, nil, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `Int` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Int` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int`.
	func getInt(from column: Int) throws -> Int? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)

		let res = resultGetInt(resPointer, &column, nil, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return Int(res)
		} else {
			return nil
		}
	}

	/// Retrieves an `Int64` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Int64` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int64`.
	func getInt64(from column: Int) throws -> Int64? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)

		let res = resultGetBigInt(resPointer, &column, nil, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `Int32` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Int32` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int32`.
	func getInt32(from column: Int) throws -> Int32? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)

		let res = resultGetLong(resPointer, &column, nil, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `Float` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Float` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Float`.
	func getFloat(from column: Int) throws -> Float? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)

		let res = resultGetFloat(resPointer, &column, nil, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `Double` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Double` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Double`.
	func getDouble(from column: Int) throws -> Double? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)

		let res = resultGetDouble(resPointer, &column, nil, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `Bool` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Bool` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Bool`.
	func getBool(from column: Int) throws -> Bool? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)

		let res = resultGetBool(resPointer, &column, nil, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves a `String` from the column at index `column`.
	/// - Parameter column: The column you want to get the `String` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `String`.
	func getString(from column: Int) throws -> String? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)

		let res = resultGetString(resPointer, &column, nil, errorPointer)

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return String(cString: res!)
		} else {
			return nil
		}
	}

	/// Retrieves a `Time` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Time` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Time`.
	func getTime(from column: Int) throws -> Time? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)

		let res = resultGetTime(resPointer, &column, nil, errorPointer)

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return Time(cTime: res!.pointee)
		} else {
			return nil
		}
	}

	/// Retrieves a `Time` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Time` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Time`.
	func getTimeStamp(from column: Int) throws -> TimeStamp? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)

		let res = resultGetTimeStamp(resPointer, &column, nil, errorPointer)

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return TimeStamp(cTimeStamp: res!.pointee)
		} else {
			return nil
		}
	}

	/// Retrieves a `Date` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Date` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Date`.
	func getDate(from column: Int) throws -> Date? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)

		let res = resultGetDate(resPointer, &column, nil, errorPointer)

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return Date(cDate: res!.pointee)
		} else {
			return nil
		}
	}

	func getBytes(from column: Int) throws -> [UInt8]? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var column = Int16(column)
		var size: Int32 = 0
		var data: [UInt8] = []

		let res = resultGetBinary(resPointer, &column, nil, &size, errorPointer)

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

// MARK: - Get through column name.

public extension Result {
	/// Retrieves an `Int16` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Int16` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int16`.
	func getInt16(from column: String) throws -> Int16? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetShort(resPointer, nil, column, errorPointer)

		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `UInt16` from the column at index `column`.
	/// - Parameter column: The column you want to get the `UInt16` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `UInt16`.
	func getUInt16(from column: String) throws -> UInt16? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetUnsignedShort(resPointer, nil, column, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `Int` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Int` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int`.
	func getInt(from column: String) throws -> Int? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetInt(resPointer, nil, column, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return Int(res)
		} else {
			return nil
		}
	}

	/// Retrieves an `Int64` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Int64` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int64`.
	func getInt64(from column: String) throws -> Int64? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetBigInt(resPointer, nil, column, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `Int32` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Int32` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int32`.
	func getInt32(from column: String) throws -> Int32? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetLong(resPointer, nil, column, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `Float` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Float` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Float`.
	func getFloat(from column: String) throws -> Float? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetFloat(resPointer, nil, column, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `Double` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Double` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Double`.
	func getDouble(from column: String) throws -> Double? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetDouble(resPointer, nil, column, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves an `Bool` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Bool` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Bool`.
	func getBool(from column: String) throws -> Bool? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetBool(resPointer, nil, column, errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return nil
		}
	}

	/// Retrieves a `String` from the column at index `column`.
	/// - Parameter column: The column you want to get the `String` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `String`.
	func getString(from column: String) throws -> String? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetString(resPointer, nil, column, errorPointer)

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return String(cString: res!)
		} else {
			return nil
		}
	}

	/// Retrieves a `Time` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Time` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Time`.
	func getTime(from column: String) throws -> Time? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetTime(resPointer, nil, column, errorPointer)

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return Time(cTime: res!.pointee)
		} else {
			return nil
		}
	}

	/// Retrieves a `Time` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Time` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Time`.
	func getTimeStamp(from column: String) throws -> TimeStamp? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetTimeStamp(resPointer, nil, column, errorPointer)

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return TimeStamp(cTimeStamp: res!.pointee)
		} else {
			return nil
		}
	}

	/// Retrieves a `Date` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Date` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Date`.
	func getDate(from column: String) throws -> Date? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetDate(resPointer, nil, column, errorPointer)

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return Date(cDate: res!.pointee)
		} else {
			return nil
		}
	}

	func getBytes(from column: String) throws -> [UInt8]? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		var size: Int32 = 0
		var data: [UInt8] = []

		let res = resultGetBinary(resPointer, nil, column, &size, errorPointer)

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
