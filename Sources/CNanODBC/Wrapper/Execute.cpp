//
//  File.cpp
//  
//
//  Created by Jeff Lebrun on 4/13/21.
//

#include "../nanodbc.h"
#include <CNanODBC/CNanODBC.h>
#include <cstring>
#include <malloc/_malloc.h>

extern "C" {
	void justExecute(CConnection * rawConn, const char * query, long batchOperations, long timeout, CError * error) {
		try {
			nanodbc::just_execute(*reinterpret_cast<nanodbc::connection *>(rawConn), charToString(query), batchOperations, timeout);
		} catch (std::exception& e) {
			CError cError = CError { .message = strdup(e.what()) };
			*error = cError;
		}
	}

	CResult * cExecute(CConnection * rawConn, const char * query, long batchOperations, long timeout, CError * error) {
		try {
			return reinterpret_cast<CResult *>(new nanodbc::result(nanodbc::execute(*reinterpret_cast<nanodbc::connection *>(rawConn), charToString(query), batchOperations, timeout)));
		} catch (std::exception& e) {
			CError cError = CError { .message = strdup(e.what()) };
			*error = cError;
			return NULL;
		}
	}
}
