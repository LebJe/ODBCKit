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
	bool resultNext(CResult * rawRes);

#ifdef __cplusplus
}
#endif

#endif /* CNanODBC_h */
