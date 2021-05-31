// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public enum ODBCValueType {
	case int,
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

public protocol BindableValue {
	var type: ODBCValueType { get }

	/// Bind this value to the `Statement` pointer at index `index`.
	func bind(stmtPointer: OpaquePointer, index: Int16) throws
}

extension Int: BindableValue {
	public var type: ODBCValueType { .int }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindBigInt(stmtPointer, index, Int64(self))
	}
}

extension Int16: BindableValue {
	public var type: ODBCValueType { .int16 }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindShort(stmtPointer, index, self)
	}
}

extension Int32: BindableValue {
	public var type: ODBCValueType { .int32 }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindInt(stmtPointer, index, self)
	}
}

extension Int64: BindableValue {
	public var type: ODBCValueType { .int64 }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindBigInt(stmtPointer, index, self)
	}
}

extension UInt16: BindableValue {
	public var type: ODBCValueType { .uint16 }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindUnsignedShort(stmtPointer, index, self)
	}
}

extension Float: BindableValue {
	public var type: ODBCValueType { .float }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindFloat(stmtPointer, index, self)
	}
}

extension Double: BindableValue {
	public var type: ODBCValueType { .double }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindDouble(stmtPointer, index, self)
	}
}

extension String: BindableValue {
	public var type: ODBCValueType { .string }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindString(stmtPointer, Int16(index), self)
	}
}

extension Bool: BindableValue {
	public var type: ODBCValueType { .bool }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindBool(stmtPointer, index, self)
	}
}

extension ODBCDate: BindableValue {
	public var type: ODBCValueType { .date }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindDate(stmtPointer, index, self.cDate)
	}
}

extension ODBCTime: BindableValue {
	public var type: ODBCValueType { .time }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindTime(stmtPointer, index, self.cTime)
	}
}

extension ODBCTimeStamp: BindableValue {
	public var type: ODBCValueType { .timestamp }

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		stmtBindTimeStamp(stmtPointer, index, self.cTimestamp)
	}
}

extension Array: BindableValue where Element == UInt8 {
	public var type: ODBCValueType {
		.bytes
	}

	public func bind(stmtPointer: OpaquePointer, index: Int16) throws {
		let pointer: UnsafeMutablePointer<UInt8> = .allocate(capacity: self.count)

		for i in 0..<self.count {
			pointer[i] = self[i]
		}

		stmtBindBinary(stmtPointer, index, pointer, Int64(self.count))
	}
}
