// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#include "../nanodbc.h"
#include <CNanODBC/CNanODBC.h>
#include <CNanODBC/CxxFuncs.h>
#include <cstring>

long catalogColumnBufferLength(CColumns * _Nonnull columns) {
	return reinterpret_cast<nanodbc::catalog::columns *>(columns)->buffer_length();
}

long catalogColumnCharOctetLength(CColumns * _Nonnull columns) {
	return reinterpret_cast<nanodbc::catalog::columns *>(columns)->char_octet_length();
}

const char * _Nonnull catalogColumnDefault(CColumns * _Nonnull columns) {
	return strdup(reinterpret_cast<nanodbc::catalog::columns *>(columns)->column_default().c_str());
}

const char * _Nonnull catalogColumnName(CColumns * _Nonnull columns) {
	return strdup(reinterpret_cast<nanodbc::catalog::columns *>(columns)->column_name().c_str());
}

long catalogColumnSize(CColumns * _Nonnull columns) {
	return reinterpret_cast<nanodbc::catalog::columns *>(columns)->column_size();
}

short catalogColumnDataType(CColumns * _Nonnull columns) {
	return reinterpret_cast<nanodbc::catalog::columns *>(columns)->data_type();
}

short catalogColumnDecimalDigits(CColumns * _Nonnull columns) {
	return reinterpret_cast<nanodbc::catalog::columns *>(columns)->decimal_digits();
}

const char * _Nonnull catalogIsNullable(CColumns * _Nonnull columns) {
	return strdup(reinterpret_cast<nanodbc::catalog::columns *>(columns)->is_nullable().c_str());
}

bool catalogColumnNext(CColumns * _Nonnull columns) {
	return reinterpret_cast<nanodbc::catalog::columns *>(columns)->next();
}

short catalogColumnNumericPrecisionRadix(CColumns * _Nonnull columns) {
	return reinterpret_cast<nanodbc::catalog::columns *>(columns)->numeric_precision_radix();
}

long catalogColumnOrdinalPosition(CColumns * _Nonnull columns) {
	return reinterpret_cast<nanodbc::catalog::columns *>(columns)->ordinal_position();
}

const char * _Nonnull catalogColumnRemarks(CColumns * _Nonnull columns) {
	return strdup(reinterpret_cast<nanodbc::catalog::columns *>(columns)->remarks().c_str());
}

short catalogColumnSQLDataType(CColumns * _Nonnull columns) {
	return reinterpret_cast<nanodbc::catalog::columns *>(columns)->sql_data_type();
}

short catalogColumnSQLDateTimeSubType(CColumns * _Nonnull columns) {
	return reinterpret_cast<nanodbc::catalog::columns *>(columns)->sql_datetime_subtype();
}

const char * _Nonnull catalogColumnTableCatalog(CColumns * _Nonnull columns) {
	return strdup(reinterpret_cast<nanodbc::catalog::columns *>(columns)->table_catalog().c_str());
}

const char * _Nonnull catalogColumnTableName(CColumns * _Nonnull columns) {
	return strdup(reinterpret_cast<nanodbc::catalog::columns *>(columns)->table_name().c_str());
}

const char * _Nonnull catalogColumnTableSchema(CColumns * _Nonnull columns) {
	return strdup(reinterpret_cast<nanodbc::catalog::columns *>(columns)->table_schema().c_str());
}

const char * _Nonnull catalogColumnTypeName(CColumns * _Nonnull columns) {
	return strdup(reinterpret_cast<nanodbc::catalog::columns *>(columns)->type_name().c_str());
}
