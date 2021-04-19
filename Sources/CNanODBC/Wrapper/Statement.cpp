// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#include "../nanodbc.h"
#include <CNanODBC/CNanODBC.h>
#include <CNanODBC/CxxFuncs.h>

extern "C" {
	// MARK: - Create
	CStatement * stmtCreate(CConnection * rawConn, const char * query, long timeout) {
		return reinterpret_cast<CStatement *>( new nanodbc::statement(*reinterpret_cast<nanodbc::connection *>(rawConn), charToString(query), timeout) );
	}

	// MARK: - Bind

	CError * stmtBindInt(CStatement * rawStmt, short paramIndex, int value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
		}
	}

	CError * stmtBindString(CStatement * rawStmt, short paramIndex, const char * value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, value);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
		}
	}

	// MARK: - Execute
	CResult * stmtExecute(CStatement * rawStmt, CError * error) {
		try {
			return reinterpret_cast<CResult *>(new nanodbc::result(reinterpret_cast<nanodbc::statement *>(rawStmt)->execute()));
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return NULL;
		}
	}

	void stmtClose(CStatement * rawStmt) {
		reinterpret_cast<nanodbc::statement *>(rawStmt)->close();
	}
}
