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

	public var hasAffectedRows: Bool {
		resultHasAffectedRows(self.resPointer)
	}

	public var columns: Int {
		Int(resultNumCols(self.resPointer))
	}

	public var rows: Int {
		resultNumRows(self.resPointer)
	}

	/// Advances to the next row in the `Result`.
	/// - Throws: `ConnectionError`.
	/// - Returns: `true` if `next` successfully advanced to the next row, `false` otherwise.
	public func next() throws -> Bool {
		let errorPointer: UnsafeMutablePointer<CError>? = nil

		let res = resultNext(resPointer, errorPointer)

		guard errorPointer == nil else {
			throw ODBCError.error(message: String(cString: errorPointer!.pointee.message))
		}

		return res
	}

	/// Returns to the previous row in the `Result`.
	/// - Throws: `ConnectionError`.
	/// - Returns: `true` if `previous` successfully returned to the previous row, `false` otherwise.
	public func previous() throws -> Bool {
		let errorPointer: UnsafeMutablePointer<CError>? = nil

		let res = resultPrior(resPointer, errorPointer)

		guard errorPointer == nil else {
			throw ODBCError.error(message: String(cString: errorPointer!.pointee.message))
		}

		return res
	}

	/// `true` if we should return the value and `false` if we should return `nil`.
	func handleError(errorPointer: UnsafeMutablePointer<CError>?) throws -> Bool {
		guard let error = errorPointer else {
			return true
		}

		switch error.pointee.reason {
			case general:
				throw ODBCError.error(message: String(cString: error.pointee.message))
			case nullAccessError:
				return false
			case invalidType:
				throw ODBCError.invalidType
			case indexOutOfRange:
				throw ODBCError.indexOutOfRange
			case programmingError:
				throw ODBCError.programmingError(message: String(cString: error.pointee.message))
			default:
				throw ODBCError.error(message: String(cString: error.pointee.message))
		}
	}

	/// Retrieves an `Int` from the column at index `column`.
	/// - Parameter column: The column you want to get the `Int` from.
	/// - Throws: `ODBCError`.
	/// - Returns: The requested `Int`.
	public func getInt(from column: Int) throws -> Int? {
		let errorPointer: UnsafeMutablePointer<CError>? = nil

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
		let errorPointer: UnsafeMutablePointer<CError>? = nil

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
		let errorPointer: UnsafeMutablePointer<CError>? = nil

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
		let errorPointer: UnsafeMutablePointer<CError>? = nil

		let res = resultGetTimeStamp(resPointer, Int16(column), errorPointer)

		if try self.handleError(errorPointer: errorPointer) && res != nil {
			return TimeStamp(cTimeStamp: res!.pointee)
		} else {
			return nil
		}
	}
}
