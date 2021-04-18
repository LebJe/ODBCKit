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

	short resultNumCols(CResult * rawRes, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->columns();
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return false;
		}
	}

	bool resultHasAffectedRows(CResult * rawRes, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->affected_rows();
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return false;
		}
	}

	// MARK: - Next and Prior

	bool resultNext(CResult * rawRes, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->next();
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return false;
		}
	}

	bool resultPrior(CResult * rawRes, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->prior();
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return false;
		}
	}

	short resultGetShort(CResult * rawRes, short colNum, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<short>(colNum);
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return -1;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return -1;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return -1;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return -1;
		}
	}

	unsigned short resultGetUnsignedShort(CResult * rawRes, short colNum, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<unsigned short>(colNum);
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return -1;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return -1;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return -1;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return -1;
		}
	}

	int resultGetInt(CResult * rawRes, short colNum, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int>(colNum);
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return -1;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return -1;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return -1;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return -1;
		}
	}

	int64_t resultGetBigInt(CResult * rawRes, short colNum, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int64_t>(colNum);
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return -1;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return -1;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return -1;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return -1;
		}
	}

	int32_t resultGetLong(CResult * rawRes, short colNum, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int32_t>(colNum);
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return -1;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return -1;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return -1;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return -1;
		}
	}

	float resultGetFloat(CResult * rawRes, short colNum, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<float>(colNum);
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return -1;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return -1;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return -1;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return -1;
		}
	}

	double resultGetDouble(CResult * rawRes, short colNum, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<double>(colNum);
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return -1;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return -1;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return -1;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return -1;
		}
	}

	char * resultGetString(CResult * rawRes, short colNum, CError * error) {
		try {
			return strdup(reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::string>(colNum).c_str());
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return NULL;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return NULL;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return NULL;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return NULL;
		}
	}

	CTime * resultGetTime(CResult * rawRes, short colNum, CError * error) {
		try {
			auto time = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::time>(colNum);
			CTime * cTime = (CTime *)malloc(sizeof(CTime));
			*cTime = CTime { .hour = time.hour, .minute = time.min, .second = time.sec };
			return cTime;
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return NULL;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return NULL;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return NULL;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
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
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return NULL;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return NULL;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return NULL;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return NULL;
		}
	}

	CDate * resultGetDate(CResult * rawRes, short colNum, CError * error) {
		try {
			auto date = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::date>(colNum);
			return new CDate { .month = date.month, .day = date.day, .year = date.year };
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return NULL;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return NULL;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return NULL;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return NULL;
		}
	}

	bool resultGetBool(CResult * rawRes, short colNum, CError * error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int>(colNum);
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return NULL;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return NULL;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return NULL;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return NULL;
		}
	}

	uint8_t * resultGetBinary(CResult * rawRes, short colNum, int * sizePointer, CError * error) {
		try {
			auto res = reinterpret_cast<nanodbc::result *>(rawRes)->get<std::vector<uint8_t>>(colNum);
			uint8_t * rawRes = (uint8_t *)malloc(sizeof(uint8_t) * res.size());

			for (int i = 0; i < res.size(); i++) {
				rawRes[i] = res[i];
			}

			*sizePointer = res.size();
			return rawRes;
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return NULL;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return NULL;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return NULL;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return NULL;
		}
	}
}
