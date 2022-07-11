// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

import CNanODBC

extension UnsafeMutablePointer where Self.Pointee == CError {
	static var cErrorPointer: UnsafeMutablePointer<CError> {
		let p = UnsafeMutablePointer<CError>.allocate(capacity: 1)
		p.pointee.isValid = false
		return p
	}
}

extension UnsafeMutablePointer where Self.Pointee == CChar {
	var string: String {
		String(cString: self)
	}
}

extension UnsafePointer where Self.Pointee == CChar {
	var string: String {
		String(cString: self)
	}
}
