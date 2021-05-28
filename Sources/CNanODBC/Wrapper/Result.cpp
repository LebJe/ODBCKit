// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#include "../nanodbc.h"
#include <CNanODBC/CNanODBC.h>
#include <stdbool.h>
#include <CNanODBC/CxxFuncs.h>
#include <string.h>
#include <stdlib.h>

extern "C" {

	// MARK: - Result Information
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

	long resultAffectedRows(CResult * rawRes, CError * error) {
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

	// MARK: - Get data through column index

	short resultGetShort(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<short>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<short>(colName);
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

	unsigned short resultGetUnsignedShort(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<unsigned short>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<unsigned short>(colName);
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

	int resultGetInt(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<int>(*colNum);
			}

			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int>(colName);
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

	int64_t resultGetBigInt(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<int64_t>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int64_t>(colName);
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

	int32_t resultGetLong(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<int32_t>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int32_t>(colName);
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

	float resultGetFloat(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<float>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<float>(colName);
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

	double resultGetDouble(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<double>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<double>(colName);
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

	const char * resultGetString(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			if (colNum != NULL) {
				return strdup(reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::string>(*colNum).c_str());
			}
			return strdup(reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::string>(colName).c_str());
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

	CTime * resultGetTime(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			nanodbc::time time;

			if (colNum != NULL) {
				time = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::time>(*colNum);
			} else {
				time = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::time>(colName);
			}
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

	CTimeStamp * resultGetTimeStamp(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			nanodbc::timestamp timestamp;

			if (colNum != NULL) {
				timestamp = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::timestamp>(*colNum);
			} else {
				timestamp = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::timestamp>(colName);
			}
			CTimeStamp * cTimeStamp = (CTimeStamp *)malloc(sizeof(CTimeStamp));

			*cTimeStamp = CTimeStamp {
				.date = CDate { .month = timestamp.month, .day = timestamp.day, .year = timestamp.year },
				.hour = timestamp.hour,
				.minute = timestamp.min,
				.second = timestamp.sec,
				.fractionalSec = timestamp.fract
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

	CDate * resultGetDate(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			nanodbc::date date;

			if (colNum != NULL) {
				date = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::date>(*colNum);
			} else {
				date = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::date>(colName);
			}
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

	bool resultGetBool(CResult * rawRes, const short * colNum, const char * colName, CError * error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<int>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int>(colName);
		} catch (nanodbc::database_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = databaseError };
			*error = cError;
			return false;
		} catch (nanodbc::index_range_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = indexOutOfRange };
			*error = cError;
			return false;
		} catch (nanodbc::type_incompatible_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = invalidType };
			*error = cError;
			return false;
		} catch (nanodbc::null_access_error& e) {
			CError cError = CError { .message = strdup(e.what()), .reason = nullAccessError };
			*error = cError;
			return false;
		}
	}

	uint8_t * resultGetBinary(CResult * rawRes, const short * colNum, const char * colName, unsigned long * sizePointer, CError * error) {
		try {
			auto res = std::vector<uint8_t>();
			if (colNum != NULL) {
				res = reinterpret_cast<nanodbc::result *>(rawRes)->get<std::vector<uint8_t>>(*colNum);
			} else {
				res = reinterpret_cast<nanodbc::result *>(rawRes)->get<std::vector<uint8_t>>(colName);
			}

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
