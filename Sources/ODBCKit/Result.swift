//
//  File.swift
//  
//
//  Created by Jeff Lebrun on 4/15/21.
//

import CNanODBC

public struct Result {
	let resPointer: OpaquePointer?

	public var affectedRows: Int {
		resultAffectedRows(resPointer)
	}

	public var hasAffectedRows: Bool {
		resultHasAffectedRows(resPointer)
	}

	public var columns: Int {
		Int(resultNumCols(resPointer))
	}

	public var rows: Int {
		resultNumRows(resPointer)
	}

	/// 
	public func next() -> Bool { resultNext(resPointer) }

}
