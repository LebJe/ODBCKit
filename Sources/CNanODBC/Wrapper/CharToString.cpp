// Copyright (c) 2021 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#include <string>
#include "../nanodbc.h"

std::string charToString(const char * string) {
	return NANODBC_TEXT(string);
}
