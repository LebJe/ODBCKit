// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#include "../nanodbc.h"
#include <CNanODBC/CNanODBC.h>
#include <CNanODBC/CxxFuncs.h>
#include <stdbool.h>
#include <stdlib.h>
#include <string.h>

extern "C" {

	// MARK: - Result Information
	long resultNumRows(CResult * _Nonnull rawRes, CError * _Nonnull error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->rows();
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return false;
		}
	}

	short resultNumCols(CResult * _Nonnull rawRes, CError * _Nonnull error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->columns();
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return false;
		}
	}

	long resultAffectedRows(CResult * _Nonnull rawRes, CError * _Nonnull error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->affected_rows();
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return false;
		}
	}

	// MARK: - Next, Prior, Skip, Position, Move, First, Last

	bool resultNext(CResult * _Nonnull rawRes, CError * _Nonnull error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->next();
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return false;
		}
	}

	bool resultPrior(CResult * _Nonnull rawRes, CError * _Nonnull error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->prior();
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return false;
		}
	}

	bool resultFirst(CResult * _Nonnull rawRes, CError * _Nonnull error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->first();
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return false;
		}
	}

	bool resultLast(CResult * _Nonnull rawRes, CError * _Nonnull error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->first();
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return false;
		}
	}

	bool resultMoveTo(CResult * _Nonnull rawRes, long row, CError * _Nonnull error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->move(row);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return false;
		}
	}

	bool resultSkip(CResult * _Nonnull rawRes, long rows, CError * _Nonnull error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->skip(rows);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return false;
		}
	}

	unsigned long resultPosition(CResult * _Nonnull rawRes) {
		return reinterpret_cast<nanodbc::result *>(rawRes)->position();
	}

	bool resultAtEnd(CResult * _Nonnull rawRes) {
		return reinterpret_cast<nanodbc::result *>(rawRes)->at_end();
	}

	const char * _Nonnull resultDataTypeName(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return strdup(reinterpret_cast<nanodbc::result *>(rawRes)
								  ->column_datatype_name(*colNum)
								  .c_str());
			}
			return strdup(
				reinterpret_cast<nanodbc::result *>(rawRes)->column_datatype_name(colName).c_str());
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return "";
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return "";
		}
	}

	int resultDataType(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->column_datatype(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->column_datatype(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return 100;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return 100;
		}
	}

	bool resultIsNull(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->is_null(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->is_null(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return 100;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return false;
		}
	}

	long resultColumnSize(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->column_size(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->column_size(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return 100;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return -1;
		}
	}

	const char * _Nullable resultColumnName(
		CResult * _Nonnull rawRes, short colNum, CError * _Nonnull error) {
		try {
			return strdup(reinterpret_cast<nanodbc::result *>(rawRes)->column_name(colNum).c_str());
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return NULL;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return NULL;
		}
	}

	short resultColumnIndex(
		CResult * _Nonnull rawRes, const char * _Nonnull colName, CError * _Nonnull error) {
		try {
			return reinterpret_cast<nanodbc::result *>(rawRes)->column(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return -1;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return -1;
		}
	}

	// MARK: - Get data through column index

	short resultGetShort(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<short>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<short>(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return -1;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return -1;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return -1;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return -1;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return -1;
		}
	}

	unsigned short resultGetUnsignedShort(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<unsigned short>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<unsigned short>(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return -1;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return -1;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return -1;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return -1;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return -1;
		}
	}

	int resultGetInt(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<int>(*colNum);
			}

			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int>(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return -1;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return -1;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return -1;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return -1;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return -1;
		}
	}

	int64_t resultGetBigInt(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<int64_t>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int64_t>(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return -1;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return -1;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return -1;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return -1;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return -1;
		}
	}

	int32_t resultGetLong(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<int32_t>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int32_t>(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return -1;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return -1;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return -1;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return -1;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return -1;
		}
	}

	float resultGetFloat(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<float>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<float>(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return -1;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return -1;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return -1;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return -1;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return -1;
		}
	}

	double resultGetDouble(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<double>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<double>(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return -1;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return -1;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return -1;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return -1;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return -1;
		}
	}

	const char * _Nullable resultGetString(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return strdup(reinterpret_cast<nanodbc::result *>(rawRes)
								  ->get<nanodbc::string>(*colNum)
								  .c_str());
			}
			return strdup(
				reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::string>(colName).c_str());
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return NULL;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return NULL;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return NULL;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return NULL;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return NULL;
		}
	}

	CTime * _Nullable resultGetTime(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			nanodbc::time time;

			if (colNum != NULL) {
				time = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::time>(*colNum);
			} else {
				time = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::time>(colName);
			}
			CTime * cTime = (CTime *) malloc(sizeof(CTime));
			*cTime = CTime { .hour = time.hour, .minute = time.min, .second = time.sec };
			return cTime;
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return NULL;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return NULL;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return NULL;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return NULL;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return NULL;
		}
	}

	CTimeStamp * _Nullable resultGetTimeStamp(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			nanodbc::timestamp timestamp;

			if (colNum != NULL) {
				timestamp =
					reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::timestamp>(*colNum);
			} else {
				timestamp =
					reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::timestamp>(colName);
			}
			CTimeStamp * cTimeStamp = (CTimeStamp *) malloc(sizeof(CTimeStamp));

			*cTimeStamp = CTimeStamp { .date = CDate { .month = timestamp.month,
													   .day = timestamp.day,
													   .year = timestamp.year },
									   .hour = timestamp.hour,
									   .minute = timestamp.min,
									   .second = timestamp.sec,
									   .fractionalSec = timestamp.fract };
			return cTimeStamp;
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return NULL;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return NULL;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return NULL;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return NULL;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return NULL;
		}
	}

	CDate * _Nullable resultGetDate(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			nanodbc::date date;

			if (colNum != NULL) {
				date = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::date>(*colNum);
			} else {
				date = reinterpret_cast<nanodbc::result *>(rawRes)->get<nanodbc::date>(colName);
			}
			return new CDate { .month = date.month, .day = date.day, .year = date.year };
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return NULL;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return NULL;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return NULL;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return NULL;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return NULL;
		}
	}

	bool resultGetBool(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error) {
		try {
			if (colNum != NULL) {
				return reinterpret_cast<nanodbc::result *>(rawRes)->get<int>(*colNum);
			}
			return reinterpret_cast<nanodbc::result *>(rawRes)->get<int>(colName);
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return false;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return false;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return false;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return false;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return false;
		}
	}

	uint8_t * _Nullable resultGetBinary(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		unsigned long * _Nonnull sizePointer, CError * _Nonnull error) {
		try {
			auto res = std::vector<uint8_t>();
			if (colNum != NULL) {
				res =
					reinterpret_cast<nanodbc::result *>(rawRes)->get<std::vector<uint8_t>>(*colNum);
			} else {
				res =
					reinterpret_cast<nanodbc::result *>(rawRes)->get<std::vector<uint8_t>>(colName);
			}

			uint8_t * rawRes = (uint8_t *) malloc(sizeof(uint8_t) * res.size());

			for (int i = 0; i < res.size(); i++) {
				rawRes[i] = res[i];
			}

			*sizePointer = res.size();
			return rawRes;
		} catch (nanodbc::database_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };

			return NULL;
		} catch (nanodbc::index_range_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = indexOutOfRange };

			return NULL;
		} catch (nanodbc::type_incompatible_error & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = invalidType };

			return NULL;
		} catch (nanodbc::null_access_error & e) {
			*error =
				CError { .isValid = true, .message = strdup(e.what()), .reason = nullAccessError };

			return NULL;
		} catch (std::exception & e) {
			*error = CError { .isValid = true, .message = strdup(e.what()), .reason = general };

			return NULL;
		}
	}
}
