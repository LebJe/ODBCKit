// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#ifndef CNanODBC_h
#define CNanODBC_h

#ifdef __cplusplus

#include <string>

extern "C" {
#endif

	#include <stdbool.h>
	#include <stdint.h>

	// MARK: - Structs

	struct CConnection;
	typedef struct CConnection CConnection;

	struct CResult;
	typedef struct CResult CResult;

	struct CStatement;
	typedef struct CStatement CStatement;

	struct CDataSource {
		const char * name;
		const char * driver;
	};

	typedef struct CDataSource CDataSource;

	struct CAttribute {
		const char * keyword;
		const char * value;
	};

	typedef struct CAttribute CAttribute;

	struct CDriver {
		const char * name;
		const int * attrSize;
		const CAttribute * attributes;
	};

	typedef struct CDriver CDriver;

enum ErrorReason {
	general,
	nullAccessError,
	invalidType,
	indexOutOfRange,
	programmingError,
	databaseError
};

typedef enum ErrorReason ErrorReason;

	struct CError {
		char * message;
		ErrorReason reason;
	};

	typedef struct CError CError;

	struct CDate {
		int16_t year;
		int16_t month;
		int16_t day;
	};

	typedef struct CDate CDate;

	struct CTime {
		int16_t hour;
		int16_t minute;
		int16_t second;
	};

	typedef struct CTime CTime;

	struct CTimeStamp {
		CDate date;
		int16_t hour;
		int16_t minute;
		int16_t second;
		int32_t fractionalSec;
	};

	typedef struct CTimeStamp CTimeStamp;

	// MARK: - Connection
	CConnection * createConnectionConnectionString(const char * connStr, long timeout, CError * error);
	CConnection * createConnectionDSN(const char * dsn, const char * username, const char * password, long timeout, CError * error);
	void destroyConnection(CConnection * conn);

	// MARK: - List
	const CDriver * listDrivers(int * cDriverArraySize);
	const CDataSource * listDataSources(int * cDataSourceArraySize);

	// MARK: - Execute
	void justExecute(CConnection * rawConn, const char * query, long batchOperations, long timeout, CError * error);
	CResult * cExecute(CConnection * rawConn, const char * query, long batchOperations, long timeout, CError * error);

	// MARK: - Result
	long resultAffectedRows(CResult * rawRes);
	long resultNumRows(CResult * rawRes);
	short resultNumCols(CResult * rawRes, CError * error);
	bool resultHasAffectedRows(CResult * rawRes, CError * error);
	bool resultNext(CResult * rawRes, CError * error);
	bool resultPrior(CResult * rawRes, CError * error);
	short resultGetShort(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	unsigned short resultGetUnsignedShort(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	int resultGetInt(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	int64_t resultGetBigInt(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	int32_t resultGetLong(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	float resultGetFloat(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	double resultGetDouble(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	char * resultGetString(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	CTime * resultGetTime(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	CTimeStamp * resultGetTimeStamp(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	CDate * resultGetDate(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	bool resultGetBool(CResult * rawRes, const short * colNum, const char * colName, CError * error);
	uint8_t * resultGetBinary(CResult * rawRes, const short * colNum, const char * colName, int * sizePointer, CError * error);

	// MARK: - Statement

	CStatement * stmtCreate(CConnection * rawConn, const char * query, long timeout);
	CError * stmtBindInt(CStatement * rawStmt, short paramIndex, int value);
	CError * stmtBindString(CStatement * rawStmt, short paramIndex, const char * value);
	void stmtClose(CStatement * rawStmt);

#ifdef __cplusplus
}
#endif

#endif /* CNanODBC_h */
