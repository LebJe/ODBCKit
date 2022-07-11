//
//  Header.h
//
//
//  Created by Jeff Lebrun on 4/18/21.
//

#ifndef Header_h
#define Header_h

#ifdef __cplusplus

	#include "CNanODBC.h"
	#include <string>

std::string charToString(const char * string);

nanodbc::date cDateToDate(CDate date);
nanodbc::time cTimeToTime(CTime time);

nanodbc::timestamp cTimeStampToTimestamp(CTimeStamp ts);
#endif
#endif /* Header_h */
