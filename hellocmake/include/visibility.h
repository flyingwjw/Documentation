#ifndef NUBULA_VISIBILITY_H_INCLUDED_
#define NUBULA_VISIBILITY_H_INCLUDED_

#include <nebula-config.h>

#if defined(NEBULA__NEED_DLLEXPORT)
# if defined (__SUNPRO_C) && (__SUNPRO_C >= 0x550)
#  define NEBULA_EXPORT_SYMBOL __global
# elif defined __GNUC__
#  define NEBULA_EXPORT_SYMBOL __attribute__ ((visibility("default")))
# elif defined(_MSC_VER)
#  define NEBULA_EXPORT_SYMBOL extern __declspec(dllexport)
# else
#  define NEBULA_EXPORT_SYMBOL /* unknown compiler */
# endif
#else
# if defined(NEBULA__NEED_DLLIMPORT) && defined(_MSC_VER)
#  define NEBULA_EXPORT_SYMBOL extern __declspec(dllimport)
# else
#  define NEBULA_EXPORT_SYMBOL
# endif
#endif

#endif /* EVENT2_VISIBILITY_H_INCLUDED_ */