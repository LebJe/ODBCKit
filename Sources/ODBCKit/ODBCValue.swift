// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

enum ODBCValueType {
	case int,
	     int8,
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

protocol ODBCValue {
	var type: ODBCValueType { get }
	func bind(stmtPointer: OpaquePointer, index: Int) throws
}

extension ODBCValue {
	var odbcValue: Self {
		self
	}

	func bind(stmtPointer: OpaquePointer, index: Int) throws {
		// We can use `as!` since `ODBCValueType` is private.
		switch type {
			case .int:
				stmtBindInt(stmtPointer, Int16(index), Int32(self as! Int))
			case .string:
				stmtBindString(stmtPointer, Int16(index), self as! String)
			default:
				break
		}
	}
}

extension Int: ODBCValue { var type: ODBCValueType { .int } }
extension Int8: ODBCValue { var type: ODBCValueType { .int8 } }
extension Int16: ODBCValue { var type: ODBCValueType { .int16 } }
extension Int32: ODBCValue { var type: ODBCValueType { .int32 } }
extension Int64: ODBCValue { var type: ODBCValueType { .int64 } }
extension UInt16: ODBCValue { var type: ODBCValueType { .uint16 } }
extension Float: ODBCValue { var type: ODBCValueType { .float } }
extension Double: ODBCValue { var type: ODBCValueType { .double } }
extension String: ODBCValue { var type: ODBCValueType { .string } }
extension Bool: ODBCValue { var type: ODBCValueType { .bool } }

extension Date: ODBCValue {
	var odbcValue: CDate { self.cDate }
	var type: ODBCValueType { .date }
}

extension Time: ODBCValue {
	var odbcValue: CTime { self.cTime }
	var type: ODBCValueType { .time }
}

extension TimeStamp: ODBCValue {
	var odbcValue: CTimeStamp { self.cTimestamp }
	var type: ODBCValueType { .timestamp }
}
