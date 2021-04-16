//
//  Result.cpp
//  
//
//  Created by Jeff Lebrun on 4/15/21.
//

#include "nanodbc.h"
#include <CNanODBC/CNanODBC.h>
#include <stdbool.h>

extern "C" {

	// MARK: - Result Information
	long resultAffectedRows(CResult * rawRes) {
		return reinterpret_cast<nanodbc::result *>(rawRes)->affected_rows();
	}

	long resultNumRows(CResult * rawRes) {
		return reinterpret_cast<nanodbc::result *>(rawRes)->rows();
	}

	short resultNumCols(CResult * rawRes) {
		return reinterpret_cast<nanodbc::result *>(rawRes)->columns();
	}

	bool resultHasAffectedRows(CResult * rawRes) {
		return reinterpret_cast<nanodbc::result *>(rawRes)->has_affected_rows();
	}

	// MARK: - f

	bool resultNext(CResult * rawRes) {
		return reinterpret_cast<nanodbc::result *>(rawRes)->next();
	}
}
