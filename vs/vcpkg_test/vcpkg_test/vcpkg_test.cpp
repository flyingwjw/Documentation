#include <sqlite3.h>
#include <zlib.h>

#include <stdio.h>

int main()
{
	printf("sqlite3: %s\n", sqlite3_libversion());
	printf("zlib: %s\n", zlibVersion());
	getchar();
	return 0;
}
