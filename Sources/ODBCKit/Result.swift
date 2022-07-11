// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

/// The result of running a query.
public struct Result {
	let resPointer: OpaquePointer

	/// The amount of affected rows.
	/// - Throws: ``ODBCError``.
	public var affectedRows: Int {
		get throws {
			let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
			let res = resultAffectedRows(self.resPointer, errorPointer)

			if errorPointer.pointee.isValid {
				throw ODBCError.fromErrorPointer(errorPointer)
			} else {
				return res
			}
		}
	}

	/// The amount of columns in this `Result`.
	/// - Throws: ``ODBCError``.
	public var columns: Int {
		get throws {
			let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
			let res = resultNumCols(self.resPointer, errorPointer)

			if errorPointer.pointee.isValid {
				throw ODBCError.fromErrorPointer(errorPointer)
			} else {
				return Int(res)
			}
		}
	}

	/// The amount of rows in this `Result`, or 0 if the number of rows is not available.
	/// - Throws: ``ODBCError``.
	public var rows: Int {
		get throws {
			let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
			let res = resultNumRows(self.resPointer, errorPointer)

			if errorPointer.pointee.isValid {
				throw ODBCError.fromErrorPointer(errorPointer)
			} else {
				return Int(res)
			}
		}
	}

	/// The row that is currently selected.
	public var position: Int {
		Int(resultPosition(self.resPointer))
	}

	/// If the last row is selected.
	public var isAtEnd: Bool {
		resultAtEnd(self.resPointer)
	}

	/// Advances to the next row in the `Result`.
	/// - Throws: `ODBCError`.
	/// - Returns: `true` if `next` successfully advanced to the next row, `false` otherwise.
	public func next() throws -> Bool {
		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer

		let res = resultNext(resPointer, errorPointer)

		if errorPointer.pointee.isValid {
			throw ODBCError.fromErrorPointer(errorPointer)
		} else {
			return res
		}
	}

	/// Returns to the previous row in the `Result`.
	/// - Throws: `ODBCError`.
	/// - Returns: `true` if `previous` successfully returned to the previous row, `false` otherwise.
	public func previous() throws -> Bool {
		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer

		let res = resultPrior(resPointer, errorPointer)

		if errorPointer.pointee.isValid {
			throw ODBCError.fromErrorPointer(errorPointer)
		} else {
			return res
		}
	}

	/// Jumps to the first row in the `Result`.
	/// - Throws: `ODBCError`.
	/// - Returns: `true` if successfully jumped to the first row, `false` otherwise.
	public func first() throws -> Bool {
		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer

		let res = resultFirst(resPointer, errorPointer)

		if errorPointer.pointee.isValid {
			throw ODBCError.fromErrorPointer(errorPointer)
		} else {
			return res
		}
	}

	/// Jumps to the last row in the `Result`.
	/// - Throws: `ODBCError`.
	/// - Returns: `true` if successfully jumped to the last row, `false` otherwise.
	public func last() throws -> Bool {
		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer

		let res = resultLast(resPointer, errorPointer)

		if errorPointer.pointee.isValid {
			throw ODBCError.fromErrorPointer(errorPointer)
		} else {
			return res
		}
	}

	/// Moves to the specified row in the `Result`.
	/// - Throws: `ODBCError`.
	/// - Returns: `true` if successfully jumped to the specified row, `false` otherwise.
	public func move(to row: Int) throws -> Bool {
		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer

		let res = resultMoveTo(resPointer, row, errorPointer)

		if errorPointer.pointee.isValid {
			throw ODBCError.fromErrorPointer(errorPointer)
		} else {
			return res
		}
	}

	/// Skips the specified amount of rows in the `Result`.
	/// - Throws: `ODBCError`.
	/// - Returns: `true` if successfully skipped specified rows, `false` otherwise.
	public func skip(rows: Int) throws -> Bool {
		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer

		let res = resultSkip(resPointer, rows, errorPointer)

		if errorPointer.pointee.isValid {
			throw ODBCError.fromErrorPointer(errorPointer)
		} else {
			return res
		}
	}

	/// Finds the index of the named column in the currently selected row.
	public func index(of column: String) throws -> Int {
		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
		let res = resultColumnIndex(self.resPointer, column, errorPointer)

		if errorPointer.pointee.isValid {
			throw ODBCError.fromErrorPointer(errorPointer)
		} else {
			return Int(res)
		}
	}

	/// Finds the name of the indexed column in the currently selected row.
	public func name(of index: Int) throws -> String {
		let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
		let res = resultColumnName(self.resPointer, Int16(index), errorPointer)

		if errorPointer.pointee.isValid {
			throw ODBCError.fromErrorPointer(errorPointer)
		} else {
			guard let s = res?.string else {
				throw ODBCError.unexpectedNull(name: "nanodbc::result::column_name")
			}

			return s
		}
	}

	public subscript(index: Int) -> Self.Value? {
		mutating get {
			Self.Value(numOrName: .left(Int16(index)), resPointer: self.resPointer)
		}
	}

	public subscript(name: String) -> Self.Value? {
		mutating get {
			Self.Value(numOrName: .right(name), resPointer: self.resPointer)
		}
	}
}
