// Copyright (c) 2022 Jeff Lebrun
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
	CStatement * _Nonnull stmtCreate(
		CConnection * _Nonnull rawConn, const char * _Nonnull query, long timeout) {
		return reinterpret_cast<CStatement *>(new nanodbc::statement(
			*reinterpret_cast<nanodbc::connection *>(rawConn), charToString(query), timeout));
	}

	// MARK: - Bind

	CError * _Nullable stmtBindNull(CStatement * _Nonnull rawStmt, short paramIndex) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind_null(paramIndex);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindShort(CStatement * _Nonnull rawStmt, short paramIndex, short value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindUnsignedShort(
		CStatement * _Nonnull rawStmt, short paramIndex, unsigned short value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindInt(CStatement * _Nonnull rawStmt, short paramIndex, int value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindBigInt(
		CStatement * _Nonnull rawStmt, short paramIndex, int64_t value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
		}

		return NULL;
	}

	CError * _Nullable stmtBindLong(
		CStatement * _Nonnull rawStmt, short paramIndex, int32_t value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindFloat(CStatement * _Nonnull rawStmt, short paramIndex, float value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindDouble(
		CStatement * _Nonnull rawStmt, short paramIndex, double value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &value);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindString(
		CStatement * _Nonnull rawStmt, short paramIndex, const char * _Nonnull value) {
		try {
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, value);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindBool(CStatement * _Nonnull rawStmt, short paramIndex, bool value) {
		try {
			int v = value ? 1 : 0;
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &v);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindBinary(
		CStatement * _Nonnull rawStmt, short paramIndex, const uint8_t * _Nonnull value,
		int64_t size) {
		try {
			auto vec =
				std::vector<std::vector<std::uint8_t>> { std::vector<uint8_t>(value[0], size) };
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, vec);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindTime(CStatement * _Nonnull rawStmt, short paramIndex, CTime value) {
		try {
			auto time = cTimeToTime(value);
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &time);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindTimeStamp(
		CStatement * _Nonnull rawStmt, short paramIndex, CTimeStamp value) {
		try {
			auto timestamp = cTimeStampToTimestamp(value);
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &timestamp);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	CError * _Nullable stmtBindDate(CStatement * _Nonnull rawStmt, short paramIndex, CDate value) {
		try {
			auto date = cDateToDate(value);
			reinterpret_cast<nanodbc::statement *>(rawStmt)->bind(paramIndex, &date);
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	// MARK: - Execute
	CResult * _Nullable stmtExecute(
		CStatement * _Nonnull rawStmt, long timeout, CError * _Nonnull error) {
		try {
			return reinterpret_cast<CResult *>(
				new nanodbc::result(reinterpret_cast<nanodbc::statement *>(rawStmt)->execute()));
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}

		return NULL;
	}

	void stmtClose(CStatement * _Nonnull rawStmt) {
		reinterpret_cast<nanodbc::statement *>(rawStmt)->close();
	}
}
