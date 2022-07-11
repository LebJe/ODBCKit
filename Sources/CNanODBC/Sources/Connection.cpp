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
	CConnection * _Nullable createConnectionConnectionString(
		const char * _Nonnull connStr, long timeout, CError * _Nonnull error) {
		try {
			error->isValid = false;
			return reinterpret_cast<CConnection *>(
				new nanodbc::connection(charToString(connStr), timeout));
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}
	}

	CConnection * _Nullable createConnectionDSN(
		const char * _Nonnull dsn, const char * _Nonnull username, const char * _Nonnull password,
		long timeout, CError * _Nonnull error) {
		try {
			return reinterpret_cast<CConnection *>(new nanodbc::connection(
				charToString(dsn), charToString(username), charToString(password), timeout));
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };
			return NULL;
		}
	}

	bool connectionConnected(CConnection * _Nonnull conn) {
		return reinterpret_cast<nanodbc::connection *>(conn)->connected();
	}

	const char * _Nonnull connectionDBMSName(CConnection * _Nonnull conn) {
		return strdup(reinterpret_cast<nanodbc::connection *>(conn)->dbms_name().c_str());
	}

	const char * _Nonnull connectionDBMSVersion(CConnection * _Nonnull conn) {
		return strdup(reinterpret_cast<nanodbc::connection *>(conn)->dbms_version().c_str());
	}

	const char * _Nonnull connectionDatabaseName(CConnection * _Nonnull conn) {
		return strdup(reinterpret_cast<nanodbc::connection *>(conn)->database_name().c_str());
	}

	CError * _Nullable connectionDisconnect(CConnection * _Nonnull conn) {
		try {
			reinterpret_cast<nanodbc::connection *>(conn)->disconnect();
		} catch (nanodbc::database_error & e) {
			return new CError { .isValid = true,
								.message = strdup(e.what()),
								.reason = databaseError };
		}

		return NULL;
	}

	void destroyConnection(CConnection * _Nonnull conn) {
		// delete reinterpret_cast<nanodbc::connection *>(conn);
	}
}
