// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public enum ODBCError: Error {
	/// A general error occurred.
	case general(message: String? = nil)

	/// The type you requested is not the type of the value in the specified column.
	///
	/// This documentation comment is from [nanodbc's documentation on `type_incompatible_error`](https://nanodbc.github.io/nanodbc/api.html#_CPPv4N7nanodbc23type_incompatible_errorE).
	case invalidType(message: String? = nil)

	/// Index out of range.
	///
	/// This documentation comment is from [nanodbc's documentation on `index_range_error`](https://nanodbc.github.io/nanodbc/api.html#_CPPv4N7nanodbc17index_range_errorE).
	case indexOutOfRange(message: String? = nil)

	/// A nanodbc function unexpectedly returned `NULL`.
	case unexpectedNull(name: String)

	/// A nanodbc function returned an unexpected value.
	case unexpectedValue(name: String, value: Any)

	/// Accessed null data.
	///
	/// This documentation comment is from [nanodbc's documentation on `null_access_error`](https://nanodbc.github.io/nanodbc/api.html#_CPPv4N7nanodbc17null_access_errorE).
	case nullAccessError(message: String? = nil)

	/// Programming logic error.
	///
	/// This documentation comment is from [nanodbc's documentation on `programming_error`](https://nanodbc.github.io/nanodbc/api.html#_CPPv4N7nanodbc17programming_errorE).
	case programmingError(message: String? = nil)

	/// General database error.
	///
	/// This documentation comment is from [nanodbc's documentation on `database_error`](https://nanodbc.github.io/nanodbc/api.html#_CPPv4N7nanodbc14database_errorE).
	case databaseError(message: String? = nil)

	static func fromErrorPointer(_ pointer: UnsafePointer<CError>) -> Self {
		switch pointer.pointee.reason {
			case .general:
				return .general(message: pointer.pointee.message?.string)
			case .nullAccessError:
				return .nullAccessError(message: pointer.pointee.message?.string)
			case .invalidType: return .invalidType(message: pointer.pointee.message?.string)
			case .indexOutOfRange: return .indexOutOfRange(message: pointer.pointee.message?.string)
			case .programmingError:
				return .programmingError(message: pointer.pointee.message?.string)
			case .databaseError:
				return .databaseError(message: pointer.pointee.message?.string)
			@unknown default:
				return .general()
		}
	}
}
