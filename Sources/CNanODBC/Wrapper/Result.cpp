//
//  Result.cpp
//  
//
//  Created by Jeff Lebrun on 4/15/21.
//

#include "../nanodbc.h"
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

	// MARK: - Next and Prior

	bool resultNext(CResult * rawRes, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->next();
		} catch (std::exception& e) {
			CError cError = CError { .message = strdup(e.what()) };
			*error = cError;
			return false;
		}
	}

	bool resultPrior(CResult * rawRes, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->prior();
		} catch (std::exception& e) {
			CError * cError = (CError *)malloc(sizeof(CError));
			cError->message = strdup(e.what());
			error = cError;
			return false;
		}
	}

	int resultGetInt(CResult * rawRes, short colNum, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int>(colNum);
		} catch (std::exception& e) {
			assert(error == NULL);
			error = (CError *)malloc(sizeof(CError));
			*error = CError { .message = strdup(e.what()) };
		}
	}

	char * resultGetString(CResult * rawRes, short colNum, CError * error) {
		try {
			return strdup(reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::string>(colNum).c_str());
		} catch (std::exception& e) {
			assert(error == NULL);
			error = (CError *)malloc(sizeof(CError));
			*error = CError { .message = strdup(e.what()) };
			return NULL;
		}
	}
}
