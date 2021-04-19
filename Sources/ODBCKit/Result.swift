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
	/// - Throws: `ODBCError`.
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
	/// - Throws: `ODBCError`.
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
}
