// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public struct Result {
	let resPointer: OpaquePointer?

	public var affectedRows: Int {
		resultAffectedRows(self.resPointer)
	}

	public func hasAffectedRows() throws -> Bool {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		let res = resultHasAffectedRows(self.resPointer, errorPointer)

		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return false
		}
	}

	public func columns() throws -> Int {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		let res = resultNumCols(self.resPointer, errorPointer)

		if try self.handleError(errorPointer: errorPointer) {
			return Int(res)
		} else {
			return 0
		}
	}

	public var rows: Int {
		resultNumRows(self.resPointer)
	}

	/// Advances to the next row in the `Result`.
	/// - Throws: `ConnectionError`.
	/// - Returns: `true` if `next` successfully advanced to the next row, `false` otherwise.
	public func next() throws -> Bool {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultNext(resPointer, errorPointer)

		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return false
		}
	}

	/// Returns to the previous row in the `Result`.
	/// - Throws: `ConnectionError`.
	/// - Returns: `true` if `previous` successfully returned to the previous row, `false` otherwise.
	public func previous() throws -> Bool {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultPrior(resPointer, errorPointer)

		if try self.handleError(errorPointer: errorPointer) {
			return res
		} else {
			return false
		}
	}

	/// `true` if we should return the value and `false` if we should return `nil`.
	func handleError(errorPointer: UnsafeMutablePointer<CError>) throws -> Bool {
		if errorPointer.pointee.message == nil {
			return true
		}

		switch errorPointer.pointee.reason {
			case general:
				throw ODBCError.general(message: String(cString: errorPointer.pointee.message))
			case nullAccessError:
				return false
			case invalidType:
				throw ODBCError.invalidType
			case indexOutOfRange:
				throw ODBCError.indexOutOfRange
			case programmingError:
				throw ODBCError.programmingError(message: String(cString: errorPointer.pointee.message))
			case databaseError:
				throw ODBCError.databaseError(message: String(cString: errorPointer.pointee.message))
			default:
				throw ODBCError.general(message: String(cString: errorPointer.pointee.message))
		}
	}

	/// Retrieves an `Int` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Int` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int`.
	public func getInt(from column: Int) throws -> Int? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetInt(resPointer, Int16(column), errorPointer)
		if try self.handleError(errorPointer: errorPointer) {
			return Int(res)
		} else {
			return nil
		}
	}

	/// Retrieves a `String` from the column at index `column`.
	/// - Parameter column: The column you want to get the `String` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `String`.
	public func getString(from column: Int) throws -> String? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetString(resPointer, Int16(column), errorPointer)

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
	public func getTime(from column: Int) throws -> Time? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetTime(resPointer, Int16(column), errorPointer)

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
	public func getTimeStamp(from column: Int) throws -> TimeStamp? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetTimeStamp(resPointer, Int16(column), errorPointer)

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
	public func getDate(from column: Int) throws -> Date? {
		let errorPointer = UnsafeMutablePointer<CError>.allocate(capacity: 1)

		let res = resultGetDate(resPointer, Int16(column), errorPointer)

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return Date(cDate: res!.pointee)
		} else {
			return nil
		}
	}
}
