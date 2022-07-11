// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#include "../nanodbc.h"
#include <CNanODBC/CNanODBC.h>
#include <CNanODBC/CxxFuncs.h>
#include <cstring>

extern "C" {
	void justExecute(
		CConnection * _Nonnull rawConn, const char * _Nonnull query, long batchOperations,
		long timeout, CError * _Nonnull error) {
		try {
			nanodbc::just_execute(
				*reinterpret_cast<nanodbc::connection *>(rawConn), query, batchOperations, timeout);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };
		}
	}

	CResult * _Nullable cExecute(
		CConnection * _Nonnull rawConn, const char * _Nonnull query, long batchOperations,
		long timeout, CError * _Nonnull error) {
		try {
			return reinterpret_cast<CResult *>(new nanodbc::result(nanodbc::execute(
				*reinterpret_cast<nanodbc::connection *>(rawConn), query, batchOperations,
				timeout)));
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return NULL;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };
			return NULL;
		}
	}
}
