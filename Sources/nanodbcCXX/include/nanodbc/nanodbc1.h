//
//  nanodbc.h
//  
//
//  Created by Jeff Lebrun on 3/27/21.
//

#ifndef nanodbc_h
#define nanodbc_h
#include <string>
#include "../../nanodbc.h"

/// Converts a \c char* into a \c std::string.
/// @param string The \c char*  you wish to convert.
std::string stringFromCString(const char * string) {
	return NANODBC_TEXT(string);
}

#endif /* nanodbc_h */
