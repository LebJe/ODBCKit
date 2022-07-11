// Copyright (c) 2022 Jeff Lebrun
//
//  Licensed under the MIT License.
//
//  The full text of the license can be found in the file named LICENSE.

#include "../nanodbc.h"
#include <CNanODBC/CxxFuncs.h>
#include <string>

std::string charToString(const char * string) { return NANODBC_TEXT(string); }
