// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text license can be found in the file named LICENSE.

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
	/// - Returns: `true` if `next` successfully advaned to the next row, `false` otherwise.
	public func next() throws -> Bool {
		let errorPointer: UnsafeMutablePointer<CError>? = nil

		let res = resultNext(resPointer, errorPointer)

		guard errorPointer == nil else {
			throw ODBCError.error(message: String(cString: errorPointer!.pointee.message))
		}

		return res
	}

	/// Advances to the next row in the `Result`.
	/// - Throws: `ConnectionError`.
	/// - Returns: `true` if `next` successfully advaned to the next row, `false` otherwise.
	public func previous() throws -> Bool {
		let errorPointer: UnsafeMutablePointer<CError>? = nil

		let res = resultPrior(resPointer, errorPointer)

		guard errorPointer == nil else {
			throw ODBCError.error(message: String(cString: errorPointer!.pointee.message))
		}

		return res
	}

	/// Retrieves an `Int` from the column at index `column`.
	public func getInt(from column: Int) throws -> Int {
		let errorPointer: UnsafeMutablePointer<CError>? = nil

		let res = resultGetInt(resPointer, Int16(column), errorPointer)

		guard errorPointer == nil else {
			throw ODBCError.error(message: String(cString: errorPointer!.pointee.message))
		}

		return Int(res)
	}

	/// Retrieves an `Int` from the column at index `column`.
	public func getString(from column: Int) throws -> String {
		let errorPointer: UnsafeMutablePointer<CError>? = nil

		let res = resultGetString(resPointer, Int16(column), errorPointer)

		guard errorPointer == nil, res != nil else {
			throw ODBCError.error(message: errorPointer != nil ? String(cString: errorPointer!.pointee.message) : "")
		}

		return String(cString: res!)
	}
}
