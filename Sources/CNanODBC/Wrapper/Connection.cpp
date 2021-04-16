// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#include "../nanodbc.h"
#include <CNanODBC/CNanODBC.h>

extern "C" {
CConnection * createConnectionConnectionString(const char * connStr, long timeout, CError * error) {
		try {
			return reinterpret_cast<CConnection *>( new nanodbc::connection(charToString(connStr), timeout) );
		} catch (std::exception& e) {
			*error = CError { .message = strdup(e.what()), .reason = programmingError };
			return NULL;
		}
	}

CConnection * createConnectionDSN(const char * dsn, const char * username, const char * password, long timeout, CError * error) {
		try {
			return reinterpret_cast<CConnection *>( new nanodbc::connection(charToString(dsn), charToString(username), charToString(password), timeout) );
		} catch (std::exception& e) {
			*error = CError { .message = strdup(e.what()), .reason = programmingError };
			return NULL;
		}
	}

	void destroyConnection(CConnection * conn) {
		//delete reinterpret_cast<nanodbc::connection *>(conn);
	}
}
