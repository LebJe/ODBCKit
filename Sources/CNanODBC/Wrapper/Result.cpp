// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

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
			return -1;
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

	CTime * resultGetTime(CResult * rawRes, short colNum, CError * error) {
		try {
			auto time = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::time>(colNum);
			CTime * cTime = (CTime *)malloc(sizeof(CTime));
			*cTime = CTime { .hour = time.hour, .minute = time.min, .second = time.sec };
			return cTime;
		} catch (nanodbc::null_access_error& e) {
			printf("\n%s\n", strdup(e.what()));
			error = (CError *)malloc(sizeof(CError));
			*error = CError { .message = strdup(e.what()), .reason = nullAccessError };
			return NULL;
		} catch (nanodbc::type_incompatible_error& e) {
			printf("\n%s\n", strdup(e.what()));
			error = (CError *)malloc(sizeof(CError));
			*error = CError { .message = strdup(e.what()), .reason = invalidType };
			return NULL;
		} catch (std::exception& e) {
			assert(error == NULL);
			error = (CError *)malloc(sizeof(CError));
			*error = CError { .message = strdup(e.what()) };
			return NULL;
		}
	}

CTimeStamp * resultGetTimeStamp(CResult * rawRes, short colNum, CError * error) {
	try {
		auto timestamp = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::timestamp>(colNum);
		CTimeStamp * cTimeStamp = (CTimeStamp *)malloc(sizeof(CTimeStamp));
		*cTimeStamp = CTimeStamp {
			.hour = timestamp.hour,
			.minute = timestamp.min,
			.second = timestamp.sec,
			.fractionalSec = timestamp.fract,
			.date = CDate { .year = timestamp.year, .month = timestamp.month, .day = timestamp.day }
		};
		return cTimeStamp;
	} catch (nanodbc::null_access_error& e) {
		printf("\n%s\n", strdup(e.what()));
		error = (CError *)malloc(sizeof(CError));
		*error = CError { .message = strdup(e.what()), .reason = nullAccessError };
		return NULL;
	} catch (nanodbc::type_incompatible_error& e) {
		printf("\n%s\n", strdup(e.what()));
		error = (CError *)malloc(sizeof(CError));
		*error = CError { .message = strdup(e.what()), .reason = invalidType };
		return NULL;
	} catch (nanodbc::index_range_error& e) {
		printf("\n%s\n", strdup(e.what()));
		error = (CError *)malloc(sizeof(CError));
		*error = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
		return NULL;
	} catch (nanodbc::programming_error& e) {
		printf("\n%s\n", strdup(e.what()));
		error = (CError *)malloc(sizeof(CError));
		*error = CError { .message = strdup(e.what()), .reason = programmingError };
		return NULL;
	} catch (std::exception& e) {
		assert(error == NULL);
		error = (CError *)malloc(sizeof(CError));
		*error = CError { .message = strdup(e.what()) };
		return NULL;
	}
}
}
