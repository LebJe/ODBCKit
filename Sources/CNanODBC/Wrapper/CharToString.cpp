//
//  File.cpp
//  
//
//  Created by Jeff Lebrun on 4/13/21.
//

#include <string>
#include "../nanodbc.h"

std::string charToString(const char * string) {
	return NANODBC_TEXT(string);
}
