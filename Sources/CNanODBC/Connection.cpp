//
//  Connection.cpp
//  
//
//  Created by Jeff Lebrun on 4/12/21.
//

#include "nanodbc.h"
#include <CNanODBC/CNanODBC.h>

extern "C" {
CConnection * createConnectionConnectionString(const char * connStr, long timeout, CError * error) {
		try {
			return reinterpret_cast<CConnection *>( new nanodbc::connection(charToString(connStr), timeout) );
		} catch (std::exception& e) {
			CError cError = CError { .message = strdup(e.what())};

			*error = cError;
		}
	}

CConnection * createConnectionDSN(const char * dsn, const char * username, const char * password, long timeout, CError * error) {
		try {
			return reinterpret_cast<CConnection *>( new nanodbc::connection(charToString(dsn), charToString(username), charToString(password), timeout) );
		} catch (std::exception& e) {
			CError cError = CError { .message = strdup(e.what())};

			*error = cError;
		}
	}

	void destroyConnection(CConnection * conn) {
		//delete reinterpret_cast<nanodbc::connection *>(conn);
	}
}
