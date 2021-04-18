// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#include "../nanodbc.h"
#include <CNanODBC/CNanODBC.h>
#include <CNanODBC/CxxFuncs.h>

nanodbc::date cDateToDate(CDate date) {
	return nanodbc::date { .year = date.year, .month = date.month, .day = date.day };
}
