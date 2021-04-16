//
//  list.cpp
//  
//
//  Created by Jeff Lebrun on 4/13/21.
//

#include "../nanodbc.h"
#include <CNanODBC/CNanODBC.h>
#include <list>
#include <stdlib.h>

extern "C" {
	const CDriver * listDrivers(int * cDriverArraySize) {
		auto drivers = nanodbc::list_drivers();

		std::vector<nanodbc::driver> driverVector{ std::make_move_iterator(std::begin(drivers)),
			std::make_move_iterator(std::end(drivers)) };

		int size = driverVector.size();

		CDriver * driverArray = new CDriver[size];

		for (int i = 0; i < size; i++) {
			auto d = driverVector[i];
			CDriver * driver = new CDriver;
			driver->name = strdup(d.name.c_str());
			
			std::vector<nanodbc::driver::attribute> attrVector{ std::make_move_iterator(std::begin(d.attributes)),
				std::make_move_iterator(std::end(d.attributes)) };

			int attrSize = attrVector.size();

			CAttribute * attrs = new CAttribute[attrSize];

			for (int j = 0; j < attrVector.size(); j++) {
				attrs[j].keyword = strdup(attrVector[j].keyword.c_str());
				attrs[j].value = strdup(attrVector[j].value.c_str());
			}

			driver->attributes = attrs;
			driver->attrSize = &attrSize;

			driverArray[i] = *driver;
		}
		
		*cDriverArraySize = size;
		return driverArray;
	}

	const CDataSource * listDataSources(int * cDataSourceArraySize) {
		auto dataSources = nanodbc::list_datasources();

		std::vector<nanodbc::datasource> dataSourceVector{ std::make_move_iterator(std::begin(dataSources)),
			std::make_move_iterator(std::end(dataSources)) };

		int size = dataSourceVector.size();

		CDataSource * dataSourceArray = new CDataSource[size];

		for (int i = 0; i < size; i++) {
			auto d = dataSourceVector[i];
			CDataSource * dataSource = new CDataSource;

			dataSource->name = strdup(d.name.c_str());
			dataSource->driver = strdup(d.driver.c_str());
			dataSourceArray[i] = *dataSource;
		}

		*cDataSourceArraySize = size;
		return dataSourceArray;
	}
}
