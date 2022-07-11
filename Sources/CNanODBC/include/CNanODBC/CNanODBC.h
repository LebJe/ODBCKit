// Copyright (c) 2022 Jeff Lebrun
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

	// For `SQL_C_*` types.
	//#include <sqlext.h>

	// MARK: - Structs

	struct CConnection;
	typedef struct CConnection CConnection;

	struct CResult;
	typedef struct CResult CResult;

	struct CStatement;
	typedef struct CStatement CStatement;

	struct CCatalog;
	typedef struct CCatalog CCatalog;

	struct CTables;
	typedef struct CTables CTables;

	struct CTablePrivileges;
	typedef struct CTablePrivileges CTablePrivileges;

	struct CColumns;
	typedef struct CColumns CColumns;

	struct CPrimaryKeys;
	typedef struct CPrimaryKeys CPrimaryKeys;

	struct CProcedures;
	typedef struct CProcedures CProcedures;

	struct CProcedureColumns;
	typedef struct CProcedureColumns CProcedureColumns;

	struct CProcedureColumns;
	typedef struct CProcedureColumns CProcedureColumns;

	struct CDataSource {
		const char * _Nonnull name;
		const char * _Nonnull driver;
	};

	typedef struct CDataSource CDataSource;

	struct CAttribute {
		const char * _Nonnull keyword;
		const char * _Nonnull value;
	};

	typedef struct CAttribute CAttribute;

	struct CDriver {
		const char * _Nonnull name;
		const unsigned long * _Nonnull attrSize;
		const CAttribute * _Nullable attributes;
	};

	typedef struct CDriver CDriver;

	enum ErrorReason {
		general,
		nullAccessError,
		invalidType,
		indexOutOfRange,
		programmingError,
		databaseError
	} __attribute__((enum_extensibility(open)));

	typedef enum ErrorReason ErrorReason;

	struct CError {
		bool isValid;
		char * _Nullable message;
		ErrorReason reason;
	};

	typedef struct CError CError;

	struct CDate {
		int16_t month;
		int16_t day;
		int16_t year;
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
	CConnection * _Nullable createConnectionConnectionString(
		const char * _Nonnull connStr, long timeout, CError * _Nonnull error);
	CConnection * _Nullable createConnectionDSN(
		const char * _Nonnull dsn, const char * _Nonnull username, const char * _Nonnull password,
		long timeout, CError * _Nonnull error);
	bool connectionConnected(CConnection * _Nonnull conn);
	const char * _Nonnull connectionDBMSName(CConnection * _Nonnull conn);
	const char * _Nonnull connectionDBMSVersion(CConnection * _Nonnull conn);
	const char * _Nonnull connectionDatabaseName(CConnection * _Nonnull conn);
	CError * _Nullable connectionDisconnect(CConnection * _Nonnull conn);
	void destroyConnection(CConnection * _Nonnull conn);

	// MARK: - List
	const CDriver * _Null_unspecified listDrivers(unsigned long * _Nonnull cDriverArraySize);
	const CDataSource * _Null_unspecified listDataSources(
		unsigned long * _Nonnull cDataSourceArraySize);

	// MARK: - Execute
	void justExecute(
		CConnection * _Nonnull rawConn, const char * _Nonnull query, long batchOperations,
		long timeout, CError * _Nonnull error);
	CResult * _Nullable cExecute(
		CConnection * _Nonnull rawConn, const char * _Nonnull query, long batchOperations,
		long timeout, CError * _Nonnull error);

	// MARK: - Result
	long resultNumRows(CResult * _Nonnull rawRes, CError * _Nonnull error);
	short resultNumCols(CResult * _Nonnull rawRes, CError * _Nonnull error);
	long resultAffectedRows(CResult * _Nonnull rawRes, CError * _Nonnull error);
	bool resultNext(CResult * _Nonnull rawRes, CError * _Nonnull error);
	bool resultPrior(CResult * _Nonnull rawRes, CError * _Nonnull error);
	bool resultFirst(CResult * _Nonnull rawRes, CError * _Nonnull error);
	bool resultLast(CResult * _Nonnull rawRes, CError * _Nonnull error);
	bool resultMoveTo(CResult * _Nonnull rawRes, long row, CError * _Nonnull error);
	bool resultSkip(CResult * _Nonnull rawRes, long rows, CError * _Nonnull error);
	unsigned long resultPosition(CResult * _Nonnull rawRes);
	bool resultAtEnd(CResult * _Nonnull rawRes);
	const char * _Nonnull resultDataTypeName(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	int resultDataType(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	bool resultIsNull(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	long resultColumnSize(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	const char * _Nullable resultColumnName(
		CResult * _Nonnull rawRes, short colNum, CError * _Nonnull error);
	short resultColumnIndex(
		CResult * _Nonnull rawRes, const char * _Nonnull colName, CError * _Nonnull error);
	short resultGetShort(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	unsigned short resultGetUnsignedShort(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	int resultGetInt(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	int64_t resultGetBigInt(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	int32_t resultGetLong(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	float resultGetFloat(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	double resultGetDouble(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	const char * _Nullable resultGetString(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	CTime * _Nullable resultGetTime(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	CTimeStamp * _Nullable resultGetTimeStamp(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	CDate * _Nullable resultGetDate(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	bool resultGetBool(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		CError * _Nonnull error);
	uint8_t * _Nullable resultGetBinary(
		CResult * _Nonnull rawRes, const short * _Nullable colNum, const char * _Nullable colName,
		unsigned long * _Nonnull sizePointer, CError * _Nonnull error);

	// MARK: - Statement

	CStatement * _Nonnull stmtCreate(
		CConnection * _Nonnull rawConn, const char * _Nonnull query, long timeout);
	CError * _Nullable stmtBindNull(CStatement * _Nonnull rawStmt, short paramIndex);
	CError * _Nullable stmtBindShort(CStatement * _Nonnull rawStmt, short paramIndex, short value);
	CError * _Nullable stmtBindUnsignedShort(
		CStatement * _Nonnull rawStmt, short paramIndex, unsigned short value);
	CError * _Nullable stmtBindInt(CStatement * _Nonnull rawStmt, short paramIndex, int value);
	CError * _Nullable stmtBindBigInt(
		CStatement * _Nonnull rawStmt, short paramIndex, int64_t value);
	CError * _Nullable stmtBindLong(CStatement * _Nonnull rawStmt, short paramIndex, int32_t value);
	CError * _Nullable stmtBindFloat(CStatement * _Nonnull rawStmt, short paramIndex, float value);
	CError * _Nullable stmtBindDouble(
		CStatement * _Nonnull rawStmt, short paramIndex, double value);
	CError * _Nullable stmtBindString(
		CStatement * _Nonnull rawStmt, short paramIndex, const char * _Nonnull value);
	CError * _Nullable stmtBindBool(CStatement * _Nonnull rawStmt, short paramIndex, bool value);
	CError * _Nullable stmtBindBinary(
		CStatement * _Nonnull rawStmt, short paramIndex, const uint8_t * _Nonnull value,
		int64_t size);
	CError * _Nullable stmtBindTime(CStatement * _Nonnull rawStmt, short paramIndex, CTime value);
	CError * _Nullable stmtBindTimeStamp(
		CStatement * _Nonnull rawStmt, short paramIndex, CTimeStamp value);
	CError * _Nullable stmtBindDate(CStatement * _Nonnull rawStmt, short paramIndex, CDate value);
	CResult * _Nullable stmtExecute(
		CStatement * _Nonnull rawStmt, long timeout, CError * _Nonnull error);
	void stmtClose(CStatement * _Nonnull rawStmt);

	// MARK - Catalog

	CCatalog * _Nonnull catalogCreate(CConnection * _Nonnull conn);
	char * _Nonnull * _Nullable catalogListCatalogs(
		CCatalog * _Nonnull catalog, unsigned long * _Nonnull arraySize, CError * _Nonnull error);
	char * _Nonnull * _Nullable catalogListSchemas(
		CCatalog * _Nonnull catalog, unsigned long * _Nonnull arraySize, CError * _Nonnull error);
	CColumns * _Nullable catalogFindColumns(
		CCatalog * _Nonnull catalogPointer, const char * _Nonnull column,
		const char * _Nonnull table, const char * _Nonnull schema, const char * _Nonnull catalog);

	// MARK: - Catalog - Columns
	long catalogColumnBufferLength(CColumns * _Nonnull columns);
	long catalogColumnCharOctetLength(CColumns * _Nonnull columns);
	const char * _Nonnull catalogColumnDefault(CColumns * _Nonnull columns);
	const char * _Nonnull catalogColumnName(CColumns * _Nonnull columns);
	long catalogColumnSize(CColumns * _Nonnull columns);
	short catalogColumnDataType(CColumns * _Nonnull columns);
	short catalogColumnDecimalDigits(CColumns * _Nonnull columns);
	const char * _Nonnull catalogIsNullable(CColumns * _Nonnull columns);
	bool catalogColumnNext(CColumns * _Nonnull columns);
	short catalogColumnNumericPrecisionRadix(CColumns * _Nonnull columns);
	long catalogColumnOrdinalPosition(CColumns * _Nonnull columns);
	const char * _Nonnull catalogColumnRemarks(CColumns * _Nonnull columns);
	const char * _Nonnull catalogColumnTableCatalog(CColumns * _Nonnull columns);
	const char * _Nonnull catalogColumnTableName(CColumns * _Nonnull columns);
	const char * _Nonnull catalogColumnTableSchema(CColumns * _Nonnull columns);
	const char * _Nonnull catalogColumnTypeName(CColumns * _Nonnull columns);
	short catalogColumnSQLDataType(CColumns * _Nonnull columns);
	short catalogColumnSQLDateTimeSubType(CColumns * _Nonnull columns);
#ifdef __cplusplus
}
#endif

#endif /* CNanODBC_h */
