// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#include "../nanodbc.h"
#include <CNanODBC/CNanODBC.h>
#include <CNanODBC/CxxFuncs.h>
#include <cstring>

CCatalog * _Nonnull catalogCreate(CConnection * _Nonnull conn) {
	auto cat = new nanodbc::catalog(*reinterpret_cast<nanodbc::connection *>(conn));
	return reinterpret_cast<CCatalog *>(cat);
}

char * _Nonnull * _Nullable catalogListCatalogs(
	CCatalog * _Nonnull catalog, unsigned long * _Nonnull arraySize, CError * _Nonnull error) {
	try {
		auto cat = reinterpret_cast<nanodbc::catalog *>(catalog);
		auto catalogs = cat->list_catalogs();

		unsigned long size = catalogs.size();
		*arraySize = size;

		char * _Nonnull * _Nonnull cStringArray = new char *[size];

		auto i = 0;

		for (auto c : catalogs) {
			cStringArray[i] = strdup(c.c_str());
			i++;
		}

		return cStringArray;
	} catch (nanodbc::database_error & e) {
		*error = CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };
		return NULL;
	}
}

char * _Nonnull * _Nullable catalogListSchemas(
	CCatalog * _Nonnull catalog, unsigned long * _Nonnull arraySize, CError * _Nonnull error) {
	try {
		auto cat = reinterpret_cast<nanodbc::catalog *>(catalog);
		auto schemas = cat->list_schemas();

		unsigned long size = schemas.size();
		*arraySize = size;

		char * _Nonnull * _Nonnull cStringArray = new char *[size];

		auto i = 0;

		for (auto s : schemas) {
			cStringArray[i] = strdup(s.c_str());
			i++;
		}

		return cStringArray;
	} catch (nanodbc::database_error & e) {
		*error = CError { .isValid = true, .message = strdup(e.what()), .reason = databaseError };
		return NULL;
	}
}

CTables * _Nullable catalogFindTables(
	const char * _Nonnull table, const char * _Nonnull type, const char * _Nonnull schema,
	const char * _Nonnull catalog) {
	return NULL;
}

CColumns * _Nullable catalogFindColumns(
	CCatalog * _Nonnull catalogPointer, const char * _Nonnull column, const char * _Nonnull table,
	const char * _Nonnull schema, const char * _Nonnull catalog) {
	return reinterpret_cast<CColumns *>(
		new nanodbc::catalog::columns(reinterpret_cast<nanodbc::catalog *>(catalogPointer)
										  ->find_columns(column, table, schema, catalog)));
}
