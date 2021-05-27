// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#include "../nanodbc.h"
#include <CNanODBC/CNanODBC.h>
#include <CNanODBC/CxxFuncs.h>
#include <string.h>

extern "C" {
	// MARK: - Create
	CStatement * stmtCreate(CConnection * rawConn, const char * query, long timeout) {
		return reinterpret_cast<CStatement *>( new nanodbc::statement(*reinterpret_cast<nanodbc::connection *>(rawConn), charToString(query), timeout) );
	}

	// MARK: - Bind

	CError * stmtBindNull(CStatement * rawStmt, short paramIndex) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind_null(paramIndex);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindShort(CStatement * rawStmt, short paramIndex, short value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindUnsignedShort(CStatement * rawStmt, short paramIndex, unsigned short value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindInt(CStatement * rawStmt, short paramIndex, int value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindBigInt(CStatement * rawStmt, short paramIndex, int64_t value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindLong(CStatement * rawStmt, short paramIndex, int32_t value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindFloat(CStatement * rawStmt, short paramIndex, float value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindDouble(CStatement * rawStmt, short paramIndex, double value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindString(CStatement * rawStmt, short paramIndex, const char * value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, value);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindBool(CStatement * rawStmt, short paramIndex, bool value) {
		try {
			int v = value ? 1 : 0;
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &v);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindBinary(CStatement * rawStmt, short paramIndex, uint8_t * value, int64_t size) {
		try {
			auto vec = std::vector<std::vector<std::uint8_t>> {
				std::vector<uint8_t>(value[0], size)
			};
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, vec);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindTime(CStatement * rawStmt, short paramIndex, CTime value) {
		try {
			auto time = cTimeToTime(value);
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &time);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindTimeStamp(CStatement * rawStmt, short paramIndex, CTimeStamp value) {
		try {
			auto timestamp = cTimeStampToTimestamp(value);
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &timestamp);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * stmtBindDate(CStatement * rawStmt, short paramIndex, CDate value) {
		try {
			auto date = cDateToDate(value);
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &date);
		} catch (nanodbc::database_error& e) {
			return new CError { .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
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

		return NULL;
	}

	void stmtClose(CStatement * rawStmt) {
		reinterpret_cast<nanodbc::statement *>(rawStmt)->close();
	}
}
