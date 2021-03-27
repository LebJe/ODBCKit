import nanodbcCXX

var conStr = stringFromCString(strdup("Driver={SQL Server};Server=10.0.0.42,1433;Database=tempdb;Uid=sa;Pwd=reallyStrongPwd123;"))

var conn = nanodbc.connection(&conStr, 00)

var queryString = stringFromCString(strdup("SELECT * FROM [dbo].[table];"))

var results = nanodbc.execute(&conn, &queryString, 1, 0)


//while results.next() {
//	let data: Int = results.get(0)
//
//	//print(data)
//}
