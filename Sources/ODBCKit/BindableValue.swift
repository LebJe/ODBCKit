// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public enum ODBCValueType {
	case `nil`,
	     int,
	     int16,
	     int32,
	     int64,
	     uint16,
	     float,
	     double,
	     string,
	     bool,
	     date,
	     time,
	     timestamp,
	     bytes
}

/// A value that can be bound to a parameter in a SQL query.
public protocol BindableValue {
	var type: ODBCValueType { get }

	/// Bind this value to the `Statement` pointer at index `index`.
	/// - Throws: ``ODBCError``.
	func bind(stmtPointer: OpaquePointer, index: Int16) throws
}

extension Int: BindableValue {
	public var type: ODBCValueType { .int }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindBigInt(stmtPointer, index, Int64(self)) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension Int16: BindableValue {
	public var type: ODBCValueType { .int16 }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindShort(stmtPointer, index, self) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension Int32: BindableValue {
	public var type: ODBCValueType { .int32 }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindInt(stmtPointer, index, self) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension Int64: BindableValue {
	public var type: ODBCValueType { .int64 }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindBigInt(stmtPointer, index, self) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension UInt16: BindableValue {
	public var type: ODBCValueType { .uint16 }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindUnsignedShort(stmtPointer, index, self) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension Float: BindableValue {
	public var type: ODBCValueType { .float }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindFloat(stmtPointer, index, self) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension Double: BindableValue {
	public var type: ODBCValueType { .double }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindDouble(stmtPointer, index, self) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension String: BindableValue {
	public var type: ODBCValueType { .string }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindString(stmtPointer, Int16(index), self) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension Bool: BindableValue {
	public var type: ODBCValueType { .bool }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindBool(stmtPointer, index, self) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension ODBCDate: BindableValue {
	public var type: ODBCValueType { .date }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindDate(stmtPointer, index, self.cDate) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension ODBCTime: BindableValue {
	public var type: ODBCValueType { .time }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindTime(stmtPointer, index, self.cTime) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension ODBCTimeStamp: BindableValue {
	public var type: ODBCValueType { .timestamp }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		if let errorPointer = stmtBindTimeStamp(stmtPointer, index, self.cTimestamp) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension Array: BindableValue where Element == UInt8 {
	public var type: ODBCValueType { .bytes }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		guard !self.isEmpty else { return }

		if let errorPointer = self.withUnsafeBufferPointer({ buffer in
			stmtBindBinary(stmtPointer, index, buffer.baseAddress!, Int64(self.count))
		}) {
			throw ODBCError.fromErrorPointer(errorPointer)
		}
	}
}

extension Optional: BindableValue where Wrapped: BindableValue {
	public var type: ODBCValueType { .nil }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		switch self {
			case let .some(b): try b.bind(stmtPointer: stmtPointer, index: index)
			case .none:
				if let errorPointer = stmtBindNull(stmtPointer, index) {
					throw ODBCError.fromErrorPointer(errorPointer)
				}
		}
	}
}
