//
//  Header.h
//  
//
//  Created by Jeff Lebrun on 4/18/21.
//

#ifndef Header_h
#define Header_h

#ifdef __cplusplus

#include <string>
#include "CNanODBC.h"

std::string charToString(const char * string);

nanodbc::date cDateToDate(CDate date);
nanodbc::time cTimeToTime(CTime time);

nanodbc::timestamp cTimeStampToTimestamp(CTimeStamp ts);
#endif
#endif /* Header_h */
