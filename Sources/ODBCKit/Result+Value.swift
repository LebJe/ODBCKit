// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

public extension Result {
	struct Value: CustomStringConvertible, CustomDebugStringConvertible {
		let numOrName: ODBCEither<Int16, String>
		let resPointer: OpaquePointer

		public var description: String {
			guard (try? !self.isNull) ?? true else { return "null" }
			switch (try? self.dataType) ?? .char {
				case .char, .varChar, .longVarChar:
					return (try? self.string?.description) ?? Optional<String>.none.debugDescription
				case .integer, .smallInt, .tinyInt, .bigInt:
					return (try? self.int?.description) ?? Optional<Int>.none.debugDescription
				case .real, .float, .double, .numeric, .decimal:
					return (try? self.double?.description) ?? Optional<Double>.none.debugDescription
				case .date:
					return (try? self.date?.debugDescription) ?? Optional<ODBCDate>.none.debugDescription
				case .time:
					return (try? self.time?.debugDescription) ?? Optional<ODBCTime>.none.debugDescription
				case .timeStamp:
					return (try? self.timeStamp?.debugDescription) ?? Optional<ODBCTimeStamp>.none.debugDescription
				case .binary, .varBinary, .longVarBinary, .bit:
					return (try? self.bytes?.description) ?? Optional<Array<UInt8>>.none.debugDescription
				case .guid:
					return ((try? self.string) ?? Optional<String>.none.debugDescription)
			}
		}

		public var debugDescription: String {
			self.description
		}

		/// The data type name of this ``ResultValue``.
		public var dataTypeName: String {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				let res: UnsafePointer<CChar>
				switch self.numOrName {
					case var .left(index):
						res = resultDataTypeName(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultDataTypeName(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					throw ODBCError.fromErrorPointer(errorPointer)
				} else {
					return String(cString: res)
				}
			}
		}

		/// The data type of this ``ResultValue``.
		public var dataType: ODBCDataType {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				let res: Int32
				switch self.numOrName {
					case var .left(index):
						res = resultDataType(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultDataType(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					throw ODBCError.fromErrorPointer(errorPointer)
				} else {
					guard let type = ODBCDataType(rawValue: res) else {
						throw ODBCError.unexpectedValue(name: "nanodbc::result::column_datatype", value: res)
					}

					return type
				}
			}
		}

		/// If the value is `null`.
		public var isNull: Bool {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				let res: Bool

				switch self.numOrName {
					case var .left(index):
						res = resultIsNull(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultIsNull(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					throw ODBCError.fromErrorPointer(errorPointer)
				} else {
					return res
				}
			}
		}

		/// Retrieves an `Int16` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var int16: Int16? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: Int16?

				switch self.numOrName {
					case var .left(index):
						res = resultGetShort(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultGetShort(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					return res
				}
			}
		}

		/// Retrieves an `UInt16` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var uInt16: UInt16? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: UInt16?

				switch self.numOrName {
					case var .left(index):
						res = resultGetUnsignedShort(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultGetUnsignedShort(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					return res
				}
			}
		}

		/// Retrieves an `Int32` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var int32: Int32? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: Int32?

				switch self.numOrName {
					case var .left(index):
						res = resultGetLong(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultGetLong(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					return res
				}
			}
		}

		/// Retrieves an `Int64` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var int64: Int64? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: Int64?

				switch self.numOrName {
					case var .left(index):
						res = resultGetBigInt(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultGetBigInt(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					return res
				}
			}
		}

		/// Retrieves an `Int` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		///
		/// Internally, an Int is created from ``ResultValue/int64``
		public var int: Int? {
			get throws {
				if let i = try self.int64 {
					return Int(i)
				} else { return nil }
			}
		}

		/// Retrieves an `Float` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var float: Float? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: Float?

				switch self.numOrName {
					case var .left(index):
						res = resultGetFloat(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultGetFloat(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					return res
				}
			}
		}

		/// Retrieves an `Double` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var double: Double? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: Double?

				switch self.numOrName {
					case var .left(index):
						res = resultGetDouble(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultGetDouble(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					return res
				}
			}
		}

		/// Retrieves an `Bool` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var bool: Bool? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: Bool?

				switch self.numOrName {
					case var .left(index):
						res = resultGetBool(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultGetBool(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					return res
				}
			}
		}

		/// Retrieves an `String` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var string: String? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: UnsafePointer<CChar>?

				switch self.numOrName {
					case var .left(index):
						res = resultGetString(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultGetString(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					if let cString = res {
						return String(cString: cString)
					} else { return nil }
				}
			}
		}

		// Retrieves an ``ODBCTime`` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var time: ODBCTime? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: UnsafeMutablePointer<CTime>?

				switch self.numOrName {
					case var .left(index):
						res = resultGetTime(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultGetTime(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					if let cTime = res {
						return ODBCTime(cTime: cTime.pointee)
					} else { return nil }
				}
			}
		}

		/// Retrieves an ``ODBCDate`` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var date: ODBCDate? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: UnsafeMutablePointer<CDate>?

				switch self.numOrName {
					case var .left(index):
						res = resultGetDate(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultGetDate(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					if let cDate = res {
						return ODBCDate(cDate: cDate.pointee)
					} else { return nil }
				}
			}
		}

		/// Retrieves an ``ODBCTimeStamp`` from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var timeStamp: ODBCTimeStamp? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: UnsafeMutablePointer<CTimeStamp>?

				switch self.numOrName {
					case var .left(index):
						res = resultGetTimeStamp(self.resPointer, &index, nil, errorPointer)
					case let .right(name):
						res = resultGetTimeStamp(self.resPointer, nil, name, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					if let cTimeStamp = res {
						return ODBCTimeStamp(cTimeStamp: cTimeStamp.pointee)
					} else { return nil }
				}
			}
		}

		/// Retrieves an `Array<UInt8>` (bytes) from this ``ResultValue``.
		/// - Throws: ``ODBCError``.
		public var bytes: Array<UInt8>? {
			get throws {
				let errorPointer = UnsafeMutablePointer<CError>.cErrorPointer
				var res: UnsafeMutablePointer<UInt8>?
				var size: UInt = 0

				switch self.numOrName {
					case var .left(index):
						res = resultGetBinary(self.resPointer, &index, nil, &size, errorPointer)
					case let .right(name):
						res = resultGetBinary(self.resPointer, nil, name, &size, errorPointer)
				}

				if errorPointer.pointee.isValid {
					let error = ODBCError.fromErrorPointer(errorPointer)

					if case .nullAccessError = error {
						return nil
					} else {
						throw error
					}
				} else {
					if let bytesPointer = res {
						return Array<UInt8>(UnsafeBufferPointer(start: bytesPointer, count: Int(size)))
					} else { return nil }
				}
			}
		}
	}
}
