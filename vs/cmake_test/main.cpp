#include <sqlite3.h>
#include <zlib.h>
#include <ft2build.h>
#include FT_FREETYPE_H

#include <stdio.h>

int main()
{
	printf("sqlite3: %s\n", sqlite3_libversion());
	printf("zlib: %s\n", zlibVersion());
	getchar();
	return 0;
}