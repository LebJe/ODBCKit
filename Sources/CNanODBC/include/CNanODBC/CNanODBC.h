//
//  CNanoODBC.h
//  
//
//  Created by Jeff Lebrun on 4/12/21.
//

#ifndef CNanODBC_h
#define CNanODBC_h

#ifdef __cplusplus

#include <string>


std::string charToString(const char * string);

extern "C"
{
#endif

	#include <stdbool.h>
	#include <stdint.h>

	// MARK: - Structs

	struct CConnection;
	typedef struct CConnection CConnection;

	struct CResult;
	typedef struct CResult CResult;

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

	struct CError {
		char * message;
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
		int16_t fractionalSec;
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
	short resultNumCols(CResult * rawRes);
	bool resultHasAffectedRows(CResult * rawRes);
	bool resultNext(CResult * rawRes, CError * error);
	bool resultPrior(CResult * rawRes, CError * error);
	int resultGetInt(CResult * rawRes, short colNum, CError * error);
	char * resultGetString(CResult * rawRes, short colNum, CError * error);

#ifdef __cplusplus
}
#endif

#endif /* CNanODBC_h */
